package com.equitybank.drplatform.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CreateApplicationRequest {
    @NotBlank(message = "Application code is required")
    private String code;

    @NotBlank(message = "Application name is required")
    private String name;

    @NotBlank
    @Pattern(regexp = "T1|T2|T3", message = "Tier must be T1, T2, or T3")
    private String tier;

    @NotBlank(message = "Subsidiary ID is required")
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
    private String drCapability;
    private String vendor;
    private String notes;

    // ── Scheduling ─────────────────────────────────────────────────────────────
    private String scheduleHalf;       // H1 | H2
    private String drQuarter;          // Q1 | Q2 | Q3 | Q4
    private String preferredDrMonth;   // January … December
    private String preferredDrTime;    // e.g. "10:00 PM"
    private boolean hasInterdependency;
}
