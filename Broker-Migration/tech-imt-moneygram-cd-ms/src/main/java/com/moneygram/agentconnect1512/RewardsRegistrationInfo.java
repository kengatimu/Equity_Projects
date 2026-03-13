
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for RewardsRegistrationInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="RewardsRegistrationInfo"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="country" type="{http://www.moneygram.com/AgentConnect1512}stringMax3"/&gt;
 *         &lt;element name="programType" type="{http://www.moneygram.com/AgentConnect1512}stringMax3"/&gt;
 *         &lt;element name="cardType" type="{http://www.moneygram.com/AgentConnect1512}stringMax4"/&gt;
 *         &lt;element name="allowPrePrintedCards" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="allowStandardCards" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "RewardsRegistrationInfo", propOrder = {
    "country",
    "programType",
    "cardType",
    "allowPrePrintedCards",
    "allowStandardCards"
})
public class RewardsRegistrationInfo {

    @XmlElement(required = true)
    protected String country;
    @XmlElement(required = true)
    protected String programType;
    @XmlElement(required = true)
    protected String cardType;
    protected boolean allowPrePrintedCards;
    protected boolean allowStandardCards;

    /**
     * Gets the value of the country property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCountry() {
        return country;
    }

    /**
     * Sets the value of the country property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCountry(String value) {
        this.country = value;
    }

    /**
     * Gets the value of the programType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getProgramType() {
        return programType;
    }

    /**
     * Sets the value of the programType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setProgramType(String value) {
        this.programType = value;
    }

    /**
     * Gets the value of the cardType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCardType() {
        return cardType;
    }

    /**
     * Sets the value of the cardType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCardType(String value) {
        this.cardType = value;
    }

    /**
     * Gets the value of the allowPrePrintedCards property.
     * 
     */
    public boolean isAllowPrePrintedCards() {
        return allowPrePrintedCards;
    }

    /**
     * Sets the value of the allowPrePrintedCards property.
     * 
     */
    public void setAllowPrePrintedCards(boolean value) {
        this.allowPrePrintedCards = value;
    }

    /**
     * Gets the value of the allowStandardCards property.
     * 
     */
    public boolean isAllowStandardCards() {
        return allowStandardCards;
    }

    /**
     * Sets the value of the allowStandardCards property.
     * 
     */
    public void setAllowStandardCards(boolean value) {
        this.allowStandardCards = value;
    }

}
