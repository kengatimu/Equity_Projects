package com.equitybank.drplatform.dto.response;

import com.equitybank.drplatform.entity.SharedResourceEntity;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.time.Instant;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SharedResourceDto {
    private UUID id;
    private String code;
    private String name;
    private String resourceType;
    private String description;
    private String host;
    private String environment;
    @JsonProperty("isActive")
    private boolean isActive;
    private Instant createdAt;

    public static SharedResourceDto fromEntity(SharedResourceEntity e) {
        return SharedResourceDto.builder()
                .id(e.getId())
                .code(e.getCode())
                .name(e.getName())
                .resourceType(e.getResourceType())
                .description(e.getDescription())
                .host(e.getHost())
                .environment(e.getEnvironment())
                .isActive(e.isActive())
                .createdAt(e.getCreatedAt())
                .build();
    }
}
