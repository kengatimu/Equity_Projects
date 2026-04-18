package com.equitybank.drplatform.dto.response;

import com.equitybank.drplatform.entity.SharedResourceHistoryEntity;
import lombok.*;

import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SharedResourceHistoryDto {
    private String id;
    private String code;
    private String name;
    private String resourceType;
    private String description;
    private String host;
    private String environment;
    private String archivedAt;
    private String archivedByEmail;

    public static SharedResourceHistoryDto fromEntity(SharedResourceHistoryEntity e) {
        return SharedResourceHistoryDto.builder()
                .id(e.getId() != null ? e.getId().toString() : null)
                .code(e.getCode())
                .name(e.getName())
                .resourceType(e.getResourceType())
                .description(e.getDescription())
                .host(e.getHost())
                .environment(e.getEnvironment())
                .archivedAt(e.getArchivedAt() != null ? e.getArchivedAt().toString() : null)
                .archivedByEmail(e.getArchivedByEmail())
                .build();
    }
}
