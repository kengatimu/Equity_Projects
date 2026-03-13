
package com.equitybank.gag.dummy_telco_b2c_ms.dto.b2c.tran.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlSchemaType;
import java.io.Serializable;
import java.util.Date;

@XmlAccessorType(XmlAccessType.FIELD)
@JsonPropertyOrder({
    "mmHeaderInfo",
    "externalRefNo",
    "mobileNo",
    "mobileName",
    "mobileAlias",
    "accountNo",
    "accountAlias",
    "accountName",
    "transferDescription",
    "ccy",
    "amount",
    "charge",
    "tranDate",
    "udf1",
    "udf2",
    "udf3"
})
public class MobileTransferRequest implements Serializable {
    private final static long serialVersionUID = -5635425663197216341L;

    @XmlElement(name = "mmHeaderInfo")
    @JsonProperty("mmHeaderInfo")
    private MmHeaderInfo mmHeaderInfo;

    @XmlElement(name = "externalRefNo")
    @JsonProperty("externalRefNo")
    private String externalRefNo;

    @XmlElement(name = "mobileNo")
    @JsonProperty("mobileNo")
    private String mobileNo;

    @XmlElement(name = "mobileName")
    @JsonProperty("mobileName")
    private String mobileName;

    @XmlElement(name = "mobileAlias")
    @JsonProperty("mobileAlias")
    private String mobileAlias;

    @XmlElement(name = "accountNo")
    @JsonProperty("accountNo")
    private String accountNo;

    @XmlElement(name = "accountAlias")
    @JsonProperty("accountAlias")
    private String accountAlias;

    @XmlElement(name = "accountName")
    @JsonProperty("accountName")
    private String accountName;

    @XmlElement(name = "transferDescription")
    @JsonProperty("transferDescription")
    private String transferDescription;

    @XmlElement(name = "ccy")
    @JsonProperty("ccy")
    private String ccy;

    @XmlElement(name = "amount")
    @JsonProperty("amount")
    private double amount;

    @XmlElement(name = "charge")
    @JsonProperty("charge")
    private double charge;

    @XmlElement(name = "tranDate")
    @JsonProperty("tranDate")
    @XmlSchemaType(name = "date")
    private Date tranDate;

    @XmlElement(name = "udf1")
    @JsonProperty("udf1")
    private String udf1;

    @XmlElement(name = "udf2")
    @JsonProperty("udf2")
    private String udf2;

    @XmlElement(name = "udf3")
    @JsonProperty("udf3")
    private String udf3;

    @JsonProperty("mmHeaderInfo")
    public MmHeaderInfo getMmHeaderInfo() {
        return mmHeaderInfo;
    }

    @JsonProperty("mmHeaderInfo")
    public void setMmHeaderInfo(MmHeaderInfo mmHeaderInfo) {
        this.mmHeaderInfo = mmHeaderInfo;
    }

    @JsonProperty("externalRefNo")
    public String getExternalRefNo() {
        return externalRefNo;
    }

    @JsonProperty("externalRefNo")
    public void setExternalRefNo(String externalRefNo) {
        this.externalRefNo = externalRefNo;
    }

    @JsonProperty("mobileNo")
    public String getMobileNo() {
        return mobileNo;
    }

    @JsonProperty("mobileNo")
    public void setMobileNo(String mobileNo) {
        this.mobileNo = mobileNo;
    }

    @JsonProperty("mobileName")
    public String getMobileName() {
        return mobileName;
    }

    @JsonProperty("mobileName")
    public void setMobileName(String mobileName) {
        this.mobileName = mobileName;
    }

    @JsonProperty("mobileAlias")
    public String getMobileAlias() {
        return mobileAlias;
    }

    @JsonProperty("mobileAlias")
    public void setMobileAlias(String mobileAlias) {
        this.mobileAlias = mobileAlias;
    }

    @JsonProperty("accountNo")
    public String getAccountNo() {
        return accountNo;
    }

    @JsonProperty("accountNo")
    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }

    @JsonProperty("accountAlias")
    public String getAccountAlias() {
        return accountAlias;
    }

    @JsonProperty("accountAlias")
    public void setAccountAlias(String accountAlias) {
        this.accountAlias = accountAlias;
    }

    @JsonProperty("accountName")
    public String getAccountName() {
        return accountName;
    }

    @JsonProperty("accountName")
    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    @JsonProperty("transferDescription")
    public String getTransferDescription() {
        return transferDescription;
    }

    @JsonProperty("transferDescription")
    public void setTransferDescription(String transferDescription) {
        this.transferDescription = transferDescription;
    }

    @JsonProperty("ccy")
    public String getCcy() {
        return ccy;
    }

    @JsonProperty("ccy")
    public void setCcy(String ccy) {
        this.ccy = ccy;
    }

    @JsonProperty("amount")
    public double getAmount() {
        return amount;
    }

    @JsonProperty("amount")
    public void setAmount(double amount) {
        this.amount = amount;
    }

    @JsonProperty("charge")
    public double getCharge() {
        return charge;
    }

    @JsonProperty("charge")
    public void setCharge(double charge) {
        this.charge = charge;
    }

    @JsonProperty("tranDate")
    public Date getTranDate() {
        return tranDate;
    }

    @JsonProperty("tranDate")
    public void setTranDate(Date tranDate) {
        this.tranDate = tranDate;
    }

    @JsonProperty("udf1")
    public String getUdf1() {
        return udf1;
    }

    @JsonProperty("udf1")
    public void setUdf1(String udf1) {
        this.udf1 = udf1;
    }

    @JsonProperty("udf2")
    public String getUdf2() {
        return udf2;
    }

    @JsonProperty("udf2")
    public void setUdf2(String udf2) {
        this.udf2 = udf2;
    }

    @JsonProperty("udf3")
    public String getUdf3() {
        return udf3;
    }

    @JsonProperty("udf3")
    public void setUdf3(String udf3) {
        this.udf3 = udf3;
    }
}
