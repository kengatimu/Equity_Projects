package com.equitybank.drplatform.repository;

import com.equitybank.drplatform.entity.ApplicationEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ApplicationRepository extends JpaRepository<ApplicationEntity, UUID> {
    List<ApplicationEntity> findBySubsidiaryIdAndIsActiveTrue(String subsidiaryId);
    List<ApplicationEntity> findByTechOwnerIdAndIsActiveTrue(UUID ownerId);
    List<ApplicationEntity> findByTierAndSubsidiaryIdAndIsActiveTrue(String tier, String subsidiaryId);
    Page<ApplicationEntity> findByNameContainingIgnoreCaseAndIsActiveTrue(String name, Pageable pageable);
    List<ApplicationEntity> findByTierAndHasDrTrueAndIsActiveTrue(String tier);
    Optional<ApplicationEntity> findByCode(String code);
    List<ApplicationEntity> findByIsActiveTrue();
    boolean existsByCode(String code);
    Page<ApplicationEntity> findByIsActiveTrue(Pageable pageable);
    Page<ApplicationEntity> findBySubsidiaryIdAndIsActiveTrue(String subsidiaryId, Pageable pageable);
    Page<ApplicationEntity> findByTierAndIsActiveTrue(String tier, Pageable pageable);
    Page<ApplicationEntity> findByTierAndSubsidiaryIdAndIsActiveTrue(String tier, String subsidiaryId, Pageable pageable);
}
