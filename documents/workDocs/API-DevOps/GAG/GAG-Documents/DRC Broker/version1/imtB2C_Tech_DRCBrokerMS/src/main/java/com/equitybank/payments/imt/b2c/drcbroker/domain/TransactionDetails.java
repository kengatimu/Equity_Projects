
package com.equitybank.payments.imt.b2c.drcbroker.domain;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;
import javax.annotation.Generated;
import javax.persistence.*;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

@Entity
@Table(name = "transaction_details")
@Generated("jsonschema2pojo")
public class TransactionDetails implements Serializable {
    private final static long serialVersionUID = 3069762565995998474L;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceKeyGeneratorBroker")
    @SequenceGenerator(name = "sequenceKeyGeneratorBroker")
    @Column(name = "id")
    @SerializedName("id")
    @Expose
    private Long id;

    @Column(name = "beneficiary_phone")
    @SerializedName("beneficiaryPhone")
    @Expose
    private String beneficiaryPhone;

    @Column(name = "telco_name")
    @SerializedName("telcoName")
    @Expose
    private String telcoName;

    @Column(name = "amount")
    @SerializedName("amount")
    @Expose
    private String amount;

    @Column(name = "fee")
    @SerializedName("fee")
    @Expose
    private String fee;

    @Column(name = "transaction_currency")
    @SerializedName("tranCurrency")
    @Expose
    private String tranCurrency;

    @Column(name = "fee_currency")
    @SerializedName("feeCurrency")
    @Expose
    private String feeCurrency;

    @Column(name = "transaction_type")
    @SerializedName("transactionType")
    @Expose
    private String transactionType;

    @Column(name = "transaction_id")
    @SerializedName("transactionId")
    @Expose
    private String transactionId;

    @Column(name = "date_added")
    @SerializedName("dateAdded")
    @Expose
    private String dateAdded;

    @Column(name = "date_updated")
    @SerializedName("dateUpdated")
    @Expose
    private String dateUpdated;

    //bidirectional to senderDetails without applying cascade delete
    @ManyToOne(fetch = FetchType.LAZY,
            cascade = {
                    CascadeType.DETACH,
                    CascadeType.MERGE,
                    CascadeType.PERSIST,
                    CascadeType.REFRESH
            })
    @JoinColumn(name = "sender_phone")
//    @Expose //don,t @Expose, otherwise it will loop forever causing stackoverflow exception
    private SenderDetails senderDetails;

    @OneToOne(fetch = FetchType.LAZY,
            cascade = {
                    CascadeType.DETACH,
                    CascadeType.MERGE,
                    CascadeType.PERSIST,
                    CascadeType.REFRESH
            })
    @JoinColumn(name = "payload_detail_id")
    @Expose
    private PayloadDetails payloadDetails;

    @OneToOne(fetch = FetchType.LAZY,
            cascade = {
                    CascadeType.DETACH,
                    CascadeType.MERGE,
                    CascadeType.PERSIST,
                    CascadeType.REFRESH
            })
    @JoinColumn(name = "transaction_status_detail_id")
    @Expose
    private StatusDetails statusDetails;

    @PrePersist
    public void onCreate() {
        String patten = "yyyy-MM-dd'T'HH:mm:ss.SSS";
        SimpleDateFormat sdf = new SimpleDateFormat(patten);
        sdf.setTimeZone(TimeZone.getTimeZone("GMT+3"));
        String date = sdf.format(new Date()) + "Z";
        dateAdded = date;
    }

    @PreUpdate
    public void onUpdate() {
        String patten = "yyyy-MM-dd'T'HH:mm:ss.SSS";
        SimpleDateFormat sdf = new SimpleDateFormat(patten);
        sdf.setTimeZone(TimeZone.getTimeZone("GMT+3"));
        String date = sdf.format(new Date()) + "Z";
        dateUpdated = date;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getBeneficiaryPhone() {
        return beneficiaryPhone;
    }

    public void setBeneficiaryPhone(String beneficiaryPhone) {
        this.beneficiaryPhone = beneficiaryPhone;
    }

    public String getTelcoName() {
        return telcoName;
    }

    public void setTelcoName(String telcoName) {
        this.telcoName = telcoName;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getFee() {
        return fee;
    }

    public void setFee(String fee) {
        this.fee = fee;
    }

    public String getTranCurrency() {
        return tranCurrency;
    }

    public void setTranCurrency(String tranCurrency) {
        this.tranCurrency = tranCurrency;
    }

    public String getFeeCurrency() {
        return feeCurrency;
    }

    public void setFeeCurrency(String feeCurrency) {
        this.feeCurrency = feeCurrency;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public String getDateAdded() {
        return dateAdded;
    }

    public void setDateAdded(String dateAdded) {
        this.dateAdded = dateAdded;
    }

    public String getDateUpdated() {
        return dateUpdated;
    }

    public void setDateUpdated(String dateUpdated) {
        this.dateUpdated = dateUpdated;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public SenderDetails getSenderDetails() {
        return senderDetails;
    }

    public void setSenderDetails(SenderDetails senderDetails) {
        this.senderDetails = senderDetails;
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

    @Override
    public String toString() {
        return "TransactionDetails{" +
                "id=" + id +
                ", beneficiaryPhone='" + beneficiaryPhone + '\'' +
                ", telcoName='" + telcoName + '\'' +
                ", amount='" + amount + '\'' +
                ", fee='" + fee + '\'' +
                ", tranCurrency='" + tranCurrency + '\'' +
                ", feeCurrency='" + feeCurrency + '\'' +
                ", transactionType='" + transactionType + '\'' +
                ", transactionId='" + transactionId + '\'' +
                ", dateAdded='" + dateAdded + '\'' +
                ", dateUpdated='" + dateUpdated + '\'' +
                ", senderDetails=" + senderDetails +
                ", payloadDetails=" + payloadDetails +
                ", transactionStatusDetails=" + statusDetails +
                '}';
    }
}
