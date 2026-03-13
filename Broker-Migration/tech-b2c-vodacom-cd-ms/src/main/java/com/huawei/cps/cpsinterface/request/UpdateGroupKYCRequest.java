
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 修改Group的KYC
 * 
 * <p>Java class for UpdateGroupKYCRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="UpdateGroupKYCRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
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
@XmlType(name = "UpdateGroupKYCRequest", propOrder = {
    "simpleKYCUpdateData",
    "contactDetailsUpdateData"
})
public class UpdateGroupKYCRequest {

    @XmlElement(name = "SimpleKYCUpdateData")
    protected SimpleKYCUpdateDataType simpleKYCUpdateData;
    @XmlElement(name = "ContactDetailsUpdateData")
    protected ContactDetailsUpdateDataType contactDetailsUpdateData;

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
