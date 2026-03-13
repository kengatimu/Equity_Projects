
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 删除Group Beneficiary
 * 
 * <p>Java class for DeleteGroupBeneficiaryRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="DeleteGroupBeneficiaryRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BeneficiaryGroupCode" type="{http://cps.huawei.com/cpsinterface/common}GroupCodeType"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "DeleteGroupBeneficiaryRequest", propOrder = {
    "beneficiaryGroupCode"
})
public class DeleteGroupBeneficiaryRequest {

    @XmlElement(name = "BeneficiaryGroupCode", required = true)
    protected String beneficiaryGroupCode;

    /**
     * Gets the value of the beneficiaryGroupCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBeneficiaryGroupCode() {
        return beneficiaryGroupCode;
    }

    /**
     * Sets the value of the beneficiaryGroupCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBeneficiaryGroupCode(String value) {
        this.beneficiaryGroupCode = value;
    }

}
