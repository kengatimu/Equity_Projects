package com.equitybank.drplatform.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class RaiseBlockerRequest {

    @NotBlank(message = "Blocker description is required")
    private String description;

    @Pattern(regexp = "LOW|MEDIUM|HIGH|CRITICAL", message = "Severity must be LOW, MEDIUM, HIGH, or CRITICAL")
    private String severity = "MEDIUM";

    /** Email or name of person to escalate to */
    private String escalateTo;
}
