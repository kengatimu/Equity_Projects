package com.equitybank.gag.mtn_money_ms.repository;

import com.equitybank.gag.mtn_money_ms.entity.TransactionDetails;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface TransactionDetailsRepository extends JpaRepository<TransactionDetails, Long> {

    // Find by RRN and Request Type
    @EntityGraph(attributePaths = {"cbsTransactionDetails", "statusDetails", "payloadDetails", "callback"})
    Optional<TransactionDetails> findByRrnAndRequestType(String rrn, String imtOperation);

    // Find by RRN and Request Type
    @EntityGraph(attributePaths = {"cbsTransactionDetails", "statusDetails", "payloadDetails", "callback"})
    Optional<TransactionDetails> findByImtReferenceNumberAndRequestType(String imtReference, String imtOperation);

    // Find by RRN
    Optional<TransactionDetails> findByRrn(String rrn);

    // Get last 10 records (ordered by dateCreated)
    @Query("SELECT td FROM TransactionDetails td " +
            "JOIN StatusDetails s ON td.rrn = s.rrn " +
            "JOIN Callback c ON td.rrn = c.rrn " +
            "JOIN CbsTransactionDetails cbs ON td.rrn = cbs.rrn " +
            "ORDER BY td.dateCreated DESC")
    List<TransactionDetails> findTop10ByOrderByDateCreatedDesc(Pageable pageable);

    // Get records for the current day with all associations
    @Query("SELECT td FROM TransactionDetails td " +
            "JOIN StatusDetails s ON td.rrn = s.rrn " +
            "JOIN Callback c ON td.rrn = c.rrn " +
            "JOIN CbsTransactionDetails cbs ON td.rrn = cbs.rrn " +
            "WHERE td.dateCreated BETWEEN :startOfDay AND :endOfDay " +
            "ORDER BY td.dateCreated DESC")
    List<TransactionDetails> findAllForCurrentDay(@Param("startOfDay") LocalDateTime startOfDay, @Param("endOfDay") LocalDateTime endOfDay);

    // Get records between two dates
    @Query("SELECT td FROM TransactionDetails td " +
            "JOIN StatusDetails s ON td.rrn = s.rrn " +
            "JOIN Callback c ON td.rrn = c.rrn " +
            "JOIN CbsTransactionDetails cbs ON td.rrn = cbs.rrn " +
            "WHERE td.dateCreated BETWEEN :start AND :end " +
            "ORDER BY td.dateCreated DESC")
    List<TransactionDetails> findRecordsByDateCreatedBetween(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);
}