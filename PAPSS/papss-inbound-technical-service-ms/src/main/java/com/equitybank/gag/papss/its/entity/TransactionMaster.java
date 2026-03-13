package com.equitybank.gag.papss.its.entity;

import com.equitybank.gag.papss.its.enums.OperationType;
import com.equitybank.gag.papss.its.enums.TransactionStatus;
import com.equitybank.gag.papss.its.enums.TransactionType;
import jakarta.persistence.*;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.OffsetDateTime;

@Entity
@Table(name = "papss_transaction_master",
        indexes = {
                @Index(name = "idx_status", columnList = "status"),
                @Index(name = "idx_bank_id", columnList = "bank_id"),
                @Index(name = "idx_created_at", columnList = "created_at"),
                @Index(name = "idx_channel_id", columnList = "channel_id"),
                @Index(name = "idx_transaction_type", columnList = "transaction_type")
        })
public class TransactionMaster implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "papss_transaction_master_seq")
    @SequenceGenerator(name = "papss_transaction_master_seq", sequenceName = "papss_transaction_master_seq", allocationSize = 10)
    private Long id;

    @Version
    @Column(name = "version")
    private Long version;

    @Column(name = "rrn", unique = true, nullable = false)
    private String rrn;

    @Column(name = "finacle_rrn")
    private String finacleRrn;

    @Column(name = "end_to_end_id", unique = true)
    private String endToEndId;

    @Column(name = "papss_message_id", unique = true)
    private String papssMessageId;

    @Column(name = "papss_txn_creation_time", unique = true)
    private String papssTxnCreationTime;

    @Column(name = "bank_id", length = 20, nullable = false)
    private String bankId;

    @Column(name = "channel_id", length = 50, nullable = false)
    private String channelId;

    @Column(name = "source_system_id", length = 50, nullable = false)
    private String sourceSystemId;

    @Column(name = "ips_status", length = 10)
    private String ipsStatus;

    @Column(name = "ips_status_reason", length = 500)
    private String ipsStatusReason;

    @Column(name = "ips_status_code", length = 20)
    private String ipsStatusCode;

    @Column(name = "ips_status_description")
    private String ipsStatusDescription;

    @Column(length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private TransactionStatus status;

    @Column(name = "response_code", length = 20)
    private String responseCode;

    @Column(name = "response_message", length = 500)
    private String responseMessage;

    @Column(length = 20)
    @Enumerated(EnumType.STRING)
    private TransactionStatus finacleStatus;

    @Column(name = "finacle_response_code", length = 20)
    private String finacleResponseCode;

    @Column(name = "finacle_response_message", length = 500)
    private String finacleResponseMessage;

    @Column(name = "operation_type", length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private OperationType operationType;

    @Column(name = "transaction_type", length = 20, nullable = false)
    @Enumerated(EnumType.STRING)
    private TransactionType transactionType;

    @Column(name = "sender_amount", nullable = false, precision = 18, scale = 2)
    private BigDecimal senderAmount;

    @Column(name = "receiver_amount", precision = 18, scale = 2)
    private BigDecimal receiverAmount;

    @Column(name = "papss_feeAmount", precision = 18, scale = 2)
    private BigDecimal papssFeeAmount = BigDecimal.ZERO;

    @Column(name = "papss_fee_tax", precision = 18, scale = 2)
    private BigDecimal papssFeeTax = BigDecimal.ZERO;

    @Column(name = "papss_fee_amount_net", precision = 18, scale = 2)
    private BigDecimal papssFeeAmountNet = BigDecimal.ZERO;

    @Column(name = "bank_feeAmount", precision = 18, scale = 2)
    private BigDecimal bankFeeAmount = BigDecimal.ZERO;

    @Column(name = "bank_fee_tax", precision = 18, scale = 2)
    private BigDecimal bankFeeTax = BigDecimal.ZERO;

    @Column(name = "bank_fee_amount_net", precision = 18, scale = 2)
    private BigDecimal bankFeeAmountNet = BigDecimal.ZERO;

    @Column(name = "total_tax_amount", precision = 18, scale = 2)
    private BigDecimal totalTaxAmount = BigDecimal.ZERO;

    @Column(name = "fx_rate")
    private String fxRate;

    @Column(name = "transaction_currency",length = 3, nullable = false)
    private String transactionCurrency;

    @Column(name = "source_currency",length = 3)
    private String sourceCurrency;

    @Column(name = "destination_currency", length = 3, nullable = false)
    private String destinationCurrency;

    @Column(name = "destination_country", length = 20, nullable = false)
    private String destinationCountry;

    @Column(name = "payment_reason")
    private String paymentReason;

    @Column(name = "narration")
    private String narration;

    @Column(name = "created_at", nullable = false)
    private OffsetDateTime createdAt;

    @Column(name = "updated_at")
    private OffsetDateTime updatedAt;

    @Column(name = "completed_at")
    private OffsetDateTime completedAt;

    // Relationships (1:1)
    @OneToOne(mappedBy = "transaction", cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, orphanRemoval = true)
    private SenderDetails senderDetails;

    @OneToOne(mappedBy = "transaction", cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, orphanRemoval = true)
    private ReceiverDetails receiverDetails;

    @OneToOne(mappedBy = "transaction", cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, orphanRemoval = true)
    private ChannelInfo channelInfo;

    @OneToOne(mappedBy = "transaction", cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, orphanRemoval = true)
    private FinacleTransaction finacleTransaction;

    @OneToOne(mappedBy = "transaction", cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, orphanRemoval = true)
    private PapssCallbackDetails papssCallbackDetails;

    @OneToOne(mappedBy = "transaction", cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, orphanRemoval = true)
    private TransactionPayload transactionPayload;

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

    public String getFinacleRrn() {
        return finacleRrn;
    }

    public void setFinacleRrn(String finacleRrn) {
        this.finacleRrn = finacleRrn;
    }

    public String getEndToEndId() {
        return endToEndId;
    }

    public void setEndToEndId(String endToEndId) {
        this.endToEndId = endToEndId;
    }

    public String getPapssMessageId() {
        return papssMessageId;
    }

    public void setPapssMessageId(String papssMessageId) {
        this.papssMessageId = papssMessageId;
    }

    public String getPapssTxnCreationTime() {
        return papssTxnCreationTime;
    }

    public void setPapssTxnCreationTime(String papssTxnCreationTime) {
        this.papssTxnCreationTime = papssTxnCreationTime;
    }

    public String getBankId() {
        return bankId;
    }

    public void setBankId(String bankId) {
        this.bankId = bankId;
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

    public String getIpsStatus() {
        return ipsStatus;
    }

    public void setIpsStatus(String ipsStatus) {
        this.ipsStatus = ipsStatus;
    }

    public String getIpsStatusReason() {
        return ipsStatusReason;
    }

    public void setIpsStatusReason(String ipsStatusReason) {
        this.ipsStatusReason = ipsStatusReason;
    }

    public String getIpsStatusCode() {
        return ipsStatusCode;
    }

    public void setIpsStatusCode(String ipsStatusCode) {
        this.ipsStatusCode = ipsStatusCode;
    }

    public String getIpsStatusDescription() {
        return ipsStatusDescription;
    }

    public void setIpsStatusDescription(String ipsStatusDescription) {
        this.ipsStatusDescription = ipsStatusDescription;
    }

    public TransactionStatus getStatus() {
        return status;
    }

    public void setStatus(TransactionStatus status) {
        this.status = status;
    }

    public String getResponseCode() {
        return responseCode;
    }

    public void setResponseCode(String responseCode) {
        this.responseCode = responseCode;
    }

    public String getResponseMessage() {
        return responseMessage;
    }

    public void setResponseMessage(String responseMessage) {
        this.responseMessage = responseMessage;
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

    public String getFinacleResponseMessage() {
        return finacleResponseMessage;
    }

    public void setFinacleResponseMessage(String finacleResponseMessage) {
        this.finacleResponseMessage = finacleResponseMessage;
    }

    public OperationType getOperationType() {
        return operationType;
    }

    public void setOperationType(OperationType operationType) {
        this.operationType = operationType;
    }

    public TransactionType getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(TransactionType transactionType) {
        this.transactionType = transactionType;
    }

    public BigDecimal getSenderAmount() {
        return senderAmount;
    }

    public void setSenderAmount(BigDecimal senderAmount) {
        this.senderAmount = senderAmount;
    }

    public BigDecimal getReceiverAmount() {
        return receiverAmount;
    }

    public void setReceiverAmount(BigDecimal receiverAmount) {
        this.receiverAmount = receiverAmount;
    }

    public BigDecimal getPapssFeeAmount() {
        return papssFeeAmount;
    }

    public void setPapssFeeAmount(BigDecimal papssFeeAmount) {
        this.papssFeeAmount = papssFeeAmount;
    }

    public BigDecimal getBankFeeAmount() {
        return bankFeeAmount;
    }

    public BigDecimal getTotalTaxAmount() {
        return totalTaxAmount;
    }

    public void setTotalTaxAmount(BigDecimal totalTaxAmount) {
        this.totalTaxAmount = totalTaxAmount;
    }

    public void setBankFeeAmount(BigDecimal bankFeeAmount) {
        this.bankFeeAmount = bankFeeAmount;
    }

    public BigDecimal getPapssFeeAmountNet() {
        return papssFeeAmountNet;
    }

    public void setPapssFeeAmountNet(BigDecimal papssFeeAmountNet) {
        this.papssFeeAmountNet = papssFeeAmountNet;
    }

    public BigDecimal getBankFeeAmountNet() {
        return bankFeeAmountNet;
    }

    public void setBankFeeAmountNet(BigDecimal bankFeeAmountNet) {
        this.bankFeeAmountNet = bankFeeAmountNet;
    }

    public BigDecimal getPapssFeeTax() {
        return papssFeeTax;
    }

    public void setPapssFeeTax(BigDecimal papssFeeTax) {
        this.papssFeeTax = papssFeeTax;
    }

    public BigDecimal getBankFeeTax() {
        return bankFeeTax;
    }

    public void setBankFeeTax(BigDecimal bankFeeTax) {
        this.bankFeeTax = bankFeeTax;
    }

    public String getFxRate() {
        return fxRate;
    }

    public void setFxRate(String fxRate) {
        this.fxRate = fxRate;
    }

    public String getTransactionCurrency() {
        return transactionCurrency;
    }

    public void setTransactionCurrency(String transactionCurrency) {
        this.transactionCurrency = transactionCurrency;
    }

    public String getSourceCurrency() {
        return sourceCurrency;
    }

    public void setSourceCurrency(String sourceCurrency) {
        this.sourceCurrency = sourceCurrency;
    }

    public String getDestinationCurrency() {
        return destinationCurrency;
    }

    public void setDestinationCurrency(String destinationCurrency) {
        this.destinationCurrency = destinationCurrency;
    }

    public String getDestinationCountry() {
        return destinationCountry;
    }

    public void setDestinationCountry(String destinationCountry) {
        this.destinationCountry = destinationCountry;
    }

    public String getPaymentReason() {
        return paymentReason;
    }

    public void setPaymentReason(String paymentReason) {
        this.paymentReason = paymentReason;
    }

    public String getNarration() {
        return narration;
    }

    public void setNarration(String narration) {
        this.narration = narration;
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

    public OffsetDateTime getCompletedAt() {
        return completedAt;
    }

    public void setCompletedAt(OffsetDateTime completedAt) {
        this.completedAt = completedAt;
    }

    public SenderDetails getSenderDetails() {
        return senderDetails;
    }

    public void setSenderDetails(SenderDetails senderDetails) {
        this.senderDetails = senderDetails;
    }

    public ReceiverDetails getReceiverDetails() {
        return receiverDetails;
    }

    public void setReceiverDetails(ReceiverDetails receiverDetails) {
        this.receiverDetails = receiverDetails;
    }

    public ChannelInfo getChannelInfo() {
        return channelInfo;
    }

    public void setChannelInfo(ChannelInfo channelInfo) {
        this.channelInfo = channelInfo;
    }

    public FinacleTransaction getFinacleTransaction() {
        return finacleTransaction;
    }

    public void setFinacleTransaction(FinacleTransaction finacleTransaction) {
        this.finacleTransaction = finacleTransaction;
    }

    public PapssCallbackDetails getPapssCallbackDetails() {
        return papssCallbackDetails;
    }

    public void setPapssCallbackDetails(PapssCallbackDetails papssCallbackDetails) {
        this.papssCallbackDetails = papssCallbackDetails;
    }

    public TransactionPayload getTransactionPayload() {
        return transactionPayload;
    }

    public void setTransactionPayload(TransactionPayload transactionPayload) {
        this.transactionPayload = transactionPayload;
    }
}
