package com.equitybank.drplatform.entity;

import jakarta.persistence.*;
import lombok.*;

import java.io.Serializable;
import java.util.UUID;

@Entity
@Table(name = "dependency_group_members")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DependencyGroupMemberEntity {

    @EmbeddedId
    private DependencyGroupMemberId id;

    @Embeddable
    @Getter
    @Setter
    @NoArgsConstructor
    @AllArgsConstructor
    @EqualsAndHashCode
    public static class DependencyGroupMemberId implements Serializable {
        @Column(name = "group_id")
        private UUID groupId;

        @Column(name = "application_id")
        private UUID applicationId;
    }
}
