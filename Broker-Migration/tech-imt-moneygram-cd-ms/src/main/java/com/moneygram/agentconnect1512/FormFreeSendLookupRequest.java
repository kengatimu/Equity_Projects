
package com.moneygram.agentconnect1512;

import java.math.BigDecimal;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for FormFreeSendLookupRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="FormFreeSendLookupRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Request"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="confirmationNumber" type="{http://www.moneygram.com/AgentConnect1512}confirmationNumber"/&gt;
 *         &lt;element name="amount" type="{http://www.moneygram.com/AgentConnect1512}decimal14"/&gt;
 *         &lt;element name="feeAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="primaryReceiptLanguage" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="secondaryReceiptLanguage" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="receiptImages" type="{http://www.moneygram.com/AgentConnect1512}ReceiptImagesContentType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "FormFreeSendLookupRequest", propOrder = {
    "confirmationNumber",
    "amount",
    "feeAmount",
    "primaryReceiptLanguage",
    "secondaryReceiptLanguage",
    "receiptImages"
})
public class FormFreeSendLookupRequest
    extends Request
{

    @XmlElement(required = true)
    protected String confirmationNumber;
    @XmlElement(required = true)
    protected BigDecimal amount;
    protected BigDecimal feeAmount;
    protected String primaryReceiptLanguage;
    protected String secondaryReceiptLanguage;
    protected ReceiptImagesContentType receiptImages;

    /**
     * Gets the value of the confirmationNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConfirmationNumber() {
        return confirmationNumber;
    }

    /**
     * Sets the value of the confirmationNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConfirmationNumber(String value) {
        this.confirmationNumber = value;
    }

    /**
     * Gets the value of the amount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getAmount() {
        return amount;
    }

    /**
     * Sets the value of the amount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setAmount(BigDecimal value) {
        this.amount = value;
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
     * Gets the value of the primaryReceiptLanguage property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPrimaryReceiptLanguage() {
        return primaryReceiptLanguage;
    }

    /**
     * Sets the value of the primaryReceiptLanguage property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPrimaryReceiptLanguage(String value) {
        this.primaryReceiptLanguage = value;
    }

    /**
     * Gets the value of the secondaryReceiptLanguage property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSecondaryReceiptLanguage() {
        return secondaryReceiptLanguage;
    }

    /**
     * Sets the value of the secondaryReceiptLanguage property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSecondaryReceiptLanguage(String value) {
        this.secondaryReceiptLanguage = value;
    }

    /**
     * Gets the value of the receiptImages property.
     * 
     * @return
     *     possible object is
     *     {@link ReceiptImagesContentType }
     *     
     */
    public ReceiptImagesContentType getReceiptImages() {
        return receiptImages;
    }

    /**
     * Sets the value of the receiptImages property.
     * 
     * @param value
     *     allowed object is
     *     {@link ReceiptImagesContentType }
     *     
     */
    public void setReceiptImages(ReceiptImagesContentType value) {
        this.receiptImages = value;
    }

}
