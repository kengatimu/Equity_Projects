package com.equitybank.drplatform.entity;

import com.equitybank.drplatform.enums.CampaignApplicationStatus;
import com.equitybank.drplatform.enums.DrActivityType;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.util.UUID;

@Entity
@Table(name = "campaign_applications", indexes = {
    @Index(name = "idx_ca_campaign",  columnList = "campaign_id"),
    @Index(name = "idx_ca_app",       columnList = "application_id"),
    @Index(name = "idx_ca_deadlines", columnList = "itscm_approval_deadline"),
    @Index(name = "idx_ca_dr_date",   columnList = "dr_date")
}, uniqueConstraints = {
    @UniqueConstraint(name = "uq_campaign_app", columnNames = {"campaign_id", "application_id"})
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CampaignApplicationEntity extends AuditableEntity {

    @Column(name = "campaign_id", nullable = false)
    private UUID campaignId;

    @Column(name = "application_id", nullable = false)
    private UUID applicationId;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", length = 30)
    @Builder.Default
    private CampaignApplicationStatus status = CampaignApplicationStatus.PLANNED;

    @Column(name = "dr_date")
    private LocalDate drDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "dr_activity_type", length = 50)
    private DrActivityType drActivityType;

    @Column(name = "war_room_location", length = 300)
    private String warRoomLocation;

    @Column(name = "notes", columnDefinition = "TEXT")
    private String notes;

    @Column(name = "deferral_reason", columnDefinition = "TEXT")
    private String deferralReason;

    // Auto-calculated deadlines (T-21, T-14, T-10, T-3)
    @Column(name = "runbook_deadline")
    private LocalDate runbookDeadline;

    @Column(name = "peer_review_deadline")
    private LocalDate peerReviewDeadline;

    @Column(name = "itscm_approval_deadline")
    private LocalDate itscmApprovalDeadline;

    @Column(name = "checklist_deadline")
    private LocalDate checklistDeadline;
}
