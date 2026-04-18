package com.equitybank.drplatform.repository;

import com.equitybank.drplatform.entity.SharedResourceHistoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface SharedResourceHistoryRepository extends JpaRepository<SharedResourceHistoryEntity, UUID> {
    List<SharedResourceHistoryEntity> findAllByOrderByArchivedAtDesc();
}
