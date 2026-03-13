package com.equitybankgroup.payments.b2c.dto.input;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "inquireRequest")
@XmlAccessorType(XmlAccessType.FIELD)
public class InquireRequest {

  

    @XmlElement(name = "tranDate")
    private String tranDate;
    @XmlElement(name = "rrn")
    private String rrn;
    @XmlElement(name = "walletName")
    private String walletName;
    
    @XmlElement(name = "shortCode")
    private String shortCode;

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

      /**
     * @return the shortCode
     */
    public String getShortCode() {
        return shortCode;
    }

    /**
     * @param shortCode the shortCode to set
     */
    public void setShortCode(String shortCode) {
        this.shortCode = shortCode;
    }
    public String toString() {
        return "InquireRequest{tranDate=" + this.tranDate + ", rrn=" + this.rrn + ", walletName=" + this.walletName + '}';
    }
}
