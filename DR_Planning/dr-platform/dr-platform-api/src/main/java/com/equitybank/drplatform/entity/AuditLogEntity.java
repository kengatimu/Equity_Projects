package com.equitybank.drplatform.entity;

import com.equitybank.drplatform.config.UuidV7Generator;
import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Immutable;
import org.hibernate.annotations.CreationTimestamp;

import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "audit_log", indexes = {
    @Index(name = "idx_audit_log_actor",    columnList = "actor_id"),
    @Index(name = "idx_audit_log_campaign", columnList = "campaign_id"),
    @Index(name = "idx_audit_log_resource", columnList = "resource_type, resource_id")
})
@Immutable
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AuditLogEntity {

    @Id
    @GeneratedValue(generator = "uuid7")
    @GenericGenerator(name = "uuid7", type = UuidV7Generator.class)
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "actor_id")
    private UUID actorId;

    /** Denormalised email — kept even if the user record is later deleted. */
    @Column(name = "actor_email", length = 255)
    private String actorEmail;

    @Column(name = "actor_ip", length = 45)
    private String actorIp;

    @Column(name = "actor_role", length = 50)
    private String actorRole;

    @Column(name = "action", nullable = false, length = 100)
    private String action;

    @Column(name = "resource_type", length = 100)
    private String resourceType;

    @Column(name = "resource_id")
    private UUID resourceId;

    @Column(name = "campaign_id")
    private UUID campaignId;

    @Column(name = "subsidiary_id", length = 10)
    private String subsidiaryId;

    @Column(name = "before_state", columnDefinition = "jsonb")
    private String beforeState;

    @Column(name = "after_state", columnDefinition = "jsonb")
    private String afterState;

    @Column(name = "session_id", length = 100)
    private String sessionId;

    @Column(name = "user_agent", columnDefinition = "TEXT")
    private String userAgent;

    @CreationTimestamp
    @Column(name = "timestamp", nullable = false, updatable = false)
    private Instant timestamp;
}
