
package com.huawei.cps.cpsinterface.result;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 发起争议管理交易回滚的结果消息
 * 
 * <p>Java class for RaiseDisputedTxnReversalResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="RaiseDisputedTxnReversalResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="DebitPartyPublicName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="CreditPartyPublicName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="DebitAccountBalance" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="CreditAccountBalance" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="TransCompletedTime" type="{http://cps.huawei.com/cpsinterface/common}DateTime" minOccurs="0"/&gt;
 *         &lt;element name="Amount" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="Charge" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="ReceiptNumber" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="TransactionStatus" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="OriginalAmount" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="OriginalReceiptNumber" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "RaiseDisputedTxnReversalResult", propOrder = {
    "boCompletedTime",
    "debitPartyPublicName",
    "creditPartyPublicName",
    "debitAccountBalance",
    "creditAccountBalance",
    "transCompletedTime",
    "amount",
    "charge",
    "receiptNumber",
    "transactionStatus",
    "originalAmount",
    "originalReceiptNumber"
})
public class RaiseDisputedTxnReversalResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "DebitPartyPublicName", required = true)
    protected String debitPartyPublicName;
    @XmlElement(name = "CreditPartyPublicName", required = true)
    protected String creditPartyPublicName;
    @XmlElement(name = "DebitAccountBalance", required = true)
    protected String debitAccountBalance;
    @XmlElement(name = "CreditAccountBalance")
    protected String creditAccountBalance;
    @XmlElement(name = "TransCompletedTime")
    protected String transCompletedTime;
    @XmlElement(name = "Amount", required = true)
    protected String amount;
    @XmlElement(name = "Charge", required = true)
    protected String charge;
    @XmlElement(name = "ReceiptNumber", required = true)
    protected String receiptNumber;
    @XmlElement(name = "TransactionStatus", required = true)
    protected String transactionStatus;
    @XmlElement(name = "OriginalAmount", required = true)
    protected String originalAmount;
    @XmlElement(name = "OriginalReceiptNumber", required = true)
    protected String originalReceiptNumber;

    /**
     * Gets the value of the boCompletedTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBOCompletedTime() {
        return boCompletedTime;
    }

    /**
     * Sets the value of the boCompletedTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBOCompletedTime(String value) {
        this.boCompletedTime = value;
    }

    /**
     * Gets the value of the debitPartyPublicName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDebitPartyPublicName() {
        return debitPartyPublicName;
    }

    /**
     * Sets the value of the debitPartyPublicName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDebitPartyPublicName(String value) {
        this.debitPartyPublicName = value;
    }

    /**
     * Gets the value of the creditPartyPublicName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCreditPartyPublicName() {
        return creditPartyPublicName;
    }

    /**
     * Sets the value of the creditPartyPublicName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCreditPartyPublicName(String value) {
        this.creditPartyPublicName = value;
    }

    /**
     * Gets the value of the debitAccountBalance property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDebitAccountBalance() {
        return debitAccountBalance;
    }

    /**
     * Sets the value of the debitAccountBalance property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDebitAccountBalance(String value) {
        this.debitAccountBalance = value;
    }

    /**
     * Gets the value of the creditAccountBalance property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCreditAccountBalance() {
        return creditAccountBalance;
    }

    /**
     * Sets the value of the creditAccountBalance property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCreditAccountBalance(String value) {
        this.creditAccountBalance = value;
    }

    /**
     * Gets the value of the transCompletedTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTransCompletedTime() {
        return transCompletedTime;
    }

    /**
     * Sets the value of the transCompletedTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTransCompletedTime(String value) {
        this.transCompletedTime = value;
    }

    /**
     * Gets the value of the amount property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAmount() {
        return amount;
    }

    /**
     * Sets the value of the amount property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAmount(String value) {
        this.amount = value;
    }

    /**
     * Gets the value of the charge property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCharge() {
        return charge;
    }

    /**
     * Sets the value of the charge property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCharge(String value) {
        this.charge = value;
    }

    /**
     * Gets the value of the receiptNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiptNumber() {
        return receiptNumber;
    }

    /**
     * Sets the value of the receiptNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiptNumber(String value) {
        this.receiptNumber = value;
    }

    /**
     * Gets the value of the transactionStatus property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTransactionStatus() {
        return transactionStatus;
    }

    /**
     * Sets the value of the transactionStatus property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTransactionStatus(String value) {
        this.transactionStatus = value;
    }

    /**
     * Gets the value of the originalAmount property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOriginalAmount() {
        return originalAmount;
    }

    /**
     * Sets the value of the originalAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOriginalAmount(String value) {
        this.originalAmount = value;
    }

    /**
     * Gets the value of the originalReceiptNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOriginalReceiptNumber() {
        return originalReceiptNumber;
    }

    /**
     * Sets the value of the originalReceiptNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOriginalReceiptNumber(String value) {
        this.originalReceiptNumber = value;
    }

}
