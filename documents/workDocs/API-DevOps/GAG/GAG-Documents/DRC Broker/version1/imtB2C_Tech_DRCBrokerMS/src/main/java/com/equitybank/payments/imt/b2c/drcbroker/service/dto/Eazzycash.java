
package com.equitybank.payments.imt.b2c.drcbroker.service.dto;

import java.io.Serializable;
import javax.annotation.Generated;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "rrn",
        "amount",
        "currency",
        "sender",
        "name",
        "number",
        "telco",
        "receiverName",
        "businessServiceRequest",
        "businessServiceInitialResponse",
        "businessServiceFinalResponse",
        "telcoRequest",
        "telcoInitialResponse",
        "telcoFinalResponse",
        "transactionId",
        "status",
        "statusCode",
        "statusDesc",
        "statusMessage"
})
@Generated("jsonschema2pojo")
public class Eazzycash implements Serializable {

    private String rrn;
    private String amount;
    private String currency;
    private String sender;
    private String name;
    private String number;
    private String telco;
    private String receiverName;
    private String businessServiceRequest;
    private String businessServiceInitialResponse;
    private String businessServiceFinalResponse;
    private String telcoRequest;
    private String telcoInitialResponse;
    private String telcoFinalResponse;
    private String transactionId;
    private String status;
    private String statusCode;
    private String statusDesc;
    private String statusMessage;
    private final static long serialVersionUID = 7759706532877086302L;

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

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getTelco() {
        return telco;
    }

    public void setTelco(String telco) {
        this.telco = telco;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
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

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
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

    public String getStatusMessage() {
        return statusMessage;
    }

    public void setStatusMessage(String statusMessage) {
        this.statusMessage = statusMessage;
    }

    @Override
    public String toString() {
        return "Eazzycash{" +
                "rrn='" + rrn + '\'' +
                ", amount='" + amount + '\'' +
                ", currency='" + currency + '\'' +
                ", sender='" + sender + '\'' +
                ", name='" + name + '\'' +
                ", number='" + number + '\'' +
                ", telco='" + telco + '\'' +
                ", receiverName='" + receiverName + '\'' +
                ", businessServiceRequest='" + businessServiceRequest + '\'' +
                ", businessServiceInitialResponse='" + businessServiceInitialResponse + '\'' +
                ", businessServiceFinalResponse='" + businessServiceFinalResponse + '\'' +
                ", telcoRequest='" + telcoRequest + '\'' +
                ", telcoInitialResponse='" + telcoInitialResponse + '\'' +
                ", telcoFinalResponse='" + telcoFinalResponse + '\'' +
                ", transactionId='" + transactionId + '\'' +
                ", status='" + status + '\'' +
                ", statusCode='" + statusCode + '\'' +
                ", statusDesc='" + statusDesc + '\'' +
                ", statusMessage='" + statusMessage + '\'' +
                '}';
    }
}
