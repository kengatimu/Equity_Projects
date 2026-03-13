
package com.huawei.cps.cpsinterface.request;

import com.huawei.cps.cpsinterface.common.SimpleKYCDataType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * CCH:重置Organization Operator的PIN
 * 
 * <p>Java class for CCHSendOperatorStartKeyRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CCHSendOperatorStartKeyRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="FreePIN" minOccurs="0"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;length value="1"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="VerifyKYCData" type="{http://cps.huawei.com/cpsinterface/common}SimpleKYCDataType"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CCHSendOperatorStartKeyRequest", propOrder = {
    "freePIN",
    "verifyKYCData"
})
public class CCHSendOperatorStartKeyRequest {

    @XmlElement(name = "FreePIN")
    protected String freePIN;
    @XmlElement(name = "VerifyKYCData", required = true)
    protected SimpleKYCDataType verifyKYCData;

    /**
     * Gets the value of the freePIN property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFreePIN() {
        return freePIN;
    }

    /**
     * Sets the value of the freePIN property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFreePIN(String value) {
        this.freePIN = value;
    }

    /**
     * Gets the value of the verifyKYCData property.
     * 
     * @return
     *     possible object is
     *     {@link SimpleKYCDataType }
     *     
     */
    public SimpleKYCDataType getVerifyKYCData() {
        return verifyKYCData;
    }

    /**
     * Sets the value of the verifyKYCData property.
     * 
     * @param value
     *     allowed object is
     *     {@link SimpleKYCDataType }
     *     
     */
    public void setVerifyKYCData(SimpleKYCDataType value) {
        this.verifyKYCData = value;
    }

}
