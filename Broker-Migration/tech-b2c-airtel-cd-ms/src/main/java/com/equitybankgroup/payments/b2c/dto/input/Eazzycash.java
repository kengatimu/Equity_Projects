package com.equitybankgroup.payments.b2c.dto.input;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.gson.annotations.Expose;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;


@XmlAccessorType(XmlAccessType.FIELD)
public class Eazzycash {
    
    @Expose
    @XmlElement(name = "bankId")
    private String bankId;
    @Expose
    @XmlElement(name = "amount")
    private String amount;
    @Expose
    @XmlElement(name = "sender")
    private String sender;
    @Expose
    @XmlElement(name = "number")
    private String number;
    @Expose
    @XmlElement(name = "name")
    private String name;
    @Expose
    @XmlElement(name = "telco")
    private String telco;
    @Expose
    @XmlElement(name = "rrn")
    private String rrn;
    @Expose
    @XmlElement(name = "signature")
    private String signature;
    @Expose
    @XmlElement(name = "channel")
    private String channel;
    @Expose
    @XmlElement(name = "tranID")
    private String walletTranID;
    @Expose
    @XmlElement(name = "currency")
    private String currency;

    public Eazzycash() {
    }

    public String getBankId() {
        return bankId;
    }

    public void setBankId(String bankId) {
        this.bankId = bankId;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTelco() {
        return telco;
    }

    public void setTelco(String telco) {
        this.telco = telco;
    }

    public String getRrn() {
        return rrn;
    }

    public void setRrn(String rrn) {
        this.rrn = rrn;
    }

    public String getSignature() {
        return signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    public String getChannel() {
        return channel;
    }

    public void setChannel(String channel) {
        this.channel = channel;
    }

    public String getWalletTranID() {
        return walletTranID;
    }

    public void setWalletTranID(String walletTranID) {
        this.walletTranID = walletTranID;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    @Override
    public String toString() {
        return "Eazzycash{" + "bankId=" + bankId + ", amount=" + amount + ", sender=" + sender + ", number=" + number + ", name=" + name + ", telco=" + telco + ", rrn=" + rrn + ", signature=" + signature + ", channel=" + channel + ", walletTranID=" + walletTranID + ", currency=" + currency + '}';
    }

    
    
}


/* Location:              C:\Users\geoffrey.kamau\Desktop\111\sub-b2c\b2c-sub-0.0.1-SNAPSHOT.jar!\com\way4\Eazzycash.class
 * Java compiler version: 6 (50.0)
 * JD-Core Version:       1.1.3
 */