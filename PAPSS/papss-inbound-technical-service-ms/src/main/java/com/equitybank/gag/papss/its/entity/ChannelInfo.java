package com.equitybank.gag.papss.its.entity;

import jakarta.persistence.*;

import java.io.Serializable;
import java.time.OffsetDateTime;

@Entity
@Table(name = "papss_channel_info")
public class ChannelInfo implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "papss_channel_info_seq")
    @SequenceGenerator(name = "papss_channel_info_seq", sequenceName = "papss_channel_info_seq", allocationSize = 10)
    private Long id;

    @Version
    @Column(name = "version")
    private Long version;

    @Column(name = "rrn", unique = true, nullable = false)
    private String rrn;

    @Column(name = "channel_id", length = 50, nullable = false)
    private String channelId;

    @Column(name = "source_system_id", length = 50, nullable = false)
    private String sourceSystemId;

    @Column(name = "callback_url", length = 500)
    private String callbackUrl;

    @Column(name = "created_at", nullable = false)
    private OffsetDateTime createdAt;

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

    public String getChannelId() {
        return channelId;
    }

    public void setChannelId(String channelId) {
        this.channelId = channelId;
    }

    public String getSourceSystemId() {
        return sourceSystemId;
    }

    public void setSourceSystemId(String sourceSystemId) {
        this.sourceSystemId = sourceSystemId;
    }

    public String getCallbackUrl() {
        return callbackUrl;
    }

    public void setCallbackUrl(String callbackUrl) {
        this.callbackUrl = callbackUrl;
    }

    public OffsetDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(OffsetDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public TransactionMaster getTransaction() {
        return transaction;
    }

    public void setTransaction(TransactionMaster transaction) {
        this.transaction = transaction;
    }
}

