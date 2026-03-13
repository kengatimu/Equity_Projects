
package com.huawei.cps.cpsinterface.result;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Customer基本信息
 * 
 * <p>Java class for CustomerInfoType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CustomerInfoType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="CustomerType" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="IdentityStatus" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="RegistrationDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
 *         &lt;element name="RegisteredBy" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="PrimaryMSISDN" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="LanguageCode" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="TrustLevel" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="TrustLevelName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="RuleProfileID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="RuleProfileName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="ChargeProfileID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="ChargeProfileName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CustomerInfoType", propOrder = {
    "customerType",
    "identityStatus",
    "registrationDate",
    "registeredBy",
    "primaryMSISDN",
    "languageCode",
    "trustLevel",
    "trustLevelName",
    "ruleProfileID",
    "ruleProfileName",
    "chargeProfileID",
    "chargeProfileName"
})
public class CustomerInfoType {

    @XmlElement(name = "CustomerType", required = true)
    protected String customerType;
    @XmlElement(name = "IdentityStatus", required = true)
    protected String identityStatus;
    @XmlElement(name = "RegistrationDate", required = true)
    protected String registrationDate;
    @XmlElement(name = "RegisteredBy", required = true)
    protected String registeredBy;
    @XmlElement(name = "PrimaryMSISDN", required = true)
    protected String primaryMSISDN;
    @XmlElement(name = "LanguageCode", required = true)
    protected String languageCode;
    @XmlElement(name = "TrustLevel", required = true)
    protected String trustLevel;
    @XmlElement(name = "TrustLevelName", required = true)
    protected String trustLevelName;
    @XmlElement(name = "RuleProfileID", required = true)
    protected String ruleProfileID;
    @XmlElement(name = "RuleProfileName", required = true)
    protected String ruleProfileName;
    @XmlElement(name = "ChargeProfileID", required = true)
    protected String chargeProfileID;
    @XmlElement(name = "ChargeProfileName", required = true)
    protected String chargeProfileName;

    /**
     * Gets the value of the customerType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomerType() {
        return customerType;
    }

    /**
     * Sets the value of the customerType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomerType(String value) {
        this.customerType = value;
    }

    /**
     * Gets the value of the identityStatus property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIdentityStatus() {
        return identityStatus;
    }

    /**
     * Sets the value of the identityStatus property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIdentityStatus(String value) {
        this.identityStatus = value;
    }

    /**
     * Gets the value of the registrationDate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRegistrationDate() {
        return registrationDate;
    }

    /**
     * Sets the value of the registrationDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRegistrationDate(String value) {
        this.registrationDate = value;
    }

    /**
     * Gets the value of the registeredBy property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRegisteredBy() {
        return registeredBy;
    }

    /**
     * Sets the value of the registeredBy property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRegisteredBy(String value) {
        this.registeredBy = value;
    }

    /**
     * Gets the value of the primaryMSISDN property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPrimaryMSISDN() {
        return primaryMSISDN;
    }

    /**
     * Sets the value of the primaryMSISDN property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPrimaryMSISDN(String value) {
        this.primaryMSISDN = value;
    }

    /**
     * Gets the value of the languageCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getLanguageCode() {
        return languageCode;
    }

    /**
     * Sets the value of the languageCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setLanguageCode(String value) {
        this.languageCode = value;
    }

    /**
     * Gets the value of the trustLevel property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTrustLevel() {
        return trustLevel;
    }

    /**
     * Sets the value of the trustLevel property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTrustLevel(String value) {
        this.trustLevel = value;
    }

    /**
     * Gets the value of the trustLevelName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTrustLevelName() {
        return trustLevelName;
    }

    /**
     * Sets the value of the trustLevelName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTrustLevelName(String value) {
        this.trustLevelName = value;
    }

    /**
     * Gets the value of the ruleProfileID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRuleProfileID() {
        return ruleProfileID;
    }

    /**
     * Sets the value of the ruleProfileID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRuleProfileID(String value) {
        this.ruleProfileID = value;
    }

    /**
     * Gets the value of the ruleProfileName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRuleProfileName() {
        return ruleProfileName;
    }

    /**
     * Sets the value of the ruleProfileName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRuleProfileName(String value) {
        this.ruleProfileName = value;
    }

    /**
     * Gets the value of the chargeProfileID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getChargeProfileID() {
        return chargeProfileID;
    }

    /**
     * Sets the value of the chargeProfileID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setChargeProfileID(String value) {
        this.chargeProfileID = value;
    }

    /**
     * Gets the value of the chargeProfileName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getChargeProfileName() {
        return chargeProfileName;
    }

    /**
     * Sets the value of the chargeProfileName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setChargeProfileName(String value) {
        this.chargeProfileName = value;
    }

}
