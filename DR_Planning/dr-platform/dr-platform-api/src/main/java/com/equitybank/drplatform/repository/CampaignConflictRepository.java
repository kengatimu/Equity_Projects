package com.equitybank.drplatform.repository;

import com.equitybank.drplatform.entity.CampaignConflictEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface CampaignConflictRepository extends JpaRepository<CampaignConflictEntity, UUID> {
    List<CampaignConflictEntity> findByCampaignId(UUID campaignId);

    @Query("SELECT cc FROM CampaignConflictEntity cc WHERE cc.campaignId = :campaignId AND cc.resolution IS NULL")
    List<CampaignConflictEntity> findUnresolvedByCampaignId(@Param("campaignId") UUID campaignId);

    @Query("SELECT COUNT(cc) FROM CampaignConflictEntity cc WHERE cc.campaignId = :campaignId AND cc.resolution IS NULL")
    long countUnresolvedByCampaignId(@Param("campaignId") UUID campaignId);
}
