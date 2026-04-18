package com.equitybank.drplatform.repository;

import com.equitybank.drplatform.entity.ChecklistBlockerEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface ChecklistBlockerRepository extends JpaRepository<ChecklistBlockerEntity, UUID> {

    List<ChecklistBlockerEntity> findByChecklistItemId(UUID itemId);

    List<ChecklistBlockerEntity> findByChecklistItemIdAndResolvedAtIsNull(UUID itemId);

    List<ChecklistBlockerEntity> findByRaisedById(UUID userId);

    @Query("SELECT COUNT(b) FROM ChecklistBlockerEntity b WHERE b.resolvedAt IS NULL")
    long countOpenBlockers();

    @Query("SELECT COUNT(b) FROM ChecklistBlockerEntity b WHERE b.resolvedAt IS NULL AND b.severity = 'HIGH'")
    long countCriticalOpenBlockers();

    @Query("SELECT COUNT(b) FROM ChecklistBlockerEntity b " +
           "JOIN ChecklistItemEntity ci ON ci.id = b.checklistItemId " +
           "WHERE b.resolvedAt IS NULL AND ci.campaignApplicationId = :campaignApplicationId")
    long countOpenBlockersByCampaignApplicationId(@Param("campaignApplicationId") UUID campaignApplicationId);
}
