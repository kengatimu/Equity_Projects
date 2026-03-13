package com.equitybank.gag.papss.ots.entity;

import jakarta.persistence.*;

import java.io.Serializable;
import java.time.OffsetDateTime;

@Entity
@Table(name = "papss_transaction_payload")
public class TransactionPayload implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "papss_transaction_payloads_seq")
    @SequenceGenerator(name = "papss_transaction_payloads_seq", sequenceName = "papss_transaction_payloads_seq", allocationSize = 10)
    private Long id;

    @Version
    @Column(name = "version")
    private Long version;

    @Column(name = "rrn", unique = true, nullable = false)
    private String rrn;

    @Lob
    @Column(name = "channel_request")
    private String channelRequest; // CLOB in Oracle

    @Lob
    @Column(name = "channel_response")
    private String channelResponse; // CLOB in Oracle

    @Lob
    @Column(name = "channel_callback_response")
    private String channelCallbackResponse; // CLOB in Oracle

    @Lob
    @Column(name = "fin_txn_iso_request")
    private byte[] finTxnIsoRequest; // BLOB in Oracle

    @Lob
    @Column(name = "fin_txn_iso_response")
    private byte[] finTxnIsoResponse; // BLOB in Oracle

    @Lob
    @Column(name = "fin_charges_iso_request")
    private byte[] finChargesIsoRequest; // BLOB in Oracle

    @Lob
    @Column(name = "fin_charges_iso_response")
    private byte[] finChargesIsoResponse; // BLOB in Oracle

    @Lob
    @Column(name = "fin_chrg_reverse_iso_request")
    private byte[] finChargesReversalIsoRequest; // BLOB in Oracle

    @Lob
    @Column(name = "fin_chrg_reverse_iso_response")
    private byte[] finChargesReversalIsoResponse; // BLOB in Oracle

    @Lob
    @Column(name = "fin_txn_reverse_iso_request")
    private byte[] finTxnReversalIsoRequest; // BLOB in Oracle

    @Lob
    @Column(name = "fin_txn_reverse_iso_response")
    private byte[] finTxnReversalIsoResponse; // BLOB in Oracle

    @Column(name = "created_at", nullable = false)
    private OffsetDateTime createdAt; // TIMESTAMP WITH TIME ZONE

    @Column(name = "updated_at")
    private OffsetDateTime updatedAt; // TIMESTAMP WITH TIME ZONE

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

    public String getChannelCallbackResponse() {
        return channelCallbackResponse;
    }

    public void setChannelCallbackResponse(String channelCallbackResponse) {
        this.channelCallbackResponse = channelCallbackResponse;
    }

    public byte[] getFinTxnIsoRequest() {
        return finTxnIsoRequest;
    }

    public void setFinTxnIsoRequest(byte[] finTxnIsoRequest) {
        this.finTxnIsoRequest = finTxnIsoRequest;
    }

    public byte[] getFinChargesIsoRequest() {
        return finChargesIsoRequest;
    }

    public void setFinChargesIsoRequest(byte[] finChargesIsoRequest) {
        this.finChargesIsoRequest = finChargesIsoRequest;
    }

    public byte[] getFinTxnIsoResponse() {
        return finTxnIsoResponse;
    }

    public void setFinTxnIsoResponse(byte[] finTxnIsoResponse) {
        this.finTxnIsoResponse = finTxnIsoResponse;
    }

    public byte[] getFinChargesIsoResponse() {
        return finChargesIsoResponse;
    }

    public void setFinChargesIsoResponse(byte[] finChargesIsoResponse) {
        this.finChargesIsoResponse = finChargesIsoResponse;
    }

    public byte[] getFinChargesReversalIsoRequest() {
        return finChargesReversalIsoRequest;
    }

    public void setFinChargesReversalIsoRequest(byte[] finChargesReversalIsoRequest) {
        this.finChargesReversalIsoRequest = finChargesReversalIsoRequest;
    }

    public byte[] getFinChargesReversalIsoResponse() {
        return finChargesReversalIsoResponse;
    }

    public void setFinChargesReversalIsoResponse(byte[] finChargesReversalIsoResponse) {
        this.finChargesReversalIsoResponse = finChargesReversalIsoResponse;
    }

    public byte[] getFinTxnReversalIsoRequest() {
        return finTxnReversalIsoRequest;
    }

    public void setFinTxnReversalIsoRequest(byte[] finTxnReversalIsoRequest) {
        this.finTxnReversalIsoRequest = finTxnReversalIsoRequest;
    }

    public byte[] getFinTxnReversalIsoResponse() {
        return finTxnReversalIsoResponse;
    }

    public void setFinTxnReversalIsoResponse(byte[] finTxnReversalIsoResponse) {
        this.finTxnReversalIsoResponse = finTxnReversalIsoResponse;
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