
package com.huawei.cps.cpsinterface.common;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Operator的证书类型定义
 * 
 * <p>Java class for CertificateRecordType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CertificateRecordType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="CertificateTypeValue"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="32"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="CertificateNumber"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="64"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="CertificateEffectiveDate" type="{http://cps.huawei.com/cpsinterface/common}Date" minOccurs="0"/&gt;
 *         &lt;element name="CertificateExpiryDate" type="{http://cps.huawei.com/cpsinterface/common}Date" minOccurs="0"/&gt;
 *         &lt;element name="Status" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CertificateRecordType", propOrder = {
    "certificateTypeValue",
    "certificateNumber",
    "certificateEffectiveDate",
    "certificateExpiryDate",
    "status"
})
public class CertificateRecordType {

    @XmlElement(name = "CertificateTypeValue", required = true)
    protected String certificateTypeValue;
    @XmlElement(name = "CertificateNumber", required = true)
    protected String certificateNumber;
    @XmlElement(name = "CertificateEffectiveDate")
    protected String certificateEffectiveDate;
    @XmlElement(name = "CertificateExpiryDate")
    protected String certificateExpiryDate;
    @XmlElement(name = "Status")
    protected String status;

    /**
     * Gets the value of the certificateTypeValue property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCertificateTypeValue() {
        return certificateTypeValue;
    }

    /**
     * Sets the value of the certificateTypeValue property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCertificateTypeValue(String value) {
        this.certificateTypeValue = value;
    }

    /**
     * Gets the value of the certificateNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCertificateNumber() {
        return certificateNumber;
    }

    /**
     * Sets the value of the certificateNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCertificateNumber(String value) {
        this.certificateNumber = value;
    }

    /**
     * Gets the value of the certificateEffectiveDate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCertificateEffectiveDate() {
        return certificateEffectiveDate;
    }

    /**
     * Sets the value of the certificateEffectiveDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCertificateEffectiveDate(String value) {
        this.certificateEffectiveDate = value;
    }

    /**
     * Gets the value of the certificateExpiryDate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCertificateExpiryDate() {
        return certificateExpiryDate;
    }

    /**
     * Sets the value of the certificateExpiryDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCertificateExpiryDate(String value) {
        this.certificateExpiryDate = value;
    }

    /**
     * Gets the value of the status property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getStatus() {
        return status;
    }

    /**
     * Sets the value of the status property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setStatus(String value) {
        this.status = value;
    }

}
