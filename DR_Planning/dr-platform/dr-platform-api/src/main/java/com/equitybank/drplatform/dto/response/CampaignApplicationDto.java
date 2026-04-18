package com.equitybank.drplatform.dto.response;

import com.equitybank.drplatform.entity.ApplicationEntity;
import com.equitybank.drplatform.entity.CampaignApplicationEntity;
import lombok.*;

import java.time.Instant;
import java.time.LocalDate;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CampaignApplicationDto {
    private UUID id;
    private UUID campaignId;
    private UUID applicationId;
    private String applicationName;
    private String applicationCode;
    private String applicationTier;
    private String drActivityType;
    private LocalDate drDate;
    private String status;
    private String warRoomLocation;
    private String notes;
    private String deferralReason;
    private LocalDate runbookDeadline;
    private LocalDate peerReviewDeadline;
    private LocalDate itscmApprovalDeadline;
    private LocalDate checklistDeadline;
    private Instant createdAt;

    public static CampaignApplicationDto fromEntity(CampaignApplicationEntity e, ApplicationEntity app) {
        return CampaignApplicationDto.builder()
                .id(e.getId())
                .campaignId(e.getCampaignId())
                .applicationId(e.getApplicationId())
                .applicationName(app != null ? app.getName() : null)
                .applicationCode(app != null ? app.getCode() : null)
                .applicationTier(app != null ? app.getTier() : null)
                .drActivityType(e.getDrActivityType() != null ? e.getDrActivityType().name() : null)
                .drDate(e.getDrDate())
                .status(e.getStatus() != null ? e.getStatus().name() : null)
                .warRoomLocation(e.getWarRoomLocation())
                .notes(e.getNotes())
                .deferralReason(e.getDeferralReason())
                .runbookDeadline(e.getRunbookDeadline())
                .peerReviewDeadline(e.getPeerReviewDeadline())
                .itscmApprovalDeadline(e.getItscmApprovalDeadline())
                .checklistDeadline(e.getChecklistDeadline())
                .createdAt(e.getCreatedAt())
                .build();
    }

    public static CampaignApplicationDto fromEntity(CampaignApplicationEntity e) {
        return fromEntity(e, null);
    }
}
