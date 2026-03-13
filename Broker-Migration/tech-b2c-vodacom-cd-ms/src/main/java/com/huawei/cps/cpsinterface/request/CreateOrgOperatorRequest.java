
package com.huawei.cps.cpsinterface.request;

import com.huawei.cps.cpsinterface.common.AuthenticationDataType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 创建组织操作员
 * 
 * <p>Java class for CreateOrgOperatorRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CreateOrgOperatorRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
 *         &lt;element name="LanguageCode" type="{http://cps.huawei.com/cpsinterface/common}LanguageType" minOccurs="0"/&gt;
 *         &lt;element name="RuleProfileID" type="{http://cps.huawei.com/cpsinterface/common}IDType" minOccurs="0"/&gt;
 *         &lt;element name="RoleUpdateData" type="{http://cps.huawei.com/cpsinterface/request}RoleUpdateDataType"/&gt;
 *         &lt;element name="AuthenticationTypeData" type="{http://cps.huawei.com/cpsinterface/common}AuthenticationDataType"/&gt;
 *         &lt;element name="SimpleKYCUpdateData" type="{http://cps.huawei.com/cpsinterface/request}SimpleKYCUpdateDataType"/&gt;
 *         &lt;element name="UpdateIDDetails" type="{http://cps.huawei.com/cpsinterface/request}IDDetailsUpdateDataType" minOccurs="0"/&gt;
 *         &lt;element name="UpdateCerfificateDetails" type="{http://cps.huawei.com/cpsinterface/request}CertificateDetailsUpdateDataType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CreateOrgOperatorRequest", propOrder = {
    "shortCode",
    "languageCode",
    "ruleProfileID",
    "roleUpdateData",
    "authenticationTypeData",
    "simpleKYCUpdateData",
    "updateIDDetails",
    "updateCerfificateDetails"
})
public class CreateOrgOperatorRequest {

    @XmlElement(name = "ShortCode")
    protected String shortCode;
    @XmlElement(name = "LanguageCode")
    protected String languageCode;
    @XmlElement(name = "RuleProfileID")
    protected String ruleProfileID;
    @XmlElement(name = "RoleUpdateData", required = true)
    protected RoleUpdateDataType roleUpdateData;
    @XmlElement(name = "AuthenticationTypeData", required = true)
    protected AuthenticationDataType authenticationTypeData;
    @XmlElement(name = "SimpleKYCUpdateData", required = true)
    protected SimpleKYCUpdateDataType simpleKYCUpdateData;
    @XmlElement(name = "UpdateIDDetails")
    protected IDDetailsUpdateDataType updateIDDetails;
    @XmlElement(name = "UpdateCerfificateDetails")
    protected CertificateDetailsUpdateDataType updateCerfificateDetails;

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
     * Gets the value of the roleUpdateData property.
     * 
     * @return
     *     possible object is
     *     {@link RoleUpdateDataType }
     *     
     */
    public RoleUpdateDataType getRoleUpdateData() {
        return roleUpdateData;
    }

    /**
     * Sets the value of the roleUpdateData property.
     * 
     * @param value
     *     allowed object is
     *     {@link RoleUpdateDataType }
     *     
     */
    public void setRoleUpdateData(RoleUpdateDataType value) {
        this.roleUpdateData = value;
    }

    /**
     * Gets the value of the authenticationTypeData property.
     * 
     * @return
     *     possible object is
     *     {@link AuthenticationDataType }
     *     
     */
    public AuthenticationDataType getAuthenticationTypeData() {
        return authenticationTypeData;
    }

    /**
     * Sets the value of the authenticationTypeData property.
     * 
     * @param value
     *     allowed object is
     *     {@link AuthenticationDataType }
     *     
     */
    public void setAuthenticationTypeData(AuthenticationDataType value) {
        this.authenticationTypeData = value;
    }

    /**
     * Gets the value of the simpleKYCUpdateData property.
     * 
     * @return
     *     possible object is
     *     {@link SimpleKYCUpdateDataType }
     *     
     */
    public SimpleKYCUpdateDataType getSimpleKYCUpdateData() {
        return simpleKYCUpdateData;
    }

    /**
     * Sets the value of the simpleKYCUpdateData property.
     * 
     * @param value
     *     allowed object is
     *     {@link SimpleKYCUpdateDataType }
     *     
     */
    public void setSimpleKYCUpdateData(SimpleKYCUpdateDataType value) {
        this.simpleKYCUpdateData = value;
    }

    /**
     * Gets the value of the updateIDDetails property.
     * 
     * @return
     *     possible object is
     *     {@link IDDetailsUpdateDataType }
     *     
     */
    public IDDetailsUpdateDataType getUpdateIDDetails() {
        return updateIDDetails;
    }

    /**
     * Sets the value of the updateIDDetails property.
     * 
     * @param value
     *     allowed object is
     *     {@link IDDetailsUpdateDataType }
     *     
     */
    public void setUpdateIDDetails(IDDetailsUpdateDataType value) {
        this.updateIDDetails = value;
    }

    /**
     * Gets the value of the updateCerfificateDetails property.
     * 
     * @return
     *     possible object is
     *     {@link CertificateDetailsUpdateDataType }
     *     
     */
    public CertificateDetailsUpdateDataType getUpdateCerfificateDetails() {
        return updateCerfificateDetails;
    }

    /**
     * Sets the value of the updateCerfificateDetails property.
     * 
     * @param value
     *     allowed object is
     *     {@link CertificateDetailsUpdateDataType }
     *     
     */
    public void setUpdateCerfificateDetails(CertificateDetailsUpdateDataType value) {
        this.updateCerfificateDetails = value;
    }

}
