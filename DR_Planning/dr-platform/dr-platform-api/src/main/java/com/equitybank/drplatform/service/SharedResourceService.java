package com.equitybank.drplatform.service;

import com.equitybank.drplatform.dto.request.CreateSharedResourceRequest;
import com.equitybank.drplatform.dto.response.SharedResourceDto;
import com.equitybank.drplatform.dto.response.SharedResourceHistoryDto;
import com.equitybank.drplatform.entity.ApplicationEntity;
import com.equitybank.drplatform.entity.DependencyEntity;
import com.equitybank.drplatform.entity.SharedResourceEntity;
import com.equitybank.drplatform.entity.SharedResourceHistoryEntity;
import com.equitybank.drplatform.exception.ConflictException;
import com.equitybank.drplatform.exception.ResourceNotFoundException;
import com.equitybank.drplatform.repository.ApplicationRepository;
import com.equitybank.drplatform.repository.DependencyRepository;
import com.equitybank.drplatform.repository.SharedResourceHistoryRepository;
import com.equitybank.drplatform.repository.SharedResourceRepository;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Manages the Shared Resource Registry (CMDB-lite).
 *
 * Rules enforced here (beyond the DB constraint):
 * - Codes are stored as UPPERCASE and cannot be changed after creation.
 * - Duplicate codes (case-insensitive) throw ConflictException before hitting the DB.
 * - Only COORDINATOR and above can create or deactivate/archive resources (enforced in controller).
 */
@Service
@Transactional
@RequiredArgsConstructor
public class SharedResourceService {

    private final SharedResourceRepository repository;
    private final SharedResourceHistoryRepository sharedResourceHistoryRepository;
    private final DependencyRepository dependencyRepository;
    private final ApplicationRepository applicationRepository;

    @Getter
    @AllArgsConstructor
    public static class ArchiveSharedResourceResult {
        private final boolean hasWarnings;
        private final List<String> warningApps;
        private final boolean archived;
    }

    public SharedResourceDto create(CreateSharedResourceRequest request) {
        String canonicalCode = request.getCode().toUpperCase().strip();
        if (repository.existsByCodeIgnoreCase(canonicalCode)) {
            throw new ConflictException(
                "A shared resource with code '" + canonicalCode + "' already exists. " +
                "If this is the same resource please link to the existing entry.");
        }
        SharedResourceEntity entity = SharedResourceEntity.builder()
                .code(canonicalCode)
                .name(request.getName().strip())
                .resourceType(request.getResourceType())
                .description(request.getDescription())
                .host(request.getHost())
                .environment(request.getEnvironment() != null ? request.getEnvironment() : "PRODUCTION")
                .build();
        return SharedResourceDto.fromEntity(repository.save(entity));
    }

    @Transactional(readOnly = true)
    public List<SharedResourceDto> listAll() {
        return repository.findByIsActiveTrueOrderByNameAsc()
                .stream().map(SharedResourceDto::fromEntity).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<SharedResourceDto> search(String query) {
        if (query == null || query.isBlank()) return listAll();
        return repository.search(query.strip())
                .stream().map(SharedResourceDto::fromEntity).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<SharedResourceDto> listByType(String resourceType) {
        return repository.findByResourceTypeAndIsActiveTrueOrderByNameAsc(resourceType)
                .stream().map(SharedResourceDto::fromEntity).collect(Collectors.toList());
    }

    /**
     * Deactivates a shared resource (sets isActive = false) without removing it from
     * the registry. The resource remains visible in history/audit but is excluded from
     * active typeahead results.
     */
    @Transactional
    public SharedResourceDto deactivateSharedResource(UUID id) {
        SharedResourceEntity r = repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("SharedResource", id));
        r.setActive(false);
        return SharedResourceDto.fromEntity(repository.save(r));
    }

    /**
     * Archives an infrastructure resource by copying it to {@code infrastructure_resource_history}
     * then hard-deleting it from {@code infrastructure_resources}.
     *
     * When {@code force} is {@code false} (default), the method first checks whether
     * any active application_dependencies reference this resource (by its UUID via {@code dependsOnId}).
     * If links exist it returns a result with {@code hasWarnings = true} and the
     * list of affected application names — without archiving anything — so the caller can
     * present a confirmation dialog to the user.
     *
     * When {@code force} is {@code true} the resource is archived regardless of existing links.
     */
    @Transactional
    public ArchiveSharedResourceResult archiveSharedResource(UUID id, boolean force, UUID actorId, String actorEmail) {
        SharedResourceEntity resource = repository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("SharedResource", id));

        // Collect dependencies that reference this resource by its UUID (dependsOnId FK)
        List<DependencyEntity> linkedDeps = dependencyRepository.findByDependsOnId(id);

        List<String> warningApps = new ArrayList<>();
        for (DependencyEntity dep : linkedDeps) {
            applicationRepository.findById(dep.getApplicationId())
                    .filter(ApplicationEntity::isActive)
                    .ifPresent(app -> warningApps.add(app.getName() + " (" + app.getCode() + ")"));
        }

        boolean hasWarnings = !warningApps.isEmpty();

        if (hasWarnings && !force) {
            // Return warning without archiving — caller must re-submit with force=true
            return new ArchiveSharedResourceResult(true, warningApps, false);
        }

        // Save to history, then hard-delete
        sharedResourceHistoryRepository.save(SharedResourceHistoryEntity.from(resource, actorId, actorEmail));
        repository.delete(resource);
        return new ArchiveSharedResourceResult(hasWarnings, warningApps, true);
    }

    @Transactional(readOnly = true)
    public List<SharedResourceHistoryDto> listHistory() {
        return sharedResourceHistoryRepository.findAllByOrderByArchivedAtDesc()
                .stream().map(SharedResourceHistoryDto::fromEntity).collect(Collectors.toList());
    }
}
