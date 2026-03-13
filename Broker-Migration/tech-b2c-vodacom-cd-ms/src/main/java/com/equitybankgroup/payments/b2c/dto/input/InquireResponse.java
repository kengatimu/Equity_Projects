package com.equitybankgroup.payments.b2c.dto.input;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "inquireResponse")
@XmlAccessorType(XmlAccessType.FIELD)
public class InquireResponse {

    @XmlElement(name = "tranDate")
    private String tranDate;
    @XmlElement(name = "rrn")
    private String rrn;
    @XmlElement(name = "walletName")
    private String walletName;
    @XmlElement(name = "resultCode")
    private String resultCode;
    @XmlElement(name = "resultCodeDesc")
    private String resultCodeDesc;
    @XmlElement(name = "tranId")
    private String tranId;
    @XmlElement(name = "timeStamp")
    private String timeStamp;
    @XmlElement(name = "otherDetails")
    private String otherDetails;

    @XmlElement(name = "revStatus")
    private String revStatus;

    public InquireResponse() {
    }

    public InquireResponse(InquireRequest inquireRequest) {
        this.tranDate = inquireRequest.getTranDate();
        this.rrn = inquireRequest.getRrn();
        this.walletName = inquireRequest.getWalletName();
    }

    public String getTranDate() {
        return this.tranDate;
    }

    public void setTranDate(String tranDate) {
        this.tranDate = tranDate;
    }

    public String getRrn() {
        return this.rrn;
    }

    public void setRrn(String rrn) {
        this.rrn = rrn;
    }

    public String getWalletName() {
        return this.walletName;
    }

    public void setWalletName(String walletName) {
        this.walletName = walletName;
    }

    public String getResultCode() {
        return this.resultCode;
    }

    public void setResultCode(String resultCode) {
        this.resultCode = resultCode;
    }

    public String getResultCodeDesc() {
        return this.resultCodeDesc;
    }

    public void setResultCodeDesc(String resultCodeDesc) {
        this.resultCodeDesc = resultCodeDesc;
    }

    public String getTranId() {
        return this.tranId;
    }

    public void setTranId(String tranId) {
        this.tranId = tranId;
    }

    public String getTimeStamp() {
        return this.timeStamp;
    }

    public void setTimeStamp(String timeStamp) {
        this.timeStamp = timeStamp;
    }

    public String getOtherDetails() {
        return this.otherDetails;
    }

    public void setOtherDetails(String otherDetails) {
        this.otherDetails = otherDetails;
    }

    /**
     * @return the revStatus
     */
    public String getRevStatus() {
        return revStatus;
    }

    /**
     * @param revStatus the revStatus to set
     */
    public void setRevStatus(String revStatus) {
        this.revStatus = revStatus;
    }

    public String toString() {
        return "InquireResponse{tranDate=" + this.tranDate + ", rrn=" + this.rrn + ", walletName=" + this.walletName + ", resultCode=" + this.resultCode + ", resultCodeDesc=" + this.resultCodeDesc + ", tranId=" + this.tranId + ", timeStamp=" + this.timeStamp + ", otherDetails=" + this.otherDetails + '}';
    }

}
