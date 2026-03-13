
package com.moneygram.agentconnect1512;

import java.math.BigDecimal;
import javax.xml.datatype.XMLGregorianCalendar;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for SendReversalResponse complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="SendReversalResponse"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Response"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="transactionDateTime" type="{http://www.w3.org/2001/XMLSchema}dateTime"/&gt;
 *         &lt;element name="refundTotalAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14nonZero" minOccurs="0"/&gt;
 *         &lt;element name="refundFaceAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14nonZero" minOccurs="0"/&gt;
 *         &lt;element name="refundFeeAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="totalCheckAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="reversalType" type="{http://www.moneygram.com/AgentConnect1512}sendReversalType"/&gt;
 *         &lt;element name="agentCheckAuthorizationNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax5" minOccurs="0"/&gt;
 *         &lt;element name="receipts" type="{http://www.moneygram.com/AgentConnect1512}CompletionReceiptType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "SendReversalResponse", propOrder = {
    "transactionDateTime",
    "refundTotalAmount",
    "refundFaceAmount",
    "refundFeeAmount",
    "totalCheckAmount",
    "reversalType",
    "agentCheckAuthorizationNumber",
    "receipts"
})
public class SendReversalResponse
    extends Response
{

    @XmlElement(required = true)
    @XmlSchemaType(name = "dateTime")
    protected XMLGregorianCalendar transactionDateTime;
    protected BigDecimal refundTotalAmount;
    protected BigDecimal refundFaceAmount;
    protected BigDecimal refundFeeAmount;
    protected BigDecimal totalCheckAmount;
    @XmlElement(required = true)
    @XmlSchemaType(name = "string")
    protected SendReversalType reversalType;
    protected String agentCheckAuthorizationNumber;
    protected CompletionReceiptType receipts;

    /**
     * Gets the value of the transactionDateTime property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getTransactionDateTime() {
        return transactionDateTime;
    }

    /**
     * Sets the value of the transactionDateTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setTransactionDateTime(XMLGregorianCalendar value) {
        this.transactionDateTime = value;
    }

    /**
     * Gets the value of the refundTotalAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getRefundTotalAmount() {
        return refundTotalAmount;
    }

    /**
     * Sets the value of the refundTotalAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setRefundTotalAmount(BigDecimal value) {
        this.refundTotalAmount = value;
    }

    /**
     * Gets the value of the refundFaceAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getRefundFaceAmount() {
        return refundFaceAmount;
    }

    /**
     * Sets the value of the refundFaceAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setRefundFaceAmount(BigDecimal value) {
        this.refundFaceAmount = value;
    }

    /**
     * Gets the value of the refundFeeAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getRefundFeeAmount() {
        return refundFeeAmount;
    }

    /**
     * Sets the value of the refundFeeAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setRefundFeeAmount(BigDecimal value) {
        this.refundFeeAmount = value;
    }

    /**
     * Gets the value of the totalCheckAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getTotalCheckAmount() {
        return totalCheckAmount;
    }

    /**
     * Sets the value of the totalCheckAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setTotalCheckAmount(BigDecimal value) {
        this.totalCheckAmount = value;
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
     * Gets the value of the agentCheckAuthorizationNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAgentCheckAuthorizationNumber() {
        return agentCheckAuthorizationNumber;
    }

    /**
     * Sets the value of the agentCheckAuthorizationNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAgentCheckAuthorizationNumber(String value) {
        this.agentCheckAuthorizationNumber = value;
    }

    /**
     * Gets the value of the receipts property.
     * 
     * @return
     *     possible object is
     *     {@link CompletionReceiptType }
     *     
     */
    public CompletionReceiptType getReceipts() {
        return receipts;
    }

    /**
     * Sets the value of the receipts property.
     * 
     * @param value
     *     allowed object is
     *     {@link CompletionReceiptType }
     *     
     */
    public void setReceipts(CompletionReceiptType value) {
        this.receipts = value;
    }

}
