package com.equitybank.drplatform.repository;

import com.equitybank.drplatform.entity.ApplicationHistoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface ApplicationHistoryRepository extends JpaRepository<ApplicationHistoryEntity, UUID> {
    List<ApplicationHistoryEntity> findAllByOrderByArchivedAtDesc();
    List<ApplicationHistoryEntity> findByArchivedByIdOrderByArchivedAtDesc(UUID archivedById);
}
