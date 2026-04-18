package com.equitybank.drplatform.repository;

import com.equitybank.drplatform.entity.AuditLogEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface AuditLogRepository extends JpaRepository<AuditLogEntity, UUID> {
    // READ ONLY — no save/delete operations should be used via this repository
    Page<AuditLogEntity> findByActorIdOrderByTimestampDesc(UUID actorId, Pageable pageable);
    Page<AuditLogEntity> findByCampaignIdOrderByTimestampDesc(UUID campaignId, Pageable pageable);
    Page<AuditLogEntity> findByResourceTypeOrderByTimestampDesc(String resourceType, Pageable pageable);
    Page<AuditLogEntity> findByResourceTypeAndResourceIdOrderByTimestampDesc(String resourceType, UUID resourceId, Pageable pageable);
    Page<AuditLogEntity> findBySubsidiaryIdOrderByTimestampDesc(String subsidiaryId, Pageable pageable);
    Page<AuditLogEntity> findAllByOrderByTimestampDesc(Pageable pageable);
}
