
package com.moneygram.agentconnect1512;

import java.math.BigDecimal;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for RedirectInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="RedirectInfo"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="originalSendAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="originalSendCurrency" type="{http://www.moneygram.com/AgentConnect1512}currencyCode" minOccurs="0"/&gt;
 *         &lt;element name="originalSendFee" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="originalExchangeRate" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="originalReceiveAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="originalReceiveCurrency" type="{http://www.moneygram.com/AgentConnect1512}currencyCode" minOccurs="0"/&gt;
 *         &lt;element name="originalReceiveCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="newSendFee" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="newExchangeRate" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="newReceiveAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="newReceiveCurrency" type="{http://www.moneygram.com/AgentConnect1512}currencyCode" minOccurs="0"/&gt;
 *         &lt;element name="feeDifference" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="redirectType" type="{http://www.moneygram.com/AgentConnect1512}RedirectInfoRedirectType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "RedirectInfo", propOrder = {
    "originalSendAmount",
    "originalSendCurrency",
    "originalSendFee",
    "originalExchangeRate",
    "originalReceiveAmount",
    "originalReceiveCurrency",
    "originalReceiveCountry",
    "newSendFee",
    "newExchangeRate",
    "newReceiveAmount",
    "newReceiveCurrency",
    "feeDifference",
    "redirectType"
})
public class RedirectInfo {

    protected BigDecimal originalSendAmount;
    protected String originalSendCurrency;
    protected BigDecimal originalSendFee;
    protected BigDecimal originalExchangeRate;
    protected BigDecimal originalReceiveAmount;
    protected String originalReceiveCurrency;
    protected String originalReceiveCountry;
    protected BigDecimal newSendFee;
    protected BigDecimal newExchangeRate;
    protected BigDecimal newReceiveAmount;
    protected String newReceiveCurrency;
    protected BigDecimal feeDifference;
    @XmlSchemaType(name = "string")
    protected RedirectInfoRedirectType redirectType;

    /**
     * Gets the value of the originalSendAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getOriginalSendAmount() {
        return originalSendAmount;
    }

    /**
     * Sets the value of the originalSendAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setOriginalSendAmount(BigDecimal value) {
        this.originalSendAmount = value;
    }

    /**
     * Gets the value of the originalSendCurrency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOriginalSendCurrency() {
        return originalSendCurrency;
    }

    /**
     * Sets the value of the originalSendCurrency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOriginalSendCurrency(String value) {
        this.originalSendCurrency = value;
    }

    /**
     * Gets the value of the originalSendFee property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getOriginalSendFee() {
        return originalSendFee;
    }

    /**
     * Sets the value of the originalSendFee property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setOriginalSendFee(BigDecimal value) {
        this.originalSendFee = value;
    }

    /**
     * Gets the value of the originalExchangeRate property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getOriginalExchangeRate() {
        return originalExchangeRate;
    }

    /**
     * Sets the value of the originalExchangeRate property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setOriginalExchangeRate(BigDecimal value) {
        this.originalExchangeRate = value;
    }

    /**
     * Gets the value of the originalReceiveAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getOriginalReceiveAmount() {
        return originalReceiveAmount;
    }

    /**
     * Sets the value of the originalReceiveAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setOriginalReceiveAmount(BigDecimal value) {
        this.originalReceiveAmount = value;
    }

    /**
     * Gets the value of the originalReceiveCurrency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOriginalReceiveCurrency() {
        return originalReceiveCurrency;
    }

    /**
     * Sets the value of the originalReceiveCurrency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOriginalReceiveCurrency(String value) {
        this.originalReceiveCurrency = value;
    }

    /**
     * Gets the value of the originalReceiveCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOriginalReceiveCountry() {
        return originalReceiveCountry;
    }

    /**
     * Sets the value of the originalReceiveCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOriginalReceiveCountry(String value) {
        this.originalReceiveCountry = value;
    }

    /**
     * Gets the value of the newSendFee property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getNewSendFee() {
        return newSendFee;
    }

    /**
     * Sets the value of the newSendFee property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setNewSendFee(BigDecimal value) {
        this.newSendFee = value;
    }

    /**
     * Gets the value of the newExchangeRate property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getNewExchangeRate() {
        return newExchangeRate;
    }

    /**
     * Sets the value of the newExchangeRate property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setNewExchangeRate(BigDecimal value) {
        this.newExchangeRate = value;
    }

    /**
     * Gets the value of the newReceiveAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getNewReceiveAmount() {
        return newReceiveAmount;
    }

    /**
     * Sets the value of the newReceiveAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setNewReceiveAmount(BigDecimal value) {
        this.newReceiveAmount = value;
    }

    /**
     * Gets the value of the newReceiveCurrency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNewReceiveCurrency() {
        return newReceiveCurrency;
    }

    /**
     * Sets the value of the newReceiveCurrency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNewReceiveCurrency(String value) {
        this.newReceiveCurrency = value;
    }

    /**
     * Gets the value of the feeDifference property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getFeeDifference() {
        return feeDifference;
    }

    /**
     * Sets the value of the feeDifference property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setFeeDifference(BigDecimal value) {
        this.feeDifference = value;
    }

    /**
     * Gets the value of the redirectType property.
     * 
     * @return
     *     possible object is
     *     {@link RedirectInfoRedirectType }
     *     
     */
    public RedirectInfoRedirectType getRedirectType() {
        return redirectType;
    }

    /**
     * Sets the value of the redirectType property.
     * 
     * @param value
     *     allowed object is
     *     {@link RedirectInfoRedirectType }
     *     
     */
    public void setRedirectType(RedirectInfoRedirectType value) {
        this.redirectType = value;
    }

}
