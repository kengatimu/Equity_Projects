package com.equitybank.drplatform.service;

import com.equitybank.drplatform.audit.Auditable;
import com.equitybank.drplatform.dto.request.CreateApplicationRequest;
import com.equitybank.drplatform.dto.response.ApplicationDto;
import com.equitybank.drplatform.dto.response.ApplicationHistoryDto;
import com.equitybank.drplatform.dto.response.PagedResponse;
import com.equitybank.drplatform.entity.ApplicationEntity;
import com.equitybank.drplatform.entity.ApplicationHistoryEntity;
import com.equitybank.drplatform.exception.ConflictException;
import com.equitybank.drplatform.exception.ResourceNotFoundException;
import com.equitybank.drplatform.repository.ApplicationHistoryRepository;
import com.equitybank.drplatform.repository.ApplicationRepository;
import com.equitybank.drplatform.repository.CampaignApplicationRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
@Transactional
@RequiredArgsConstructor
public class ApplicationService {

    private final ApplicationRepository applicationRepository;
    private final CampaignApplicationRepository campaignApplicationRepository;
    private final ApplicationHistoryRepository applicationHistoryRepository;

    @Auditable(action = "APPLICATION_CREATED", resourceType = "application")
    public ApplicationDto createApplication(CreateApplicationRequest request) {
        if (applicationRepository.existsByCode(request.getCode())) {
            throw new ConflictException("Application with code already exists: " + request.getCode());
        }
        ApplicationEntity app = ApplicationEntity.builder()
                .code(request.getCode())
                .name(request.getName())
                .tier(request.getTier())
                .subsidiaryId(request.getSubsidiaryId())
                .hasDr(request.isHasDr())
                .dcEndpoint(request.getDcEndpoint())
                .drEndpoint(request.getDrEndpoint())
                .dcServers(request.getDcServers())
                .drServers(request.getDrServers())
                .techOwnerId(request.getTechOwnerId())
                .businessOwner(request.getBusinessOwner())
                .businessOwnerEmail(request.getBusinessOwnerEmail())
                .techOwnerName(request.getTechOwnerName())
                .techOwnerEmail(request.getTechOwnerEmail())
                .description(request.getDescription())
                .directCustomerImpact(request.isDirectCustomerImpact())
                .drCapability(request.getDrCapability())
                .vendor(request.getVendor())
                .notes(request.getNotes())
                .scheduleHalf(request.getScheduleHalf())
                .drQuarter(request.getDrQuarter())
                .preferredDrMonth(request.getPreferredDrMonth())
                .preferredDrTime(request.getPreferredDrTime())
                .hasInterdependency(request.isHasInterdependency())
                .isActive(true)
                .build();
        return ApplicationDto.fromEntity(applicationRepository.save(app));
    }

    @Auditable(action = "APPLICATION_UPDATED", resourceType = "application")
    public ApplicationDto updateApplication(UUID id, CreateApplicationRequest request) {
        ApplicationEntity app = findById(id);
        app.setName(request.getName());
        app.setTier(request.getTier());
        app.setSubsidiaryId(request.getSubsidiaryId());
        app.setHasDr(request.isHasDr());
        app.setDcEndpoint(request.getDcEndpoint());
        app.setDrEndpoint(request.getDrEndpoint());
        app.setDcServers(request.getDcServers());
        app.setDrServers(request.getDrServers());
        app.setTechOwnerId(request.getTechOwnerId());
        app.setBusinessOwner(request.getBusinessOwner());
        app.setBusinessOwnerEmail(request.getBusinessOwnerEmail());
        app.setTechOwnerName(request.getTechOwnerName());
        app.setTechOwnerEmail(request.getTechOwnerEmail());
        app.setDescription(request.getDescription());
        app.setDirectCustomerImpact(request.isDirectCustomerImpact());
        app.setDrCapability(request.getDrCapability());
        app.setVendor(request.getVendor());
        app.setNotes(request.getNotes());
        app.setScheduleHalf(request.getScheduleHalf());
        app.setDrQuarter(request.getDrQuarter());
        app.setPreferredDrMonth(request.getPreferredDrMonth());
        app.setPreferredDrTime(request.getPreferredDrTime());
        app.setHasInterdependency(request.isHasInterdependency());
        return ApplicationDto.fromEntity(applicationRepository.save(app));
    }

    @Auditable(action = "APPLICATION_DEACTIVATED", resourceType = "application")
    public void deactivateApplication(UUID id) {
        ApplicationEntity app = findById(id);
        app.setActive(false);
        applicationRepository.save(app);
    }

    /**
     * Archives an application: copies full row to application_history,
     * then hard-deletes from the applications table (and its dependencies).
     * APP_OWNER can only archive apps where they are the registered tech owner.
     */
    @Auditable(action = "APPLICATION_ARCHIVED", resourceType = "application")
    public void archiveApplication(UUID id, UUID actorId, String actorEmail) {
        ApplicationEntity app = findById(id);
        // Copy to history
        applicationHistoryRepository.save(
                ApplicationHistoryEntity.from(app, actorId, actorEmail));
        // Hard-delete
        applicationRepository.delete(app);
    }

    /**
     * Restores an archived application from history back to the live applications table.
     * The history record is removed after a successful restore.
     */
    @Transactional
    @Auditable(action = "APPLICATION_RESTORED", resourceType = "application")
    public ApplicationDto restoreApplication(UUID historyId) {
        ApplicationHistoryEntity history = applicationHistoryRepository.findById(historyId)
                .orElseThrow(() -> new ResourceNotFoundException("ApplicationHistory", historyId));

        ApplicationEntity restored = ApplicationEntity.builder()
                .code(history.getCode())
                .name(history.getName())
                .tier(history.getTier())
                .subsidiaryId(history.getSubsidiaryId())
                .hasDr(history.isHasDr())
                .dcEndpoint(history.getDcEndpoint())
                .drEndpoint(history.getDrEndpoint())
                .dcServers(history.getDcServers())
                .drServers(history.getDrServers())
                .techOwnerId(history.getTechOwnerId())
                .businessOwner(history.getBusinessOwner())
                .businessOwnerEmail(history.getBusinessOwnerEmail())
                .techOwnerName(history.getTechOwnerName())
                .techOwnerEmail(history.getTechOwnerEmail())
                .description(history.getDescription())
                .directCustomerImpact(history.isDirectCustomerImpact())
                .hasDependency(history.isHasDependency())
                .drCapability(history.getDrCapability())
                .vendor(history.getVendor())
                .notes(history.getNotes())
                .scheduleHalf(history.getScheduleHalf())
                .drQuarter(history.getDrQuarter())
                .preferredDrMonth(history.getPreferredDrMonth())
                .preferredDrTime(history.getPreferredDrTime())
                .hasInterdependency(history.isHasInterdependency())
                .isActive(true)
                .build();
        // Preserve the original identity and timestamps
        restored.setId(history.getId());
        restored.setCreatedAt(history.getOriginalCreatedAt());
        restored.setUpdatedAt(history.getOriginalUpdatedAt());

        ApplicationEntity saved = applicationRepository.save(restored);
        applicationHistoryRepository.delete(history);
        return ApplicationDto.fromEntity(saved);
    }

    /**
     * Returns the full archive history, most recently archived first.
     */
    @Transactional(readOnly = true)
    public List<ApplicationHistoryDto> getArchiveHistory() {
        return applicationHistoryRepository.findAllByOrderByArchivedAtDesc()
                .stream().map(ApplicationHistoryDto::fromEntity)
                .collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public ApplicationDto getById(UUID id) {
        return ApplicationDto.fromEntity(findById(id));
    }

    @Transactional(readOnly = true)
    public PagedResponse<ApplicationDto> listAll(Pageable pageable) {
        return PagedResponse.from(applicationRepository.findByIsActiveTrue(pageable).map(ApplicationDto::fromEntity));
    }

    @Transactional(readOnly = true)
    public PagedResponse<ApplicationDto> search(String name, String tier, String subsidiaryId, Pageable pageable) {
        Page<ApplicationEntity> page;
        if (name != null && !name.isBlank()) {
            page = applicationRepository.findByNameContainingIgnoreCaseAndIsActiveTrue(name, pageable);
        } else if (tier != null && subsidiaryId != null) {
            page = applicationRepository.findByTierAndSubsidiaryIdAndIsActiveTrue(tier, subsidiaryId, pageable);
        } else if (tier != null) {
            page = applicationRepository.findByTierAndIsActiveTrue(tier, pageable);
        } else if (subsidiaryId != null) {
            page = applicationRepository.findBySubsidiaryIdAndIsActiveTrue(subsidiaryId, pageable);
        } else {
            page = applicationRepository.findByIsActiveTrue(pageable);
        }
        return PagedResponse.from(page.map(ApplicationDto::fromEntity));
    }

    @Transactional(readOnly = true)
    public List<ApplicationDto> listByOwner(UUID userId) {
        return applicationRepository.findByTechOwnerIdAndIsActiveTrue(userId)
                .stream().map(ApplicationDto::fromEntity).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<ApplicationDto> listBySubsidiary(String subsidiaryId) {
        return applicationRepository.findBySubsidiaryIdAndIsActiveTrue(subsidiaryId)
                .stream().map(ApplicationDto::fromEntity).collect(Collectors.toList());
    }

    @Transactional(readOnly = true)
    public List<ApplicationDto> getApplicationsForCampaign(UUID campaignId) {
        return campaignApplicationRepository.findByCampaignId(campaignId).stream()
                .map(ca -> applicationRepository.findById(ca.getApplicationId()))
                .filter(java.util.Optional::isPresent)
                .map(opt -> ApplicationDto.fromEntity(opt.get()))
                .collect(Collectors.toList());
    }

    private ApplicationEntity findById(UUID id) {
        return applicationRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Application", id));
    }
}
