
package com.huawei.cps.cpsinterface.result;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Group基本信息
 * 
 * <p>Java class for GroupInfoType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="GroupInfoType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="GroupCode" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="GroupName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="ProductID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="ProductName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="IdentityStatus" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="CreationDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
 *         &lt;element name="CreatedBy" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
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
@XmlType(name = "GroupInfoType", propOrder = {
    "groupCode",
    "groupName",
    "productID",
    "productName",
    "identityStatus",
    "creationDate",
    "createdBy",
    "trustLevel",
    "trustLevelName",
    "ruleProfileID",
    "ruleProfileName",
    "chargeProfileID",
    "chargeProfileName"
})
public class GroupInfoType {

    @XmlElement(name = "GroupCode", required = true)
    protected String groupCode;
    @XmlElement(name = "GroupName", required = true)
    protected String groupName;
    @XmlElement(name = "ProductID", required = true)
    protected String productID;
    @XmlElement(name = "ProductName", required = true)
    protected String productName;
    @XmlElement(name = "IdentityStatus", required = true)
    protected String identityStatus;
    @XmlElement(name = "CreationDate", required = true)
    protected String creationDate;
    @XmlElement(name = "CreatedBy", required = true)
    protected String createdBy;
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
     * Gets the value of the groupCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getGroupCode() {
        return groupCode;
    }

    /**
     * Sets the value of the groupCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setGroupCode(String value) {
        this.groupCode = value;
    }

    /**
     * Gets the value of the groupName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getGroupName() {
        return groupName;
    }

    /**
     * Sets the value of the groupName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setGroupName(String value) {
        this.groupName = value;
    }

    /**
     * Gets the value of the productID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getProductID() {
        return productID;
    }

    /**
     * Sets the value of the productID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setProductID(String value) {
        this.productID = value;
    }

    /**
     * Gets the value of the productName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getProductName() {
        return productName;
    }

    /**
     * Sets the value of the productName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setProductName(String value) {
        this.productName = value;
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
     * Gets the value of the creationDate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCreationDate() {
        return creationDate;
    }

    /**
     * Sets the value of the creationDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCreationDate(String value) {
        this.creationDate = value;
    }

    /**
     * Gets the value of the createdBy property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCreatedBy() {
        return createdBy;
    }

    /**
     * Sets the value of the createdBy property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCreatedBy(String value) {
        this.createdBy = value;
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
