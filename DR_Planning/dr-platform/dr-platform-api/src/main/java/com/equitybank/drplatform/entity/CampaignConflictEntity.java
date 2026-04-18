package com.equitybank.drplatform.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "campaign_conflicts", indexes = {
    @Index(name = "idx_conflicts_campaign", columnList = "campaign_id")
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CampaignConflictEntity extends BaseEntity {

    @Column(name = "campaign_id", nullable = false)
    private UUID campaignId;

    @Column(name = "conflict_type", nullable = false, length = 50)
    private String conflictType;

    @JdbcTypeCode(SqlTypes.ARRAY)
    @Column(name = "application_ids", columnDefinition = "uuid[]")
    private UUID[] applicationIds;

    @Column(name = "description", columnDefinition = "TEXT", nullable = false)
    private String description;

    @Column(name = "recommendation", columnDefinition = "TEXT")
    private String recommendation;

    @Column(name = "resolution", length = 50)
    private String resolution;

    @Column(name = "resolution_reason", columnDefinition = "TEXT")
    private String resolutionReason;

    @Column(name = "resolved_by_id")
    private UUID resolvedById;

    @Column(name = "resolved_at")
    private Instant resolvedAt;
}
