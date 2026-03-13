
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for CountryCurrencyInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CountryCurrencyInfo"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="countryCode" type="{http://www.moneygram.com/AgentConnect1512}countryType"/&gt;
 *         &lt;element name="baseCurrency" type="{http://www.moneygram.com/AgentConnect1512}currencyCode"/&gt;
 *         &lt;element name="localCurrency" type="{http://www.moneygram.com/AgentConnect1512}currencyCode" minOccurs="0"/&gt;
 *         &lt;element name="receiveCurrency" type="{http://www.moneygram.com/AgentConnect1512}currencyCode"/&gt;
 *         &lt;element name="indicativeRateAvailable" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="deliveryOption" type="{http://www.moneygram.com/AgentConnect1512}deliveryOption"/&gt;
 *         &lt;element name="receiveAgentID" type="{http://www.moneygram.com/AgentConnect1512}agentID" minOccurs="0"/&gt;
 *         &lt;element name="receiveAgentAbbreviation" type="{http://www.moneygram.com/AgentConnect1512}stringMax10" minOccurs="0"/&gt;
 *         &lt;element name="mgManaged" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="agentManaged" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="validationExprs" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="checkDigitAlg" type="{http://www.moneygram.com/AgentConnect1512}stringMax10" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CountryCurrencyInfo", propOrder = {
    "countryCode",
    "baseCurrency",
    "localCurrency",
    "receiveCurrency",
    "indicativeRateAvailable",
    "deliveryOption",
    "receiveAgentID",
    "receiveAgentAbbreviation",
    "mgManaged",
    "agentManaged",
    "validationExprs",
    "checkDigitAlg"
})
public class CountryCurrencyInfo {

    @XmlElement(required = true)
    protected String countryCode;
    @XmlElement(required = true)
    protected String baseCurrency;
    protected String localCurrency;
    @XmlElement(required = true)
    protected String receiveCurrency;
    protected boolean indicativeRateAvailable;
    @XmlElement(required = true)
    protected String deliveryOption;
    protected String receiveAgentID;
    protected String receiveAgentAbbreviation;
    protected String mgManaged;
    protected String agentManaged;
    protected String validationExprs;
    protected String checkDigitAlg;

    /**
     * Gets the value of the countryCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCountryCode() {
        return countryCode;
    }

    /**
     * Sets the value of the countryCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCountryCode(String value) {
        this.countryCode = value;
    }

    /**
     * Gets the value of the baseCurrency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBaseCurrency() {
        return baseCurrency;
    }

    /**
     * Sets the value of the baseCurrency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBaseCurrency(String value) {
        this.baseCurrency = value;
    }

    /**
     * Gets the value of the localCurrency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getLocalCurrency() {
        return localCurrency;
    }

    /**
     * Sets the value of the localCurrency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setLocalCurrency(String value) {
        this.localCurrency = value;
    }

    /**
     * Gets the value of the receiveCurrency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiveCurrency() {
        return receiveCurrency;
    }

    /**
     * Sets the value of the receiveCurrency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiveCurrency(String value) {
        this.receiveCurrency = value;
    }

    /**
     * Gets the value of the indicativeRateAvailable property.
     * 
     */
    public boolean isIndicativeRateAvailable() {
        return indicativeRateAvailable;
    }

    /**
     * Sets the value of the indicativeRateAvailable property.
     * 
     */
    public void setIndicativeRateAvailable(boolean value) {
        this.indicativeRateAvailable = value;
    }

    /**
     * Gets the value of the deliveryOption property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDeliveryOption() {
        return deliveryOption;
    }

    /**
     * Sets the value of the deliveryOption property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDeliveryOption(String value) {
        this.deliveryOption = value;
    }

    /**
     * Gets the value of the receiveAgentID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiveAgentID() {
        return receiveAgentID;
    }

    /**
     * Sets the value of the receiveAgentID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiveAgentID(String value) {
        this.receiveAgentID = value;
    }

    /**
     * Gets the value of the receiveAgentAbbreviation property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiveAgentAbbreviation() {
        return receiveAgentAbbreviation;
    }

    /**
     * Sets the value of the receiveAgentAbbreviation property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiveAgentAbbreviation(String value) {
        this.receiveAgentAbbreviation = value;
    }

    /**
     * Gets the value of the mgManaged property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMgManaged() {
        return mgManaged;
    }

    /**
     * Sets the value of the mgManaged property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMgManaged(String value) {
        this.mgManaged = value;
    }

    /**
     * Gets the value of the agentManaged property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAgentManaged() {
        return agentManaged;
    }

    /**
     * Sets the value of the agentManaged property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAgentManaged(String value) {
        this.agentManaged = value;
    }

    /**
     * Gets the value of the validationExprs property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getValidationExprs() {
        return validationExprs;
    }

    /**
     * Sets the value of the validationExprs property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setValidationExprs(String value) {
        this.validationExprs = value;
    }

    /**
     * Gets the value of the checkDigitAlg property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCheckDigitAlg() {
        return checkDigitAlg;
    }

    /**
     * Sets the value of the checkDigitAlg property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCheckDigitAlg(String value) {
        this.checkDigitAlg = value;
    }

}
