package com.equitybank.drplatform.repository;

import com.equitybank.drplatform.entity.ChecklistItemEntity;
import com.equitybank.drplatform.enums.ChecklistItemStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface ChecklistItemRepository extends JpaRepository<ChecklistItemEntity, UUID> {

    List<ChecklistItemEntity> findByCampaignApplicationIdOrderBySortOrder(UUID campaignApplicationId);

    List<ChecklistItemEntity> findByCampaignApplicationIdAndStatus(UUID campaignApplicationId, ChecklistItemStatus status);

    List<ChecklistItemEntity> findByCarriedForwardFromId(UUID fromId);

    List<ChecklistItemEntity> findByCampaignApplicationIdAndCarriedForwardFromIdIsNotNull(UUID campaignApplicationId);

    long countByCampaignApplicationId(UUID campaignApplicationId);

    long countByCampaignApplicationIdAndStatus(UUID campaignApplicationId, ChecklistItemStatus status);

    @Query("SELECT COUNT(ci), " +
           "SUM(CASE WHEN ci.status = com.equitybank.drplatform.enums.ChecklistItemStatus.DONE " +
           "      OR ci.status = com.equitybank.drplatform.enums.ChecklistItemStatus.VERIFIED THEN 1 ELSE 0 END), " +
           "SUM(CASE WHEN ci.status = com.equitybank.drplatform.enums.ChecklistItemStatus.BLOCKED THEN 1 ELSE 0 END) " +
           "FROM ChecklistItemEntity ci WHERE ci.campaignApplicationId = :id")
    Object[] getChecklistSummary(@Param("id") UUID campaignApplicationId);
}
