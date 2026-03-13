
package com.huawei.cps.cpsinterface.result;

import com.huawei.cps.cpsinterface.common.CertificateDetailsDataType;
import com.huawei.cps.cpsinterface.common.IDDetailsDataType;
import com.huawei.cps.cpsinterface.common.SimpleKYCDataType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询OrgOperator的KYC
 * 
 * <p>Java class for QueryOrgOperatorKYCResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryOrgOperatorKYCResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="SimpleKYCData" type="{http://cps.huawei.com/cpsinterface/common}SimpleKYCDataType" minOccurs="0"/&gt;
 *         &lt;element name="IDDetailsData" type="{http://cps.huawei.com/cpsinterface/common}IDDetailsDataType" minOccurs="0"/&gt;
 *         &lt;element name="CertificateDetailsData" type="{http://cps.huawei.com/cpsinterface/common}CertificateDetailsDataType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "QueryOrgOperatorKYCResult", propOrder = {
    "boCompletedTime",
    "simpleKYCData",
    "idDetailsData",
    "certificateDetailsData"
})
public class QueryOrgOperatorKYCResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "SimpleKYCData")
    protected SimpleKYCDataType simpleKYCData;
    @XmlElement(name = "IDDetailsData")
    protected IDDetailsDataType idDetailsData;
    @XmlElement(name = "CertificateDetailsData")
    protected CertificateDetailsDataType certificateDetailsData;

    /**
     * Gets the value of the boCompletedTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBOCompletedTime() {
        return boCompletedTime;
    }

    /**
     * Sets the value of the boCompletedTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBOCompletedTime(String value) {
        this.boCompletedTime = value;
    }

    /**
     * Gets the value of the simpleKYCData property.
     * 
     * @return
     *     possible object is
     *     {@link SimpleKYCDataType }
     *     
     */
    public SimpleKYCDataType getSimpleKYCData() {
        return simpleKYCData;
    }

    /**
     * Sets the value of the simpleKYCData property.
     * 
     * @param value
     *     allowed object is
     *     {@link SimpleKYCDataType }
     *     
     */
    public void setSimpleKYCData(SimpleKYCDataType value) {
        this.simpleKYCData = value;
    }

    /**
     * Gets the value of the idDetailsData property.
     * 
     * @return
     *     possible object is
     *     {@link IDDetailsDataType }
     *     
     */
    public IDDetailsDataType getIDDetailsData() {
        return idDetailsData;
    }

    /**
     * Sets the value of the idDetailsData property.
     * 
     * @param value
     *     allowed object is
     *     {@link IDDetailsDataType }
     *     
     */
    public void setIDDetailsData(IDDetailsDataType value) {
        this.idDetailsData = value;
    }

    /**
     * Gets the value of the certificateDetailsData property.
     * 
     * @return
     *     possible object is
     *     {@link CertificateDetailsDataType }
     *     
     */
    public CertificateDetailsDataType getCertificateDetailsData() {
        return certificateDetailsData;
    }

    /**
     * Sets the value of the certificateDetailsData property.
     * 
     * @param value
     *     allowed object is
     *     {@link CertificateDetailsDataType }
     *     
     */
    public void setCertificateDetailsData(CertificateDetailsDataType value) {
        this.certificateDetailsData = value;
    }

}
