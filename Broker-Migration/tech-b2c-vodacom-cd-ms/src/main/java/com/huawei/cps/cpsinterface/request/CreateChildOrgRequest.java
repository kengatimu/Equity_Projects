
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 创建子组织
 * 
 * <p>Java class for CreateChildOrgRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CreateChildOrgRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType"/&gt;
 *         &lt;element name="ParentShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType"/&gt;
 *         &lt;element name="OrganizationName" type="{http://cps.huawei.com/cpsinterface/common}OrganizationNameType"/&gt;
 *         &lt;element name="ChargeProfileID" type="{http://cps.huawei.com/cpsinterface/common}IDType" minOccurs="0"/&gt;
 *         &lt;element name="RuleProfileID" type="{http://cps.huawei.com/cpsinterface/common}IDType" minOccurs="0"/&gt;
 *         &lt;element name="ChargeDistributionModel" type="{http://cps.huawei.com/cpsinterface/common}IDType" minOccurs="0"/&gt;
 *         &lt;element name="SimpleKYCUpdateData" type="{http://cps.huawei.com/cpsinterface/request}SimpleKYCUpdateDataType"/&gt;
 *         &lt;element name="UpdateOrganizationContactDetails" type="{http://cps.huawei.com/cpsinterface/request}ContactDetailsUpdateDataType" minOccurs="0"/&gt;
 *         &lt;element name="UpdateProductsData" type="{http://cps.huawei.com/cpsinterface/request}ProductUpdateDataType"/&gt;
 *         &lt;element name="TaxExemptionData" type="{http://cps.huawei.com/cpsinterface/request}TaxExemptionDataType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CreateChildOrgRequest", propOrder = {
    "shortCode",
    "parentShortCode",
    "organizationName",
    "chargeProfileID",
    "ruleProfileID",
    "chargeDistributionModel",
    "simpleKYCUpdateData",
    "updateOrganizationContactDetails",
    "updateProductsData",
    "taxExemptionData"
})
public class CreateChildOrgRequest {

    @XmlElement(name = "ShortCode", required = true)
    protected String shortCode;
    @XmlElement(name = "ParentShortCode", required = true)
    protected String parentShortCode;
    @XmlElement(name = "OrganizationName", required = true)
    protected String organizationName;
    @XmlElement(name = "ChargeProfileID")
    protected String chargeProfileID;
    @XmlElement(name = "RuleProfileID")
    protected String ruleProfileID;
    @XmlElement(name = "ChargeDistributionModel")
    protected String chargeDistributionModel;
    @XmlElement(name = "SimpleKYCUpdateData", required = true)
    protected SimpleKYCUpdateDataType simpleKYCUpdateData;
    @XmlElement(name = "UpdateOrganizationContactDetails")
    protected ContactDetailsUpdateDataType updateOrganizationContactDetails;
    @XmlElement(name = "UpdateProductsData", required = true)
    protected ProductUpdateDataType updateProductsData;
    @XmlElement(name = "TaxExemptionData")
    protected TaxExemptionDataType taxExemptionData;

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
     * Gets the value of the chargeDistributionModel property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getChargeDistributionModel() {
        return chargeDistributionModel;
    }

    /**
     * Sets the value of the chargeDistributionModel property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setChargeDistributionModel(String value) {
        this.chargeDistributionModel = value;
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
     * Gets the value of the updateOrganizationContactDetails property.
     * 
     * @return
     *     possible object is
     *     {@link ContactDetailsUpdateDataType }
     *     
     */
    public ContactDetailsUpdateDataType getUpdateOrganizationContactDetails() {
        return updateOrganizationContactDetails;
    }

    /**
     * Sets the value of the updateOrganizationContactDetails property.
     * 
     * @param value
     *     allowed object is
     *     {@link ContactDetailsUpdateDataType }
     *     
     */
    public void setUpdateOrganizationContactDetails(ContactDetailsUpdateDataType value) {
        this.updateOrganizationContactDetails = value;
    }

    /**
     * Gets the value of the updateProductsData property.
     * 
     * @return
     *     possible object is
     *     {@link ProductUpdateDataType }
     *     
     */
    public ProductUpdateDataType getUpdateProductsData() {
        return updateProductsData;
    }

    /**
     * Sets the value of the updateProductsData property.
     * 
     * @param value
     *     allowed object is
     *     {@link ProductUpdateDataType }
     *     
     */
    public void setUpdateProductsData(ProductUpdateDataType value) {
        this.updateProductsData = value;
    }

    /**
     * Gets the value of the taxExemptionData property.
     * 
     * @return
     *     possible object is
     *     {@link TaxExemptionDataType }
     *     
     */
    public TaxExemptionDataType getTaxExemptionData() {
        return taxExemptionData;
    }

    /**
     * Sets the value of the taxExemptionData property.
     * 
     * @param value
     *     allowed object is
     *     {@link TaxExemptionDataType }
     *     
     */
    public void setTaxExemptionData(TaxExemptionDataType value) {
        this.taxExemptionData = value;
    }

}
