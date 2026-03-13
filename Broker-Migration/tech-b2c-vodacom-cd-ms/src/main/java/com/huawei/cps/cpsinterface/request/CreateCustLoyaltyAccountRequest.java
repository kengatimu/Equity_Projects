
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 为客户创建积分帐户
 * 
 * <p>Java class for CreateCustLoyaltyAccountRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CreateCustLoyaltyAccountRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="LoyaltyProviderIdentityType" type="{http://cps.huawei.com/cpsinterface/common}IdentityType"/&gt;
 *         &lt;element name="LoyaltyProviderShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
 *         &lt;element name="AccountType"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="128"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="AccountName" minOccurs="0"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="64"/&gt;
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
@XmlType(name = "CreateCustLoyaltyAccountRequest", propOrder = {
    "loyaltyProviderIdentityType",
    "loyaltyProviderShortCode",
    "accountType",
    "accountName"
})
public class CreateCustLoyaltyAccountRequest {

    @XmlElement(name = "LoyaltyProviderIdentityType", required = true)
    protected String loyaltyProviderIdentityType;
    @XmlElement(name = "LoyaltyProviderShortCode")
    protected String loyaltyProviderShortCode;
    @XmlElement(name = "AccountType", required = true)
    protected String accountType;
    @XmlElement(name = "AccountName")
    protected String accountName;

    /**
     * Gets the value of the loyaltyProviderIdentityType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getLoyaltyProviderIdentityType() {
        return loyaltyProviderIdentityType;
    }

    /**
     * Sets the value of the loyaltyProviderIdentityType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setLoyaltyProviderIdentityType(String value) {
        this.loyaltyProviderIdentityType = value;
    }

    /**
     * Gets the value of the loyaltyProviderShortCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getLoyaltyProviderShortCode() {
        return loyaltyProviderShortCode;
    }

    /**
     * Sets the value of the loyaltyProviderShortCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setLoyaltyProviderShortCode(String value) {
        this.loyaltyProviderShortCode = value;
    }

    /**
     * Gets the value of the accountType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAccountType() {
        return accountType;
    }

    /**
     * Sets the value of the accountType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAccountType(String value) {
        this.accountType = value;
    }

    /**
     * Gets the value of the accountName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAccountName() {
        return accountName;
    }

    /**
     * Sets the value of the accountName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAccountName(String value) {
        this.accountName = value;
    }

}
