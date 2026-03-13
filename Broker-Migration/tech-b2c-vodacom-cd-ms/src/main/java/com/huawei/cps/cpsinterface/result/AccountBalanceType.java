
package com.huawei.cps.cpsinterface.result;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 账户余额信息
 * 
 * <p>Java class for AccountBalanceType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="AccountBalanceType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="AccountHolderID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="AccountHolderPublicName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="AccountTypeName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="AccountTypeAlias" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="AccountRuleProfileID" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="AccountRuleProfileName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="AccountNo" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="AccountName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="DefaultFlag" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="AccountStatus" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="Currency" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="AvailableBalance" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="ReservedBalance" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="UnclearedBalance" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="CurrentBalance" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "AccountBalanceType", propOrder = {
    "accountHolderID",
    "accountHolderPublicName",
    "accountTypeName",
    "accountTypeAlias",
    "accountRuleProfileID",
    "accountRuleProfileName",
    "accountNo",
    "accountName",
    "defaultFlag",
    "accountStatus",
    "currency",
    "availableBalance",
    "reservedBalance",
    "unclearedBalance",
    "currentBalance"
})
public class AccountBalanceType {

    @XmlElement(name = "AccountHolderID", required = true)
    protected String accountHolderID;
    @XmlElement(name = "AccountHolderPublicName")
    protected String accountHolderPublicName;
    @XmlElement(name = "AccountTypeName")
    protected String accountTypeName;
    @XmlElement(name = "AccountTypeAlias", required = true)
    protected String accountTypeAlias;
    @XmlElement(name = "AccountRuleProfileID")
    protected String accountRuleProfileID;
    @XmlElement(name = "AccountRuleProfileName")
    protected String accountRuleProfileName;
    @XmlElement(name = "AccountNo")
    protected String accountNo;
    @XmlElement(name = "AccountName")
    protected String accountName;
    @XmlElement(name = "DefaultFlag")
    protected String defaultFlag;
    @XmlElement(name = "AccountStatus")
    protected String accountStatus;
    @XmlElement(name = "Currency", required = true)
    protected String currency;
    @XmlElement(name = "AvailableBalance", required = true)
    protected String availableBalance;
    @XmlElement(name = "ReservedBalance")
    protected String reservedBalance;
    @XmlElement(name = "UnclearedBalance", required = true)
    protected String unclearedBalance;
    @XmlElement(name = "CurrentBalance", required = true)
    protected String currentBalance;

    /**
     * Gets the value of the accountHolderID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAccountHolderID() {
        return accountHolderID;
    }

    /**
     * Sets the value of the accountHolderID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAccountHolderID(String value) {
        this.accountHolderID = value;
    }

    /**
     * Gets the value of the accountHolderPublicName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAccountHolderPublicName() {
        return accountHolderPublicName;
    }

    /**
     * Sets the value of the accountHolderPublicName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAccountHolderPublicName(String value) {
        this.accountHolderPublicName = value;
    }

    /**
     * Gets the value of the accountTypeName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAccountTypeName() {
        return accountTypeName;
    }

    /**
     * Sets the value of the accountTypeName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAccountTypeName(String value) {
        this.accountTypeName = value;
    }

    /**
     * Gets the value of the accountTypeAlias property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAccountTypeAlias() {
        return accountTypeAlias;
    }

    /**
     * Sets the value of the accountTypeAlias property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAccountTypeAlias(String value) {
        this.accountTypeAlias = value;
    }

    /**
     * Gets the value of the accountRuleProfileID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAccountRuleProfileID() {
        return accountRuleProfileID;
    }

    /**
     * Sets the value of the accountRuleProfileID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAccountRuleProfileID(String value) {
        this.accountRuleProfileID = value;
    }

    /**
     * Gets the value of the accountRuleProfileName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAccountRuleProfileName() {
        return accountRuleProfileName;
    }

    /**
     * Sets the value of the accountRuleProfileName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAccountRuleProfileName(String value) {
        this.accountRuleProfileName = value;
    }

    /**
     * Gets the value of the accountNo property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAccountNo() {
        return accountNo;
    }

    /**
     * Sets the value of the accountNo property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAccountNo(String value) {
        this.accountNo = value;
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

    /**
     * Gets the value of the defaultFlag property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDefaultFlag() {
        return defaultFlag;
    }

    /**
     * Sets the value of the defaultFlag property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDefaultFlag(String value) {
        this.defaultFlag = value;
    }

    /**
     * Gets the value of the accountStatus property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAccountStatus() {
        return accountStatus;
    }

    /**
     * Sets the value of the accountStatus property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAccountStatus(String value) {
        this.accountStatus = value;
    }

    /**
     * Gets the value of the currency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCurrency() {
        return currency;
    }

    /**
     * Sets the value of the currency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCurrency(String value) {
        this.currency = value;
    }

    /**
     * Gets the value of the availableBalance property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAvailableBalance() {
        return availableBalance;
    }

    /**
     * Sets the value of the availableBalance property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAvailableBalance(String value) {
        this.availableBalance = value;
    }

    /**
     * Gets the value of the reservedBalance property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReservedBalance() {
        return reservedBalance;
    }

    /**
     * Sets the value of the reservedBalance property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReservedBalance(String value) {
        this.reservedBalance = value;
    }

    /**
     * Gets the value of the unclearedBalance property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUnclearedBalance() {
        return unclearedBalance;
    }

    /**
     * Sets the value of the unclearedBalance property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUnclearedBalance(String value) {
        this.unclearedBalance = value;
    }

    /**
     * Gets the value of the currentBalance property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCurrentBalance() {
        return currentBalance;
    }

    /**
     * Sets the value of the currentBalance property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCurrentBalance(String value) {
        this.currentBalance = value;
    }

}
