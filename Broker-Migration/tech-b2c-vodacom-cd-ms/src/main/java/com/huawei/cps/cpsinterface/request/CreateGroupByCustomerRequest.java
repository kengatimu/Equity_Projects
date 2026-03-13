
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Customer创建Group
 * 
 * <p>Java class for CreateGroupByCustomerRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CreateGroupByCustomerRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="GroupCode" type="{http://cps.huawei.com/cpsinterface/common}GroupCodeType" minOccurs="0"/&gt;
 *         &lt;element name="GroupName"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="64"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="GroupDescription" minOccurs="0"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="512"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="RuleProfileID" type="{http://cps.huawei.com/cpsinterface/common}IDType" minOccurs="0"/&gt;
 *         &lt;element name="ChargeProfileID" type="{http://cps.huawei.com/cpsinterface/common}IDType" minOccurs="0"/&gt;
 *         &lt;element name="ProductUpdateData" type="{http://cps.huawei.com/cpsinterface/request}ProductUpdateDataType"/&gt;
 *         &lt;element name="SimpleKYCUpdateData" type="{http://cps.huawei.com/cpsinterface/request}SimpleKYCUpdateDataType" minOccurs="0"/&gt;
 *         &lt;element name="ContactDetailsUpdateData" type="{http://cps.huawei.com/cpsinterface/request}ContactDetailsUpdateDataType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CreateGroupByCustomerRequest", propOrder = {
    "groupCode",
    "groupName",
    "groupDescription",
    "ruleProfileID",
    "chargeProfileID",
    "productUpdateData",
    "simpleKYCUpdateData",
    "contactDetailsUpdateData"
})
public class CreateGroupByCustomerRequest {

    @XmlElement(name = "GroupCode")
    protected String groupCode;
    @XmlElement(name = "GroupName", required = true)
    protected String groupName;
    @XmlElement(name = "GroupDescription")
    protected String groupDescription;
    @XmlElement(name = "RuleProfileID")
    protected String ruleProfileID;
    @XmlElement(name = "ChargeProfileID")
    protected String chargeProfileID;
    @XmlElement(name = "ProductUpdateData", required = true)
    protected ProductUpdateDataType productUpdateData;
    @XmlElement(name = "SimpleKYCUpdateData")
    protected SimpleKYCUpdateDataType simpleKYCUpdateData;
    @XmlElement(name = "ContactDetailsUpdateData")
    protected ContactDetailsUpdateDataType contactDetailsUpdateData;

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
     * Gets the value of the groupDescription property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getGroupDescription() {
        return groupDescription;
    }

    /**
     * Sets the value of the groupDescription property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setGroupDescription(String value) {
        this.groupDescription = value;
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
     * Gets the value of the productUpdateData property.
     * 
     * @return
     *     possible object is
     *     {@link ProductUpdateDataType }
     *     
     */
    public ProductUpdateDataType getProductUpdateData() {
        return productUpdateData;
    }

    /**
     * Sets the value of the productUpdateData property.
     * 
     * @param value
     *     allowed object is
     *     {@link ProductUpdateDataType }
     *     
     */
    public void setProductUpdateData(ProductUpdateDataType value) {
        this.productUpdateData = value;
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
     * Gets the value of the contactDetailsUpdateData property.
     * 
     * @return
     *     possible object is
     *     {@link ContactDetailsUpdateDataType }
     *     
     */
    public ContactDetailsUpdateDataType getContactDetailsUpdateData() {
        return contactDetailsUpdateData;
    }

    /**
     * Sets the value of the contactDetailsUpdateData property.
     * 
     * @param value
     *     allowed object is
     *     {@link ContactDetailsUpdateDataType }
     *     
     */
    public void setContactDetailsUpdateData(ContactDetailsUpdateDataType value) {
        this.contactDetailsUpdateData = value;
    }

}
