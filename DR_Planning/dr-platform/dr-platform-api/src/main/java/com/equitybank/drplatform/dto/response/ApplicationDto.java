package com.equitybank.drplatform.dto.response;

import com.equitybank.drplatform.entity.ApplicationEntity;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.time.Instant;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ApplicationDto {
    private UUID id;
    private String code;
    private String name;
    private String tier;
    private String subsidiaryId;
    private boolean hasDr;
    private String dcEndpoint;
    private String drEndpoint;
    private String dcServers;
    private String drServers;
    private UUID techOwnerId;
    private String businessOwner;
    private String businessOwnerEmail;
    private String techOwnerName;
    private String techOwnerEmail;
    private String description;
    private boolean directCustomerImpact;
    private boolean hasDependency;
    private String drCapability;
    private String vendor;
    private String notes;
    @JsonProperty("isActive")
    private boolean isActive;
    private Instant createdAt;
    private Instant updatedAt;

    // ── Scheduling ─────────────────────────────────────────────────────────────
    private String scheduleHalf;
    private String drQuarter;
    private String preferredDrMonth;
    private String preferredDrTime;
    private boolean hasInterdependency;

    public static ApplicationDto fromEntity(ApplicationEntity e) {
        return ApplicationDto.builder()
                .id(e.getId())
                .code(e.getCode())
                .name(e.getName())
                .tier(e.getTier())
                .subsidiaryId(e.getSubsidiaryId())
                .hasDr(e.isHasDr())
                .dcEndpoint(e.getDcEndpoint())
                .drEndpoint(e.getDrEndpoint())
                .dcServers(e.getDcServers())
                .drServers(e.getDrServers())
                .techOwnerId(e.getTechOwnerId())
                .businessOwner(e.getBusinessOwner())
                .businessOwnerEmail(e.getBusinessOwnerEmail())
                .techOwnerName(e.getTechOwnerName())
                .techOwnerEmail(e.getTechOwnerEmail())
                .description(e.getDescription())
                .directCustomerImpact(e.isDirectCustomerImpact())
                .hasDependency(e.isHasDependency())
                .drCapability(e.getDrCapability())
                .vendor(e.getVendor())
                .notes(e.getNotes())
                .isActive(e.isActive())
                .createdAt(e.getCreatedAt())
                .updatedAt(e.getUpdatedAt())
                .scheduleHalf(e.getScheduleHalf())
                .drQuarter(e.getDrQuarter())
                .preferredDrMonth(e.getPreferredDrMonth())
                .preferredDrTime(e.getPreferredDrTime())
                .hasInterdependency(e.isHasInterdependency())
                .build();
    }
}
