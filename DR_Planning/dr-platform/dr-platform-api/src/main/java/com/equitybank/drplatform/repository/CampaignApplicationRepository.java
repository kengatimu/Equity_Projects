package com.equitybank.drplatform.repository;

import com.equitybank.drplatform.entity.CampaignApplicationEntity;
import com.equitybank.drplatform.enums.CampaignApplicationStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface CampaignApplicationRepository extends JpaRepository<CampaignApplicationEntity, UUID> {

    List<CampaignApplicationEntity> findByCampaignId(UUID campaignId);

    Optional<CampaignApplicationEntity> findByCampaignIdAndApplicationId(UUID campaignId, UUID applicationId);

    boolean existsByCampaignIdAndApplicationId(UUID campaignId, UUID applicationId);

    long countByCampaignId(UUID campaignId);

    List<CampaignApplicationEntity> findByCampaignIdAndStatus(UUID campaignId, CampaignApplicationStatus status);

    @Query("SELECT ca FROM CampaignApplicationEntity ca WHERE ca.itscmApprovalDeadline < :today " +
           "AND ca.status = com.equitybank.drplatform.enums.CampaignApplicationStatus.PRE_DR_OPEN")
    List<CampaignApplicationEntity> findOverdueItscmApprovals(@Param("today") LocalDate today);

    @Query("SELECT COUNT(ca) FROM CampaignApplicationEntity ca WHERE ca.itscmApprovalDeadline < :today " +
           "AND ca.status = com.equitybank.drplatform.enums.CampaignApplicationStatus.PRE_DR_OPEN")
    long countOverdueItscmApprovals(@Param("today") LocalDate today);

    @Query("SELECT ca FROM CampaignApplicationEntity ca WHERE ca.runbookDeadline = :deadline " +
           "AND ca.status = com.equitybank.drplatform.enums.CampaignApplicationStatus.PRE_DR_OPEN")
    List<CampaignApplicationEntity> findByRunbookDeadline(@Param("deadline") LocalDate deadline);

    @Query("SELECT ca FROM CampaignApplicationEntity ca " +
           "WHERE ca.drDate BETWEEN :from AND :to " +
           "AND ca.status NOT IN " +
           "(com.equitybank.drplatform.enums.CampaignApplicationStatus.CANCELLED, " +
           "com.equitybank.drplatform.enums.CampaignApplicationStatus.DEFERRED) " +
           "ORDER BY ca.drDate")
    List<CampaignApplicationEntity> findUpcomingDrEvents(
            @Param("from") LocalDate from, @Param("to") LocalDate to);

    @Query("SELECT ca FROM CampaignApplicationEntity ca " +
           "JOIN ApplicationEntity a ON a.id = ca.applicationId " +
           "WHERE a.techOwnerId = :ownerId " +
           "AND ca.status NOT IN " +
           "(com.equitybank.drplatform.enums.CampaignApplicationStatus.CANCELLED, " +
           "com.equitybank.drplatform.enums.CampaignApplicationStatus.DEFERRED) " +
           "ORDER BY ca.drDate ASC")
    List<CampaignApplicationEntity> findByApplicationOwnerId(@Param("ownerId") UUID ownerId);
}
