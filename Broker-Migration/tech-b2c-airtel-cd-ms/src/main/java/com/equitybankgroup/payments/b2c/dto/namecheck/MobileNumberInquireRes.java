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


@XmlRootElement(name = "MobileNumberInquireRes")
@XmlAccessorType(XmlAccessType.FIELD)
public class MobileNumberInquireRes {
    @XmlElement(name = "msgId", required = false)
    private String msgId;
    @XmlElement(name = "channel")
    private String channel;
    @XmlElement(name = "telcom")
    private String telcom;
    @XmlElement(name = "mobileNumber")
    private String mobileNumber;
    @XmlElement(name = "responseCode")
    private String responseCode;
    @XmlElement(name = "customerNames")
    private String customerNames;
    @XmlElement(name = "limit")
    private String limit;
    @XmlElement(name = "charge")
    private Long charge;

    public MobileNumberInquireRes() {
    }

    public MobileNumberInquireRes(MobileNumberInquireReq mobileNumberInquireReq, String respCode, String custNames) {
        this.msgId = mobileNumberInquireReq.getMsgId();
        this.channel = mobileNumberInquireReq.getChannel();
        this.telcom = mobileNumberInquireReq.getTelcom();
        this.mobileNumber = mobileNumberInquireReq.getMobileNumber();
        this.responseCode = respCode;
        this.customerNames = custNames;
    }

    public MobileNumberInquireRes(MobileNumberInquireReq mobileNumberInquireReq, String respCode, String custNames, String limit) {
        this.msgId = mobileNumberInquireReq.getMsgId();
        this.channel = mobileNumberInquireReq.getChannel();
        this.telcom = mobileNumberInquireReq.getTelcom();
        this.mobileNumber = mobileNumberInquireReq.getMobileNumber();
        this.responseCode = respCode;
        this.customerNames = custNames;
        this.limit = limit;
    }

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

    public String getResponseCode() {
        return this.responseCode;
    }

    public void setResponseCode(String responseCode) {
        this.responseCode = responseCode;
    }

    public String getCustomerNames() {
        return this.customerNames;
    }

    public void setCustomerNames(String customerNames) {
        this.customerNames = customerNames;
    }

    public String getLimit() {
        return this.limit;
    }

    public void setLimit(String limit) {
        this.limit = limit;
    }

    @Override
    public String toString() {
        return "MobileNumberInquireRes{" +
                "msgId='" + msgId + '\'' +
                ", channel='" + channel + '\'' +
                ", telcom='" + telcom + '\'' +
                ", mobileNumber='" + mobileNumber + '\'' +
                ", responseCode='" + responseCode + '\'' +
                ", customerNames='" + customerNames + '\'' +
                ", limit='" + limit + '\'' +
                ", charge='" + charge + '\'' +
                '}';
    }

    public Long getCharge() {
        return charge;
    }

    public void setCharge(Long charge) {
        this.charge = charge;
    }
}


