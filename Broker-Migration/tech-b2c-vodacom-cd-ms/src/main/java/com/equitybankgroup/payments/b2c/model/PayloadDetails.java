package com.equitybankgroup.payments.b2c.model;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;

@Entity
@Table(name = "Telco_B2C_Payload_Details")
public class PayloadDetails implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "payload_seq")
    @SequenceGenerator(name = "payload_seq", sequenceName = "payload_seq", allocationSize = 10)
    private Long id;

    @Column(name = "rrn", unique = true, nullable = false)
    private String rrn;

    @Lob
    @Column(name = "channel_request")
    private String channelRequest;

    @Lob
    @Column(name = "channel_response")
    private String channelResponse;

    @Lob
    @Column(name = "fin_iso_request")
    private String finIsoRequest;

    @Lob
    @Column(name = "fin_iso_response")
    private String finIsoResponse;

    @Lob
    @Column(name = "channel_callback_response")
    private String channelCallbackResponse;

    @Lob
    @Column(name = "channel_status_check_req")
    private String channelStatusCheckReq;

    @Lob
    @Column(name = "channel_status_check_res")
    private String channelStatusCheckRes;

    @Lob
    @Column(name = "telco_request")
    private String telcoRequest;

    @Lob
    @Column(name = "telco_response")
    private String telcoResponse;

    @Lob
    @Column(name = "telco_status_check_req")
    private String telcoStatusCheckReq;

    @Lob
    @Column(name = "telco_status_check_res")
    private String telcoStatusCheckRes;

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

    public String getChannelRequest() {
        return channelRequest;
    }

    public void setChannelRequest(String channelRequest) {
        this.channelRequest = channelRequest;
    }

    public String getChannelResponse() {
        return channelResponse;
    }

    public void setChannelResponse(String channelResponse) {
        this.channelResponse = channelResponse;
    }

    public String getFinIsoRequest() {
        return finIsoRequest;
    }

    public void setFinIsoRequest(String finIsoRequest) {
        this.finIsoRequest = finIsoRequest;
    }

    public String getFinIsoResponse() {
        return finIsoResponse;
    }

    public void setFinIsoResponse(String finIsoResponse) {
        this.finIsoResponse = finIsoResponse;
    }

    public String getChannelCallbackResponse() {
        return channelCallbackResponse;
    }

    public void setChannelCallbackResponse(String channelCallbackResponse) {
        this.channelCallbackResponse = channelCallbackResponse;
    }

    public String getChannelStatusCheckReq() {
        return channelStatusCheckReq;
    }

    public void setChannelStatusCheckReq(String channelStatusCheckReq) {
        this.channelStatusCheckReq = channelStatusCheckReq;
    }

    public String getChannelStatusCheckRes() {
        return channelStatusCheckRes;
    }

    public void setChannelStatusCheckRes(String channelStatusCheckRes) {
        this.channelStatusCheckRes = channelStatusCheckRes;
    }

    public String getTelcoRequest() {
        return telcoRequest;
    }

    public void setTelcoRequest(String telcoRequest) {
        this.telcoRequest = telcoRequest;
    }

    public String getTelcoResponse() {
        return telcoResponse;
    }

    public void setTelcoResponse(String telcoResponse) {
        this.telcoResponse = telcoResponse;
    }

    public String getTelcoStatusCheckReq() {
        return telcoStatusCheckReq;
    }

    public void setTelcoStatusCheckReq(String telcoStatusCheckReq) {
        this.telcoStatusCheckReq = telcoStatusCheckReq;
    }

    public String getTelcoStatusCheckRes() {
        return telcoStatusCheckRes;
    }

    public void setTelcoStatusCheckRes(String telcoStatusCheckRes) {
        this.telcoStatusCheckRes = telcoStatusCheckRes;
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
