
package com.huawei.cps.cpsinterface.request;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 创建Customer以及升级UnregisterCustomer/LiteCustomer
 * 
 * <p>Java class for RegisterCustomerRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="RegisterCustomerRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="CustomerType" minOccurs="0"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;length value="4"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="SIMDeviceData"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="SIMDeviceItem" type="{http://cps.huawei.com/cpsinterface/request}SIMDeviceUpdateType" maxOccurs="unbounded"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="RuleProfileID" minOccurs="0"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="64"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="RegisteredBy" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
 *         &lt;element name="LanguageCode" type="{http://cps.huawei.com/cpsinterface/common}LanguageType" minOccurs="0"/&gt;
 *         &lt;element name="ProductUpdateData" type="{http://cps.huawei.com/cpsinterface/request}ProductUpdateDataType" minOccurs="0"/&gt;
 *         &lt;element name="SimpleKYCUpdateData" type="{http://cps.huawei.com/cpsinterface/request}SimpleKYCUpdateDataType"/&gt;
 *         &lt;element name="IDDetailsUpdateData" type="{http://cps.huawei.com/cpsinterface/request}IDDetailsUpdateDataType" minOccurs="0"/&gt;
 *         &lt;element name="ContactDetailsUpdateData" type="{http://cps.huawei.com/cpsinterface/request}ContactDetailsUpdateDataType" minOccurs="0"/&gt;
 *         &lt;element name="CertificateDetailsUpdateData" type="{http://cps.huawei.com/cpsinterface/request}CertificateDetailsUpdateDataType" minOccurs="0"/&gt;
 *         &lt;element name="BankAccountDetailsUpdateData" type="{http://cps.huawei.com/cpsinterface/request}BankAccountDetailsUpdateDataType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "RegisterCustomerRequest", propOrder = {
    "customerType",
    "simDeviceData",
    "ruleProfileID",
    "registeredBy",
    "languageCode",
    "productUpdateData",
    "simpleKYCUpdateData",
    "idDetailsUpdateData",
    "contactDetailsUpdateData",
    "certificateDetailsUpdateData",
    "bankAccountDetailsUpdateData"
})
public class RegisterCustomerRequest {

    @XmlElement(name = "CustomerType")
    protected String customerType;
    @XmlElement(name = "SIMDeviceData", required = true)
    protected RegisterCustomerRequest.SIMDeviceData simDeviceData;
    @XmlElement(name = "RuleProfileID")
    protected String ruleProfileID;
    @XmlElement(name = "RegisteredBy")
    protected String registeredBy;
    @XmlElement(name = "LanguageCode")
    protected String languageCode;
    @XmlElement(name = "ProductUpdateData")
    protected ProductUpdateDataType productUpdateData;
    @XmlElement(name = "SimpleKYCUpdateData", required = true)
    protected SimpleKYCUpdateDataType simpleKYCUpdateData;
    @XmlElement(name = "IDDetailsUpdateData")
    protected IDDetailsUpdateDataType idDetailsUpdateData;
    @XmlElement(name = "ContactDetailsUpdateData")
    protected ContactDetailsUpdateDataType contactDetailsUpdateData;
    @XmlElement(name = "CertificateDetailsUpdateData")
    protected CertificateDetailsUpdateDataType certificateDetailsUpdateData;
    @XmlElement(name = "BankAccountDetailsUpdateData")
    protected BankAccountDetailsUpdateDataType bankAccountDetailsUpdateData;

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
     * Gets the value of the simDeviceData property.
     * 
     * @return
     *     possible object is
     *     {@link RegisterCustomerRequest.SIMDeviceData }
     *     
     */
    public RegisterCustomerRequest.SIMDeviceData getSIMDeviceData() {
        return simDeviceData;
    }

    /**
     * Sets the value of the simDeviceData property.
     * 
     * @param value
     *     allowed object is
     *     {@link RegisterCustomerRequest.SIMDeviceData }
     *     
     */
    public void setSIMDeviceData(RegisterCustomerRequest.SIMDeviceData value) {
        this.simDeviceData = value;
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
     * Gets the value of the idDetailsUpdateData property.
     * 
     * @return
     *     possible object is
     *     {@link IDDetailsUpdateDataType }
     *     
     */
    public IDDetailsUpdateDataType getIDDetailsUpdateData() {
        return idDetailsUpdateData;
    }

    /**
     * Sets the value of the idDetailsUpdateData property.
     * 
     * @param value
     *     allowed object is
     *     {@link IDDetailsUpdateDataType }
     *     
     */
    public void setIDDetailsUpdateData(IDDetailsUpdateDataType value) {
        this.idDetailsUpdateData = value;
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

    /**
     * Gets the value of the certificateDetailsUpdateData property.
     * 
     * @return
     *     possible object is
     *     {@link CertificateDetailsUpdateDataType }
     *     
     */
    public CertificateDetailsUpdateDataType getCertificateDetailsUpdateData() {
        return certificateDetailsUpdateData;
    }

    /**
     * Sets the value of the certificateDetailsUpdateData property.
     * 
     * @param value
     *     allowed object is
     *     {@link CertificateDetailsUpdateDataType }
     *     
     */
    public void setCertificateDetailsUpdateData(CertificateDetailsUpdateDataType value) {
        this.certificateDetailsUpdateData = value;
    }

    /**
     * Gets the value of the bankAccountDetailsUpdateData property.
     * 
     * @return
     *     possible object is
     *     {@link BankAccountDetailsUpdateDataType }
     *     
     */
    public BankAccountDetailsUpdateDataType getBankAccountDetailsUpdateData() {
        return bankAccountDetailsUpdateData;
    }

    /**
     * Sets the value of the bankAccountDetailsUpdateData property.
     * 
     * @param value
     *     allowed object is
     *     {@link BankAccountDetailsUpdateDataType }
     *     
     */
    public void setBankAccountDetailsUpdateData(BankAccountDetailsUpdateDataType value) {
        this.bankAccountDetailsUpdateData = value;
    }


    /**
     * <p>Java class for anonymous complex type.
     * 
     * <p>The following schema fragment specifies the expected content contained within this class.
     * 
     * <pre>
     * &lt;complexType&gt;
     *   &lt;complexContent&gt;
     *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *       &lt;sequence&gt;
     *         &lt;element name="SIMDeviceItem" type="{http://cps.huawei.com/cpsinterface/request}SIMDeviceUpdateType" maxOccurs="unbounded"/&gt;
     *       &lt;/sequence&gt;
     *     &lt;/restriction&gt;
     *   &lt;/complexContent&gt;
     * &lt;/complexType&gt;
     * </pre>
     * 
     * 
     */
    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "", propOrder = {
        "simDeviceItem"
    })
    public static class SIMDeviceData {

        @XmlElement(name = "SIMDeviceItem", required = true)
        protected List<SIMDeviceUpdateType> simDeviceItem;

        /**
         * Gets the value of the simDeviceItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the simDeviceItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getSIMDeviceItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link SIMDeviceUpdateType }
         * 
         * 
         */
        public List<SIMDeviceUpdateType> getSIMDeviceItem() {
            if (simDeviceItem == null) {
                simDeviceItem = new ArrayList<SIMDeviceUpdateType>();
            }
            return this.simDeviceItem;
        }

    }

}
