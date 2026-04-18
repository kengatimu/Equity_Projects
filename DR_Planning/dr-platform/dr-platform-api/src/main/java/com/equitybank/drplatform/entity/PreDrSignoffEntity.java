package com.equitybank.drplatform.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;
import java.util.UUID;

@Entity
@Table(name = "pre_dr_signoffs")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PreDrSignoffEntity extends BaseEntity {

    @Column(name = "campaign_application_id", unique = true, nullable = false)
    private UUID campaignApplicationId;

    @Column(name = "submitted_by_id")
    private UUID submittedById;

    @Column(name = "submitted_at")
    private LocalDateTime submittedAt;

    @Column(name = "coordinator_acknowledged_by_id")
    private UUID coordinatorAcknowledgedById;

    @Column(name = "coordinator_acknowledged_at")
    private LocalDateTime coordinatorAcknowledgedAt;

    @Column(name = "notes", columnDefinition = "TEXT")
    private String notes;
}
