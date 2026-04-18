package com.equitybank.drplatform.repository;

import com.equitybank.drplatform.entity.CampaignEntity;
import com.equitybank.drplatform.enums.CampaignStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface CampaignRepository extends JpaRepository<CampaignEntity, UUID> {
    List<CampaignEntity> findBySubsidiaryIdOrderByCreatedAtDesc(String subsidiaryId);
    List<CampaignEntity> findByQuarterAndYearAndSubsidiaryId(String quarter, int year, String subsidiaryId);
    List<CampaignEntity> findByCoordinatorId(UUID coordinatorId);
    List<CampaignEntity> findByCoordinatorIdAndStatusIn(UUID coordinatorId, List<CampaignStatus> statuses);
    Page<CampaignEntity> findBySubsidiaryId(String subsidiaryId, Pageable pageable);
    Page<CampaignEntity> findAllByOrderByCreatedAtDesc(Pageable pageable);
}
