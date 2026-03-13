
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 发送试算结果的确认操作的请求，可以是continue,reject,time out等
 * 
 * <p>Java class for PreValidationConfirmationRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="PreValidationConfirmationRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="ConfirmationAction" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "PreValidationConfirmationRequest", propOrder = {
    "confirmationAction"
})
public class PreValidationConfirmationRequest {

    @XmlElement(name = "ConfirmationAction", required = true)
    protected String confirmationAction;

    /**
     * Gets the value of the confirmationAction property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConfirmationAction() {
        return confirmationAction;
    }

    /**
     * Sets the value of the confirmationAction property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConfirmationAction(String value) {
        this.confirmationAction = value;
    }

}
