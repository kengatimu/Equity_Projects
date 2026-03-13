
package com.moneygram.agentconnect1512;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for BpValidationResponse complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="BpValidationResponse"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Response"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="mgiTransactionSessionID" type="{http://www.moneygram.com/AgentConnect1512}mgiTransactionSessionID"/&gt;
 *         &lt;element name="totalSendAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14nonZero" minOccurs="0"/&gt;
 *         &lt;element name="mgiRewardsNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="productVariant" type="{http://www.moneygram.com/AgentConnect1512}productVariant"/&gt;
 *         &lt;element name="serviceOfferingID" type="{http://www.moneygram.com/AgentConnect1512}stringMax21" minOccurs="0"/&gt;
 *         &lt;element name="billerWebsite" type="{http://www.moneygram.com/AgentConnect1512}stringMax40" minOccurs="0"/&gt;
 *         &lt;element name="billerPhone" type="{http://www.moneygram.com/AgentConnect1512}phoneType" minOccurs="0"/&gt;
 *         &lt;element name="expectedPostingTimeFrame" type="{http://www.moneygram.com/AgentConnect1512}TextTranslation" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="billerCutoffTime" type="{http://www.moneygram.com/AgentConnect1512}stringMax12" minOccurs="0"/&gt;
 *         &lt;element name="billerNotes" type="{http://www.moneygram.com/AgentConnect1512}TextTranslation" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="serviceOfferingDescription" type="{http://www.moneygram.com/AgentConnect1512}TextTranslation" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="customerTips" type="{http://www.moneygram.com/AgentConnect1512}TextTranslation" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="billerAddress" type="{http://www.moneygram.com/AgentConnect1512}addressType" minOccurs="0"/&gt;
 *         &lt;element name="billerAddress2" type="{http://www.moneygram.com/AgentConnect1512}addressType" minOccurs="0"/&gt;
 *         &lt;element name="billerAddress3" type="{http://www.moneygram.com/AgentConnect1512}addressType" minOccurs="0"/&gt;
 *         &lt;element name="billerCity" type="{http://www.moneygram.com/AgentConnect1512}cityType" minOccurs="0"/&gt;
 *         &lt;element name="billerState" type="{http://www.moneygram.com/AgentConnect1512}stateType" minOccurs="0"/&gt;
 *         &lt;element name="billerZip" type="{http://www.moneygram.com/AgentConnect1512}zipType" minOccurs="0"/&gt;
 *         &lt;element name="printMGICustomerServiceNumber" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="agentTransactionId" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="promotionInfo" type="{http://www.moneygram.com/AgentConnect1512}PromotionInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="promotionalMessage" type="{http://www.moneygram.com/AgentConnect1512}TextTranslation" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="readyForCommit" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="disclosureText" type="{http://www.moneygram.com/AgentConnect1512}TextTranslation" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="additionalFieldsToCollect" type="{http://www.moneygram.com/AgentConnect1512}ProductFieldInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="processingFee" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="infoFeeIndicator" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="sendAmounts" type="{http://www.moneygram.com/AgentConnect1512}SendAmountInfo" minOccurs="0"/&gt;
 *         &lt;element name="receiveAmounts" type="{http://www.moneygram.com/AgentConnect1512}ReceiveAmountInfo" minOccurs="0"/&gt;
 *         &lt;element name="exchangeRateApplied" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
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
@XmlType(name = "BpValidationResponse", propOrder = {
    "mgiTransactionSessionID",
    "totalSendAmount",
    "mgiRewardsNumber",
    "productVariant",
    "serviceOfferingID",
    "billerWebsite",
    "billerPhone",
    "expectedPostingTimeFrame",
    "billerCutoffTime",
    "billerNotes",
    "serviceOfferingDescription",
    "customerTips",
    "billerAddress",
    "billerAddress2",
    "billerAddress3",
    "billerCity",
    "billerState",
    "billerZip",
    "printMGICustomerServiceNumber",
    "agentTransactionId",
    "promotionInfo",
    "promotionalMessage",
    "readyForCommit",
    "disclosureText",
    "additionalFieldsToCollect",
    "processingFee",
    "infoFeeIndicator",
    "sendAmounts",
    "receiveAmounts",
    "exchangeRateApplied",
    "confirmationNumber",
    "receipts"
})
public class BpValidationResponse
    extends Response
{

    @XmlElement(required = true)
    protected String mgiTransactionSessionID;
    protected BigDecimal totalSendAmount;
    protected String mgiRewardsNumber;
    @XmlElement(required = true)
    @XmlSchemaType(name = "string")
    protected ProductVariant productVariant;
    protected String serviceOfferingID;
    protected String billerWebsite;
    protected String billerPhone;
    protected List<TextTranslation> expectedPostingTimeFrame;
    protected String billerCutoffTime;
    protected List<TextTranslation> billerNotes;
    protected List<TextTranslation> serviceOfferingDescription;
    protected List<TextTranslation> customerTips;
    protected String billerAddress;
    protected String billerAddress2;
    protected String billerAddress3;
    protected String billerCity;
    protected String billerState;
    protected String billerZip;
    protected Boolean printMGICustomerServiceNumber;
    protected String agentTransactionId;
    protected List<PromotionInfo> promotionInfo;
    protected List<TextTranslation> promotionalMessage;
    protected Boolean readyForCommit;
    protected List<TextTranslation> disclosureText;
    protected List<ProductFieldInfo> additionalFieldsToCollect;
    protected BigDecimal processingFee;
    protected Boolean infoFeeIndicator;
    protected SendAmountInfo sendAmounts;
    protected ReceiveAmountInfo receiveAmounts;
    protected BigDecimal exchangeRateApplied;
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
     * Gets the value of the totalSendAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getTotalSendAmount() {
        return totalSendAmount;
    }

    /**
     * Sets the value of the totalSendAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setTotalSendAmount(BigDecimal value) {
        this.totalSendAmount = value;
    }

    /**
     * Gets the value of the mgiRewardsNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMgiRewardsNumber() {
        return mgiRewardsNumber;
    }

    /**
     * Sets the value of the mgiRewardsNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMgiRewardsNumber(String value) {
        this.mgiRewardsNumber = value;
    }

    /**
     * Gets the value of the productVariant property.
     * 
     * @return
     *     possible object is
     *     {@link ProductVariant }
     *     
     */
    public ProductVariant getProductVariant() {
        return productVariant;
    }

    /**
     * Sets the value of the productVariant property.
     * 
     * @param value
     *     allowed object is
     *     {@link ProductVariant }
     *     
     */
    public void setProductVariant(ProductVariant value) {
        this.productVariant = value;
    }

    /**
     * Gets the value of the serviceOfferingID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getServiceOfferingID() {
        return serviceOfferingID;
    }

    /**
     * Sets the value of the serviceOfferingID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setServiceOfferingID(String value) {
        this.serviceOfferingID = value;
    }

    /**
     * Gets the value of the billerWebsite property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillerWebsite() {
        return billerWebsite;
    }

    /**
     * Sets the value of the billerWebsite property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillerWebsite(String value) {
        this.billerWebsite = value;
    }

    /**
     * Gets the value of the billerPhone property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillerPhone() {
        return billerPhone;
    }

    /**
     * Sets the value of the billerPhone property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillerPhone(String value) {
        this.billerPhone = value;
    }

    /**
     * Gets the value of the expectedPostingTimeFrame property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the expectedPostingTimeFrame property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getExpectedPostingTimeFrame().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link TextTranslation }
     * 
     * 
     */
    public List<TextTranslation> getExpectedPostingTimeFrame() {
        if (expectedPostingTimeFrame == null) {
            expectedPostingTimeFrame = new ArrayList<TextTranslation>();
        }
        return this.expectedPostingTimeFrame;
    }

    /**
     * Gets the value of the billerCutoffTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillerCutoffTime() {
        return billerCutoffTime;
    }

    /**
     * Sets the value of the billerCutoffTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillerCutoffTime(String value) {
        this.billerCutoffTime = value;
    }

    /**
     * Gets the value of the billerNotes property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the billerNotes property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getBillerNotes().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link TextTranslation }
     * 
     * 
     */
    public List<TextTranslation> getBillerNotes() {
        if (billerNotes == null) {
            billerNotes = new ArrayList<TextTranslation>();
        }
        return this.billerNotes;
    }

    /**
     * Gets the value of the serviceOfferingDescription property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the serviceOfferingDescription property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getServiceOfferingDescription().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link TextTranslation }
     * 
     * 
     */
    public List<TextTranslation> getServiceOfferingDescription() {
        if (serviceOfferingDescription == null) {
            serviceOfferingDescription = new ArrayList<TextTranslation>();
        }
        return this.serviceOfferingDescription;
    }

    /**
     * Gets the value of the customerTips property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the customerTips property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getCustomerTips().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link TextTranslation }
     * 
     * 
     */
    public List<TextTranslation> getCustomerTips() {
        if (customerTips == null) {
            customerTips = new ArrayList<TextTranslation>();
        }
        return this.customerTips;
    }

    /**
     * Gets the value of the billerAddress property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillerAddress() {
        return billerAddress;
    }

    /**
     * Sets the value of the billerAddress property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillerAddress(String value) {
        this.billerAddress = value;
    }

    /**
     * Gets the value of the billerAddress2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillerAddress2() {
        return billerAddress2;
    }

    /**
     * Sets the value of the billerAddress2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillerAddress2(String value) {
        this.billerAddress2 = value;
    }

    /**
     * Gets the value of the billerAddress3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillerAddress3() {
        return billerAddress3;
    }

    /**
     * Sets the value of the billerAddress3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillerAddress3(String value) {
        this.billerAddress3 = value;
    }

    /**
     * Gets the value of the billerCity property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillerCity() {
        return billerCity;
    }

    /**
     * Sets the value of the billerCity property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillerCity(String value) {
        this.billerCity = value;
    }

    /**
     * Gets the value of the billerState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillerState() {
        return billerState;
    }

    /**
     * Sets the value of the billerState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillerState(String value) {
        this.billerState = value;
    }

    /**
     * Gets the value of the billerZip property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillerZip() {
        return billerZip;
    }

    /**
     * Sets the value of the billerZip property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillerZip(String value) {
        this.billerZip = value;
    }

    /**
     * Gets the value of the printMGICustomerServiceNumber property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isPrintMGICustomerServiceNumber() {
        return printMGICustomerServiceNumber;
    }

    /**
     * Sets the value of the printMGICustomerServiceNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setPrintMGICustomerServiceNumber(Boolean value) {
        this.printMGICustomerServiceNumber = value;
    }

    /**
     * Gets the value of the agentTransactionId property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAgentTransactionId() {
        return agentTransactionId;
    }

    /**
     * Sets the value of the agentTransactionId property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAgentTransactionId(String value) {
        this.agentTransactionId = value;
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
     * Gets the value of the processingFee property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getProcessingFee() {
        return processingFee;
    }

    /**
     * Sets the value of the processingFee property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setProcessingFee(BigDecimal value) {
        this.processingFee = value;
    }

    /**
     * Gets the value of the infoFeeIndicator property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isInfoFeeIndicator() {
        return infoFeeIndicator;
    }

    /**
     * Sets the value of the infoFeeIndicator property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setInfoFeeIndicator(Boolean value) {
        this.infoFeeIndicator = value;
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
