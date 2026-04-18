package com.equitybank.drplatform.service;

import com.equitybank.drplatform.dto.response.DashboardDto;
import com.equitybank.drplatform.entity.ApplicationEntity;
import com.equitybank.drplatform.entity.CampaignApplicationEntity;
import com.equitybank.drplatform.entity.CampaignEntity;
import com.equitybank.drplatform.enums.CampaignApplicationStatus;
import com.equitybank.drplatform.enums.CampaignStatus;
import com.equitybank.drplatform.repository.ApplicationRepository;
import com.equitybank.drplatform.repository.CampaignApplicationRepository;
import com.equitybank.drplatform.repository.CampaignConflictRepository;
import com.equitybank.drplatform.repository.CampaignRepository;
import com.equitybank.drplatform.repository.ChecklistBlockerRepository;
import com.equitybank.drplatform.repository.ChecklistItemRepository;
import com.equitybank.drplatform.security.DrPlatformUserDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
public class DashboardService {

    private final CampaignRepository campaignRepository;
    private final CampaignApplicationRepository campaignApplicationRepository;
    private final CampaignConflictRepository campaignConflictRepository;
    private final ChecklistItemRepository checklistItemRepository;
    private final ChecklistBlockerRepository checklistBlockerRepository;
    private final ApplicationRepository applicationRepository;

    @Transactional(readOnly = true)
    public DashboardDto getCoordinatorDashboard(UUID coordinatorId, String subsidiaryId) {
        // Active campaigns
        List<CampaignEntity> activeCampaigns = campaignRepository
                .findByCoordinatorIdAndStatusIn(coordinatorId,
                        List.of(CampaignStatus.DRAFT, CampaignStatus.PRE_DR_OPEN,
                                CampaignStatus.APPROVED, CampaignStatus.IN_PROGRESS));

        List<DashboardDto.CampaignProgressDto> campaignProgress = activeCampaigns.stream()
                .map(c -> buildCampaignProgress(c))
                .toList();

        // Upcoming DR events (next 30 days)
        List<CampaignApplicationEntity> upcoming = campaignApplicationRepository
                .findUpcomingDrEvents(LocalDate.now(), LocalDate.now().plusDays(30));

        List<DashboardDto.UpcomingDrEventDto> upcomingEvents = upcoming.stream()
                .map(ca -> {
                    ApplicationEntity app = applicationRepository.findById(ca.getApplicationId()).orElse(null);
                    return new DashboardDto.UpcomingDrEventDto(
                            ca.getId(),
                            ca.getCampaignId(),
                            ca.getApplicationId(),
                            app != null ? app.getCode() : "UNKNOWN",
                            app != null ? app.getName() : "Unknown Application",
                            ca.getDrDate(),
                            ca.getStatus().name(),
                            ca.getWarRoomLocation()
                    );
                })
                .toList();

        // Blocker summary
        long openBlockers = checklistBlockerRepository.countOpenBlockers();
        long criticalBlockers = checklistBlockerRepository.countCriticalOpenBlockers();
        long overdueItems = campaignApplicationRepository.countOverdueItscmApprovals(LocalDate.now());

        DashboardDto.BlockerSummaryDto blockerSummary = new DashboardDto.BlockerSummaryDto(
                openBlockers, criticalBlockers, overdueItems);

        // Runbook status summary across active campaigns
        long totalApps = 0;
        long runbookDone = 0;
        long pendingReview = 0;
        long overdue = 0;

        for (CampaignEntity campaign : activeCampaigns) {
            List<CampaignApplicationEntity> apps = campaignApplicationRepository.findByCampaignId(campaign.getId());
            totalApps += apps.size();
            runbookDone += apps.stream()
                    .filter(ca -> ca.getStatus().ordinal() >= CampaignApplicationStatus.APPROVED.ordinal())
                    .count();
            pendingReview += apps.stream()
                    .filter(ca -> ca.getStatus() == CampaignApplicationStatus.PRE_DR_OPEN)
                    .count();
            overdue += apps.stream()
                    .filter(ca -> ca.getRunbookDeadline() != null
                            && ca.getRunbookDeadline().isBefore(LocalDate.now())
                            && ca.getStatus() == CampaignApplicationStatus.PLANNED)
                    .count();
        }

        DashboardDto.RunbookStatusSummaryDto runbookSummary = new DashboardDto.RunbookStatusSummaryDto(
                totalApps, runbookDone, pendingReview, overdue);

        // Unresolved conflicts summary
        long unresolvedConflicts = activeCampaigns.stream()
                .mapToLong(c -> campaignConflictRepository.countUnresolvedByCampaignId(c.getId()))
                .sum();

        return new DashboardDto(
                campaignProgress,
                upcomingEvents,
                blockerSummary,
                runbookSummary,
                unresolvedConflicts,
                activeCampaigns.size()
        );
    }

    @Transactional(readOnly = true)
    public DashboardDto getAppOwnerDashboard(UUID appOwnerId) {
        List<CampaignApplicationEntity> myApps = campaignApplicationRepository.findByApplicationOwnerId(appOwnerId);

        List<DashboardDto.UpcomingDrEventDto> upcomingEvents = myApps.stream()
                .filter(ca -> ca.getDrDate() != null && !ca.getDrDate().isBefore(LocalDate.now()))
                .filter(ca -> ca.getStatus() != CampaignApplicationStatus.CANCELLED
                        && ca.getStatus() != CampaignApplicationStatus.DEFERRED)
                .map(ca -> {
                    ApplicationEntity app = applicationRepository.findById(ca.getApplicationId()).orElse(null);
                    return new DashboardDto.UpcomingDrEventDto(
                            ca.getId(),
                            ca.getCampaignId(),
                            ca.getApplicationId(),
                            app != null ? app.getCode() : "UNKNOWN",
                            app != null ? app.getName() : "Unknown",
                            ca.getDrDate(),
                            ca.getStatus().name(),
                            ca.getWarRoomLocation()
                    );
                })
                .toList();

        long openBlockers = myApps.stream()
                .mapToLong(ca -> checklistBlockerRepository.countOpenBlockersByCampaignApplicationId(ca.getId()))
                .sum();

        return DashboardDto.forAppOwner(upcomingEvents, openBlockers, myApps.size());
    }

    @Transactional(readOnly = true)
    public List<DashboardDto.TimelineEventDto> getCampaignTimeline(UUID campaignId) {
        List<CampaignApplicationEntity> apps = campaignApplicationRepository.findByCampaignId(campaignId);
        List<DashboardDto.TimelineEventDto> timeline = new ArrayList<>();

        for (CampaignApplicationEntity ca : apps) {
            ApplicationEntity app = applicationRepository.findById(ca.getApplicationId()).orElse(null);
            String appName = app != null ? app.getCode() : ca.getApplicationId().toString();

            if (ca.getRunbookDeadline() != null) {
                timeline.add(new DashboardDto.TimelineEventDto(
                        ca.getRunbookDeadline(), "RUNBOOK_DUE", appName, ca.getApplicationId(), isOverdue(ca.getRunbookDeadline())));
            }
            if (ca.getPeerReviewDeadline() != null) {
                timeline.add(new DashboardDto.TimelineEventDto(
                        ca.getPeerReviewDeadline(), "PEER_REVIEW_DUE", appName, ca.getApplicationId(), isOverdue(ca.getPeerReviewDeadline())));
            }
            if (ca.getItscmApprovalDeadline() != null) {
                timeline.add(new DashboardDto.TimelineEventDto(
                        ca.getItscmApprovalDeadline(), "ITSCM_APPROVAL_DUE", appName, ca.getApplicationId(), isOverdue(ca.getItscmApprovalDeadline())));
            }
            if (ca.getChecklistDeadline() != null) {
                timeline.add(new DashboardDto.TimelineEventDto(
                        ca.getChecklistDeadline(), "CHECKLIST_DUE", appName, ca.getApplicationId(), isOverdue(ca.getChecklistDeadline())));
            }
            if (ca.getDrDate() != null) {
                timeline.add(new DashboardDto.TimelineEventDto(
                        ca.getDrDate(), "DR_DATE", appName, ca.getApplicationId(), false));
            }
        }

        timeline.sort(java.util.Comparator.comparing(DashboardDto.TimelineEventDto::getDate));
        return timeline;
    }

    private DashboardDto.CampaignProgressDto buildCampaignProgress(CampaignEntity campaign) {
        List<CampaignApplicationEntity> apps = campaignApplicationRepository.findByCampaignId(campaign.getId());
        long total = apps.size();
        long completed = apps.stream()
                .filter(ca -> ca.getStatus() == CampaignApplicationStatus.COMPLETED
                        || ca.getStatus() == CampaignApplicationStatus.VALIDATION)
                .count();
        long unresolvedConflicts = campaignConflictRepository.countUnresolvedByCampaignId(campaign.getId());

        return new DashboardDto.CampaignProgressDto(
                campaign.getId(),
                campaign.getName(),
                campaign.getStatus().name(),
                total,
                completed,
                total > 0 ? (int) Math.round((double) completed / total * 100) : 0,
                unresolvedConflicts,
                campaign.getPlannedDrDate()
        );
    }

    private boolean isOverdue(LocalDate deadline) {
        return deadline != null && deadline.isBefore(LocalDate.now());
    }
}
