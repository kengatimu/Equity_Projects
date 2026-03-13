
package com.huawei.cps.cpsinterface.request;

import com.huawei.cps.cpsinterface.common.OrganisationBeneficiary;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 新增Organization Beneficiary
 * 
 * <p>Java class for AddOrgBeneficiaryRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="AddOrgBeneficiaryRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="OrganisationBeneficiary" type="{http://cps.huawei.com/cpsinterface/common}OrganisationBeneficiary"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "AddOrgBeneficiaryRequest", propOrder = {
    "organisationBeneficiary"
})
public class AddOrgBeneficiaryRequest {

    @XmlElement(name = "OrganisationBeneficiary", required = true)
    protected OrganisationBeneficiary organisationBeneficiary;

    /**
     * Gets the value of the organisationBeneficiary property.
     * 
     * @return
     *     possible object is
     *     {@link OrganisationBeneficiary }
     *     
     */
    public OrganisationBeneficiary getOrganisationBeneficiary() {
        return organisationBeneficiary;
    }

    /**
     * Sets the value of the organisationBeneficiary property.
     * 
     * @param value
     *     allowed object is
     *     {@link OrganisationBeneficiary }
     *     
     */
    public void setOrganisationBeneficiary(OrganisationBeneficiary value) {
        this.organisationBeneficiary = value;
    }

}
