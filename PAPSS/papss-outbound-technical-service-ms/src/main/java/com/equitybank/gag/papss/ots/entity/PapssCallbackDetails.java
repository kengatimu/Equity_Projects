package com.equitybank.gag.papss.ots.entity;

import jakarta.persistence.*;

import java.io.Serializable;
import java.time.OffsetDateTime;

@Entity
@Table(name = "papss_callback_details")
public class PapssCallbackDetails implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "papss_callback_details_seq")
    @SequenceGenerator(name = "papss_callback_details_seq", sequenceName = "papss_callback_details_seq", allocationSize = 10)
    private Long id;

    @Version
    @Column(name = "version")
    private Long version;

    @Column(name = "rrn", unique = true, nullable = false)
    private String rrn;

    @Column(name = "papss_status", length = 50)
    private String papssStatus;

    @Column(name = "papss_status_code", length = 20)
    private String papssStatusCode;

    @Column(name = "papss_reason_code", length = 20)
    private String papssReasonCode;

    @Column(name = "papss_status_description")
    private String papssStatusDescription;

    @Column(name = "callback_received_at")
    private OffsetDateTime receivedAt;

    @Column(name = "created_at", nullable = false)
    private OffsetDateTime createdAt;

    @Column(name = "updated_at")
    private OffsetDateTime updatedAt;

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

    public String getPapssStatus() {
        return papssStatus;
    }

    public void setPapssStatus(String papssStatus) {
        this.papssStatus = papssStatus;
    }

    public String getPapssStatusCode() {
        return papssStatusCode;
    }

    public void setPapssStatusCode(String papssStatusCode) {
        this.papssStatusCode = papssStatusCode;
    }

    public String getPapssReasonCode() {
        return papssReasonCode;
    }

    public void setPapssReasonCode(String papssReasonCode) {
        this.papssReasonCode = papssReasonCode;
    }

    public String getPapssStatusDescription() {
        return papssStatusDescription;
    }

    public void setPapssStatusDescription(String papssStatusDescription) {
        this.papssStatusDescription = papssStatusDescription;
    }

    public OffsetDateTime getReceivedAt() {
        return receivedAt;
    }

    public void setReceivedAt(OffsetDateTime receivedAt) {
        this.receivedAt = receivedAt;
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

    public TransactionMaster getTransaction() {
        return transaction;
    }

    public void setTransaction(TransactionMaster transaction) {
        this.transaction = transaction;
    }
}

