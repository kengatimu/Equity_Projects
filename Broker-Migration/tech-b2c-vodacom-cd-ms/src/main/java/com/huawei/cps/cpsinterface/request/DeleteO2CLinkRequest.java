
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 删除Organization的O2CLink
 * 
 * <p>Java class for DeleteO2CLinkRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="DeleteO2CLinkRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="O2CLinkDeleteData" type="{http://cps.huawei.com/cpsinterface/request}O2CLinkDeleteDataType"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "DeleteO2CLinkRequest", propOrder = {
    "o2CLinkDeleteData"
})
public class DeleteO2CLinkRequest {

    @XmlElement(name = "O2CLinkDeleteData", required = true)
    protected O2CLinkDeleteDataType o2CLinkDeleteData;

    /**
     * Gets the value of the o2CLinkDeleteData property.
     * 
     * @return
     *     possible object is
     *     {@link O2CLinkDeleteDataType }
     *     
     */
    public O2CLinkDeleteDataType getO2CLinkDeleteData() {
        return o2CLinkDeleteData;
    }

    /**
     * Sets the value of the o2CLinkDeleteData property.
     * 
     * @param value
     *     allowed object is
     *     {@link O2CLinkDeleteDataType }
     *     
     */
    public void setO2CLinkDeleteData(O2CLinkDeleteDataType value) {
        this.o2CLinkDeleteData = value;
    }

}
