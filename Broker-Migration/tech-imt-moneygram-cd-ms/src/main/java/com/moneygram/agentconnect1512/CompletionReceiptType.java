
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * The receipts returned as part of any complete
 *                            session flow for any POE capability are uniquely different than
 *                            those returned within a validate response. This complex type
 *                            provides the complete session receipts response definition.
 * 
 * <p>Java class for CompletionReceiptType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CompletionReceiptType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="receiptMimeType" type="{http://www.moneygram.com/AgentConnect1512}mimeType" minOccurs="0"/&gt;
 *         &lt;element name="charsetEncoding" type="{http://www.moneygram.com/AgentConnect1512}CharsetType" minOccurs="0"/&gt;
 *         &lt;element name="agentReceiptMimeData" type="{http://www.moneygram.com/AgentConnect1512}ReceiptResponseType" minOccurs="0"/&gt;
 *         &lt;element name="consumerReceipt1MimeData" type="{http://www.moneygram.com/AgentConnect1512}ReceiptResponseType" minOccurs="0"/&gt;
 *         &lt;element name="consumerReceipt2MimeData" type="{http://www.moneygram.com/AgentConnect1512}ReceiptResponseType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CompletionReceiptType", propOrder = {
    "receiptMimeType",
    "charsetEncoding",
    "agentReceiptMimeData",
    "consumerReceipt1MimeData",
    "consumerReceipt2MimeData"
})
public class CompletionReceiptType {

    protected String receiptMimeType;
    protected String charsetEncoding;
    protected ReceiptResponseType agentReceiptMimeData;
    protected ReceiptResponseType consumerReceipt1MimeData;
    protected ReceiptResponseType consumerReceipt2MimeData;

    /**
     * Gets the value of the receiptMimeType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiptMimeType() {
        return receiptMimeType;
    }

    /**
     * Sets the value of the receiptMimeType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiptMimeType(String value) {
        this.receiptMimeType = value;
    }

    /**
     * Gets the value of the charsetEncoding property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCharsetEncoding() {
        return charsetEncoding;
    }

    /**
     * Sets the value of the charsetEncoding property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCharsetEncoding(String value) {
        this.charsetEncoding = value;
    }

    /**
     * Gets the value of the agentReceiptMimeData property.
     * 
     * @return
     *     possible object is
     *     {@link ReceiptResponseType }
     *     
     */
    public ReceiptResponseType getAgentReceiptMimeData() {
        return agentReceiptMimeData;
    }

    /**
     * Sets the value of the agentReceiptMimeData property.
     * 
     * @param value
     *     allowed object is
     *     {@link ReceiptResponseType }
     *     
     */
    public void setAgentReceiptMimeData(ReceiptResponseType value) {
        this.agentReceiptMimeData = value;
    }

    /**
     * Gets the value of the consumerReceipt1MimeData property.
     * 
     * @return
     *     possible object is
     *     {@link ReceiptResponseType }
     *     
     */
    public ReceiptResponseType getConsumerReceipt1MimeData() {
        return consumerReceipt1MimeData;
    }

    /**
     * Sets the value of the consumerReceipt1MimeData property.
     * 
     * @param value
     *     allowed object is
     *     {@link ReceiptResponseType }
     *     
     */
    public void setConsumerReceipt1MimeData(ReceiptResponseType value) {
        this.consumerReceipt1MimeData = value;
    }

    /**
     * Gets the value of the consumerReceipt2MimeData property.
     * 
     * @return
     *     possible object is
     *     {@link ReceiptResponseType }
     *     
     */
    public ReceiptResponseType getConsumerReceipt2MimeData() {
        return consumerReceipt2MimeData;
    }

    /**
     * Sets the value of the consumerReceipt2MimeData property.
     * 
     * @param value
     *     allowed object is
     *     {@link ReceiptResponseType }
     *     
     */
    public void setConsumerReceipt2MimeData(ReceiptResponseType value) {
        this.consumerReceipt2MimeData = value;
    }

}
