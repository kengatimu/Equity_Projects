package com.equitybank.drplatform.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "dependency_groups")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DependencyGroupEntity extends AuditableEntity {

    @Column(name = "name", nullable = false, length = 200)
    private String name;

    @Column(name = "shared_resource_name", nullable = false, length = 200)
    private String sharedResourceName;

    @Column(name = "shared_resource_type", nullable = false, length = 50)
    private String sharedResourceType;
}
