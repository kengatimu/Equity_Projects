
package com.huawei.cps.cpsinterface.result;

import java.math.BigInteger;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Organization基本信息
 * 
 * <p>Java class for OrganizationInfoType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="OrganizationInfoType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="ShortCode" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="OrganizationName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="IdentityStatus" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="CreationDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
 *         &lt;element name="ParentShortCode" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="TrustLevel" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="TrustLevelName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="RuleProfileID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="RuleProfileName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="ChargeProfileID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="ChargeProfileName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="CentrallyOwnedAcctModel" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="AggregatorAcctModel" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="HierarchyLevel" type="{http://www.w3.org/2001/XMLSchema}integer"/&gt;
 *         &lt;element name="HierarchyModel" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="ChargeDistributionModelID" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="ChargeDistributionModelName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "OrganizationInfoType", propOrder = {
    "shortCode",
    "organizationName",
    "identityStatus",
    "creationDate",
    "parentShortCode",
    "trustLevel",
    "trustLevelName",
    "ruleProfileID",
    "ruleProfileName",
    "chargeProfileID",
    "chargeProfileName",
    "centrallyOwnedAcctModel",
    "aggregatorAcctModel",
    "hierarchyLevel",
    "hierarchyModel",
    "chargeDistributionModelID",
    "chargeDistributionModelName"
})
public class OrganizationInfoType {

    @XmlElement(name = "ShortCode", required = true)
    protected String shortCode;
    @XmlElement(name = "OrganizationName", required = true)
    protected String organizationName;
    @XmlElement(name = "IdentityStatus", required = true)
    protected String identityStatus;
    @XmlElement(name = "CreationDate", required = true)
    protected String creationDate;
    @XmlElement(name = "ParentShortCode")
    protected String parentShortCode;
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
    @XmlElement(name = "CentrallyOwnedAcctModel")
    protected String centrallyOwnedAcctModel;
    @XmlElement(name = "AggregatorAcctModel")
    protected String aggregatorAcctModel;
    @XmlElement(name = "HierarchyLevel", required = true)
    protected BigInteger hierarchyLevel;
    @XmlElement(name = "HierarchyModel")
    protected String hierarchyModel;
    @XmlElement(name = "ChargeDistributionModelID")
    protected String chargeDistributionModelID;
    @XmlElement(name = "ChargeDistributionModelName")
    protected String chargeDistributionModelName;

    /**
     * Gets the value of the shortCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getShortCode() {
        return shortCode;
    }

    /**
     * Sets the value of the shortCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setShortCode(String value) {
        this.shortCode = value;
    }

    /**
     * Gets the value of the organizationName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOrganizationName() {
        return organizationName;
    }

    /**
     * Sets the value of the organizationName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOrganizationName(String value) {
        this.organizationName = value;
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
     * Gets the value of the parentShortCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getParentShortCode() {
        return parentShortCode;
    }

    /**
     * Sets the value of the parentShortCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setParentShortCode(String value) {
        this.parentShortCode = value;
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

    /**
     * Gets the value of the centrallyOwnedAcctModel property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCentrallyOwnedAcctModel() {
        return centrallyOwnedAcctModel;
    }

    /**
     * Sets the value of the centrallyOwnedAcctModel property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCentrallyOwnedAcctModel(String value) {
        this.centrallyOwnedAcctModel = value;
    }

    /**
     * Gets the value of the aggregatorAcctModel property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAggregatorAcctModel() {
        return aggregatorAcctModel;
    }

    /**
     * Sets the value of the aggregatorAcctModel property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAggregatorAcctModel(String value) {
        this.aggregatorAcctModel = value;
    }

    /**
     * Gets the value of the hierarchyLevel property.
     * 
     * @return
     *     possible object is
     *     {@link BigInteger }
     *     
     */
    public BigInteger getHierarchyLevel() {
        return hierarchyLevel;
    }

    /**
     * Sets the value of the hierarchyLevel property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigInteger }
     *     
     */
    public void setHierarchyLevel(BigInteger value) {
        this.hierarchyLevel = value;
    }

    /**
     * Gets the value of the hierarchyModel property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getHierarchyModel() {
        return hierarchyModel;
    }

    /**
     * Sets the value of the hierarchyModel property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setHierarchyModel(String value) {
        this.hierarchyModel = value;
    }

    /**
     * Gets the value of the chargeDistributionModelID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getChargeDistributionModelID() {
        return chargeDistributionModelID;
    }

    /**
     * Sets the value of the chargeDistributionModelID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setChargeDistributionModelID(String value) {
        this.chargeDistributionModelID = value;
    }

    /**
     * Gets the value of the chargeDistributionModelName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getChargeDistributionModelName() {
        return chargeDistributionModelName;
    }

    /**
     * Sets the value of the chargeDistributionModelName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setChargeDistributionModelName(String value) {
        this.chargeDistributionModelName = value;
    }

}
