package com.equitybank.drplatform.repository;

import com.equitybank.drplatform.entity.SharedResourceEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface SharedResourceRepository extends JpaRepository<SharedResourceEntity, UUID> {

    boolean existsByCodeIgnoreCase(String code);

    Optional<SharedResourceEntity> findByCodeIgnoreCase(String code);

    List<SharedResourceEntity> findByIsActiveTrueOrderByNameAsc();

    List<SharedResourceEntity> findByResourceTypeAndIsActiveTrueOrderByNameAsc(String resourceType);

    List<SharedResourceEntity> findByIsActiveFalseOrderByUpdatedAtDesc();

    /** Fuzzy search by name or code for the typeahead dropdown */
    @Query("""
        SELECT r FROM SharedResourceEntity r
        WHERE r.isActive = true
          AND (UPPER(r.code) LIKE UPPER(CONCAT('%', :q, '%'))
            OR UPPER(r.name) LIKE UPPER(CONCAT('%', :q, '%')))
        ORDER BY r.name ASC
        """)
    List<SharedResourceEntity> search(@Param("q") String query);
}
