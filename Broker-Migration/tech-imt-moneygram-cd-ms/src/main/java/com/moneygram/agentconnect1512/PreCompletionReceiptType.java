
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * The receipts returned as part of any
 *                            validation-side flow for any POE capability (e.g. Sends, Receives,
 *                            Amends...) are uniquely different than those returned within a
 *                            commit transaction or complete session response. This complex type
 *                            provides the validation-side specific receipt response definition.
 * 
 * <p>Java class for PreCompletionReceiptType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="PreCompletionReceiptType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="receiptMimeType" type="{http://www.moneygram.com/AgentConnect1512}mimeType" minOccurs="0"/&gt;
 *         &lt;element name="charsetEncoding" type="{http://www.moneygram.com/AgentConnect1512}CharsetType" minOccurs="0"/&gt;
 *         &lt;element name="disclosure1MimeData" type="{http://www.moneygram.com/AgentConnect1512}ReceiptResponseType" minOccurs="0"/&gt;
 *         &lt;element name="disclosure2MimeData" type="{http://www.moneygram.com/AgentConnect1512}ReceiptResponseType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "PreCompletionReceiptType", propOrder = {
    "receiptMimeType",
    "charsetEncoding",
    "disclosure1MimeData",
    "disclosure2MimeData"
})
public class PreCompletionReceiptType {

    protected String receiptMimeType;
    protected String charsetEncoding;
    protected ReceiptResponseType disclosure1MimeData;
    protected ReceiptResponseType disclosure2MimeData;

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
     * Gets the value of the disclosure1MimeData property.
     * 
     * @return
     *     possible object is
     *     {@link ReceiptResponseType }
     *     
     */
    public ReceiptResponseType getDisclosure1MimeData() {
        return disclosure1MimeData;
    }

    /**
     * Sets the value of the disclosure1MimeData property.
     * 
     * @param value
     *     allowed object is
     *     {@link ReceiptResponseType }
     *     
     */
    public void setDisclosure1MimeData(ReceiptResponseType value) {
        this.disclosure1MimeData = value;
    }

    /**
     * Gets the value of the disclosure2MimeData property.
     * 
     * @return
     *     possible object is
     *     {@link ReceiptResponseType }
     *     
     */
    public ReceiptResponseType getDisclosure2MimeData() {
        return disclosure2MimeData;
    }

    /**
     * Sets the value of the disclosure2MimeData property.
     * 
     * @param value
     *     allowed object is
     *     {@link ReceiptResponseType }
     *     
     */
    public void setDisclosure2MimeData(ReceiptResponseType value) {
        this.disclosure2MimeData = value;
    }

}
