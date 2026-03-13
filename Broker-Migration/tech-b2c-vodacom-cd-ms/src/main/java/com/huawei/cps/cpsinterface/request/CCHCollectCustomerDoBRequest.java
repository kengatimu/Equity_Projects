
package com.huawei.cps.cpsinterface.request;

import com.huawei.cps.cpsinterface.common.IDDetailsDataType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * CCH:修改Customer的生日
 * 
 * <p>Java class for CCHCollectCustomerDoBRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CCHCollectCustomerDoBRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="NewDoB" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
 *         &lt;element name="IDDetailsData" type="{http://cps.huawei.com/cpsinterface/common}IDDetailsDataType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CCHCollectCustomerDoBRequest", propOrder = {
    "newDoB",
    "idDetailsData"
})
public class CCHCollectCustomerDoBRequest {

    @XmlElement(name = "NewDoB", required = true)
    protected String newDoB;
    @XmlElement(name = "IDDetailsData")
    protected IDDetailsDataType idDetailsData;

    /**
     * Gets the value of the newDoB property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNewDoB() {
        return newDoB;
    }

    /**
     * Sets the value of the newDoB property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNewDoB(String value) {
        this.newDoB = value;
    }

    /**
     * Gets the value of the idDetailsData property.
     * 
     * @return
     *     possible object is
     *     {@link IDDetailsDataType }
     *     
     */
    public IDDetailsDataType getIDDetailsData() {
        return idDetailsData;
    }

    /**
     * Sets the value of the idDetailsData property.
     * 
     * @param value
     *     allowed object is
     *     {@link IDDetailsDataType }
     *     
     */
    public void setIDDetailsData(IDDetailsDataType value) {
        this.idDetailsData = value;
    }

}
