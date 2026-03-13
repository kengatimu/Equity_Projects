
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 修改Organization的免税信息
 * 
 * <p>Java class for UpdateOrgTaxExemptionRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="UpdateOrgTaxExemptionRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="TaxExemptionData" type="{http://cps.huawei.com/cpsinterface/request}TaxExemptionDataType"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "UpdateOrgTaxExemptionRequest", propOrder = {
    "taxExemptionData"
})
public class UpdateOrgTaxExemptionRequest {

    @XmlElement(name = "TaxExemptionData", required = true)
    protected TaxExemptionDataType taxExemptionData;

    /**
     * Gets the value of the taxExemptionData property.
     * 
     * @return
     *     possible object is
     *     {@link TaxExemptionDataType }
     *     
     */
    public TaxExemptionDataType getTaxExemptionData() {
        return taxExemptionData;
    }

    /**
     * Sets the value of the taxExemptionData property.
     * 
     * @param value
     *     allowed object is
     *     {@link TaxExemptionDataType }
     *     
     */
    public void setTaxExemptionData(TaxExemptionDataType value) {
        this.taxExemptionData = value;
    }

}
