package com.equitybankgroup.payments.b2c.dto.input;

import com.google.gson.annotations.Expose;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;


@XmlAccessorType(XmlAccessType.FIELD)
public class Eazzycash {
    @Expose
    @XmlElement(name = "amount")
    private long amount;
    @Expose
    @XmlElement(name = "bankId")
    private String bankId;
    @Expose
    @XmlElement(name = "currency")
    private String currency;
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
    @XmlElement(name = "destinationShortCode")
    private String destinationShortCode;
    @Expose
    @XmlElement(name = "storeNumber")
    private String storeNumber;
    @Expose
    @XmlElement(name = "tranType")
    private String tranType;
    @Expose
    @XmlElement(name = "refNumber")
    private String refNumber;
    @Expose
    @XmlElement(name = "source")
    private String source;
    @Expose
    @XmlElement(name = "narration")
    private String narration;
    @Expose
    @XmlElement(name = "chargeFlag")
    private String chargeFlag;

    public long getAmount() {
        return this.amount;
    }


    public void setAmount(long amount) {
        this.amount = amount;
    }


    public String getSender() {
        return this.sender;
    }


    public void setSender(String sender) {
        this.sender = sender;
    }


    public String getNumber() {
        return this.number;
    }


    public void setNumber(String number) {
        this.number = number;
    }


    public String getName() {
        return this.name;
    }


    public void setName(String name) {
        this.name = name;
    }


    public String getTelco() {
        return this.telco;
    }


    public void setTelco(String telco) {
        this.telco = telco;
    }


    public String getRrn() {
        return this.rrn;
    }


    public void setRrn(String rrn) {
        this.rrn = rrn;
    }


    public String getSignature() {
        return this.signature;
    }


    public void setSignature(String signature) {
        this.signature = signature;
    }


    public String getChannel() {
        return this.channel;
    }


    public void setChannel(String channel) {
        this.channel = channel;
    }

    public String getWalletTranID() {
        return this.walletTranID;
    }

    public void setWalletTranID(String walletTranID) {
        this.walletTranID = walletTranID;
    }

    public String getDestinationShortCode() {
        return destinationShortCode;
    }

    public void setDestinationShortCode(String destinationShortCode) {
        this.destinationShortCode = destinationShortCode;
    }

    public String getStoreNumber() {
        return storeNumber;
    }

    public void setStoreNumber(String storeNumber) {
        this.storeNumber = storeNumber;
    }

    public String getTranType() {
        return tranType;
    }

    public void setTranType(String tranType) {
        this.tranType = tranType;
    }

    public String getRefNumber() {
        return refNumber;
    }

    public void setRefNumber(String refNumber) {
        this.refNumber = refNumber;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getBankId() {
        return bankId;
    }

    public void setBankId(String bankId) {
        this.bankId = bankId;
    }

    public String getCurrency() {
        return currency;
    }

    public void setCurrency(String currency) {
        this.currency = currency;
    }

    public String getNarration() {
        return narration;
    }

    public void setNarration(String narration) {
        this.narration = narration;
    }

    public String getChargeFlag() {
        return chargeFlag;
    }

    public void setChargeFlag(String chargeFlag) {
        this.chargeFlag = chargeFlag;
    }
}


/* Location:              C:\Users\geoffrey.kamau\Desktop\111\sub-b2c\b2c-sub-0.0.1-SNAPSHOT.jar!\com\way4\Eazzycash.class
 * Java compiler version: 6 (50.0)
 * JD-Core Version:       1.1.3
 */