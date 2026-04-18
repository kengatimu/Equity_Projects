package com.equitybank.drplatform.dto.response;

import com.equitybank.drplatform.entity.CampaignEntity;
import lombok.*;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CampaignDto {
    private UUID id;
    private String name;
    private String quarter;
    private int year;
    /** Primary subsidiary (first in subsidiaryIds list) — kept for backward compat. */
    private String subsidiaryId;
    /** All participating subsidiaries. */
    private List<String> subsidiaryIds;
    /** Preferred DR start time in 24-hour EAT format (e.g. "22:00"). */
    private String preferredStartTime;
    private UUID coordinatorId;
    private String status;
    private LocalDate plannedDrDate;
    private String activityType;
    private String description;
    private LocalDateTime preDrOpenedAt;
    private LocalDateTime approvedAt;
    private Instant createdAt;
    private Instant updatedAt;
    private List<CampaignApplicationDto> applications;

    public static CampaignDto fromEntity(CampaignEntity e) {
        List<String> subs = e.getSubsidiaryIds() != null
                ? new ArrayList<>(e.getSubsidiaryIds())
                : new ArrayList<>();
        // Ensure the primary subsidiaryId is included (backward-compat guard)
        if (e.getSubsidiaryId() != null && !subs.contains(e.getSubsidiaryId())) {
            subs.add(0, e.getSubsidiaryId());
        }
        return CampaignDto.builder()
                .id(e.getId())
                .name(e.getName())
                .quarter(e.getQuarter())
                .year(e.getYear())
                .subsidiaryId(subs.isEmpty() ? e.getSubsidiaryId() : subs.get(0))
                .subsidiaryIds(subs)
                .preferredStartTime(e.getPreferredStartTime())
                .coordinatorId(e.getCoordinatorId())
                .status(e.getStatus() != null ? e.getStatus().name() : null)
                .plannedDrDate(e.getPlannedDrDate())
                .activityType(e.getActivityType() != null ? e.getActivityType().name() : null)
                .description(e.getDescription())
                .preDrOpenedAt(e.getPreDrOpenedAt())
                .approvedAt(e.getApprovedAt())
                .createdAt(e.getCreatedAt())
                .updatedAt(e.getUpdatedAt())
                .build();
    }
}
