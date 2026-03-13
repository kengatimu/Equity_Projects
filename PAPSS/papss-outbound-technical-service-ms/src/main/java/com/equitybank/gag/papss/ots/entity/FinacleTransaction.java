package com.equitybank.gag.papss.ots.entity;

import com.equitybank.gag.papss.ots.enums.TransactionStatus;
import jakarta.persistence.*;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.OffsetDateTime;

@Entity
@Table(name = "papss_finacle_transaction")
public class FinacleTransaction implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "papss_finacle_transaction_seq")
    @SequenceGenerator(name = "papss_finacle_transaction_seq", sequenceName = "papss_finacle_transaction_seq", allocationSize = 10)
    private Long id;

    @Version
    @Column(name = "version")
    private Long version;

    @Column(name = "rrn", unique = true, nullable = false)
    private String rrn;

    @Column(name = "debit_account", length = 30)
    private String debitAccount;

    @Column(name = "credit_account", length = 30)
    private String creditAccount;

    @Column(name = "commission_account", length = 30)
    private String commissionAccount;

    @Column(name = "finacle_status", length = 50)
    @Enumerated(EnumType.STRING)
    private TransactionStatus finacleStatus;

    @Column(name = "finacle_response_code", length = 10)
    private String finacleResponseCode;

    @Column(name = "finacle_response_desc")
    private String finacleResponseDesc;

    @Column(name = "amount", precision = 18, scale = 2)
    private BigDecimal amount;

    @Column(name = "fee_amount", precision = 18, scale = 2)
    private BigDecimal feeAmount;

    @Column(name = "transaction_currency", length = 10, nullable = false)
    private String transactionCurrency;

    @Column(name = "finacle_tran_id", length = 50)
    private String finacleTranId;

    @Column(name = "created_at", nullable = false)
    private OffsetDateTime createdAt;

    @Column(name = "updated_at")
    private OffsetDateTime updatedAt;

    // Reversal related columns
    @Column(name = "reversal_status", length = 50)
    @Enumerated(EnumType.STRING)
    private TransactionStatus reversalStatus;

    @Column(name = "reversal_response_code", length = 10)
    private String reversalResponseCode;

    @Column(name = "reversal_response_desc")
    private String reversalResponseDesc;

    @Column(name = "reversal_amount", precision = 18, scale = 2)
    private BigDecimal reversalAmount;

    @Column(name = "reversal_fee_amount", precision = 18, scale = 2)
    private BigDecimal reversalFeeAmount;

    @Column(name = "reversal_transaction_ref", length = 50)
    private String reversalTransactionRef;

    @Column(name = "reversal_created_at")
    private OffsetDateTime reversalCreatedAt;

    @Column(name = "reversal_completed_at")
    private OffsetDateTime reversalCompletedAt;

    // Relationship with TransactionMaster (1:1)
    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "rrn", referencedColumnName = "rrn", insertable = false, updatable = false)
    private TransactionMaster transaction;

    public Long getId() {
        return id;
    }

    public Long getVersion() {
        return version;
    }

    public void setVersion(Long version) {
        this.version = version;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRrn() {
        return rrn;
    }

    public void setRrn(String rrn) {
        this.rrn = rrn;
    }

    public String getDebitAccount() {
        return debitAccount;
    }

    public void setDebitAccount(String debitAccount) {
        this.debitAccount = debitAccount;
    }

    public String getCreditAccount() {
        return creditAccount;
    }

    public void setCreditAccount(String creditAccount) {
        this.creditAccount = creditAccount;
    }

    public String getCommissionAccount() {
        return commissionAccount;
    }

    public void setCommissionAccount(String commissionAccount) {
        this.commissionAccount = commissionAccount;
    }

    public TransactionStatus getFinacleStatus() {
        return finacleStatus;
    }

    public void setFinacleStatus(TransactionStatus finacleStatus) {
        this.finacleStatus = finacleStatus;
    }

    public String getFinacleResponseCode() {
        return finacleResponseCode;
    }

    public void setFinacleResponseCode(String finacleResponseCode) {
        this.finacleResponseCode = finacleResponseCode;
    }

    public String getFinacleResponseDesc() {
        return finacleResponseDesc;
    }

    public void setFinacleResponseDesc(String finacleResponseDesc) {
        this.finacleResponseDesc = finacleResponseDesc;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public BigDecimal getFeeAmount() {
        return feeAmount;
    }

    public void setFeeAmount(BigDecimal feeAmount) {
        this.feeAmount = feeAmount;
    }

    public String getTransactionCurrency() {
        return transactionCurrency;
    }

    public void setTransactionCurrency(String transactionCurrency) {
        this.transactionCurrency = transactionCurrency;
    }

    public String getFinacleTranId() {
        return finacleTranId;
    }

    public void setFinacleTranId(String finacleTranId) {
        this.finacleTranId = finacleTranId;
    }


    public TransactionStatus getReversalStatus() {
        return reversalStatus;
    }

    public void setReversalStatus(TransactionStatus reversalStatus) {
        this.reversalStatus = reversalStatus;
    }

    public String getReversalResponseCode() {
        return reversalResponseCode;
    }

    public void setReversalResponseCode(String reversalResponseCode) {
        this.reversalResponseCode = reversalResponseCode;
    }

    public String getReversalResponseDesc() {
        return reversalResponseDesc;
    }

    public void setReversalResponseDesc(String reversalResponseDesc) {
        this.reversalResponseDesc = reversalResponseDesc;
    }

    public BigDecimal getReversalAmount() {
        return reversalAmount;
    }

    public void setReversalAmount(BigDecimal reversalAmount) {
        this.reversalAmount = reversalAmount;
    }

    public BigDecimal getReversalFeeAmount() {
        return reversalFeeAmount;
    }

    public void setReversalFeeAmount(BigDecimal reversalFeeAmount) {
        this.reversalFeeAmount = reversalFeeAmount;
    }

    public String getReversalTransactionRef() {
        return reversalTransactionRef;
    }

    public void setReversalTransactionRef(String reversalTransactionRef) {
        this.reversalTransactionRef = reversalTransactionRef;
    }

    public OffsetDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(OffsetDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public OffsetDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(OffsetDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public OffsetDateTime getReversalCreatedAt() {
        return reversalCreatedAt;
    }

    public void setReversalCreatedAt(OffsetDateTime reversalCreatedAt) {
        this.reversalCreatedAt = reversalCreatedAt;
    }

    public OffsetDateTime getReversalCompletedAt() {
        return reversalCompletedAt;
    }

    public void setReversalCompletedAt(OffsetDateTime reversalCompletedAt) {
        this.reversalCompletedAt = reversalCompletedAt;
    }

    public TransactionMaster getTransaction() {
        return transaction;
    }

    public void setTransaction(TransactionMaster transaction) {
        this.transaction = transaction;
    }
}
