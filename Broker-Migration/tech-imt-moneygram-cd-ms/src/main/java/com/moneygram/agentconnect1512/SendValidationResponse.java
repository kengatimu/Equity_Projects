
package com.moneygram.agentconnect1512;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for SendValidationResponse complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="SendValidationResponse"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Response"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="mgiTransactionSessionID" type="{http://www.moneygram.com/AgentConnect1512}mgiTransactionSessionID"/&gt;
 *         &lt;element name="referenceNumber" type="{http://www.moneygram.com/AgentConnect1512}referenceNumber" minOccurs="0"/&gt;
 *         &lt;element name="customerReceiveNumber" type="{http://www.moneygram.com/AgentConnect1512}customerReceiveNumber" minOccurs="0"/&gt;
 *         &lt;element name="displayAccountID" type="{http://www.moneygram.com/AgentConnect1512}stringMax255" minOccurs="0"/&gt;
 *         &lt;element name="customerServiceMessage" type="{http://www.moneygram.com/AgentConnect1512}stringMax255" minOccurs="0"/&gt;
 *         &lt;element name="accountNickname" type="{http://www.moneygram.com/AgentConnect1512}accountNickname" minOccurs="0"/&gt;
 *         &lt;element name="promotionInfo" type="{http://www.moneygram.com/AgentConnect1512}PromotionInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="promotionalMessage" type="{http://www.moneygram.com/AgentConnect1512}TextTranslation" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="readyForCommit" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="disclosureText" type="{http://www.moneygram.com/AgentConnect1512}TextTranslation" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="receiveAgentName" type="{http://www.moneygram.com/AgentConnect1512}stringMax40" minOccurs="0"/&gt;
 *         &lt;element name="receiveAgentAddress" type="{http://www.moneygram.com/AgentConnect1512}AgentAddress" minOccurs="0"/&gt;
 *         &lt;element name="additionalFieldsToCollect" type="{http://www.moneygram.com/AgentConnect1512}ProductFieldInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="sendAmounts" type="{http://www.moneygram.com/AgentConnect1512}SendAmountInfo" minOccurs="0"/&gt;
 *         &lt;element name="receiveAmounts" type="{http://www.moneygram.com/AgentConnect1512}ReceiveAmountInfo" minOccurs="0"/&gt;
 *         &lt;element name="exchangeRateApplied" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="receiveFeeDisclosureText" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="receiveTaxDisclosureText" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="confirmationNumber" type="{http://www.moneygram.com/AgentConnect1512}confirmationNumber" minOccurs="0"/&gt;
 *         &lt;element name="receipts" type="{http://www.moneygram.com/AgentConnect1512}PreCompletionReceiptType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "SendValidationResponse", propOrder = {
    "mgiTransactionSessionID",
    "referenceNumber",
    "customerReceiveNumber",
    "displayAccountID",
    "customerServiceMessage",
    "accountNickname",
    "promotionInfo",
    "promotionalMessage",
    "readyForCommit",
    "disclosureText",
    "receiveAgentName",
    "receiveAgentAddress",
    "additionalFieldsToCollect",
    "sendAmounts",
    "receiveAmounts",
    "exchangeRateApplied",
    "receiveFeeDisclosureText",
    "receiveTaxDisclosureText",
    "confirmationNumber",
    "receipts"
})
public class SendValidationResponse
    extends Response
{

    @XmlElement(required = true)
    protected String mgiTransactionSessionID;
    protected String referenceNumber;
    protected String customerReceiveNumber;
    protected String displayAccountID;
    protected String customerServiceMessage;
    protected String accountNickname;
    protected List<PromotionInfo> promotionInfo;
    protected List<TextTranslation> promotionalMessage;
    protected Boolean readyForCommit;
    protected List<TextTranslation> disclosureText;
    protected String receiveAgentName;
    protected AgentAddress receiveAgentAddress;
    protected List<ProductFieldInfo> additionalFieldsToCollect;
    protected SendAmountInfo sendAmounts;
    protected ReceiveAmountInfo receiveAmounts;
    protected BigDecimal exchangeRateApplied;
    protected Boolean receiveFeeDisclosureText;
    protected Boolean receiveTaxDisclosureText;
    protected String confirmationNumber;
    protected PreCompletionReceiptType receipts;

    /**
     * Gets the value of the mgiTransactionSessionID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMgiTransactionSessionID() {
        return mgiTransactionSessionID;
    }

    /**
     * Sets the value of the mgiTransactionSessionID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMgiTransactionSessionID(String value) {
        this.mgiTransactionSessionID = value;
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
     * Gets the value of the customerReceiveNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomerReceiveNumber() {
        return customerReceiveNumber;
    }

    /**
     * Sets the value of the customerReceiveNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomerReceiveNumber(String value) {
        this.customerReceiveNumber = value;
    }

    /**
     * Gets the value of the displayAccountID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDisplayAccountID() {
        return displayAccountID;
    }

    /**
     * Sets the value of the displayAccountID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDisplayAccountID(String value) {
        this.displayAccountID = value;
    }

    /**
     * Gets the value of the customerServiceMessage property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomerServiceMessage() {
        return customerServiceMessage;
    }

    /**
     * Sets the value of the customerServiceMessage property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomerServiceMessage(String value) {
        this.customerServiceMessage = value;
    }

    /**
     * Gets the value of the accountNickname property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAccountNickname() {
        return accountNickname;
    }

    /**
     * Sets the value of the accountNickname property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAccountNickname(String value) {
        this.accountNickname = value;
    }

    /**
     * Gets the value of the promotionInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the promotionInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getPromotionInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link PromotionInfo }
     * 
     * 
     */
    public List<PromotionInfo> getPromotionInfo() {
        if (promotionInfo == null) {
            promotionInfo = new ArrayList<PromotionInfo>();
        }
        return this.promotionInfo;
    }

    /**
     * Gets the value of the promotionalMessage property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the promotionalMessage property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getPromotionalMessage().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link TextTranslation }
     * 
     * 
     */
    public List<TextTranslation> getPromotionalMessage() {
        if (promotionalMessage == null) {
            promotionalMessage = new ArrayList<TextTranslation>();
        }
        return this.promotionalMessage;
    }

    /**
     * Gets the value of the readyForCommit property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isReadyForCommit() {
        return readyForCommit;
    }

    /**
     * Sets the value of the readyForCommit property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setReadyForCommit(Boolean value) {
        this.readyForCommit = value;
    }

    /**
     * Gets the value of the disclosureText property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the disclosureText property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getDisclosureText().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link TextTranslation }
     * 
     * 
     */
    public List<TextTranslation> getDisclosureText() {
        if (disclosureText == null) {
            disclosureText = new ArrayList<TextTranslation>();
        }
        return this.disclosureText;
    }

    /**
     * Gets the value of the receiveAgentName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiveAgentName() {
        return receiveAgentName;
    }

    /**
     * Sets the value of the receiveAgentName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiveAgentName(String value) {
        this.receiveAgentName = value;
    }

    /**
     * Gets the value of the receiveAgentAddress property.
     * 
     * @return
     *     possible object is
     *     {@link AgentAddress }
     *     
     */
    public AgentAddress getReceiveAgentAddress() {
        return receiveAgentAddress;
    }

    /**
     * Sets the value of the receiveAgentAddress property.
     * 
     * @param value
     *     allowed object is
     *     {@link AgentAddress }
     *     
     */
    public void setReceiveAgentAddress(AgentAddress value) {
        this.receiveAgentAddress = value;
    }

    /**
     * Gets the value of the additionalFieldsToCollect property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the additionalFieldsToCollect property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getAdditionalFieldsToCollect().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ProductFieldInfo }
     * 
     * 
     */
    public List<ProductFieldInfo> getAdditionalFieldsToCollect() {
        if (additionalFieldsToCollect == null) {
            additionalFieldsToCollect = new ArrayList<ProductFieldInfo>();
        }
        return this.additionalFieldsToCollect;
    }

    /**
     * Gets the value of the sendAmounts property.
     * 
     * @return
     *     possible object is
     *     {@link SendAmountInfo }
     *     
     */
    public SendAmountInfo getSendAmounts() {
        return sendAmounts;
    }

    /**
     * Sets the value of the sendAmounts property.
     * 
     * @param value
     *     allowed object is
     *     {@link SendAmountInfo }
     *     
     */
    public void setSendAmounts(SendAmountInfo value) {
        this.sendAmounts = value;
    }

    /**
     * Gets the value of the receiveAmounts property.
     * 
     * @return
     *     possible object is
     *     {@link ReceiveAmountInfo }
     *     
     */
    public ReceiveAmountInfo getReceiveAmounts() {
        return receiveAmounts;
    }

    /**
     * Sets the value of the receiveAmounts property.
     * 
     * @param value
     *     allowed object is
     *     {@link ReceiveAmountInfo }
     *     
     */
    public void setReceiveAmounts(ReceiveAmountInfo value) {
        this.receiveAmounts = value;
    }

    /**
     * Gets the value of the exchangeRateApplied property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getExchangeRateApplied() {
        return exchangeRateApplied;
    }

    /**
     * Sets the value of the exchangeRateApplied property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setExchangeRateApplied(BigDecimal value) {
        this.exchangeRateApplied = value;
    }

    /**
     * Gets the value of the receiveFeeDisclosureText property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isReceiveFeeDisclosureText() {
        return receiveFeeDisclosureText;
    }

    /**
     * Sets the value of the receiveFeeDisclosureText property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setReceiveFeeDisclosureText(Boolean value) {
        this.receiveFeeDisclosureText = value;
    }

    /**
     * Gets the value of the receiveTaxDisclosureText property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isReceiveTaxDisclosureText() {
        return receiveTaxDisclosureText;
    }

    /**
     * Sets the value of the receiveTaxDisclosureText property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setReceiveTaxDisclosureText(Boolean value) {
        this.receiveTaxDisclosureText = value;
    }

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
     * Gets the value of the receipts property.
     * 
     * @return
     *     possible object is
     *     {@link PreCompletionReceiptType }
     *     
     */
    public PreCompletionReceiptType getReceipts() {
        return receipts;
    }

    /**
     * Sets the value of the receipts property.
     * 
     * @param value
     *     allowed object is
     *     {@link PreCompletionReceiptType }
     *     
     */
    public void setReceipts(PreCompletionReceiptType value) {
        this.receipts = value;
    }

}
