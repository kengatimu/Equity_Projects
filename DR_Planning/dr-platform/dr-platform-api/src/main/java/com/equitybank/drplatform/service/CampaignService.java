package com.equitybank.drplatform.service;

import com.equitybank.drplatform.audit.Auditable;
import com.equitybank.drplatform.dto.request.AddApplicationToCampaignRequest;
import com.equitybank.drplatform.dto.request.CreateCampaignRequest;
import com.equitybank.drplatform.dto.response.CampaignApplicationDto;
import com.equitybank.drplatform.dto.response.CampaignDto;
import com.equitybank.drplatform.dto.response.DeadlineSetDto;
import com.equitybank.drplatform.dto.response.PagedResponse;
import com.equitybank.drplatform.entity.ApplicationEntity;
import com.equitybank.drplatform.entity.CampaignApplicationEntity;
import com.equitybank.drplatform.entity.CampaignEntity;
import com.equitybank.drplatform.enums.CampaignApplicationStatus;
import com.equitybank.drplatform.enums.CampaignStatus;
import com.equitybank.drplatform.exception.ConflictException;
import com.equitybank.drplatform.exception.ResourceNotFoundException;
import com.equitybank.drplatform.exception.ValidationException;
import com.equitybank.drplatform.repository.ApplicationRepository;
import com.equitybank.drplatform.repository.CampaignApplicationRepository;
import com.equitybank.drplatform.repository.CampaignConflictRepository;
import com.equitybank.drplatform.repository.CampaignRepository;
import com.equitybank.drplatform.repository.PreDrSignoffRepository;
import com.equitybank.drplatform.security.DrPlatformUserDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class CampaignService {

    private final CampaignRepository campaignRepository;
    private final CampaignApplicationRepository campaignApplicationRepository;
    private final CampaignConflictRepository campaignConflictRepository;
    private final ApplicationRepository applicationRepository;
    private final PreDrSignoffRepository preDrSignoffRepository;
    private final DeadlineCalculatorService deadlineCalculatorService;
    private final DependencyEngineService dependencyEngineService;
    private final ChecklistService checklistService;

    public record GateCheckResult(boolean passed, List<String> failureReasons) {
        public static GateCheckResult pass() {
            return new GateCheckResult(true, List.of());
        }
        public static GateCheckResult fail(List<String> reasons) {
            return new GateCheckResult(false, reasons);
        }
    }

    @Auditable(action = "CAMPAIGN_CREATED", resourceType = "Campaign")
    @Transactional
    public CampaignDto createCampaign(CreateCampaignRequest req) {
        UUID coordinatorId = currentUserId();
        CampaignEntity entity = new CampaignEntity();
        entity.setName(req.getName());
        entity.setQuarter(req.getQuarter());
        entity.setYear(req.getYear());
        // Multi-subsidiary: store all; keep primary for backward-compat queries/indexes
        entity.setSubsidiaryIds(req.getSubsidiaryIds());
        entity.setSubsidiaryId(req.getSubsidiaryIds().get(0));
        entity.setPreferredStartTime(req.getPreferredStartTime());
        entity.setCoordinatorId(coordinatorId);
        entity.setStatus(CampaignStatus.DRAFT);
        entity.setPlannedDrDate(req.getPlannedDrDate());
        entity.setActivityType(req.getActivityType());
        entity.setDescription(req.getDescription());
        CampaignEntity saved = campaignRepository.save(entity);
        return CampaignDto.fromEntity(saved);
    }

    @Auditable(action = "APPLICATION_ADDED_TO_CAMPAIGN", resourceType = "CampaignApplication")
    @Transactional
    public CampaignApplicationDto addApplication(UUID campaignId, AddApplicationToCampaignRequest req) {
        CampaignEntity campaign = campaignRepository.findById(campaignId)
                .orElseThrow(() -> new ResourceNotFoundException("Campaign", campaignId));

        if (campaign.getStatus() != CampaignStatus.DRAFT && campaign.getStatus() != CampaignStatus.PRE_DR_OPEN) {
            throw new ValidationException("Applications can only be added when campaign is in DRAFT or PRE_DR_OPEN status");
        }

        ApplicationEntity application = applicationRepository.findById(req.getApplicationId())
                .orElseThrow(() -> new ResourceNotFoundException("Application", req.getApplicationId()));

        boolean alreadyAdded = campaignApplicationRepository
                .existsByCampaignIdAndApplicationId(campaignId, req.getApplicationId());
        if (alreadyAdded) {
            throw new ConflictException("Application " + application.getCode() + " is already in this campaign");
        }

        DeadlineSetDto deadlines = deadlineCalculatorService.calculateDeadlines(
                req.getDrDate() != null ? req.getDrDate() : campaign.getPlannedDrDate());

        CampaignApplicationEntity ca = new CampaignApplicationEntity();
        ca.setCampaignId(campaignId);
        ca.setApplicationId(req.getApplicationId());
        ca.setStatus(CampaignApplicationStatus.PLANNED);
        ca.setDrDate(req.getDrDate() != null ? req.getDrDate() : campaign.getPlannedDrDate());
        ca.setRunbookDeadline(deadlines.getRunbookDeadline());
        ca.setPeerReviewDeadline(deadlines.getPeerReviewDeadline());
        ca.setItscmApprovalDeadline(deadlines.getItscmApprovalDeadline());
        ca.setChecklistDeadline(deadlines.getChecklistDeadline());
        ca.setWarRoomLocation(req.getWarRoomLocation());
        ca.setNotes(req.getNotes());

        CampaignApplicationEntity saved = campaignApplicationRepository.save(ca);

        // Trigger async conflict scan
        dependencyEngineService.scanCampaignConflictsAsync(campaignId);

        // Auto-generate default checklist items
        checklistService.generateDefaultItems(saved.getId());

        return CampaignApplicationDto.fromEntity(saved, application);
    }

    @Auditable(action = "CAMPAIGN_PRE_DR_OPENED", resourceType = "Campaign")
    @Transactional
    public CampaignDto openPreDr(UUID campaignId) {
        CampaignEntity campaign = campaignRepository.findById(campaignId)
                .orElseThrow(() -> new ResourceNotFoundException("Campaign", campaignId));

        if (campaign.getStatus() != CampaignStatus.DRAFT) {
            throw new ValidationException("Campaign must be in DRAFT status to open Pre-DR");
        }

        long appCount = campaignApplicationRepository.countByCampaignId(campaignId);
        if (appCount == 0) {
            throw new ValidationException("Campaign must have at least one application before opening Pre-DR");
        }

        campaign.setStatus(CampaignStatus.PRE_DR_OPEN);
        campaign.setPreDrOpenedAt(java.time.LocalDateTime.now());
        CampaignEntity saved = campaignRepository.save(campaign);
        return CampaignDto.fromEntity(saved);
    }

    @Auditable(action = "CAMPAIGN_APPROVED", resourceType = "Campaign")
    @Transactional
    public CampaignDto approveCampaign(UUID campaignId) {
        CampaignEntity campaign = campaignRepository.findById(campaignId)
                .orElseThrow(() -> new ResourceNotFoundException("Campaign", campaignId));

        if (campaign.getStatus() != CampaignStatus.PRE_DR_OPEN) {
            throw new ValidationException("Campaign must be in PRE_DR_OPEN status to approve");
        }

        GateCheckResult gate = checkApprovalGate(campaignId);
        if (!gate.passed()) {
            throw new ValidationException("Approval gate failed: " + String.join("; ", gate.failureReasons()));
        }

        campaign.setStatus(CampaignStatus.APPROVED);
        campaign.setApprovedAt(java.time.LocalDateTime.now());
        CampaignEntity saved = campaignRepository.save(campaign);
        return CampaignDto.fromEntity(saved);
    }

    public GateCheckResult checkApprovalGate(UUID campaignId) {
        List<String> failures = new java.util.ArrayList<>();

        List<CampaignApplicationEntity> apps = campaignApplicationRepository.findByCampaignId(campaignId);

        for (CampaignApplicationEntity ca : apps) {
            // Check runbook submitted (status must be at least APPROVED)
            if (ca.getStatus() == CampaignApplicationStatus.PLANNED ||
                    ca.getStatus() == CampaignApplicationStatus.PRE_DR_OPEN) {
                ApplicationEntity app = applicationRepository.findById(ca.getApplicationId()).orElse(null);
                String appName = app != null ? app.getCode() : ca.getApplicationId().toString();
                failures.add(appName + ": runbook not yet approved");
            }

            // Check ITSCM approval not overdue
            if (ca.getItscmApprovalDeadline() != null && ca.getItscmApprovalDeadline().isBefore(LocalDate.now())
                    && ca.getStatus().ordinal() < CampaignApplicationStatus.APPROVED.ordinal()) {
                ApplicationEntity app = applicationRepository.findById(ca.getApplicationId()).orElse(null);
                String appName = app != null ? app.getCode() : ca.getApplicationId().toString();
                failures.add(appName + ": ITSCM approval overdue");
            }
        }

        // Check unresolved conflicts
        long unresolvedConflicts = campaignConflictRepository.countUnresolvedByCampaignId(campaignId);
        if (unresolvedConflicts > 0) {
            failures.add(unresolvedConflicts + " unresolved dependency conflict(s) must be addressed");
        }

        // Check all pre-DR signoffs submitted
        for (CampaignApplicationEntity ca : apps) {
            boolean signoffExists = preDrSignoffRepository.existsByCampaignApplicationId(ca.getId());
            if (!signoffExists && ca.getStatus() != CampaignApplicationStatus.DEFERRED
                    && ca.getStatus() != CampaignApplicationStatus.CANCELLED) {
                ApplicationEntity app = applicationRepository.findById(ca.getApplicationId()).orElse(null);
                String appName = app != null ? app.getCode() : ca.getApplicationId().toString();
                failures.add(appName + ": pre-DR signoff not submitted");
            }
        }

        return failures.isEmpty() ? GateCheckResult.pass() : GateCheckResult.fail(failures);
    }

    @Auditable(action = "APPLICATION_DEFERRED", resourceType = "CampaignApplication")
    @Transactional
    public CampaignApplicationDto deferApplication(UUID campaignId, UUID applicationId, String reason) {
        CampaignApplicationEntity ca = campaignApplicationRepository
                .findByCampaignIdAndApplicationId(campaignId, applicationId)
                .orElseThrow(() -> new ResourceNotFoundException("CampaignApplication",
                        UUID.fromString(campaignId + "-" + applicationId)));

        ca.setStatus(CampaignApplicationStatus.DEFERRED);
        ca.setDeferralReason(reason);
        CampaignApplicationEntity saved = campaignApplicationRepository.save(ca);
        ApplicationEntity app = applicationRepository.findById(applicationId)
                .orElseThrow(() -> new ResourceNotFoundException("Application", applicationId));
        return CampaignApplicationDto.fromEntity(saved, app);
    }

    @Transactional(readOnly = true)
    public CampaignDto getCampaignWithApplications(UUID campaignId) {
        CampaignEntity campaign = campaignRepository.findById(campaignId)
                .orElseThrow(() -> new ResourceNotFoundException("Campaign", campaignId));
        return CampaignDto.fromEntity(campaign);
    }

    @Transactional(readOnly = true)
    public PagedResponse<CampaignDto> listCampaigns(int page, int size, String subsidiaryId) {
        var pageable = PageRequest.of(page, size, Sort.by("createdAt").descending());
        var result = subsidiaryId != null
                ? campaignRepository.findBySubsidiaryId(subsidiaryId, pageable)
                : campaignRepository.findAll(pageable);
        return PagedResponse.from(result.map(CampaignDto::fromEntity));
    }

    @Transactional(readOnly = true)
    public GateCheckResult getApprovalGateStatus(UUID campaignId) {
        return checkApprovalGate(campaignId);
    }

    private UUID currentUserId() {
        var auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null && auth.getPrincipal() instanceof DrPlatformUserDetails ud) {
            return ud.getUser().getId();
        }
        throw new ValidationException("No authenticated user found");
    }
}
