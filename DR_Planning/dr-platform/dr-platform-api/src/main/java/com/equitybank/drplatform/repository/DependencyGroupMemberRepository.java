package com.equitybank.drplatform.repository;

import com.equitybank.drplatform.entity.DependencyGroupMemberEntity;
import com.equitybank.drplatform.entity.DependencyGroupMemberEntity.DependencyGroupMemberId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface DependencyGroupMemberRepository extends JpaRepository<DependencyGroupMemberEntity, DependencyGroupMemberId> {
    List<DependencyGroupMemberEntity> findByIdGroupId(UUID groupId);
    List<DependencyGroupMemberEntity> findByIdApplicationId(UUID applicationId);
    void deleteByIdGroupIdAndIdApplicationId(UUID groupId, UUID applicationId);
}
