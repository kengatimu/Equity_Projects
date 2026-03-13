
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for CountryInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CountryInfo"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="countryCode" type="{http://www.moneygram.com/AgentConnect1512}countryType"/&gt;
 *         &lt;element name="countryName" type="{http://www.moneygram.com/AgentConnect1512}stringMax50"/&gt;
 *         &lt;element name="countryLegacyCode" type="{http://www.moneygram.com/AgentConnect1512}stringMax2"/&gt;
 *         &lt;element name="sendActive" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="receiveActive" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="directedSendCountry" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="mgDirectedSendCountry" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="baseReceiveCurrency" type="{http://www.moneygram.com/AgentConnect1512}currencyCode" minOccurs="0"/&gt;
 *         &lt;element name="isZipCodeRequired" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CountryInfo", propOrder = {
    "countryCode",
    "countryName",
    "countryLegacyCode",
    "sendActive",
    "receiveActive",
    "directedSendCountry",
    "mgDirectedSendCountry",
    "baseReceiveCurrency",
    "isZipCodeRequired"
})
public class CountryInfo {

    @XmlElement(required = true)
    protected String countryCode;
    @XmlElement(required = true)
    protected String countryName;
    @XmlElement(required = true)
    protected String countryLegacyCode;
    protected boolean sendActive;
    protected boolean receiveActive;
    protected boolean directedSendCountry;
    protected boolean mgDirectedSendCountry;
    protected String baseReceiveCurrency;
    protected Boolean isZipCodeRequired;

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
     * Gets the value of the countryName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCountryName() {
        return countryName;
    }

    /**
     * Sets the value of the countryName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCountryName(String value) {
        this.countryName = value;
    }

    /**
     * Gets the value of the countryLegacyCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCountryLegacyCode() {
        return countryLegacyCode;
    }

    /**
     * Sets the value of the countryLegacyCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCountryLegacyCode(String value) {
        this.countryLegacyCode = value;
    }

    /**
     * Gets the value of the sendActive property.
     * 
     */
    public boolean isSendActive() {
        return sendActive;
    }

    /**
     * Sets the value of the sendActive property.
     * 
     */
    public void setSendActive(boolean value) {
        this.sendActive = value;
    }

    /**
     * Gets the value of the receiveActive property.
     * 
     */
    public boolean isReceiveActive() {
        return receiveActive;
    }

    /**
     * Sets the value of the receiveActive property.
     * 
     */
    public void setReceiveActive(boolean value) {
        this.receiveActive = value;
    }

    /**
     * Gets the value of the directedSendCountry property.
     * 
     */
    public boolean isDirectedSendCountry() {
        return directedSendCountry;
    }

    /**
     * Sets the value of the directedSendCountry property.
     * 
     */
    public void setDirectedSendCountry(boolean value) {
        this.directedSendCountry = value;
    }

    /**
     * Gets the value of the mgDirectedSendCountry property.
     * 
     */
    public boolean isMgDirectedSendCountry() {
        return mgDirectedSendCountry;
    }

    /**
     * Sets the value of the mgDirectedSendCountry property.
     * 
     */
    public void setMgDirectedSendCountry(boolean value) {
        this.mgDirectedSendCountry = value;
    }

    /**
     * Gets the value of the baseReceiveCurrency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBaseReceiveCurrency() {
        return baseReceiveCurrency;
    }

    /**
     * Sets the value of the baseReceiveCurrency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBaseReceiveCurrency(String value) {
        this.baseReceiveCurrency = value;
    }

    /**
     * Gets the value of the isZipCodeRequired property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isIsZipCodeRequired() {
        return isZipCodeRequired;
    }

    /**
     * Sets the value of the isZipCodeRequired property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setIsZipCodeRequired(Boolean value) {
        this.isZipCodeRequired = value;
    }

}
