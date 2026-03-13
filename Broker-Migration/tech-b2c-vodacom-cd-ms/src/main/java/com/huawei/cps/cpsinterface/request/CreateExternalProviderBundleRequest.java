
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 创建外部MNO的Bundle的请求消息，场景是外部MNO在Splitting Mode为On的情况发起
 * 
 * <p>Java class for CreateExternalProviderBundleRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CreateExternalProviderBundleRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BundleID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="EffectiveDate" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="AssignType" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CreateExternalProviderBundleRequest", propOrder = {
    "bundleID",
    "effectiveDate",
    "assignType"
})
public class CreateExternalProviderBundleRequest {

    @XmlElement(name = "BundleID", required = true)
    protected String bundleID;
    @XmlElement(name = "EffectiveDate")
    protected String effectiveDate;
    @XmlElement(name = "AssignType")
    protected String assignType;

    /**
     * Gets the value of the bundleID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBundleID() {
        return bundleID;
    }

    /**
     * Sets the value of the bundleID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBundleID(String value) {
        this.bundleID = value;
    }

    /**
     * Gets the value of the effectiveDate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getEffectiveDate() {
        return effectiveDate;
    }

    /**
     * Sets the value of the effectiveDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setEffectiveDate(String value) {
        this.effectiveDate = value;
    }

    /**
     * Gets the value of the assignType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAssignType() {
        return assignType;
    }

    /**
     * Sets the value of the assignType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAssignType(String value) {
        this.assignType = value;
    }

}
