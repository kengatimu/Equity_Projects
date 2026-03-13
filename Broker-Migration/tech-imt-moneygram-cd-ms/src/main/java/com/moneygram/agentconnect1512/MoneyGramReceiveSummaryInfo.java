
package com.moneygram.agentconnect1512;

import java.math.BigDecimal;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for MoneyGramReceiveSummaryInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="MoneyGramReceiveSummaryInfo"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="agentNumber" type="{http://www.moneygram.com/AgentConnect1512}agentNumber"/&gt;
 *         &lt;element name="agentName" type="{http://www.moneygram.com/AgentConnect1512}agentName"/&gt;
 *         &lt;element name="cashOrCheckAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14nonZero" minOccurs="0"/&gt;
 *         &lt;element name="otherPayoutAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14nonZero" minOccurs="0"/&gt;
 *         &lt;element name="receiveCurrency" type="{http://www.moneygram.com/AgentConnect1512}currencyCode"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "MoneyGramReceiveSummaryInfo", propOrder = {
    "agentNumber",
    "agentName",
    "cashOrCheckAmount",
    "otherPayoutAmount",
    "receiveCurrency"
})
public class MoneyGramReceiveSummaryInfo {

    @XmlElement(required = true)
    protected String agentNumber;
    @XmlElement(required = true)
    protected String agentName;
    protected BigDecimal cashOrCheckAmount;
    protected BigDecimal otherPayoutAmount;
    @XmlElement(required = true)
    protected String receiveCurrency;

    /**
     * Gets the value of the agentNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAgentNumber() {
        return agentNumber;
    }

    /**
     * Sets the value of the agentNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAgentNumber(String value) {
        this.agentNumber = value;
    }

    /**
     * Gets the value of the agentName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAgentName() {
        return agentName;
    }

    /**
     * Sets the value of the agentName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAgentName(String value) {
        this.agentName = value;
    }

    /**
     * Gets the value of the cashOrCheckAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getCashOrCheckAmount() {
        return cashOrCheckAmount;
    }

    /**
     * Sets the value of the cashOrCheckAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setCashOrCheckAmount(BigDecimal value) {
        this.cashOrCheckAmount = value;
    }

    /**
     * Gets the value of the otherPayoutAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getOtherPayoutAmount() {
        return otherPayoutAmount;
    }

    /**
     * Sets the value of the otherPayoutAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setOtherPayoutAmount(BigDecimal value) {
        this.otherPayoutAmount = value;
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

}
