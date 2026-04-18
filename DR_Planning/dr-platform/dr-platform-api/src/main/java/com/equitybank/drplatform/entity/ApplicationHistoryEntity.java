package com.equitybank.drplatform.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "application_history")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ApplicationHistoryEntity {

    @Id
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    @Column(name = "code", nullable = false, length = 100)
    private String code;

    @Column(name = "name", nullable = false, length = 200)
    private String name;

    @Column(name = "tier", nullable = false, length = 5)
    private String tier;

    @Column(name = "subsidiary_id", nullable = false, length = 10)
    private String subsidiaryId;

    @Column(name = "has_dr")
    private boolean hasDr;

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
    private boolean directCustomerImpact;

    @Column(name = "has_dependency")
    private boolean hasDependency;

    @Column(name = "dr_capability", length = 50)
    private String drCapability;

    @Column(name = "vendor", length = 100)
    private String vendor;

    @Column(name = "notes", columnDefinition = "TEXT")
    private String notes;

    @Column(name = "schedule_half", length = 2)
    private String scheduleHalf;

    @Column(name = "dr_quarter", length = 3)
    private String drQuarter;

    @Column(name = "preferred_dr_month", length = 20)
    private String preferredDrMonth;

    @Column(name = "preferred_dr_time", length = 10)
    private String preferredDrTime;

    @Column(name = "has_interdependency")
    private boolean hasInterdependency;

    @Column(name = "original_created_at")
    private Instant originalCreatedAt;

    @Column(name = "original_updated_at")
    private Instant originalUpdatedAt;

    @Column(name = "archived_at", nullable = false)
    private Instant archivedAt;

    @Column(name = "archived_by_id")
    private UUID archivedById;

    @Column(name = "archived_by_email", length = 200)
    private String archivedByEmail;

    /** Factory: copy all fields from a live ApplicationEntity */
    public static ApplicationHistoryEntity from(ApplicationEntity app, UUID archivedById, String archivedByEmail) {
        return ApplicationHistoryEntity.builder()
                .id(app.getId())
                .code(app.getCode())
                .name(app.getName())
                .tier(app.getTier())
                .subsidiaryId(app.getSubsidiaryId())
                .hasDr(app.isHasDr())
                .dcEndpoint(app.getDcEndpoint())
                .drEndpoint(app.getDrEndpoint())
                .dcServers(app.getDcServers())
                .drServers(app.getDrServers())
                .techOwnerId(app.getTechOwnerId())
                .businessOwner(app.getBusinessOwner())
                .businessOwnerEmail(app.getBusinessOwnerEmail())
                .techOwnerName(app.getTechOwnerName())
                .techOwnerEmail(app.getTechOwnerEmail())
                .description(app.getDescription())
                .directCustomerImpact(app.isDirectCustomerImpact())
                .hasDependency(app.isHasDependency())
                .drCapability(app.getDrCapability())
                .vendor(app.getVendor())
                .notes(app.getNotes())
                .scheduleHalf(app.getScheduleHalf())
                .drQuarter(app.getDrQuarter())
                .preferredDrMonth(app.getPreferredDrMonth())
                .preferredDrTime(app.getPreferredDrTime())
                .hasInterdependency(app.isHasInterdependency())
                .originalCreatedAt(app.getCreatedAt())
                .originalUpdatedAt(app.getUpdatedAt())
                .archivedAt(Instant.now())
                .archivedById(archivedById)
                .archivedByEmail(archivedByEmail)
                .build();
    }
}
