package com.equitybank.drplatform.dto.response;

import lombok.*;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DashboardDto {

    private List<CampaignProgressDto> activeCampaigns;
    private List<UpcomingDrEventDto> upcomingEvents;
    private BlockerSummaryDto blockerSummary;
    private RunbookStatusSummaryDto runbookStatusSummary;
    private long unresolvedConflicts;
    private int activeCampaignCount;

    /** App owner dashboard factory. */
    public static DashboardDto forAppOwner(List<UpcomingDrEventDto> upcomingEvents,
                                           long openBlockers,
                                           int totalApps) {
        return DashboardDto.builder()
                .upcomingEvents(upcomingEvents)
                .blockerSummary(new BlockerSummaryDto(openBlockers, 0, 0))
                .runbookStatusSummary(new RunbookStatusSummaryDto(totalApps, 0, 0, 0))
                .build();
    }

    @Getter
    @Setter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class CampaignProgressDto {
        private UUID campaignId;
        private String campaignName;
        private String status;
        private long totalApps;
        private long completedApps;
        private int readinessPercent;
        private long unresolvedConflicts;
        private LocalDate plannedDrDate;
    }

    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class UpcomingDrEventDto {
        private UUID campaignApplicationId;
        private UUID campaignId;
        private UUID applicationId;
        private String applicationCode;
        private String applicationName;
        private LocalDate drDate;
        private String status;
        private String warRoomLocation;
    }

    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class BlockerSummaryDto {
        private long openBlockers;
        private long criticalBlockers;
        private long overdueItems;
    }

    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class RunbookStatusSummaryDto {
        private long totalApps;
        private long runbookApproved;
        private long pendingReview;
        private long overdue;
    }

    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class TimelineEventDto {
        private LocalDate date;
        private String eventType;
        private String applicationCode;
        private UUID applicationId;
        private boolean overdue;
    }
}
