package com.equitybank.drplatform.repository;

import com.equitybank.drplatform.entity.EmailOtpEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.Instant;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface EmailOtpRepository extends JpaRepository<EmailOtpEntity, UUID> {

    Optional<EmailOtpEntity> findTopByEmailAndUsedFalseOrderByCreatedAtDesc(String email);

    @Modifying
    @Query("DELETE FROM EmailOtpEntity o WHERE o.expiresAt < :now")
    void deleteExpired(@Param("now") Instant now);
}
