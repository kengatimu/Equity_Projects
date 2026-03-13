
package com.huawei.cps.cpsinterface.common;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Group Beneficiary结构定义
 * 
 * <p>Java class for GroupBeneficiary complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="GroupBeneficiary"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BeneficiaryIdentityName" minOccurs="0"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="64"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="BeneficiaryGroupCode" type="{http://cps.huawei.com/cpsinterface/common}GroupCodeType"/&gt;
 *         &lt;element name="BeneficiaryReference" minOccurs="0"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="128"/&gt;
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
@XmlType(name = "GroupBeneficiary", propOrder = {
    "beneficiaryIdentityName",
    "beneficiaryGroupCode",
    "beneficiaryReference"
})
public class GroupBeneficiary {

    @XmlElement(name = "BeneficiaryIdentityName")
    protected String beneficiaryIdentityName;
    @XmlElement(name = "BeneficiaryGroupCode", required = true)
    protected String beneficiaryGroupCode;
    @XmlElement(name = "BeneficiaryReference")
    protected String beneficiaryReference;

    /**
     * Gets the value of the beneficiaryIdentityName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBeneficiaryIdentityName() {
        return beneficiaryIdentityName;
    }

    /**
     * Sets the value of the beneficiaryIdentityName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBeneficiaryIdentityName(String value) {
        this.beneficiaryIdentityName = value;
    }

    /**
     * Gets the value of the beneficiaryGroupCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBeneficiaryGroupCode() {
        return beneficiaryGroupCode;
    }

    /**
     * Sets the value of the beneficiaryGroupCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBeneficiaryGroupCode(String value) {
        this.beneficiaryGroupCode = value;
    }

    /**
     * Gets the value of the beneficiaryReference property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBeneficiaryReference() {
        return beneficiaryReference;
    }

    /**
     * Sets the value of the beneficiaryReference property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBeneficiaryReference(String value) {
        this.beneficiaryReference = value;
    }

}
