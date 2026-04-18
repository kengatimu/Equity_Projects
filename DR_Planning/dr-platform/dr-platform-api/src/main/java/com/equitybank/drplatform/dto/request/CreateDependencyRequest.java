package com.equitybank.drplatform.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CreateDependencyRequest {
    private UUID dependsOnId;

    @NotBlank(message = "Dependency type is required")
    private String dependencyType;

    @JsonProperty("isShared")
    private boolean isShared;
    private String resourceName;
    private String description;
}
