
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for GetFieldsForRewardsRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="GetFieldsForRewardsRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Request"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="cardTypeCode" type="{http://www.moneygram.com/AgentConnect1512}stringMax4"/&gt;
 *         &lt;element name="programType" type="{http://www.moneygram.com/AgentConnect1512}stringMax3"/&gt;
 *         &lt;element name="rewardsRequestType" type="{http://www.moneygram.com/AgentConnect1512}rewardsRequestType"/&gt;
 *         &lt;element name="freqCustCardNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="senderCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "GetFieldsForRewardsRequest", propOrder = {
    "cardTypeCode",
    "programType",
    "rewardsRequestType",
    "freqCustCardNumber",
    "senderCountry"
})
public class GetFieldsForRewardsRequest
    extends Request
{

    @XmlElement(required = true)
    protected String cardTypeCode;
    @XmlElement(required = true)
    protected String programType;
    @XmlElement(required = true)
    @XmlSchemaType(name = "string")
    protected RewardsRequestType rewardsRequestType;
    protected String freqCustCardNumber;
    protected String senderCountry;

    /**
     * Gets the value of the cardTypeCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCardTypeCode() {
        return cardTypeCode;
    }

    /**
     * Sets the value of the cardTypeCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCardTypeCode(String value) {
        this.cardTypeCode = value;
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
     * Gets the value of the rewardsRequestType property.
     * 
     * @return
     *     possible object is
     *     {@link RewardsRequestType }
     *     
     */
    public RewardsRequestType getRewardsRequestType() {
        return rewardsRequestType;
    }

    /**
     * Sets the value of the rewardsRequestType property.
     * 
     * @param value
     *     allowed object is
     *     {@link RewardsRequestType }
     *     
     */
    public void setRewardsRequestType(RewardsRequestType value) {
        this.rewardsRequestType = value;
    }

    /**
     * Gets the value of the freqCustCardNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFreqCustCardNumber() {
        return freqCustCardNumber;
    }

    /**
     * Sets the value of the freqCustCardNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFreqCustCardNumber(String value) {
        this.freqCustCardNumber = value;
    }

    /**
     * Gets the value of the senderCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderCountry() {
        return senderCountry;
    }

    /**
     * Sets the value of the senderCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderCountry(String value) {
        this.senderCountry = value;
    }

}
