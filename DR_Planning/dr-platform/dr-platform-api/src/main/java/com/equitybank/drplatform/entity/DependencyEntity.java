package com.equitybank.drplatform.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.UUID;

@Entity
@Table(name = "application_dependencies", uniqueConstraints = {
    @UniqueConstraint(name = "uq_app_resource", columnNames = {"application_id", "resource_name"})
})
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DependencyEntity extends AuditableEntity {

    @Column(name = "application_id", nullable = false)
    private UUID applicationId;

    @Column(name = "depends_on_id")
    private UUID dependsOnId;

    @Column(name = "dependency_type", nullable = false, length = 50)
    private String dependencyType;

    @Column(name = "is_shared")
    @Builder.Default
    private boolean isShared = false;

    @Column(name = "resource_name", length = 200)
    private String resourceName;

    @Column(name = "description", columnDefinition = "TEXT")
    private String description;

    @Column(name = "is_active")
    @Builder.Default
    private boolean isActive = true;
}
