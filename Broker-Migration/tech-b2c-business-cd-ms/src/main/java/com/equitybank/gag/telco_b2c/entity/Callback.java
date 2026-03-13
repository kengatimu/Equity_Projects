package com.equitybank.gag.telco_b2c.entity;

import com.equitybank.gag.telco_b2c.enums.TransactionStatus;
import jakarta.persistence.*;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.TimeZone;

@Entity
@Table(name = "Telco_B2C_Callback")
//@Table(name = "Telco_B2C_Callback", indexes = {
//        @Index(name = "index_rrn", columnList = "rrn")
//})
public class Callback implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "callback_seq")
    @SequenceGenerator(name = "callback_seq", sequenceName = "callback_seq", allocationSize = 10)
    private Long id;

    @Version
    @Column(name = "version")
    private Long version;

    @Column(name = "rrn", unique = true, nullable = false)
    private String rrn;

    @Column(name = "callback_received")
    private String callbackReceived;

    @Column(name = "callback_status")
    private String callbackStatus;

    @Column(name = "callback_status_msg")
    private String callbackStatusMsg;

    @Column(name = "callback_url")
    private String callbackUrl;

    @Column(name = "date_created")
    private LocalDateTime dateCreated;

    @Column(name = "date_updated")
    private LocalDateTime dateUpdated;

    @PrePersist
    public void onCreate() {
        LocalDateTime currentDateTime = LocalDateTime.now(ZoneId.of("GMT+3"));

        // Assign the LocalDateTime to dateCreated and dateUpdated. Also truncate the nanoseconds
        dateCreated = currentDateTime.truncatedTo(ChronoUnit.SECONDS);
        callbackReceived = "false";
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

    public Long getVersion() {
        return version;
    }

    public void setVersion(Long version) {
        this.version = version;
    }

    public String getRrn() {
        return rrn;
    }

    public void setRrn(String rrn) {
        this.rrn = rrn;
    }

    public String getCallbackReceived() {
        return callbackReceived;
    }

    public void setCallbackReceived(String callbackReceived) {
        this.callbackReceived = callbackReceived;
    }

    public String getCallbackStatus() {
        return callbackStatus;
    }

    public void setCallbackStatus(String callbackStatus) {
        this.callbackStatus = callbackStatus;
    }

    public String getCallbackStatusMsg() {
        return callbackStatusMsg;
    }

    public void setCallbackStatusMsg(String callbackStatusMsg) {
        this.callbackStatusMsg = callbackStatusMsg;
    }

    public String getCallbackUrl() {
        return callbackUrl;
    }

    public void setCallbackUrl(String callbackUrl) {
        this.callbackUrl = callbackUrl;
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
