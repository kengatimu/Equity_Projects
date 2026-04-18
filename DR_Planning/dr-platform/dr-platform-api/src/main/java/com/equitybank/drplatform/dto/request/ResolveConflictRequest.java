package com.equitybank.drplatform.dto.request;

import jakarta.validation.constraints.NotBlank;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ResolveConflictRequest {
    @NotBlank(message = "Resolution is required")
    private String resolution;

    @NotBlank(message = "Resolution reason is required")
    private String reason;
}
