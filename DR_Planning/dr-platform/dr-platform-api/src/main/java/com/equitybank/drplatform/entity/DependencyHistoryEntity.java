package com.equitybank.drplatform.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.Instant;
import java.util.UUID;

@Entity
@Table(name = "application_dependency_history")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DependencyHistoryEntity {

    @Id
    private UUID id;

    @Column(name = "application_id", nullable = false)
    private UUID applicationId;

    @Column(name = "depends_on_id")
    private UUID dependsOnId;

    @Column(name = "dependency_type", nullable = false, length = 50)
    private String dependencyType;

    @Column(name = "is_shared")
    private boolean isShared;

    @Column(name = "resource_name", length = 200)
    private String resourceName;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "is_active")
    private boolean isActive;

    @Column(name = "archived_at")
    private Instant archivedAt;

    @Column(name = "archived_by_id")
    private UUID archivedById;

    @Column(name = "archived_by_email", length = 200)
    private String archivedByEmail;

    @Column(name = "original_created_at")
    private Instant originalCreatedAt;

    public static DependencyHistoryEntity from(DependencyEntity dep, UUID archivedById, String archivedByEmail) {
        return DependencyHistoryEntity.builder()
                .id(dep.getId())
                .applicationId(dep.getApplicationId())
                .dependsOnId(dep.getDependsOnId())
                .dependencyType(dep.getDependencyType())
                .isShared(dep.isShared())
                .resourceName(dep.getResourceName())
                .description(dep.getDescription())
                .isActive(dep.isActive())
                .archivedAt(Instant.now())
                .archivedById(archivedById)
                .archivedByEmail(archivedByEmail)
                .originalCreatedAt(dep.getCreatedAt())
                .build();
    }
}
