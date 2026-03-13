
package com.moneygram.agentconnect1512;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.xml.datatype.XMLGregorianCalendar;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for DetailLookupResponse complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="DetailLookupResponse"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Response"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="mgiTransactionSessionID" type="{http://www.moneygram.com/AgentConnect1512}mgiTransactionSessionID" minOccurs="0"/&gt;
 *         &lt;element name="transactionStatus" type="{http://www.moneygram.com/AgentConnect1512}transactionStatus"/&gt;
 *         &lt;element name="dateTimeSent" type="{http://www.w3.org/2001/XMLSchema}dateTime"/&gt;
 *         &lt;element name="referenceNumber" type="{http://www.moneygram.com/AgentConnect1512}referenceNumber" minOccurs="0"/&gt;
 *         &lt;element name="freqCustCardNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="receiveCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType"/&gt;
 *         &lt;element name="deliveryOption" type="{http://www.moneygram.com/AgentConnect1512}deliveryOption" minOccurs="0"/&gt;
 *         &lt;element name="senderFirstName" type="{http://www.moneygram.com/AgentConnect1512}fNameType40" minOccurs="0"/&gt;
 *         &lt;element name="senderMiddleName" type="{http://www.moneygram.com/AgentConnect1512}mNameType40" minOccurs="0"/&gt;
 *         &lt;element name="senderLastName" type="{http://www.moneygram.com/AgentConnect1512}lNameType40" minOccurs="0"/&gt;
 *         &lt;element name="senderLastName2" type="{http://www.moneygram.com/AgentConnect1512}lNameType40" minOccurs="0"/&gt;
 *         &lt;element name="senderAddress" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="senderAddress2" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="senderAddress3" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="senderCity" type="{http://www.moneygram.com/AgentConnect1512}cityTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="senderState" type="{http://www.moneygram.com/AgentConnect1512}stateType" minOccurs="0"/&gt;
 *         &lt;element name="senderZipCode" type="{http://www.moneygram.com/AgentConnect1512}zipType" minOccurs="0"/&gt;
 *         &lt;element name="senderCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="senderHomePhone" type="{http://www.moneygram.com/AgentConnect1512}phoneType14" minOccurs="0"/&gt;
 *         &lt;element name="receiverFirstName" type="{http://www.moneygram.com/AgentConnect1512}fNameType40" minOccurs="0"/&gt;
 *         &lt;element name="receiverMiddleName" type="{http://www.moneygram.com/AgentConnect1512}mNameType40" minOccurs="0"/&gt;
 *         &lt;element name="receiverLastName" type="{http://www.moneygram.com/AgentConnect1512}lNameType40" minOccurs="0"/&gt;
 *         &lt;element name="receiverLastName2" type="{http://www.moneygram.com/AgentConnect1512}lNameType40" minOccurs="0"/&gt;
 *         &lt;element name="receiverAddress" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="receiverAddress2" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="receiverAddress3" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="receiverCity" type="{http://www.moneygram.com/AgentConnect1512}cityTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="receiverState" type="{http://www.moneygram.com/AgentConnect1512}stateTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="receiverZipCode" type="{http://www.moneygram.com/AgentConnect1512}zipType" minOccurs="0"/&gt;
 *         &lt;element name="receiverCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="receiverPhone" type="{http://www.moneygram.com/AgentConnect1512}phoneType14" minOccurs="0"/&gt;
 *         &lt;element name="direction1" type="{http://www.moneygram.com/AgentConnect1512}directionType" minOccurs="0"/&gt;
 *         &lt;element name="direction2" type="{http://www.moneygram.com/AgentConnect1512}directionType" minOccurs="0"/&gt;
 *         &lt;element name="direction3" type="{http://www.moneygram.com/AgentConnect1512}directionType" minOccurs="0"/&gt;
 *         &lt;element name="testQuestion" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="testAnswer" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="messageField1" type="{http://www.moneygram.com/AgentConnect1512}stringMax40" minOccurs="0"/&gt;
 *         &lt;element name="messageField2" type="{http://www.moneygram.com/AgentConnect1512}stringMax40" minOccurs="0"/&gt;
 *         &lt;element name="senderPhotoIdType" type="{http://www.moneygram.com/AgentConnect1512}photoIdType" minOccurs="0"/&gt;
 *         &lt;element name="senderPhotoIdNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax25" minOccurs="0"/&gt;
 *         &lt;element name="senderPhotoIdState" type="{http://www.moneygram.com/AgentConnect1512}stateType" minOccurs="0"/&gt;
 *         &lt;element name="senderPhotoIdCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="senderLegalIdType" type="{http://www.moneygram.com/AgentConnect1512}legalIdType" minOccurs="0"/&gt;
 *         &lt;element name="senderLegalIdNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="senderDOB" type="{http://www.w3.org/2001/XMLSchema}date" minOccurs="0"/&gt;
 *         &lt;element name="senderOccupation" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyFirstName" type="{http://www.moneygram.com/AgentConnect1512}fNameType40" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyMiddleName" type="{http://www.moneygram.com/AgentConnect1512}mNameType40" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLastName" type="{http://www.moneygram.com/AgentConnect1512}lNameType40" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLastName2" type="{http://www.moneygram.com/AgentConnect1512}lNameType40" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyAddress" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyAddress2" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyAddress3" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyCity" type="{http://www.moneygram.com/AgentConnect1512}cityTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyState" type="{http://www.moneygram.com/AgentConnect1512}stateType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyZipCode" type="{http://www.moneygram.com/AgentConnect1512}zipType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyDOB" type="{http://www.w3.org/2001/XMLSchema}date" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdType" type="{http://www.moneygram.com/AgentConnect1512}legalIdType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyOccupation" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyOrg" type="{http://www.moneygram.com/AgentConnect1512}stringMax60" minOccurs="0"/&gt;
 *         &lt;element name="senderBirthCity" type="{http://www.moneygram.com/AgentConnect1512}cityTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="senderBirthCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="senderPassportIssueDate" type="{http://www.w3.org/2001/XMLSchema}date" minOccurs="0"/&gt;
 *         &lt;element name="senderPassportIssueCity" type="{http://www.moneygram.com/AgentConnect1512}cityTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="senderPassportIssueCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="operatorName" type="{http://www.moneygram.com/AgentConnect1512}stringMax7" minOccurs="0"/&gt;
 *         &lt;element name="validIndicator" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="agentUseSendData" type="{http://www.moneygram.com/AgentConnect1512}stringMax200" minOccurs="0"/&gt;
 *         &lt;element name="customerReceiveNumber" type="{http://www.moneygram.com/AgentConnect1512}customerReceiveNumber" minOccurs="0"/&gt;
 *         &lt;element name="receiveAgentID" type="{http://www.moneygram.com/AgentConnect1512}agentID" minOccurs="0"/&gt;
 *         &lt;element name="receiveAgentName" type="{http://www.moneygram.com/AgentConnect1512}stringMax40" minOccurs="0"/&gt;
 *         &lt;element name="receiveAgentAbbreviation" type="{http://www.moneygram.com/AgentConnect1512}stringMax10" minOccurs="0"/&gt;
 *         &lt;element name="expectedDateOfDelivery" type="{http://www.w3.org/2001/XMLSchema}date" minOccurs="0"/&gt;
 *         &lt;element name="redirectIndicator" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="redirectInfo" type="{http://www.moneygram.com/AgentConnect1512}RedirectInfo" minOccurs="0"/&gt;
 *         &lt;element name="agentCheckAuthorizationNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax5" minOccurs="0"/&gt;
 *         &lt;element name="accountNickname" type="{http://www.moneygram.com/AgentConnect1512}accountNickname" minOccurs="0"/&gt;
 *         &lt;element name="promotionInfo" type="{http://www.moneygram.com/AgentConnect1512}PromotionInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="disclosureText" type="{http://www.moneygram.com/AgentConnect1512}TextTranslation" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="feeRefundRequired" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="sendAmounts" type="{http://www.moneygram.com/AgentConnect1512}SendAmountInfo" minOccurs="0"/&gt;
 *         &lt;element name="receiveAmounts" type="{http://www.moneygram.com/AgentConnect1512}ReceiveAmountInfo" minOccurs="0"/&gt;
 *         &lt;element name="exchangeRateApplied" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="referenceNumberTextCode" type="{http://www.moneygram.com/AgentConnect1512}referenceNumberTextCodeType" minOccurs="0"/&gt;
 *         &lt;element name="referenceNumberText" type="{http://www.moneygram.com/AgentConnect1512}referenceNumberTextType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "DetailLookupResponse", propOrder = {
    "mgiTransactionSessionID",
    "transactionStatus",
    "dateTimeSent",
    "referenceNumber",
    "freqCustCardNumber",
    "receiveCountry",
    "deliveryOption",
    "senderFirstName",
    "senderMiddleName",
    "senderLastName",
    "senderLastName2",
    "senderAddress",
    "senderAddress2",
    "senderAddress3",
    "senderCity",
    "senderState",
    "senderZipCode",
    "senderCountry",
    "senderHomePhone",
    "receiverFirstName",
    "receiverMiddleName",
    "receiverLastName",
    "receiverLastName2",
    "receiverAddress",
    "receiverAddress2",
    "receiverAddress3",
    "receiverCity",
    "receiverState",
    "receiverZipCode",
    "receiverCountry",
    "receiverPhone",
    "direction1",
    "direction2",
    "direction3",
    "testQuestion",
    "testAnswer",
    "messageField1",
    "messageField2",
    "senderPhotoIdType",
    "senderPhotoIdNumber",
    "senderPhotoIdState",
    "senderPhotoIdCountry",
    "senderLegalIdType",
    "senderLegalIdNumber",
    "senderDOB",
    "senderOccupation",
    "thirdPartyFirstName",
    "thirdPartyMiddleName",
    "thirdPartyLastName",
    "thirdPartyLastName2",
    "thirdPartyAddress",
    "thirdPartyAddress2",
    "thirdPartyAddress3",
    "thirdPartyCity",
    "thirdPartyState",
    "thirdPartyCountry",
    "thirdPartyZipCode",
    "thirdPartyDOB",
    "thirdPartyLegalIdType",
    "thirdPartyLegalIdNumber",
    "thirdPartyOccupation",
    "thirdPartyOrg",
    "senderBirthCity",
    "senderBirthCountry",
    "senderPassportIssueDate",
    "senderPassportIssueCity",
    "senderPassportIssueCountry",
    "operatorName",
    "validIndicator",
    "agentUseSendData",
    "customerReceiveNumber",
    "receiveAgentID",
    "receiveAgentName",
    "receiveAgentAbbreviation",
    "expectedDateOfDelivery",
    "redirectIndicator",
    "redirectInfo",
    "agentCheckAuthorizationNumber",
    "accountNickname",
    "promotionInfo",
    "disclosureText",
    "feeRefundRequired",
    "sendAmounts",
    "receiveAmounts",
    "exchangeRateApplied",
    "referenceNumberTextCode",
    "referenceNumberText"
})
public class DetailLookupResponse
    extends Response
{

    protected String mgiTransactionSessionID;
    @XmlElement(required = true)
    @XmlSchemaType(name = "string")
    protected TransactionStatus transactionStatus;
    @XmlElement(required = true)
    @XmlSchemaType(name = "dateTime")
    protected XMLGregorianCalendar dateTimeSent;
    protected String referenceNumber;
    protected String freqCustCardNumber;
    @XmlElement(required = true)
    protected String receiveCountry;
    protected String deliveryOption;
    protected String senderFirstName;
    protected String senderMiddleName;
    protected String senderLastName;
    protected String senderLastName2;
    protected String senderAddress;
    protected String senderAddress2;
    protected String senderAddress3;
    protected String senderCity;
    protected String senderState;
    protected String senderZipCode;
    protected String senderCountry;
    protected String senderHomePhone;
    protected String receiverFirstName;
    protected String receiverMiddleName;
    protected String receiverLastName;
    protected String receiverLastName2;
    protected String receiverAddress;
    protected String receiverAddress2;
    protected String receiverAddress3;
    protected String receiverCity;
    protected String receiverState;
    protected String receiverZipCode;
    protected String receiverCountry;
    protected String receiverPhone;
    protected String direction1;
    protected String direction2;
    protected String direction3;
    protected String testQuestion;
    protected String testAnswer;
    protected String messageField1;
    protected String messageField2;
    protected String senderPhotoIdType;
    protected String senderPhotoIdNumber;
    protected String senderPhotoIdState;
    protected String senderPhotoIdCountry;
    protected String senderLegalIdType;
    protected String senderLegalIdNumber;
    @XmlSchemaType(name = "date")
    protected XMLGregorianCalendar senderDOB;
    protected String senderOccupation;
    protected String thirdPartyFirstName;
    protected String thirdPartyMiddleName;
    protected String thirdPartyLastName;
    protected String thirdPartyLastName2;
    protected String thirdPartyAddress;
    protected String thirdPartyAddress2;
    protected String thirdPartyAddress3;
    protected String thirdPartyCity;
    protected String thirdPartyState;
    protected String thirdPartyCountry;
    protected String thirdPartyZipCode;
    @XmlSchemaType(name = "date")
    protected XMLGregorianCalendar thirdPartyDOB;
    protected String thirdPartyLegalIdType;
    protected String thirdPartyLegalIdNumber;
    protected String thirdPartyOccupation;
    protected String thirdPartyOrg;
    protected String senderBirthCity;
    protected String senderBirthCountry;
    @XmlSchemaType(name = "date")
    protected XMLGregorianCalendar senderPassportIssueDate;
    protected String senderPassportIssueCity;
    protected String senderPassportIssueCountry;
    protected String operatorName;
    protected Boolean validIndicator;
    protected String agentUseSendData;
    protected String customerReceiveNumber;
    protected String receiveAgentID;
    protected String receiveAgentName;
    protected String receiveAgentAbbreviation;
    @XmlSchemaType(name = "date")
    protected XMLGregorianCalendar expectedDateOfDelivery;
    protected Boolean redirectIndicator;
    protected RedirectInfo redirectInfo;
    protected String agentCheckAuthorizationNumber;
    protected String accountNickname;
    protected List<PromotionInfo> promotionInfo;
    protected List<TextTranslation> disclosureText;
    protected Boolean feeRefundRequired;
    protected SendAmountInfo sendAmounts;
    protected ReceiveAmountInfo receiveAmounts;
    protected BigDecimal exchangeRateApplied;
    protected String referenceNumberTextCode;
    protected String referenceNumberText;

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
     * Gets the value of the transactionStatus property.
     * 
     * @return
     *     possible object is
     *     {@link TransactionStatus }
     *     
     */
    public TransactionStatus getTransactionStatus() {
        return transactionStatus;
    }

    /**
     * Sets the value of the transactionStatus property.
     * 
     * @param value
     *     allowed object is
     *     {@link TransactionStatus }
     *     
     */
    public void setTransactionStatus(TransactionStatus value) {
        this.transactionStatus = value;
    }

    /**
     * Gets the value of the dateTimeSent property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getDateTimeSent() {
        return dateTimeSent;
    }

    /**
     * Sets the value of the dateTimeSent property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setDateTimeSent(XMLGregorianCalendar value) {
        this.dateTimeSent = value;
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
     * Gets the value of the freqCustCardNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFreqCustCardNumber() {
        return freqCustCardNumber;
    }

    /**
     * Sets the value of the freqCustCardNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFreqCustCardNumber(String value) {
        this.freqCustCardNumber = value;
    }

    /**
     * Gets the value of the receiveCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiveCountry() {
        return receiveCountry;
    }

    /**
     * Sets the value of the receiveCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiveCountry(String value) {
        this.receiveCountry = value;
    }

    /**
     * Gets the value of the deliveryOption property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDeliveryOption() {
        return deliveryOption;
    }

    /**
     * Sets the value of the deliveryOption property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDeliveryOption(String value) {
        this.deliveryOption = value;
    }

    /**
     * Gets the value of the senderFirstName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderFirstName() {
        return senderFirstName;
    }

    /**
     * Sets the value of the senderFirstName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderFirstName(String value) {
        this.senderFirstName = value;
    }

    /**
     * Gets the value of the senderMiddleName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderMiddleName() {
        return senderMiddleName;
    }

    /**
     * Sets the value of the senderMiddleName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderMiddleName(String value) {
        this.senderMiddleName = value;
    }

    /**
     * Gets the value of the senderLastName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderLastName() {
        return senderLastName;
    }

    /**
     * Sets the value of the senderLastName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderLastName(String value) {
        this.senderLastName = value;
    }

    /**
     * Gets the value of the senderLastName2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderLastName2() {
        return senderLastName2;
    }

    /**
     * Sets the value of the senderLastName2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderLastName2(String value) {
        this.senderLastName2 = value;
    }

    /**
     * Gets the value of the senderAddress property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderAddress() {
        return senderAddress;
    }

    /**
     * Sets the value of the senderAddress property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderAddress(String value) {
        this.senderAddress = value;
    }

    /**
     * Gets the value of the senderAddress2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderAddress2() {
        return senderAddress2;
    }

    /**
     * Sets the value of the senderAddress2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderAddress2(String value) {
        this.senderAddress2 = value;
    }

    /**
     * Gets the value of the senderAddress3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderAddress3() {
        return senderAddress3;
    }

    /**
     * Sets the value of the senderAddress3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderAddress3(String value) {
        this.senderAddress3 = value;
    }

    /**
     * Gets the value of the senderCity property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderCity() {
        return senderCity;
    }

    /**
     * Sets the value of the senderCity property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderCity(String value) {
        this.senderCity = value;
    }

    /**
     * Gets the value of the senderState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderState() {
        return senderState;
    }

    /**
     * Sets the value of the senderState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderState(String value) {
        this.senderState = value;
    }

    /**
     * Gets the value of the senderZipCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderZipCode() {
        return senderZipCode;
    }

    /**
     * Sets the value of the senderZipCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderZipCode(String value) {
        this.senderZipCode = value;
    }

    /**
     * Gets the value of the senderCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderCountry() {
        return senderCountry;
    }

    /**
     * Sets the value of the senderCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderCountry(String value) {
        this.senderCountry = value;
    }

    /**
     * Gets the value of the senderHomePhone property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderHomePhone() {
        return senderHomePhone;
    }

    /**
     * Sets the value of the senderHomePhone property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderHomePhone(String value) {
        this.senderHomePhone = value;
    }

    /**
     * Gets the value of the receiverFirstName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverFirstName() {
        return receiverFirstName;
    }

    /**
     * Sets the value of the receiverFirstName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverFirstName(String value) {
        this.receiverFirstName = value;
    }

    /**
     * Gets the value of the receiverMiddleName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverMiddleName() {
        return receiverMiddleName;
    }

    /**
     * Sets the value of the receiverMiddleName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverMiddleName(String value) {
        this.receiverMiddleName = value;
    }

    /**
     * Gets the value of the receiverLastName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverLastName() {
        return receiverLastName;
    }

    /**
     * Sets the value of the receiverLastName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverLastName(String value) {
        this.receiverLastName = value;
    }

    /**
     * Gets the value of the receiverLastName2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverLastName2() {
        return receiverLastName2;
    }

    /**
     * Sets the value of the receiverLastName2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverLastName2(String value) {
        this.receiverLastName2 = value;
    }

    /**
     * Gets the value of the receiverAddress property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverAddress() {
        return receiverAddress;
    }

    /**
     * Sets the value of the receiverAddress property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverAddress(String value) {
        this.receiverAddress = value;
    }

    /**
     * Gets the value of the receiverAddress2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverAddress2() {
        return receiverAddress2;
    }

    /**
     * Sets the value of the receiverAddress2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverAddress2(String value) {
        this.receiverAddress2 = value;
    }

    /**
     * Gets the value of the receiverAddress3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverAddress3() {
        return receiverAddress3;
    }

    /**
     * Sets the value of the receiverAddress3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverAddress3(String value) {
        this.receiverAddress3 = value;
    }

    /**
     * Gets the value of the receiverCity property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverCity() {
        return receiverCity;
    }

    /**
     * Sets the value of the receiverCity property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverCity(String value) {
        this.receiverCity = value;
    }

    /**
     * Gets the value of the receiverState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverState() {
        return receiverState;
    }

    /**
     * Sets the value of the receiverState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverState(String value) {
        this.receiverState = value;
    }

    /**
     * Gets the value of the receiverZipCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverZipCode() {
        return receiverZipCode;
    }

    /**
     * Sets the value of the receiverZipCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverZipCode(String value) {
        this.receiverZipCode = value;
    }

    /**
     * Gets the value of the receiverCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverCountry() {
        return receiverCountry;
    }

    /**
     * Sets the value of the receiverCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverCountry(String value) {
        this.receiverCountry = value;
    }

    /**
     * Gets the value of the receiverPhone property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverPhone() {
        return receiverPhone;
    }

    /**
     * Sets the value of the receiverPhone property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverPhone(String value) {
        this.receiverPhone = value;
    }

    /**
     * Gets the value of the direction1 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDirection1() {
        return direction1;
    }

    /**
     * Sets the value of the direction1 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDirection1(String value) {
        this.direction1 = value;
    }

    /**
     * Gets the value of the direction2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDirection2() {
        return direction2;
    }

    /**
     * Sets the value of the direction2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDirection2(String value) {
        this.direction2 = value;
    }

    /**
     * Gets the value of the direction3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDirection3() {
        return direction3;
    }

    /**
     * Sets the value of the direction3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDirection3(String value) {
        this.direction3 = value;
    }

    /**
     * Gets the value of the testQuestion property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTestQuestion() {
        return testQuestion;
    }

    /**
     * Sets the value of the testQuestion property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTestQuestion(String value) {
        this.testQuestion = value;
    }

    /**
     * Gets the value of the testAnswer property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTestAnswer() {
        return testAnswer;
    }

    /**
     * Sets the value of the testAnswer property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTestAnswer(String value) {
        this.testAnswer = value;
    }

    /**
     * Gets the value of the messageField1 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMessageField1() {
        return messageField1;
    }

    /**
     * Sets the value of the messageField1 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMessageField1(String value) {
        this.messageField1 = value;
    }

    /**
     * Gets the value of the messageField2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMessageField2() {
        return messageField2;
    }

    /**
     * Sets the value of the messageField2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMessageField2(String value) {
        this.messageField2 = value;
    }

    /**
     * Gets the value of the senderPhotoIdType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderPhotoIdType() {
        return senderPhotoIdType;
    }

    /**
     * Sets the value of the senderPhotoIdType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderPhotoIdType(String value) {
        this.senderPhotoIdType = value;
    }

    /**
     * Gets the value of the senderPhotoIdNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderPhotoIdNumber() {
        return senderPhotoIdNumber;
    }

    /**
     * Sets the value of the senderPhotoIdNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderPhotoIdNumber(String value) {
        this.senderPhotoIdNumber = value;
    }

    /**
     * Gets the value of the senderPhotoIdState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderPhotoIdState() {
        return senderPhotoIdState;
    }

    /**
     * Sets the value of the senderPhotoIdState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderPhotoIdState(String value) {
        this.senderPhotoIdState = value;
    }

    /**
     * Gets the value of the senderPhotoIdCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderPhotoIdCountry() {
        return senderPhotoIdCountry;
    }

    /**
     * Sets the value of the senderPhotoIdCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderPhotoIdCountry(String value) {
        this.senderPhotoIdCountry = value;
    }

    /**
     * Gets the value of the senderLegalIdType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderLegalIdType() {
        return senderLegalIdType;
    }

    /**
     * Sets the value of the senderLegalIdType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderLegalIdType(String value) {
        this.senderLegalIdType = value;
    }

    /**
     * Gets the value of the senderLegalIdNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderLegalIdNumber() {
        return senderLegalIdNumber;
    }

    /**
     * Sets the value of the senderLegalIdNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderLegalIdNumber(String value) {
        this.senderLegalIdNumber = value;
    }

    /**
     * Gets the value of the senderDOB property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getSenderDOB() {
        return senderDOB;
    }

    /**
     * Sets the value of the senderDOB property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setSenderDOB(XMLGregorianCalendar value) {
        this.senderDOB = value;
    }

    /**
     * Gets the value of the senderOccupation property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderOccupation() {
        return senderOccupation;
    }

    /**
     * Sets the value of the senderOccupation property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderOccupation(String value) {
        this.senderOccupation = value;
    }

    /**
     * Gets the value of the thirdPartyFirstName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyFirstName() {
        return thirdPartyFirstName;
    }

    /**
     * Sets the value of the thirdPartyFirstName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyFirstName(String value) {
        this.thirdPartyFirstName = value;
    }

    /**
     * Gets the value of the thirdPartyMiddleName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyMiddleName() {
        return thirdPartyMiddleName;
    }

    /**
     * Sets the value of the thirdPartyMiddleName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyMiddleName(String value) {
        this.thirdPartyMiddleName = value;
    }

    /**
     * Gets the value of the thirdPartyLastName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyLastName() {
        return thirdPartyLastName;
    }

    /**
     * Sets the value of the thirdPartyLastName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyLastName(String value) {
        this.thirdPartyLastName = value;
    }

    /**
     * Gets the value of the thirdPartyLastName2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyLastName2() {
        return thirdPartyLastName2;
    }

    /**
     * Sets the value of the thirdPartyLastName2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyLastName2(String value) {
        this.thirdPartyLastName2 = value;
    }

    /**
     * Gets the value of the thirdPartyAddress property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyAddress() {
        return thirdPartyAddress;
    }

    /**
     * Sets the value of the thirdPartyAddress property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyAddress(String value) {
        this.thirdPartyAddress = value;
    }

    /**
     * Gets the value of the thirdPartyAddress2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyAddress2() {
        return thirdPartyAddress2;
    }

    /**
     * Sets the value of the thirdPartyAddress2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyAddress2(String value) {
        this.thirdPartyAddress2 = value;
    }

    /**
     * Gets the value of the thirdPartyAddress3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyAddress3() {
        return thirdPartyAddress3;
    }

    /**
     * Sets the value of the thirdPartyAddress3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyAddress3(String value) {
        this.thirdPartyAddress3 = value;
    }

    /**
     * Gets the value of the thirdPartyCity property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyCity() {
        return thirdPartyCity;
    }

    /**
     * Sets the value of the thirdPartyCity property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyCity(String value) {
        this.thirdPartyCity = value;
    }

    /**
     * Gets the value of the thirdPartyState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyState() {
        return thirdPartyState;
    }

    /**
     * Sets the value of the thirdPartyState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyState(String value) {
        this.thirdPartyState = value;
    }

    /**
     * Gets the value of the thirdPartyCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyCountry() {
        return thirdPartyCountry;
    }

    /**
     * Sets the value of the thirdPartyCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyCountry(String value) {
        this.thirdPartyCountry = value;
    }

    /**
     * Gets the value of the thirdPartyZipCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyZipCode() {
        return thirdPartyZipCode;
    }

    /**
     * Sets the value of the thirdPartyZipCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyZipCode(String value) {
        this.thirdPartyZipCode = value;
    }

    /**
     * Gets the value of the thirdPartyDOB property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getThirdPartyDOB() {
        return thirdPartyDOB;
    }

    /**
     * Sets the value of the thirdPartyDOB property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setThirdPartyDOB(XMLGregorianCalendar value) {
        this.thirdPartyDOB = value;
    }

    /**
     * Gets the value of the thirdPartyLegalIdType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyLegalIdType() {
        return thirdPartyLegalIdType;
    }

    /**
     * Sets the value of the thirdPartyLegalIdType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyLegalIdType(String value) {
        this.thirdPartyLegalIdType = value;
    }

    /**
     * Gets the value of the thirdPartyLegalIdNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyLegalIdNumber() {
        return thirdPartyLegalIdNumber;
    }

    /**
     * Sets the value of the thirdPartyLegalIdNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyLegalIdNumber(String value) {
        this.thirdPartyLegalIdNumber = value;
    }

    /**
     * Gets the value of the thirdPartyOccupation property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyOccupation() {
        return thirdPartyOccupation;
    }

    /**
     * Sets the value of the thirdPartyOccupation property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyOccupation(String value) {
        this.thirdPartyOccupation = value;
    }

    /**
     * Gets the value of the thirdPartyOrg property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyOrg() {
        return thirdPartyOrg;
    }

    /**
     * Sets the value of the thirdPartyOrg property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyOrg(String value) {
        this.thirdPartyOrg = value;
    }

    /**
     * Gets the value of the senderBirthCity property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderBirthCity() {
        return senderBirthCity;
    }

    /**
     * Sets the value of the senderBirthCity property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderBirthCity(String value) {
        this.senderBirthCity = value;
    }

    /**
     * Gets the value of the senderBirthCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderBirthCountry() {
        return senderBirthCountry;
    }

    /**
     * Sets the value of the senderBirthCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderBirthCountry(String value) {
        this.senderBirthCountry = value;
    }

    /**
     * Gets the value of the senderPassportIssueDate property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getSenderPassportIssueDate() {
        return senderPassportIssueDate;
    }

    /**
     * Sets the value of the senderPassportIssueDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setSenderPassportIssueDate(XMLGregorianCalendar value) {
        this.senderPassportIssueDate = value;
    }

    /**
     * Gets the value of the senderPassportIssueCity property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderPassportIssueCity() {
        return senderPassportIssueCity;
    }

    /**
     * Sets the value of the senderPassportIssueCity property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderPassportIssueCity(String value) {
        this.senderPassportIssueCity = value;
    }

    /**
     * Gets the value of the senderPassportIssueCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderPassportIssueCountry() {
        return senderPassportIssueCountry;
    }

    /**
     * Sets the value of the senderPassportIssueCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderPassportIssueCountry(String value) {
        this.senderPassportIssueCountry = value;
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
     * Gets the value of the validIndicator property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isValidIndicator() {
        return validIndicator;
    }

    /**
     * Sets the value of the validIndicator property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setValidIndicator(Boolean value) {
        this.validIndicator = value;
    }

    /**
     * Gets the value of the agentUseSendData property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAgentUseSendData() {
        return agentUseSendData;
    }

    /**
     * Sets the value of the agentUseSendData property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAgentUseSendData(String value) {
        this.agentUseSendData = value;
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
     * Gets the value of the receiveAgentID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiveAgentID() {
        return receiveAgentID;
    }

    /**
     * Sets the value of the receiveAgentID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiveAgentID(String value) {
        this.receiveAgentID = value;
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
     * Gets the value of the receiveAgentAbbreviation property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiveAgentAbbreviation() {
        return receiveAgentAbbreviation;
    }

    /**
     * Sets the value of the receiveAgentAbbreviation property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiveAgentAbbreviation(String value) {
        this.receiveAgentAbbreviation = value;
    }

    /**
     * Gets the value of the expectedDateOfDelivery property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getExpectedDateOfDelivery() {
        return expectedDateOfDelivery;
    }

    /**
     * Sets the value of the expectedDateOfDelivery property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setExpectedDateOfDelivery(XMLGregorianCalendar value) {
        this.expectedDateOfDelivery = value;
    }

    /**
     * Gets the value of the redirectIndicator property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isRedirectIndicator() {
        return redirectIndicator;
    }

    /**
     * Sets the value of the redirectIndicator property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setRedirectIndicator(Boolean value) {
        this.redirectIndicator = value;
    }

    /**
     * Gets the value of the redirectInfo property.
     * 
     * @return
     *     possible object is
     *     {@link RedirectInfo }
     *     
     */
    public RedirectInfo getRedirectInfo() {
        return redirectInfo;
    }

    /**
     * Sets the value of the redirectInfo property.
     * 
     * @param value
     *     allowed object is
     *     {@link RedirectInfo }
     *     
     */
    public void setRedirectInfo(RedirectInfo value) {
        this.redirectInfo = value;
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
     * Gets the value of the feeRefundRequired property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isFeeRefundRequired() {
        return feeRefundRequired;
    }

    /**
     * Sets the value of the feeRefundRequired property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setFeeRefundRequired(Boolean value) {
        this.feeRefundRequired = value;
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
     * Gets the value of the referenceNumberTextCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReferenceNumberTextCode() {
        return referenceNumberTextCode;
    }

    /**
     * Sets the value of the referenceNumberTextCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReferenceNumberTextCode(String value) {
        this.referenceNumberTextCode = value;
    }

    /**
     * Gets the value of the referenceNumberText property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReferenceNumberText() {
        return referenceNumberText;
    }

    /**
     * Sets the value of the referenceNumberText property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReferenceNumberText(String value) {
        this.referenceNumberText = value;
    }

}
