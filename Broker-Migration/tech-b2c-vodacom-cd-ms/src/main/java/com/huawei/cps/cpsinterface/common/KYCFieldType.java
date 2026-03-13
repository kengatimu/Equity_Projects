
package com.huawei.cps.cpsinterface.common;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * KYC字段定义
 * 
 * <p>Java class for KYCFieldType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="KYCFieldType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="KYCName"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;minLength value="1"/&gt;
 *               &lt;maxLength value="64"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="KYCValue"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="512"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "KYCFieldType", propOrder = {
    "kycName",
    "kycValue"
})
public class KYCFieldType {

    @XmlElement(name = "KYCName", required = true)
    protected String kycName;
    @XmlElement(name = "KYCValue", required = true)
    protected String kycValue;

    /**
     * Gets the value of the kycName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getKYCName() {
        return kycName;
    }

    /**
     * Sets the value of the kycName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setKYCName(String value) {
        this.kycName = value;
    }

    /**
     * Gets the value of the kycValue property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getKYCValue() {
        return kycValue;
    }

    /**
     * Sets the value of the kycValue property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setKYCValue(String value) {
        this.kycValue = value;
    }

}
