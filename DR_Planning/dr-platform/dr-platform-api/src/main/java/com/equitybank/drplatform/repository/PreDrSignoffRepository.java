package com.equitybank.drplatform.repository;

import com.equitybank.drplatform.entity.PreDrSignoffEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface PreDrSignoffRepository extends JpaRepository<PreDrSignoffEntity, UUID> {
    Optional<PreDrSignoffEntity> findByCampaignApplicationId(UUID campaignApplicationId);
    boolean existsByCampaignApplicationId(UUID campaignApplicationId);
    List<PreDrSignoffEntity> findBySubmittedById(UUID userId);
}
