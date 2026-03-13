package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.model;

import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.enums.RequestTypes;
import jakarta.persistence.*;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;

@Entity
@Table(name = "Telco_B2C_Transaction_Details")
//@Table(name = "Telco_B2C_Transaction_Details", indexes = {
//        @Index(name = "index_rrn", columnList = "rrn"),
//        @Index(name = "index_telco_name", columnList = "telco_name")
//})
public class TransactionDetails implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "transaction_seq")
    @SequenceGenerator(name = "transaction_seq", sequenceName = "transaction_seq", allocationSize = 1)
    private Long id;

    @Column(name = "rrn", unique = true, nullable = false)
    private String rrn;

    @Column(name = "channel")
    private String channel;

    @Column(name = "bank_id")
    private String bankId;

    @Column(name = "imt_transaction_date")
    private String imtTransactionDate;

    @Column(name = "imt_reference_number")
    private String imtReferenceNumber;

    @Column(name = "country_code")
    private String countryCode;

    @Column(name = "operation_type")
    @Enumerated(EnumType.STRING)
    private RequestTypes operationType;

    @Column(name = "request_type")
    private String requestType;

    @Column(name = "imt_operation")
    private String imtOperation;

    @Column(name = "amount")
    private BigDecimal amount;

    @Column(name = "imt_fee_amount")
    private BigDecimal imtFeeAmount;

    @Column(name = "total_fees")
    private BigDecimal totalFees;

    @Column(name = "sender_account")
    private String senderAccount;

    @Column(name = "receiver_account")
    private String receiverAccount;

    @Column(name = "sender_msisdn")
    private String senderMsisdn;

    @Column(name = "sender_name")
    private String senderName;

    @Column(name = "source_currency")
    private String sourceCurrency;

    @Column(name = "receive_currency")
    private String receiveCurrency;

    @Column(name = "receiver_msisdn")
    private String receiverMsisdn;

    @Column(name = "receiver_name")
    private String receiverName;

    @Column(name = "telco_name")
    private String telcoName;

    @Column(name = "opt_in")
    private Boolean optIn;

    @Column(name = "client_type")
    private String clientType;

    @Column(name = "date_created")
    private LocalDateTime dateCreated;

    @Column(name = "date_updated")
    private LocalDateTime dateUpdated;

//    @JsonIgnore // Add this annotation to ignore the field during serialization
    @OneToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY, orphanRemoval = true)
    @JoinColumn(name = "payload_details_id", referencedColumnName = "id")
    private PayloadDetails payloadDetails;

//    @JsonIgnore // Add this annotation to ignore the field during serialization
    @OneToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY, orphanRemoval = true)
    @JoinColumn(name = "status_details_id", referencedColumnName = "id")
    private StatusDetails statusDetails;

//    @JsonIgnore // Add this annotation to ignore the field during serialization
    @OneToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY, orphanRemoval = true)
    @JoinColumn(name = "callback_id", referencedColumnName = "id")
    private Callback callback;

//    @JsonIgnore // Add this annotation to ignore the field during serialization
    @OneToOne(cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH}, fetch = FetchType.LAZY, orphanRemoval = true)
    @JoinColumn(name = "cbs_transaction_details_id", referencedColumnName = "id")
    private CbsTransactionDetails cbsTransactionDetails;

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

    public String getChannel() {
        return channel;
    }

    public void setChannel(String channel) {
        this.channel = channel;
    }

    public String getBankId() {
        return bankId;
    }

    public void setBankId(String bankId) {
        this.bankId = bankId;
    }

    public String getImtTransactionDate() {
        return imtTransactionDate;
    }

    public void setImtTransactionDate(String imtTransactionDate) {
        this.imtTransactionDate = imtTransactionDate;
    }

    public String getImtReferenceNumber() {
        return imtReferenceNumber;
    }

    public void setImtReferenceNumber(String imtReferenceNumber) {
        this.imtReferenceNumber = imtReferenceNumber;
    }

    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode;
    }

    public String getRequestType() {
        return requestType;
    }

    public void setRequestType(String requestType) {
        this.requestType = requestType;
    }

    public RequestTypes getOperationType() {
        return operationType;
    }

    public void setOperationType(RequestTypes operationType) {
        this.operationType = operationType;
    }

    public String getImtOperation() {
        return imtOperation;
    }

    public void setImtOperation(String imtOperation) {
        this.imtOperation = imtOperation;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public BigDecimal getImtFeeAmount() {
        return imtFeeAmount;
    }

    public void setImtFeeAmount(BigDecimal imtFeeAmount) {
        this.imtFeeAmount = imtFeeAmount;
    }

    public BigDecimal getTotalFees() {
        return totalFees;
    }

    public void setTotalFees(BigDecimal totalFees) {
        this.totalFees = totalFees;
    }

    public String getSenderAccount() {
        return senderAccount;
    }

    public void setSenderAccount(String senderAccount) {
        this.senderAccount = senderAccount;
    }

    public String getReceiverAccount() {
        return receiverAccount;
    }

    public void setReceiverAccount(String receiverAccount) {
        this.receiverAccount = receiverAccount;
    }

    public String getSenderMsisdn() {
        return senderMsisdn;
    }

    public void setSenderMsisdn(String senderMsisdn) {
        this.senderMsisdn = senderMsisdn;
    }

    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getSourceCurrency() {
        return sourceCurrency;
    }

    public void setSourceCurrency(String sourceCurrency) {
        this.sourceCurrency = sourceCurrency;
    }

    public String getReceiveCurrency() {
        return receiveCurrency;
    }

    public void setReceiveCurrency(String receiveCurrency) {
        this.receiveCurrency = receiveCurrency;
    }

    public String getReceiverMsisdn() {
        return receiverMsisdn;
    }

    public void setReceiverMsisdn(String receiverMsisdn) {
        this.receiverMsisdn = receiverMsisdn;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public String getTelcoName() {
        return telcoName;
    }

    public void setTelcoName(String telcoName) {
        this.telcoName = telcoName;
    }

    public Boolean getOptIn() {
        return optIn;
    }

    public void setOptIn(Boolean optIn) {
        this.optIn = optIn;
    }

    public String getClientType() {
        return clientType;
    }

    public void setClientType(String clientType) {
        this.clientType = clientType;
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

    public PayloadDetails getPayloadDetails() {
        return payloadDetails;
    }

    public void setPayloadDetails(PayloadDetails payloadDetails) {
        this.payloadDetails = payloadDetails;
    }

    public StatusDetails getStatusDetails() {
        return statusDetails;
    }

    public void setStatusDetails(StatusDetails statusDetails) {
        this.statusDetails = statusDetails;
    }

    public Callback getCallback() {
        return callback;
    }

    public void setCallback(Callback callback) {
        this.callback = callback;
    }

    public CbsTransactionDetails getCbsTransactionDetails() {
        return cbsTransactionDetails;
    }

    public void setCbsTransactionDetails(CbsTransactionDetails cbsTransactionDetails) {
        this.cbsTransactionDetails = cbsTransactionDetails;
    }
}
