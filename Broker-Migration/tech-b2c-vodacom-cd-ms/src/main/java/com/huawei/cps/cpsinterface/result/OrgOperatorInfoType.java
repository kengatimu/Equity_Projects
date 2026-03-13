
package com.huawei.cps.cpsinterface.result;

import com.huawei.cps.cpsinterface.common.AuthenticationDataType;
import com.huawei.cps.cpsinterface.common.RoleDataType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * OrgOperator基本信息
 * 
 * <p>Java class for OrgOperatorInfoType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="OrgOperatorInfoType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="OrgShortCode" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="AuthenticationData" type="{http://cps.huawei.com/cpsinterface/common}AuthenticationDataType"/&gt;
 *         &lt;element name="IdentityStatus" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="CreationDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
 *         &lt;element name="RoleData" type="{http://cps.huawei.com/cpsinterface/common}RoleDataType"/&gt;
 *         &lt;element name="LanguageCode" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="RuleProfileID" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="RuleProfileName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "OrgOperatorInfoType", propOrder = {
    "orgShortCode",
    "authenticationData",
    "identityStatus",
    "creationDate",
    "roleData",
    "languageCode",
    "ruleProfileID",
    "ruleProfileName"
})
public class OrgOperatorInfoType {

    @XmlElement(name = "OrgShortCode", required = true)
    protected String orgShortCode;
    @XmlElement(name = "AuthenticationData", required = true)
    protected AuthenticationDataType authenticationData;
    @XmlElement(name = "IdentityStatus", required = true)
    protected String identityStatus;
    @XmlElement(name = "CreationDate", required = true)
    protected String creationDate;
    @XmlElement(name = "RoleData", required = true)
    protected RoleDataType roleData;
    @XmlElement(name = "LanguageCode")
    protected String languageCode;
    @XmlElement(name = "RuleProfileID")
    protected String ruleProfileID;
    @XmlElement(name = "RuleProfileName")
    protected String ruleProfileName;

    /**
     * Gets the value of the orgShortCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOrgShortCode() {
        return orgShortCode;
    }

    /**
     * Sets the value of the orgShortCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOrgShortCode(String value) {
        this.orgShortCode = value;
    }

    /**
     * Gets the value of the authenticationData property.
     * 
     * @return
     *     possible object is
     *     {@link AuthenticationDataType }
     *     
     */
    public AuthenticationDataType getAuthenticationData() {
        return authenticationData;
    }

    /**
     * Sets the value of the authenticationData property.
     * 
     * @param value
     *     allowed object is
     *     {@link AuthenticationDataType }
     *     
     */
    public void setAuthenticationData(AuthenticationDataType value) {
        this.authenticationData = value;
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
     * Gets the value of the roleData property.
     * 
     * @return
     *     possible object is
     *     {@link RoleDataType }
     *     
     */
    public RoleDataType getRoleData() {
        return roleData;
    }

    /**
     * Sets the value of the roleData property.
     * 
     * @param value
     *     allowed object is
     *     {@link RoleDataType }
     *     
     */
    public void setRoleData(RoleDataType value) {
        this.roleData = value;
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

}
