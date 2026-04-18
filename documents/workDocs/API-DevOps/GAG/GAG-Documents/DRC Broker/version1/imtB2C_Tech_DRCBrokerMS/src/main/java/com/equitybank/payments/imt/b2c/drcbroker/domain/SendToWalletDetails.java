
package com.equitybank.payments.imt.b2c.drcbroker.domain;

import com.equitybank.payments.imt.b2c.drcbroker.domain.enumeration.ResponseStatusCode;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;
import javax.persistence.*;

@Entity
@Table(name = "send_to_wallet_details")
public class SendToWalletDetails implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "sequenceKeyGeneratorBroker")
    @SequenceGenerator(name = "sequenceKeyGeneratorBroker")
    private Long id;
    private String rrn;
    private String amount;
    private String currency;
    private String senderPhone;
    private String senderName;
    private String receiverNumber;
    private String telcoName;
    @Column(columnDefinition = "TEXT")
    private String businessServiceRequest;
    @Column(columnDefinition = "TEXT")
    private String businessServiceInitialResponse;
    @Column(columnDefinition = "TEXT")
    private String businessServiceFinalResponse;
    @Column(columnDefinition = "TEXT")
    private String telcoRequest;
    @Column(columnDefinition = "TEXT")
    private String telcoInitialResponse;
    @Column(columnDefinition = "TEXT")
    private String telcoFinalResponse;
    private String status;
    private String statusCode;
    private String statusDesc;
    private String initialStatusCode;
    private String finalStatusCode;
    @Column(columnDefinition = "TEXT")
    private String statusMessage;
    private String dateAdded;
    private String dateUpdated;
    private String transactionId;
    private final static long serialVersionUID = 1104062795824668419L;

    @PrePersist
    public void onCreate() {
        String patten = "yyyy-MM-dd'T'HH:mm:ss.SSS";
        SimpleDateFormat sdf = new SimpleDateFormat(patten);
        sdf.setTimeZone(TimeZone.getTimeZone("GMT+3"));
        String date = sdf.format(new Date()) + "Z";
        dateAdded = date;

        //initial status
        status = String.valueOf(ResponseStatusCode.PERSISTED);

        //initial status message
        statusMessage = "Transaction Persisted. Waiting For Initial Response From PCES Broker";
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

    public String getRrn() {
        return rrn;
    }

    public void setRrn(String rrn) {
        this.rrn = rrn;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getSenderPhone() {
        return senderPhone;
    }

    public void setSenderPhone(String senderPhone) {
        this.senderPhone = senderPhone;
    }

    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getReceiverNumber() {
        return receiverNumber;
    }

    public void setReceiverNumber(String receiverNumber) {
        this.receiverNumber = receiverNumber;
    }

    public String getTelcoName() {
        return telcoName;
    }

    public void setTelcoName(String telcoName) {
        this.telcoName = telcoName;
    }

    public String getBusinessServiceRequest() {
        return businessServiceRequest;
    }

    public void setBusinessServiceRequest(String businessServiceRequest) {
        this.businessServiceRequest = businessServiceRequest;
    }

    public String getBusinessServiceInitialResponse() {
        return businessServiceInitialResponse;
    }

    public void setBusinessServiceInitialResponse(String businessServiceInitialResponse) {
        this.businessServiceInitialResponse = businessServiceInitialResponse;
    }

    public String getBusinessServiceFinalResponse() {
        return businessServiceFinalResponse;
    }

    public void setBusinessServiceFinalResponse(String businessServiceFinalResponse) {
        this.businessServiceFinalResponse = businessServiceFinalResponse;
    }

    public String getTelcoRequest() {
        return telcoRequest;
    }

    public void setTelcoRequest(String telcoRequest) {
        this.telcoRequest = telcoRequest;
    }

    public String getTelcoInitialResponse() {
        return telcoInitialResponse;
    }

    public void setTelcoInitialResponse(String telcoInitialResponse) {
        this.telcoInitialResponse = telcoInitialResponse;
    }

    public String getTelcoFinalResponse() {
        return telcoFinalResponse;
    }

    public void setTelcoFinalResponse(String telcoFinalResponse) {
        this.telcoFinalResponse = telcoFinalResponse;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatusCode() {
        return statusCode;
    }

    public void setStatusCode(String statusCode) {
        this.statusCode = statusCode;
    }

    public String getStatusDesc() {
        return statusDesc;
    }

    public void setStatusDesc(String statusDesc) {
        this.statusDesc = statusDesc;
    }

    public String getInitialStatusCode() {
        return initialStatusCode;
    }

    public void setInitialStatusCode(String initialStatusCode) {
        this.initialStatusCode = initialStatusCode;
    }

    public String getFinalStatusCode() {
        return finalStatusCode;
    }

    public void setFinalStatusCode(String finalStatusCode) {
        this.finalStatusCode = finalStatusCode;
    }

    public String getStatusMessage() {
        return statusMessage;
    }

    public void setStatusMessage(String statusMessage) {
        this.statusMessage = statusMessage;
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

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    @Override
    public String toString() {
        return "BrokerServiceSendToWalletDetails{" +
                "id=" + id +
                ", rrn='" + rrn + '\'' +
                ", amount='" + amount + '\'' +
                ", currency='" + currency + '\'' +
                ", senderPhone='" + senderPhone + '\'' +
                ", senderName='" + senderName + '\'' +
                ", receiverNumber='" + receiverNumber + '\'' +
                ", telcoName='" + telcoName + '\'' +
                ", businessServiceRequest='" + businessServiceRequest + '\'' +
                ", businessServiceInitialResponse='" + businessServiceInitialResponse + '\'' +
                ", businessServiceFinalResponse='" + businessServiceFinalResponse + '\'' +
                ", telcoRequest='" + telcoRequest + '\'' +
                ", telcoInitialResponse='" + telcoInitialResponse + '\'' +
                ", telcoFinalResponse='" + telcoFinalResponse + '\'' +
                ", status='" + status + '\'' +
                ", statusCode='" + statusCode + '\'' +
                ", statusDesc='" + statusDesc + '\'' +
                ", initialStatusCode='" + initialStatusCode + '\'' +
                ", finalStatusCode='" + finalStatusCode + '\'' +
                ", statusMessage='" + statusMessage + '\'' +
                ", dateAdded='" + dateAdded + '\'' +
                ", dateUpdated='" + dateUpdated + '\'' +
                ", transactionId='" + transactionId + '\'' +
                '}';
    }
}
