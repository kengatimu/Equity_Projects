
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 删除Customer Beneficiary
 * 
 * <p>Java class for DeleteCustomerBeneficiaryRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="DeleteCustomerBeneficiaryRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BeneficiaryMSISDN" type="{http://cps.huawei.com/cpsinterface/common}MSISDNType"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "DeleteCustomerBeneficiaryRequest", propOrder = {
    "beneficiaryMSISDN"
})
public class DeleteCustomerBeneficiaryRequest {

    @XmlElement(name = "BeneficiaryMSISDN", required = true)
    protected String beneficiaryMSISDN;

    /**
     * Gets the value of the beneficiaryMSISDN property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBeneficiaryMSISDN() {
        return beneficiaryMSISDN;
    }

    /**
     * Sets the value of the beneficiaryMSISDN property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBeneficiaryMSISDN(String value) {
        this.beneficiaryMSISDN = value;
    }

}
