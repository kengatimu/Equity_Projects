package com.equitybank.drplatform.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "infrastructure_resource_history")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SharedResourceHistoryEntity {

    @Id
    private UUID id;

    @Column(name = "code", nullable = false, length = 50)
    private String code;

    @Column(name = "name", nullable = false, length = 200)
    private String name;

    @Column(name = "resource_type", nullable = false, length = 50)
    private String resourceType;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "host", columnDefinition = "TEXT")
    private String host;

    @Column(name = "environment", length = 20)
    private String environment;

    @Column(name = "archived_at")
    private Instant archivedAt;

    @Column(name = "archived_by_id")
    private UUID archivedById;

    @Column(name = "archived_by_email", length = 200)
    private String archivedByEmail;

    @Column(name = "original_created_at")
    private Instant originalCreatedAt;

    public static SharedResourceHistoryEntity from(SharedResourceEntity r, UUID archivedById, String archivedByEmail) {
        return SharedResourceHistoryEntity.builder()
                .id(r.getId())
                .code(r.getCode())
                .name(r.getName())
                .resourceType(r.getResourceType())
                .description(r.getDescription())
                .host(r.getHost())
                .environment(r.getEnvironment())
                .archivedAt(Instant.now())
                .archivedById(archivedById)
                .archivedByEmail(archivedByEmail)
                .originalCreatedAt(r.getCreatedAt())
                .build();
    }
}
