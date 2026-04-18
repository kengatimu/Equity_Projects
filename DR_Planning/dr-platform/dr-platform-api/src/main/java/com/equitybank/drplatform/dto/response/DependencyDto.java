package com.equitybank.drplatform.dto.response;

import com.equitybank.drplatform.entity.DependencyEntity;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.time.Instant;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DependencyDto {
    private UUID id;
    private UUID applicationId;
    private UUID dependsOnId;
    private String dependencyType;
    @JsonProperty("isShared")
    private boolean isShared;
    private String resourceName;
    private String description;
    private Instant createdAt;
    @JsonProperty("isActive")
    private boolean isActive;

    public static DependencyDto fromEntity(DependencyEntity e) {
        return DependencyDto.builder()
                .id(e.getId())
                .applicationId(e.getApplicationId())
                .dependsOnId(e.getDependsOnId())
                .dependencyType(e.getDependencyType())
                .isShared(e.isShared())
                .resourceName(e.getResourceName())
                .description(e.getDescription())
                .createdAt(e.getCreatedAt())
                .isActive(e.isActive())
                .build();
    }
}
