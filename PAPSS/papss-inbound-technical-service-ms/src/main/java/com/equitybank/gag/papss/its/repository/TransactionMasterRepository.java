package com.equitybank.gag.papss.its.repository;

import com.equitybank.gag.papss.its.entity.TransactionMaster;
import com.equitybank.gag.papss.its.enums.TransactionType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

public interface TransactionMasterRepository extends JpaRepository<TransactionMaster, Long> {
    // Exists check for duplicate check
    @Transactional(readOnly = true)
    boolean existsByRrnAndTransactionType(String rrn, TransactionType transactionType);

    // Find by RRN and Transaction Type
    @Query("""
            SELECT t FROM TransactionMaster t
                LEFT JOIN FETCH t.senderDetails
                LEFT JOIN FETCH t.receiverDetails
                LEFT JOIN FETCH t.channelInfo
                LEFT JOIN FETCH t.finacleTransaction
                LEFT JOIN FETCH t.papssCallbackDetails
                LEFT JOIN FETCH t.transactionPayload
                WHERE t.rrn = :rrn AND t.transactionType = :type
            """)
    @Transactional(readOnly = true)
    Optional<TransactionMaster> findByRrnAndTransactionType(@Param("rrn") String rrn, @Param("type") TransactionType type);

}
