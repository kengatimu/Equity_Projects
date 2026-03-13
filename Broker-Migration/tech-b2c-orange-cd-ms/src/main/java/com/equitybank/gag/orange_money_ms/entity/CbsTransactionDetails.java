package com.equitybank.gag.orange_money_ms.entity;

import com.equitybank.gag.orange_money_ms.enums.CbsStatus;
import jakarta.persistence.*;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;

@Entity
@Table(name = "CBS_Transaction_Details")
//@Table(name = "CBS_Transaction_Details", indexes = {
//        @Index(name = "index_rrn", columnList = "rrn")
//})
public class CbsTransactionDetails implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "cbs_transaction_seq")
    @SequenceGenerator(name = "cbs_transaction_seq", sequenceName = "cbs_transaction_seq", allocationSize = 10)
    private Long id;

    @Column(name = "rrn", unique = true, nullable = false)
    private String rrn;

    @Column(name = "cbs_status")
    @Enumerated(EnumType.STRING)
    private CbsStatus cbsStatus;

    @Column(name = "cbs_tran_id")
    private String cbsTranId;

    @Column(name = "cbs_status_code")
    private String cbsStatusCode;

    @Column(name = "cbs_status_message")
    private String cbsStatusMessage;

    @Column(name = "reversal_status")
    @Enumerated(EnumType.STRING)
    private CbsStatus reversalStatus;

    @Column(name = "reversal_status_message")
    private String reversalStatusMessage;

    @Column(name = "retry_count")
    private int retryCount;

    @Lob
    @Column(name = "fin_iso_request")
    private byte[] finIsoRequest;

    @Lob
    @Column(name = "fin_iso_response")
    private byte[] finIsoResponse;

    @Column(name = "date_created")
    private LocalDateTime dateCreated;

    @Column(name = "date_updated")
    private LocalDateTime dateUpdated;

    @PrePersist
    public void onCreate() {
        LocalDateTime currentDateTime = LocalDateTime.now(ZoneId.of("GMT+3"));

        // Assign the LocalDateTime to dateCreated and dateUpdated. Also truncate the nanoseconds
        dateCreated = currentDateTime.truncatedTo(ChronoUnit.SECONDS);
        dateUpdated = currentDateTime.truncatedTo(ChronoUnit.SECONDS);
    }

    @PreUpdate
    public void onUpdate() {
        LocalDateTime currentDateTime = LocalDateTime.now(ZoneId.of("GMT+3"));

        // Assign the LocalDateTime to dateCreated and dateUpdated. Also truncate the nanoseconds
        dateUpdated = currentDateTime.truncatedTo(ChronoUnit.SECONDS);
    }

    public Long getId() {
        return id;
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

    public CbsStatus getCbsStatus() {
        return cbsStatus;
    }

    public void setCbsStatus(CbsStatus cbsStatus) {
        this.cbsStatus = cbsStatus;
    }

    public String getCbsTranId() {
        return cbsTranId;
    }

    public void setCbsTranId(String cbsTranId) {
        this.cbsTranId = cbsTranId;
    }

    public String getCbsStatusCode() {
        return cbsStatusCode;
    }

    public void setCbsStatusCode(String cbsStatusCode) {
        this.cbsStatusCode = cbsStatusCode;
    }

    public String getCbsStatusMessage() {
        return cbsStatusMessage;
    }

    public void setCbsStatusMessage(String cbsStatusMessage) {
        this.cbsStatusMessage = cbsStatusMessage;
    }

    public CbsStatus getReversalStatus() {
        return reversalStatus;
    }

    public void setReversalStatus(CbsStatus reversalStatus) {
        this.reversalStatus = reversalStatus;
    }

    public String getReversalStatusMessage() {
        return reversalStatusMessage;
    }

    public void setReversalStatusMessage(String reversalStatusMessage) {
        this.reversalStatusMessage = reversalStatusMessage;
    }

    public int getRetryCount() {
        return retryCount;
    }

    public void setRetryCount(int retryCount) {
        this.retryCount = retryCount;
    }

    public byte[] getFinIsoRequest() {
        return finIsoRequest;
    }

    public void setFinIsoRequest(byte[] finIsoRequest) {
        this.finIsoRequest = finIsoRequest;
    }

    public byte[] getFinIsoResponse() {
        return finIsoResponse;
    }

    public void setFinIsoResponse(byte[] finIsoResponse) {
        this.finIsoResponse = finIsoResponse;
    }

    public LocalDateTime getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(LocalDateTime dateCreated) {
        this.dateCreated = dateCreated;
    }

    public LocalDateTime getDateUpdated() {
        return dateUpdated;
    }

    public void setDateUpdated(LocalDateTime dateUpdated) {
        this.dateUpdated = dateUpdated;
    }
}
