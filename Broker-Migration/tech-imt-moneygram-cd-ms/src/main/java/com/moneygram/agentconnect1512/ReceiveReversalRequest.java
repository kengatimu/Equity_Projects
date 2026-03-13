
package com.moneygram.agentconnect1512;

import java.math.BigDecimal;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for ReceiveReversalRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ReceiveReversalRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Request"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="receiveAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14nonZero"/&gt;
 *         &lt;element name="referenceNumber" type="{http://www.moneygram.com/AgentConnect1512}referenceNumber"/&gt;
 *         &lt;element name="operatorName" type="{http://www.moneygram.com/AgentConnect1512}stringMax7" minOccurs="0"/&gt;
 *         &lt;element name="communicationRetryIndicator" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="receiveReversalReason" type="{http://www.moneygram.com/AgentConnect1512}receiveReversalReasonCode"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ReceiveReversalRequest", propOrder = {
    "receiveAmount",
    "referenceNumber",
    "operatorName",
    "communicationRetryIndicator",
    "receiveReversalReason"
})
public class ReceiveReversalRequest
    extends Request
{

    @XmlElement(required = true)
    protected BigDecimal receiveAmount;
    @XmlElement(required = true)
    protected String referenceNumber;
    protected String operatorName;
    protected Boolean communicationRetryIndicator;
    @XmlElement(required = true)
    @XmlSchemaType(name = "string")
    protected ReceiveReversalReasonCode receiveReversalReason;

    /**
     * Gets the value of the receiveAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getReceiveAmount() {
        return receiveAmount;
    }

    /**
     * Sets the value of the receiveAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setReceiveAmount(BigDecimal value) {
        this.receiveAmount = value;
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

    /**
     * Gets the value of the receiveReversalReason property.
     * 
     * @return
     *     possible object is
     *     {@link ReceiveReversalReasonCode }
     *     
     */
    public ReceiveReversalReasonCode getReceiveReversalReason() {
        return receiveReversalReason;
    }

    /**
     * Sets the value of the receiveReversalReason property.
     * 
     * @param value
     *     allowed object is
     *     {@link ReceiveReversalReasonCode }
     *     
     */
    public void setReceiveReversalReason(ReceiveReversalReasonCode value) {
        this.receiveReversalReason = value;
    }

}
