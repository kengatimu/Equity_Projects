
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 创建Till
 * 
 * <p>Java class for CreateTillRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CreateTillRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType"/&gt;
 *         &lt;element name="TillNumber" type="{http://cps.huawei.com/cpsinterface/common}TillNumberType"/&gt;
 *         &lt;element name="LanguageCode" type="{http://cps.huawei.com/cpsinterface/common}LanguageType" minOccurs="0"/&gt;
 *         &lt;element name="SIMDevice" type="{http://cps.huawei.com/cpsinterface/request}SIMDeviceUpdateType"/&gt;
 *         &lt;element name="DefaultOperatorID" type="{http://cps.huawei.com/cpsinterface/common}IDType" minOccurs="0"/&gt;
 *         &lt;element name="UpdateProductsData" type="{http://cps.huawei.com/cpsinterface/request}ProductUpdateDataType"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CreateTillRequest", propOrder = {
    "shortCode",
    "tillNumber",
    "languageCode",
    "simDevice",
    "defaultOperatorID",
    "updateProductsData"
})
public class CreateTillRequest {

    @XmlElement(name = "ShortCode", required = true)
    protected String shortCode;
    @XmlElement(name = "TillNumber", required = true)
    protected String tillNumber;
    @XmlElement(name = "LanguageCode")
    protected String languageCode;
    @XmlElement(name = "SIMDevice", required = true)
    protected SIMDeviceUpdateType simDevice;
    @XmlElement(name = "DefaultOperatorID")
    protected String defaultOperatorID;
    @XmlElement(name = "UpdateProductsData", required = true)
    protected ProductUpdateDataType updateProductsData;

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
     * Gets the value of the tillNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTillNumber() {
        return tillNumber;
    }

    /**
     * Sets the value of the tillNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTillNumber(String value) {
        this.tillNumber = value;
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
     * Gets the value of the simDevice property.
     * 
     * @return
     *     possible object is
     *     {@link SIMDeviceUpdateType }
     *     
     */
    public SIMDeviceUpdateType getSIMDevice() {
        return simDevice;
    }

    /**
     * Sets the value of the simDevice property.
     * 
     * @param value
     *     allowed object is
     *     {@link SIMDeviceUpdateType }
     *     
     */
    public void setSIMDevice(SIMDeviceUpdateType value) {
        this.simDevice = value;
    }

    /**
     * Gets the value of the defaultOperatorID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDefaultOperatorID() {
        return defaultOperatorID;
    }

    /**
     * Sets the value of the defaultOperatorID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDefaultOperatorID(String value) {
        this.defaultOperatorID = value;
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

}
