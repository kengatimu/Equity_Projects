package com.equitybank.drplatform.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.UUID;

@Entity
@Table(name = "applications", indexes = {
    @Index(name = "idx_apps_subsidiary", columnList = "subsidiary_id"),
    @Index(name = "idx_apps_tier",       columnList = "tier"),
    @Index(name = "idx_apps_owner",      columnList = "tech_owner_id")
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ApplicationEntity extends AuditableEntity {

    @Column(name = "code", unique = true, nullable = false, length = 100)
    private String code;

    @Column(name = "name", nullable = false, length = 200)
    private String name;

    @Column(name = "tier", nullable = false, length = 5)
    private String tier;

    @Column(name = "subsidiary_id", nullable = false, length = 10)
    private String subsidiaryId;

    @Column(name = "has_dr")
    @Builder.Default
    private boolean hasDr = false;

    @Column(name = "dc_endpoint", columnDefinition = "TEXT")
    private String dcEndpoint;

    @Column(name = "dr_endpoint", columnDefinition = "TEXT")
    private String drEndpoint;

    @Column(name = "dc_servers", columnDefinition = "jsonb")
    @JdbcTypeCode(SqlTypes.JSON)
    private String dcServers;

    @Column(name = "dr_servers", columnDefinition = "jsonb")
    @JdbcTypeCode(SqlTypes.JSON)
    private String drServers;

    @Column(name = "tech_owner_id")
    private UUID techOwnerId;

    @Column(name = "business_owner", length = 200)
    private String businessOwner;

    @Column(name = "business_owner_email", length = 200)
    private String businessOwnerEmail;

    @Column(name = "tech_owner_name", length = 200)
    private String techOwnerName;

    @Column(name = "tech_owner_email", length = 200)
    private String techOwnerEmail;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "direct_customer_impact")
    @Builder.Default
    private boolean directCustomerImpact = false;

    @Column(name = "has_dependency")
    @Builder.Default
    private boolean hasDependency = false;

    @Column(name = "dr_capability", length = 50)
    private String drCapability;

    @Column(name = "vendor", length = 100)
    private String vendor;

    @Column(name = "notes", columnDefinition = "TEXT")
    private String notes;

    @Column(name = "is_active")
    @Builder.Default
    private boolean isActive = true;

    // ── Scheduling (from DR tracker) ──────────────────────────────────────────

    @Column(name = "schedule_half", length = 2)
    private String scheduleHalf;       // H1 | H2

    @Column(name = "dr_quarter", length = 3)
    private String drQuarter;          // Q1 | Q2 | Q3 | Q4

    @Column(name = "preferred_dr_month", length = 20)
    private String preferredDrMonth;   // January … December

    @Column(name = "preferred_dr_time", length = 10)
    private String preferredDrTime;    // e.g. "10:00 PM"

    @Column(name = "has_interdependency")
    @Builder.Default
    private boolean hasInterdependency = false;
}
