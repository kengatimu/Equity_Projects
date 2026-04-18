package com.equitybank.drplatform.dto.request;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CreateSharedResourceRequest {

    /**
     * Canonical code — must be UPPERCASE_SNAKE.
     * Enforced by the DB unique index on UPPER(code).
     */
    @NotBlank(message = "Resource code is required")
    @Pattern(
        regexp = "^[A-Z0-9_]+$",
        message = "Code must be uppercase letters, digits, and underscores only (e.g. ORACLE_OMNI_PROD)"
    )
    private String code;

    @NotBlank(message = "Resource name is required")
    private String name;

    @NotBlank(message = "Resource type is required")
    private String resourceType;

    private String description;
    private String host;
    private String environment;
}
