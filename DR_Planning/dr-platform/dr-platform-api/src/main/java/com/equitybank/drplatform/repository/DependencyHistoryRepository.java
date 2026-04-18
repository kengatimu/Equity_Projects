package com.equitybank.drplatform.repository;

import com.equitybank.drplatform.entity.DependencyHistoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.UUID;

public interface DependencyHistoryRepository extends JpaRepository<DependencyHistoryEntity, UUID> {
    List<DependencyHistoryEntity> findByApplicationIdOrderByArchivedAtDesc(UUID applicationId);
    List<DependencyHistoryEntity> findAllByOrderByArchivedAtDesc();
}
