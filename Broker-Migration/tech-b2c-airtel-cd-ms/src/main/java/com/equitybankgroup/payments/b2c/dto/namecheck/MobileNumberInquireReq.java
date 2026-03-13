/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.dto.namecheck;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlRootElement;


@XmlRootElement(name = "mobileNumberInquireReq")
@XmlAccessorType(XmlAccessType.FIELD)
public class MobileNumberInquireReq {
    @XmlElement(name = "msgId", required = false)
    private String msgId;
    @XmlElement(name = "channel")
    private String channel;
    @XmlElement(name = "telcom")
    private String telcom;
    @XmlElement(name = "mobileNumber")
    private String mobileNumber;
    @XmlElement(name = "timestamp", required = true)
    private String timestamp;
    @XmlElement(name = "signature", required = true)
    private String signature;
    @XmlElement(name = "tillNumber")
    private String tillNumber;
    @XmlElement(name = "nationalID")
    private String nationalID;
    @XmlElement(name = "amount")
    private String amount;
    @XmlElement(name = "bankId")
    private String bankId;

    public String getMsgId() {
        return this.msgId;
    }

    public void setMsgId(String msgId) {
        this.msgId = msgId;
    }

    public String getChannel() {
        return this.channel;
    }

    public void setChannel(String channel) {
        this.channel = channel;
    }

    public String getTelcom() {
        return this.telcom;
    }

    public void setTelcom(String telcom) {
        this.telcom = telcom;
    }

    public String getMobileNumber() {
        return this.mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    public String getTimestamp() {
        return this.timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public String getSignature() {
        return this.signature;
    }

    public void setSignature(String signature) {
        this.signature = signature;
    }

    public String getTillNumber() {
        return this.tillNumber;
    }

    public void setTillNumber(String tillNumber) {
        this.tillNumber = tillNumber;
    }


    public String toString() {
        StringBuffer sb = new StringBuffer("MobileNumberInquireReq{");
        sb.append("msgId='").append(this.msgId).append('\'');
        sb.append(", channel='").append(this.channel).append('\'');
        sb.append(", telcom='").append(this.telcom).append('\'');
        sb.append(", mobileNumber='").append(this.mobileNumber).append('\'');
        sb.append(", timestamp='").append(this.timestamp).append('\'');
        sb.append(", signature='").append(this.signature).append('\'');
        sb.append(", tillNumber='").append(this.tillNumber).append('\'');
        sb.append(", nationalId='").append(this.nationalID).append('\'');
        sb.append(", bankId='").append(this.nationalID).append('\'');
        sb.append('}');
        return sb.toString();
    }

    public String getNationalID() {
        return this.nationalID;
    }

    public void setNationalID(String nationalID) {
        this.nationalID = nationalID;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getBankId() {
        return bankId;
    }

    public void setBankId(String bankId) {
        this.bankId = bankId;
    }
    
    
}
