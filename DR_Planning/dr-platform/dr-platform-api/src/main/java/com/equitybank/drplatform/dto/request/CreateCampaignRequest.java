package com.equitybank.drplatform.dto.request;

import com.equitybank.drplatform.enums.DrActivityType;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.*;

import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CreateCampaignRequest {

    @NotBlank(message = "Campaign name is required")
    private String name;

    @NotBlank(message = "Quarter/period is required (Q1|Q2|Q3|Q4|H1|H2)")
    private String quarter;

    @NotNull
    @Min(2024) @Max(2099)
    private Integer year;

    /** One or more subsidiary codes (KE, UG, TZ, RW, SS, CD, ET). */
    @NotEmpty(message = "At least one subsidiary must be selected")
    private List<String> subsidiaryIds;

    private LocalDate plannedDrDate;

    /** Preferred DR start time in 24-hour EAT format (e.g. "22:00"). */
    private String preferredStartTime;

    private DrActivityType activityType;

    private String description;
}
