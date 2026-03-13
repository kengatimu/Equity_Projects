
package com.huawei.cps.cpsinterface.common;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Organization Beneficiary结构定义
 * 
 * <p>Java class for OrganisationBeneficiary complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="OrganisationBeneficiary"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="OrganisationName" type="{http://cps.huawei.com/cpsinterface/common}OrganizationNameType" minOccurs="0"/&gt;
 *         &lt;element name="BillPaymentOrganisationShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType"/&gt;
 *         &lt;element name="BillReference" minOccurs="0"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="128"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="BeneficiaryReference" minOccurs="0"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="128"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "OrganisationBeneficiary", propOrder = {
    "organisationName",
    "billPaymentOrganisationShortCode",
    "billReference",
    "beneficiaryReference"
})
public class OrganisationBeneficiary {

    @XmlElement(name = "OrganisationName")
    protected String organisationName;
    @XmlElement(name = "BillPaymentOrganisationShortCode", required = true)
    protected String billPaymentOrganisationShortCode;
    @XmlElement(name = "BillReference")
    protected String billReference;
    @XmlElement(name = "BeneficiaryReference")
    protected String beneficiaryReference;

    /**
     * Gets the value of the organisationName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOrganisationName() {
        return organisationName;
    }

    /**
     * Sets the value of the organisationName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOrganisationName(String value) {
        this.organisationName = value;
    }

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

    /**
     * Gets the value of the billReference property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillReference() {
        return billReference;
    }

    /**
     * Sets the value of the billReference property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillReference(String value) {
        this.billReference = value;
    }

    /**
     * Gets the value of the beneficiaryReference property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBeneficiaryReference() {
        return beneficiaryReference;
    }

    /**
     * Sets the value of the beneficiaryReference property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBeneficiaryReference(String value) {
        this.beneficiaryReference = value;
    }

}
