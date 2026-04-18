package com.equitybank.drplatform.service;

import com.equitybank.drplatform.dto.request.CreateDependencyRequest;
import com.equitybank.drplatform.dto.response.ConflictDto;
import com.equitybank.drplatform.dto.response.DependencyDto;
import com.equitybank.drplatform.dto.response.DependencyHistoryDto;
import com.equitybank.drplatform.dto.response.SharedResourceSummaryDto;
import com.equitybank.drplatform.entity.*;
import com.equitybank.drplatform.exception.ResourceNotFoundException;
import com.equitybank.drplatform.repository.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class DependencyEngineService {

    private final DependencyRepository dependencyRepository;
    private final DependencyHistoryRepository dependencyHistoryRepository;
    private final CampaignApplicationRepository campaignApplicationRepository;
    private final CampaignConflictRepository conflictRepository;
    private final ApplicationRepository applicationRepository;

    public DependencyDto registerDependency(UUID appId, CreateDependencyRequest request) {
        // Validate application exists in the active table (not just history)
        ApplicationEntity app = applicationRepository.findById(appId)
                .orElseThrow(() -> new ResourceNotFoundException("Application", appId));

        log.info("Registering dependency: type={}, isShared={}, resourceName={}, appId={}",
                request.getDependencyType(), request.isShared(), request.getResourceName(), appId);

        DependencyEntity dep = DependencyEntity.builder()
                .applicationId(appId)
                .dependsOnId(request.getDependsOnId())
                .dependencyType(request.getDependencyType())
                .isShared(request.isShared())
                .resourceName(request.getResourceName())
                .description(request.getDescription())
                .build();

        DependencyEntity saved = dependencyRepository.save(dep);
        log.info("Dependency saved with id={}, isActive={}", saved.getId(), saved.isActive());

        // Update hasDependency flag
        app.setHasDependency(true);
        applicationRepository.save(app);

        return DependencyDto.fromEntity(saved);
    }

    @Getter
    @AllArgsConstructor
    public static class DeactivateDependencyResult {
        private final DependencyDto dependency;
        private final List<String> warningApps; // names of other apps sharing same resource
        private final boolean hasWarnings;
    }

    /**
     * Deactivates a dependency (sets isActive=false).
     * If the dependency is shared (isShared=true), checks how many OTHER active apps
     * also depend on the same resource and returns their names as warnings.
     */
    public DeactivateDependencyResult deactivateDependency(UUID depId) {
        DependencyEntity dep = dependencyRepository.findById(depId)
                .orElseThrow(() -> new ResourceNotFoundException("Dependency", depId));

        List<String> warningApps = new ArrayList<>();

        if (dep.isShared() && dep.getResourceName() != null) {
            // Find other active apps that share the same resource
            List<DependencyEntity> siblings = dependencyRepository
                    .findAllByResourceNameAndIsSharedTrueAndIsActiveTrue(dep.getResourceName());
            for (DependencyEntity sibling : siblings) {
                if (!sibling.getId().equals(depId)) {
                    applicationRepository.findById(sibling.getApplicationId())
                            .filter(ApplicationEntity::isActive)
                            .ifPresent(app -> warningApps.add(app.getName() + " (" + app.getCode() + ")"));
                }
            }
        }

        dep.setActive(false);
        DependencyDto saved = DependencyDto.fromEntity(dependencyRepository.save(dep));
        return new DeactivateDependencyResult(saved, warningApps, !warningApps.isEmpty());
    }

    public void deleteDependency(UUID depId) {
        dependencyRepository.deleteById(depId);
    }

    @Getter
    @AllArgsConstructor
    public static class ArchiveDependencyResult {
        private final List<String> warningApps;
        private final boolean hasWarnings;
    }

    /**
     * Archives a dependency by copying it to dependency_history and hard-deleting
     * from the dependencies table. If the dependency is shared, returns warnings
     * for other active apps that also used the same resource.
     */
    public ArchiveDependencyResult archiveDependency(UUID depId, UUID actorId, String actorEmail) {
        DependencyEntity dep = dependencyRepository.findById(depId)
                .orElseThrow(() -> new ResourceNotFoundException("Dependency", depId));

        List<String> warningApps = new ArrayList<>();

        if (dep.isShared() && dep.getResourceName() != null) {
            List<DependencyEntity> siblings = dependencyRepository
                    .findAllByResourceNameAndIsSharedTrueAndIsActiveTrue(dep.getResourceName());
            for (DependencyEntity sibling : siblings) {
                if (!sibling.getId().equals(depId)) {
                    applicationRepository.findById(sibling.getApplicationId())
                            .filter(ApplicationEntity::isActive)
                            .ifPresent(app -> warningApps.add(app.getName() + " (" + app.getCode() + ")"));
                }
            }
        }

        DependencyHistoryEntity history = DependencyHistoryEntity.from(dep, actorId, actorEmail);
        dependencyHistoryRepository.save(history);
        dependencyRepository.deleteById(depId);

        return new ArchiveDependencyResult(warningApps, !warningApps.isEmpty());
    }

    @Transactional(readOnly = true)
    public List<DependencyHistoryDto> getDependencyHistory(UUID appId) {
        return dependencyHistoryRepository.findByApplicationIdOrderByArchivedAtDesc(appId)
                .stream().map(DependencyHistoryDto::fromEntity).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<DependencyDto> getApplicationDependencies(UUID appId) {
        return dependencyRepository.findByApplicationIdAndIsActiveTrue(appId)
                .stream().map(DependencyDto::fromEntity).collect(Collectors.toList());
    }

    @Async("drPlatformExecutor")
    public void scanCampaignConflictsAsync(UUID campaignId) {
        try {
            scanCampaignConflicts(campaignId);
        } catch (Exception e) {
            log.error("Async conflict scan failed for campaign {}: {}", campaignId, e.getMessage());
        }
    }

    public List<ConflictDto> scanCampaignConflicts(UUID campaignId) {
        List<CampaignApplicationEntity> campaignApps = campaignApplicationRepository.findByCampaignId(campaignId);
        List<UUID> appIds = campaignApps.stream()
                .map(CampaignApplicationEntity::getApplicationId).collect(Collectors.toList());

        // Find shared dependencies
        Map<String, List<UUID>> sharedResourceToApps = detectSharedDependencies(appIds);

        List<CampaignConflictEntity> newConflicts = new ArrayList<>();

        // Create SHARED_DEPENDENCY_CONFLICT for each resource shared by 2+ apps
        for (Map.Entry<String, List<UUID>> entry : sharedResourceToApps.entrySet()) {
            if (entry.getValue().size() < 2) continue;

            String resourceName = entry.getKey();
            List<UUID> conflictingApps = entry.getValue();

            // Check if conflict already exists
            boolean exists = conflictRepository.findByCampaignId(campaignId).stream()
                    .anyMatch(c -> c.getConflictType().equals("SHARED_DEPENDENCY_CONFLICT")
                            && c.getDescription().contains(resourceName));
            if (exists) continue;

            CampaignConflictEntity conflict = CampaignConflictEntity.builder()
                    .campaignId(campaignId)
                    .conflictType("SHARED_DEPENDENCY_CONFLICT")
                    .applicationIds(conflictingApps.toArray(new UUID[0]))
                    .description("Shared resource conflict: " + resourceName +
                                 " is depended on by " + conflictingApps.size() + " applications in this campaign")
                    .recommendation("Group all affected applications in one War Room session. " +
                                   "The shared step (e.g. Oracle DG switchover for " + resourceName +
                                   ") should be executed once by the DBA.")
                    .build();
            newConflicts.add(conflict);
        }

        // Check for direct app-to-app dependencies within the campaign (SEQUENCING_ADVISORY)
        for (CampaignApplicationEntity ca : campaignApps) {
            List<DependencyEntity> appDeps = dependencyRepository.findByApplicationId(ca.getApplicationId());
            for (DependencyEntity dep : appDeps) {
                if (dep.getDependsOnId() == null) continue;
                boolean dependedOnInCampaign = appIds.contains(dep.getDependsOnId());
                if (dependedOnInCampaign) {
                    boolean exists = conflictRepository.findByCampaignId(campaignId).stream()
                            .anyMatch(c -> c.getConflictType().equals("SEQUENCING_ADVISORY")
                                    && Arrays.asList(c.getApplicationIds()).contains(ca.getApplicationId()));
                    if (!exists) {
                        CampaignConflictEntity advisory = CampaignConflictEntity.builder()
                                .campaignId(campaignId)
                                .conflictType("SEQUENCING_ADVISORY")
                                .applicationIds(new UUID[]{dep.getDependsOnId(), ca.getApplicationId()})
                                .description("Sequencing dependency: Application depends on another application in this campaign")
                                .recommendation("Run the dependency application first, wait for validation, then proceed with the dependent application")
                                .build();
                        newConflicts.add(advisory);
                    }
                }
            }
        }

        conflictRepository.saveAll(newConflicts);
        return conflictRepository.findByCampaignId(campaignId)
                .stream().map(ConflictDto::fromEntity).collect(Collectors.toList());
    }

    /**
     * Returns all shared infrastructure resources grouped by name,
     * each entry showing which applications share that resource.
     * Used by GET /api/dependencies/shared (Dependency Engine page).
     */
    @Transactional(readOnly = true)
    public List<SharedResourceSummaryDto> getSharedResourcesSummary() {
        List<DependencyEntity> allShared = dependencyRepository.findAllByIsSharedTrueAndIsActiveTrue();

        // Batch-load application names — avoids N+1
        Set<UUID> appIdSet = allShared.stream()
                .map(DependencyEntity::getApplicationId)
                .collect(Collectors.toSet());
        Map<UUID, ApplicationEntity> appsById = applicationRepository.findAllById(appIdSet)
                .stream().collect(Collectors.toMap(ApplicationEntity::getId, a -> a));

        // Group by resourceName (null-safe)
        Map<String, List<DependencyEntity>> grouped = allShared.stream()
                .filter(d -> d.getResourceName() != null && !d.getResourceName().isBlank())
                .collect(Collectors.groupingBy(DependencyEntity::getResourceName));

        return grouped.entrySet().stream()
                .map(entry -> {
                    List<DependencyEntity> deps = entry.getValue();
                    String depType = deps.get(0).getDependencyType();

                    List<SharedResourceSummaryDto.AppRef> appRefs = deps.stream()
                            .map(dep -> {
                                ApplicationEntity app = appsById.get(dep.getApplicationId());
                                return SharedResourceSummaryDto.AppRef.builder()
                                        .applicationId(dep.getApplicationId())
                                        .applicationName(app != null ? app.getName() : "Unknown")
                                        .applicationCode(app != null ? app.getCode() : "N/A")
                                        .applicationTier(app != null ? app.getTier() : null)
                                        .dependencyId(dep.getId())
                                        .description(dep.getDescription())
                                        .build();
                            })
                            .collect(Collectors.toList());

                    return SharedResourceSummaryDto.builder()
                            .resourceName(entry.getKey())
                            .dependencyType(depType)
                            .applicationCount(deps.size())
                            .applications(appRefs)
                            .build();
                })
                // Most-shared resources first
                .sorted(Comparator.comparingInt(SharedResourceSummaryDto::getApplicationCount).reversed())
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public Map<String, List<UUID>> detectSharedDependencies(List<UUID> appIds) {
        Map<String, List<UUID>> resourceToApps = new HashMap<>();
        for (UUID appId : appIds) {
            List<DependencyEntity> sharedDeps = dependencyRepository.findByApplicationIdAndIsSharedTrue(appId);
            for (DependencyEntity dep : sharedDeps) {
                if (dep.getResourceName() != null) {
                    resourceToApps.computeIfAbsent(dep.getResourceName(), k -> new ArrayList<>()).add(appId);
                }
            }
        }
        return resourceToApps;
    }
}
