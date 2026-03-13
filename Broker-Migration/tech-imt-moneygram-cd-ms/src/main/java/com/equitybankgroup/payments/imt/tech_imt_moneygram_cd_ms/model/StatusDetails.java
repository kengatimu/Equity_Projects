package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;

@Entity
@Table(name = "Telco_B2C_Status_Details")
//@Table(name = "Telco_B2C_Status_Details", indexes = {
//        @Index(name = "index_rrn", columnList = "rrn")
//})
public class StatusDetails implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "status_seq")
    @SequenceGenerator(name = "status_seq", sequenceName = "status_seq", allocationSize = 10)
    private Long id;

    @Column(name = "rrn", unique = true, nullable = false)
    private String rrn;

    @Column(name = "status")
    private String status;

    @Column(name = "imt_status")
    private String imtStatus;

    @Column(name = "tran_id")
    private String tranId;

    @Column(name = "status_code")
    private String statusCode;

    @Column(name = "status_message")
    private String statusMessage;

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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTranId() {
        return tranId;
    }

    public void setTranId(String tranId) {
        this.tranId = tranId;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getStatusMessage() {
        return statusMessage;
    }

    public void setStatusMessage(String statusMessage) {
        this.statusMessage = statusMessage;
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

    public String getImtStatus() {
        return imtStatus;
    }

    public void setImtStatus(String imtStatus) {
        this.imtStatus = imtStatus;
    }
}
