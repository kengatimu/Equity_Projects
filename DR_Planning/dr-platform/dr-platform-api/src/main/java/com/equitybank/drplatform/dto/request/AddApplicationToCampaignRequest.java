package com.equitybank.drplatform.dto.request;

import com.equitybank.drplatform.enums.DrActivityType;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDate;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AddApplicationToCampaignRequest {

    @NotNull(message = "Application ID is required")
    private UUID applicationId;

    private DrActivityType drActivityType;

    /** Optional override — if null, uses campaign's plannedDrDate */
    private LocalDate drDate;

    private String warRoomLocation;

    private String notes;
}
