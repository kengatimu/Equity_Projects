package com.equitybank.drplatform.repository;

import com.equitybank.drplatform.entity.DependencyGroupEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface DependencyGroupRepository extends JpaRepository<DependencyGroupEntity, UUID> {
    Optional<DependencyGroupEntity> findBySharedResourceName(String name);
    List<DependencyGroupEntity> findBySharedResourceType(String type);
}
