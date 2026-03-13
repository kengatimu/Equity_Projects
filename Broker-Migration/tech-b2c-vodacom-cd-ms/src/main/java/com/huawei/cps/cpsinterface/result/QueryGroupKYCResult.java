
package com.huawei.cps.cpsinterface.result;

import com.huawei.cps.cpsinterface.common.ContactDetailsDataType;
import com.huawei.cps.cpsinterface.common.SimpleKYCDataType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询Group的KYC的结果消息
 * 
 * <p>Java class for QueryGroupKYCResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryGroupKYCResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="SimpleKYCData" type="{http://cps.huawei.com/cpsinterface/common}SimpleKYCDataType" minOccurs="0"/&gt;
 *         &lt;element name="ContactDetailsData" type="{http://cps.huawei.com/cpsinterface/common}ContactDetailsDataType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "QueryGroupKYCResult", propOrder = {
    "boCompletedTime",
    "simpleKYCData",
    "contactDetailsData"
})
public class QueryGroupKYCResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "SimpleKYCData")
    protected SimpleKYCDataType simpleKYCData;
    @XmlElement(name = "ContactDetailsData")
    protected ContactDetailsDataType contactDetailsData;

    /**
     * Gets the value of the boCompletedTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBOCompletedTime() {
        return boCompletedTime;
    }

    /**
     * Sets the value of the boCompletedTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBOCompletedTime(String value) {
        this.boCompletedTime = value;
    }

    /**
     * Gets the value of the simpleKYCData property.
     * 
     * @return
     *     possible object is
     *     {@link SimpleKYCDataType }
     *     
     */
    public SimpleKYCDataType getSimpleKYCData() {
        return simpleKYCData;
    }

    /**
     * Sets the value of the simpleKYCData property.
     * 
     * @param value
     *     allowed object is
     *     {@link SimpleKYCDataType }
     *     
     */
    public void setSimpleKYCData(SimpleKYCDataType value) {
        this.simpleKYCData = value;
    }

    /**
     * Gets the value of the contactDetailsData property.
     * 
     * @return
     *     possible object is
     *     {@link ContactDetailsDataType }
     *     
     */
    public ContactDetailsDataType getContactDetailsData() {
        return contactDetailsData;
    }

    /**
     * Sets the value of the contactDetailsData property.
     * 
     * @param value
     *     allowed object is
     *     {@link ContactDetailsDataType }
     *     
     */
    public void setContactDetailsData(ContactDetailsDataType value) {
        this.contactDetailsData = value;
    }

}
