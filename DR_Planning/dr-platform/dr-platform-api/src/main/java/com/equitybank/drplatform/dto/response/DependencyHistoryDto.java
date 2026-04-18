package com.equitybank.drplatform.dto.response;

import com.equitybank.drplatform.entity.DependencyHistoryEntity;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import java.time.Instant;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DependencyHistoryDto {
    private UUID id;
    private UUID applicationId;
    private String dependencyType;
    @JsonProperty("isShared")
    private boolean isShared;
    private String resourceName;
    private String description;
    @JsonProperty("isActive")
    private boolean isActive;
    private Instant archivedAt;
    private String archivedByEmail;

    public static DependencyHistoryDto fromEntity(DependencyHistoryEntity e) {
        return DependencyHistoryDto.builder()
                .id(e.getId())
                .applicationId(e.getApplicationId())
                .dependencyType(e.getDependencyType())
                .isShared(e.isShared())
                .resourceName(e.getResourceName())
                .description(e.getDescription())
                .isActive(e.isActive())
                .archivedAt(e.getArchivedAt())
                .archivedByEmail(e.getArchivedByEmail())
                .build();
    }
}
