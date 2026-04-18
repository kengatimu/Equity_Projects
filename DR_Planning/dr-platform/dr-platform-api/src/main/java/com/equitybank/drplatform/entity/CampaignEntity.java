package com.equitybank.drplatform.entity;

import com.equitybank.drplatform.enums.CampaignStatus;
import com.equitybank.drplatform.enums.DrActivityType;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "campaigns", indexes = {
    @Index(name = "idx_campaign_subsidiary", columnList = "subsidiary_id"),
    @Index(name = "idx_campaign_coordinator", columnList = "coordinator_id"),
    @Index(name = "idx_campaign_status", columnList = "status")
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CampaignEntity extends AuditableEntity {

    @Column(name = "name", nullable = false, length = 200)
    private String name;

    @Column(name = "quarter", nullable = false, length = 5)
    private String quarter;

    @Column(name = "year", nullable = false)
    private int year;

    /** Primary subsidiary — kept for backward-compat with existing queries/indexes. */
    @Column(name = "subsidiary_id", length = 10)
    private String subsidiaryId;

    /** All participating subsidiaries (persisted in campaign_subsidiaries junction table). */
    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(
        name = "campaign_subsidiaries",
        joinColumns = @JoinColumn(name = "campaign_id")
    )
    @Column(name = "subsidiary_id", length = 10)
    @Builder.Default
    private List<String> subsidiaryIds = new ArrayList<>();

    /** Preferred DR start time in 24-hour EAT format, e.g. "22:00". Optional. */
    @Column(name = "preferred_start_time", length = 10)
    private String preferredStartTime;

    @Column(name = "coordinator_id")
    private UUID coordinatorId;

    @Enumerated(EnumType.STRING)
    @Column(name = "status", length = 30)
    @Builder.Default
    private CampaignStatus status = CampaignStatus.DRAFT;

    @Column(name = "planned_dr_date")
    private LocalDate plannedDrDate;

    @Enumerated(EnumType.STRING)
    @Column(name = "activity_type", length = 50)
    private DrActivityType activityType;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "pre_dr_opened_at")
    private LocalDateTime preDrOpenedAt;

    @Column(name = "approved_at")
    private LocalDateTime approvedAt;
}
