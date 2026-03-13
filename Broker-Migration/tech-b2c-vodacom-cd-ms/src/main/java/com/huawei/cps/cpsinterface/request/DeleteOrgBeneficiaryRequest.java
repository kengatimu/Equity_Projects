
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 删除Organization Beneficiary
 * 
 * <p>Java class for DeleteOrgBeneficiaryRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="DeleteOrgBeneficiaryRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BillPaymentOrganisationShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "DeleteOrgBeneficiaryRequest", propOrder = {
    "billPaymentOrganisationShortCode"
})
public class DeleteOrgBeneficiaryRequest {

    @XmlElement(name = "BillPaymentOrganisationShortCode", required = true)
    protected String billPaymentOrganisationShortCode;

    /**
     * Gets the value of the billPaymentOrganisationShortCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillPaymentOrganisationShortCode() {
        return billPaymentOrganisationShortCode;
    }

    /**
     * Sets the value of the billPaymentOrganisationShortCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillPaymentOrganisationShortCode(String value) {
        this.billPaymentOrganisationShortCode = value;
    }

}
