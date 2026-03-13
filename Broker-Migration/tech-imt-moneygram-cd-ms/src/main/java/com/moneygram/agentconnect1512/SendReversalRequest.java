
package com.moneygram.agentconnect1512;

import java.math.BigDecimal;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for SendReversalRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="SendReversalRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Request"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="sendAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14nonZero"/&gt;
 *         &lt;element name="feeAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14"/&gt;
 *         &lt;element name="sendCurrency" type="{http://www.moneygram.com/AgentConnect1512}currencyCode"/&gt;
 *         &lt;element name="referenceNumber" type="{http://www.moneygram.com/AgentConnect1512}referenceNumber"/&gt;
 *         &lt;element name="operatorName" type="{http://www.moneygram.com/AgentConnect1512}stringMax80" minOccurs="0"/&gt;
 *         &lt;element name="reversalType" type="{http://www.moneygram.com/AgentConnect1512}sendReversalType"/&gt;
 *         &lt;element name="sendReversalReason" type="{http://www.moneygram.com/AgentConnect1512}sendReversalReasonCode" minOccurs="0"/&gt;
 *         &lt;element name="feeRefund" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="agentCheckType" type="{http://www.moneygram.com/AgentConnect1512}checkType" minOccurs="0"/&gt;
 *         &lt;element name="agentCheckNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax12" minOccurs="0"/&gt;
 *         &lt;element name="agentCheckAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14nonZero" minOccurs="0"/&gt;
 *         &lt;element name="customerCheckType" type="{http://www.moneygram.com/AgentConnect1512}checkType" minOccurs="0"/&gt;
 *         &lt;element name="customerCheckNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax12" minOccurs="0"/&gt;
 *         &lt;element name="customerCheckAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14nonZero" minOccurs="0"/&gt;
 *         &lt;element name="communicationRetryIndicator" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "SendReversalRequest", propOrder = {
    "sendAmount",
    "feeAmount",
    "sendCurrency",
    "referenceNumber",
    "operatorName",
    "reversalType",
    "sendReversalReason",
    "feeRefund",
    "agentCheckType",
    "agentCheckNumber",
    "agentCheckAmount",
    "customerCheckType",
    "customerCheckNumber",
    "customerCheckAmount",
    "communicationRetryIndicator"
})
public class SendReversalRequest
    extends Request
{

    @XmlElement(required = true)
    protected BigDecimal sendAmount;
    @XmlElement(required = true)
    protected BigDecimal feeAmount;
    @XmlElement(required = true)
    protected String sendCurrency;
    @XmlElement(required = true)
    protected String referenceNumber;
    protected String operatorName;
    @XmlElement(required = true)
    @XmlSchemaType(name = "string")
    protected SendReversalType reversalType;
    @XmlSchemaType(name = "string")
    protected SendReversalReasonCode sendReversalReason;
    protected String feeRefund;
    protected String agentCheckType;
    protected String agentCheckNumber;
    protected BigDecimal agentCheckAmount;
    protected String customerCheckType;
    protected String customerCheckNumber;
    protected BigDecimal customerCheckAmount;
    protected Boolean communicationRetryIndicator;

    /**
     * Gets the value of the sendAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getSendAmount() {
        return sendAmount;
    }

    /**
     * Sets the value of the sendAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setSendAmount(BigDecimal value) {
        this.sendAmount = value;
    }

    /**
     * Gets the value of the feeAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getFeeAmount() {
        return feeAmount;
    }

    /**
     * Sets the value of the feeAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setFeeAmount(BigDecimal value) {
        this.feeAmount = value;
    }

    /**
     * Gets the value of the sendCurrency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSendCurrency() {
        return sendCurrency;
    }

    /**
     * Sets the value of the sendCurrency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSendCurrency(String value) {
        this.sendCurrency = value;
    }

    /**
     * Gets the value of the referenceNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReferenceNumber() {
        return referenceNumber;
    }

    /**
     * Sets the value of the referenceNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReferenceNumber(String value) {
        this.referenceNumber = value;
    }

    /**
     * Gets the value of the operatorName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOperatorName() {
        return operatorName;
    }

    /**
     * Sets the value of the operatorName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOperatorName(String value) {
        this.operatorName = value;
    }

    /**
     * Gets the value of the reversalType property.
     * 
     * @return
     *     possible object is
     *     {@link SendReversalType }
     *     
     */
    public SendReversalType getReversalType() {
        return reversalType;
    }

    /**
     * Sets the value of the reversalType property.
     * 
     * @param value
     *     allowed object is
     *     {@link SendReversalType }
     *     
     */
    public void setReversalType(SendReversalType value) {
        this.reversalType = value;
    }

    /**
     * Gets the value of the sendReversalReason property.
     * 
     * @return
     *     possible object is
     *     {@link SendReversalReasonCode }
     *     
     */
    public SendReversalReasonCode getSendReversalReason() {
        return sendReversalReason;
    }

    /**
     * Sets the value of the sendReversalReason property.
     * 
     * @param value
     *     allowed object is
     *     {@link SendReversalReasonCode }
     *     
     */
    public void setSendReversalReason(SendReversalReasonCode value) {
        this.sendReversalReason = value;
    }

    /**
     * Gets the value of the feeRefund property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFeeRefund() {
        return feeRefund;
    }

    /**
     * Sets the value of the feeRefund property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFeeRefund(String value) {
        this.feeRefund = value;
    }

    /**
     * Gets the value of the agentCheckType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAgentCheckType() {
        return agentCheckType;
    }

    /**
     * Sets the value of the agentCheckType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAgentCheckType(String value) {
        this.agentCheckType = value;
    }

    /**
     * Gets the value of the agentCheckNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAgentCheckNumber() {
        return agentCheckNumber;
    }

    /**
     * Sets the value of the agentCheckNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAgentCheckNumber(String value) {
        this.agentCheckNumber = value;
    }

    /**
     * Gets the value of the agentCheckAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getAgentCheckAmount() {
        return agentCheckAmount;
    }

    /**
     * Sets the value of the agentCheckAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setAgentCheckAmount(BigDecimal value) {
        this.agentCheckAmount = value;
    }

    /**
     * Gets the value of the customerCheckType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomerCheckType() {
        return customerCheckType;
    }

    /**
     * Sets the value of the customerCheckType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomerCheckType(String value) {
        this.customerCheckType = value;
    }

    /**
     * Gets the value of the customerCheckNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomerCheckNumber() {
        return customerCheckNumber;
    }

    /**
     * Sets the value of the customerCheckNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomerCheckNumber(String value) {
        this.customerCheckNumber = value;
    }

    /**
     * Gets the value of the customerCheckAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getCustomerCheckAmount() {
        return customerCheckAmount;
    }

    /**
     * Sets the value of the customerCheckAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setCustomerCheckAmount(BigDecimal value) {
        this.customerCheckAmount = value;
    }

    /**
     * Gets the value of the communicationRetryIndicator property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isCommunicationRetryIndicator() {
        return communicationRetryIndicator;
    }

    /**
     * Sets the value of the communicationRetryIndicator property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setCommunicationRetryIndicator(Boolean value) {
        this.communicationRetryIndicator = value;
    }

}
