package com.equitybank.drplatform.repository;

import com.equitybank.drplatform.entity.DependencyEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface DependencyRepository extends JpaRepository<DependencyEntity, UUID> {
    List<DependencyEntity> findByApplicationId(UUID appId);
    List<DependencyEntity> findByDependsOnId(UUID resourceId);
    List<DependencyEntity> findByResourceNameAndIsSharedTrue(String resourceName);

    @Query("SELECT d FROM DependencyEntity d WHERE d.resourceName = :name AND d.isShared = true")
    List<DependencyEntity> findSharedDependents(@Param("name") String resourceName);

    void deleteByApplicationIdAndDependsOnId(UUID appId, UUID dependsOnId);

    List<DependencyEntity> findByApplicationIdAndIsSharedTrue(UUID appId);

    List<DependencyEntity> findAllByIsSharedTrue();
    List<DependencyEntity> findAllByIsSharedTrueAndIsActiveTrue();

    List<DependencyEntity> findAllByResourceNameAndIsSharedTrueAndIsActiveTrue(String resourceName);
    List<DependencyEntity> findByApplicationIdAndIsActiveTrue(UUID applicationId);
}
