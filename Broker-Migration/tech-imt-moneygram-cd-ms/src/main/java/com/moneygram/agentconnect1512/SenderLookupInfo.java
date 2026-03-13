
package com.moneygram.agentconnect1512;

import java.util.ArrayList;
import java.util.List;
import javax.xml.datatype.XMLGregorianCalendar;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;
import jakarta.xml.bind.annotation.adapters.CollapsedStringAdapter;
import jakarta.xml.bind.annotation.adapters.XmlJavaTypeAdapter;


/**
 * <p>Java class for SenderLookupInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="SenderLookupInfo"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="senderFirstName" type="{http://www.moneygram.com/AgentConnect1512}fNameType40" minOccurs="0"/&gt;
 *         &lt;element name="senderMiddleName" type="{http://www.moneygram.com/AgentConnect1512}mNameType40" minOccurs="0"/&gt;
 *         &lt;element name="senderLastName" type="{http://www.moneygram.com/AgentConnect1512}lNameType40" minOccurs="0"/&gt;
 *         &lt;element name="senderLastName2" type="{http://www.moneygram.com/AgentConnect1512}lNameType40" minOccurs="0"/&gt;
 *         &lt;element name="senderAddress" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="senderAddress2" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="senderAddress3" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="senderAddress4" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="senderCity" type="{http://www.moneygram.com/AgentConnect1512}cityTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="senderState" type="{http://www.moneygram.com/AgentConnect1512}stateType" minOccurs="0"/&gt;
 *         &lt;element name="senderZipCode" type="{http://www.moneygram.com/AgentConnect1512}zipType" minOccurs="0"/&gt;
 *         &lt;element name="senderCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="senderHomePhone" type="{http://www.moneygram.com/AgentConnect1512}phoneType14" minOccurs="0"/&gt;
 *         &lt;element name="freqCustCardNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="agentFrequentCustomerNumber" type="{http://www.moneygram.com/AgentConnect1512}agentFrequentCustomerNumber" minOccurs="0"/&gt;
 *         &lt;element name="consumerId" type="{http://www.moneygram.com/AgentConnect1512}consumerId" minOccurs="0"/&gt;
 *         &lt;element name="senderBirthCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="senderDOB" type="{http://www.w3.org/2001/XMLSchema}date" minOccurs="0"/&gt;
 *         &lt;element name="senderHomePhoneCountryCode" type="{http://www.moneygram.com/AgentConnect1512}countryCodeType" minOccurs="0"/&gt;
 *         &lt;element name="senderTransactionEmailNotificationOptIn" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="senderTransactionSMSNotificationOptIn" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="senderMarketingEmailNotificationOptIn" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="senderMarketingSMSNotificationOptIn" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="senderEmailAddress" type="{http://www.moneygram.com/AgentConnect1512}emailType" minOccurs="0"/&gt;
 *         &lt;element name="senderMobilePhone" type="{http://www.moneygram.com/AgentConnect1512}phoneType14" minOccurs="0"/&gt;
 *         &lt;element name="receiverInfo" type="{http://www.moneygram.com/AgentConnect1512}ReceiverLookupInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="billerInfo" type="{http://www.moneygram.com/AgentConnect1512}BillerLookupInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "SenderLookupInfo", propOrder = {
    "senderFirstName",
    "senderMiddleName",
    "senderLastName",
    "senderLastName2",
    "senderAddress",
    "senderAddress2",
    "senderAddress3",
    "senderAddress4",
    "senderCity",
    "senderState",
    "senderZipCode",
    "senderCountry",
    "senderHomePhone",
    "freqCustCardNumber",
    "agentFrequentCustomerNumber",
    "consumerId",
    "senderBirthCountry",
    "senderDOB",
    "senderHomePhoneCountryCode",
    "senderTransactionEmailNotificationOptIn",
    "senderTransactionSMSNotificationOptIn",
    "senderMarketingEmailNotificationOptIn",
    "senderMarketingSMSNotificationOptIn",
    "senderEmailAddress",
    "senderMobilePhone",
    "receiverInfo",
    "billerInfo"
})
public class SenderLookupInfo {

    protected String senderFirstName;
    protected String senderMiddleName;
    protected String senderLastName;
    protected String senderLastName2;
    protected String senderAddress;
    protected String senderAddress2;
    protected String senderAddress3;
    protected String senderAddress4;
    protected String senderCity;
    protected String senderState;
    protected String senderZipCode;
    protected String senderCountry;
    protected String senderHomePhone;
    protected String freqCustCardNumber;
    protected String agentFrequentCustomerNumber;
    protected String consumerId;
    protected String senderBirthCountry;
    @XmlSchemaType(name = "date")
    protected XMLGregorianCalendar senderDOB;
    protected String senderHomePhoneCountryCode;
    protected Boolean senderTransactionEmailNotificationOptIn;
    protected Boolean senderTransactionSMSNotificationOptIn;
    protected Boolean senderMarketingEmailNotificationOptIn;
    protected Boolean senderMarketingSMSNotificationOptIn;
    @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
    @XmlSchemaType(name = "token")
    protected String senderEmailAddress;
    protected String senderMobilePhone;
    protected List<ReceiverLookupInfo> receiverInfo;
    protected List<BillerLookupInfo> billerInfo;

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
     * Gets the value of the senderAddress4 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderAddress4() {
        return senderAddress4;
    }

    /**
     * Sets the value of the senderAddress4 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderAddress4(String value) {
        this.senderAddress4 = value;
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
     * Gets the value of the agentFrequentCustomerNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAgentFrequentCustomerNumber() {
        return agentFrequentCustomerNumber;
    }

    /**
     * Sets the value of the agentFrequentCustomerNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAgentFrequentCustomerNumber(String value) {
        this.agentFrequentCustomerNumber = value;
    }

    /**
     * Gets the value of the consumerId property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerId() {
        return consumerId;
    }

    /**
     * Sets the value of the consumerId property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerId(String value) {
        this.consumerId = value;
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
     * Gets the value of the senderHomePhoneCountryCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderHomePhoneCountryCode() {
        return senderHomePhoneCountryCode;
    }

    /**
     * Sets the value of the senderHomePhoneCountryCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderHomePhoneCountryCode(String value) {
        this.senderHomePhoneCountryCode = value;
    }

    /**
     * Gets the value of the senderTransactionEmailNotificationOptIn property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isSenderTransactionEmailNotificationOptIn() {
        return senderTransactionEmailNotificationOptIn;
    }

    /**
     * Sets the value of the senderTransactionEmailNotificationOptIn property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setSenderTransactionEmailNotificationOptIn(Boolean value) {
        this.senderTransactionEmailNotificationOptIn = value;
    }

    /**
     * Gets the value of the senderTransactionSMSNotificationOptIn property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isSenderTransactionSMSNotificationOptIn() {
        return senderTransactionSMSNotificationOptIn;
    }

    /**
     * Sets the value of the senderTransactionSMSNotificationOptIn property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setSenderTransactionSMSNotificationOptIn(Boolean value) {
        this.senderTransactionSMSNotificationOptIn = value;
    }

    /**
     * Gets the value of the senderMarketingEmailNotificationOptIn property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isSenderMarketingEmailNotificationOptIn() {
        return senderMarketingEmailNotificationOptIn;
    }

    /**
     * Sets the value of the senderMarketingEmailNotificationOptIn property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setSenderMarketingEmailNotificationOptIn(Boolean value) {
        this.senderMarketingEmailNotificationOptIn = value;
    }

    /**
     * Gets the value of the senderMarketingSMSNotificationOptIn property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isSenderMarketingSMSNotificationOptIn() {
        return senderMarketingSMSNotificationOptIn;
    }

    /**
     * Sets the value of the senderMarketingSMSNotificationOptIn property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setSenderMarketingSMSNotificationOptIn(Boolean value) {
        this.senderMarketingSMSNotificationOptIn = value;
    }

    /**
     * Gets the value of the senderEmailAddress property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderEmailAddress() {
        return senderEmailAddress;
    }

    /**
     * Sets the value of the senderEmailAddress property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderEmailAddress(String value) {
        this.senderEmailAddress = value;
    }

    /**
     * Gets the value of the senderMobilePhone property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderMobilePhone() {
        return senderMobilePhone;
    }

    /**
     * Sets the value of the senderMobilePhone property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderMobilePhone(String value) {
        this.senderMobilePhone = value;
    }

    /**
     * Gets the value of the receiverInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the receiverInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getReceiverInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ReceiverLookupInfo }
     * 
     * 
     */
    public List<ReceiverLookupInfo> getReceiverInfo() {
        if (receiverInfo == null) {
            receiverInfo = new ArrayList<ReceiverLookupInfo>();
        }
        return this.receiverInfo;
    }

    /**
     * Gets the value of the billerInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the billerInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getBillerInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link BillerLookupInfo }
     * 
     * 
     */
    public List<BillerLookupInfo> getBillerInfo() {
        if (billerInfo == null) {
            billerInfo = new ArrayList<BillerLookupInfo>();
        }
        return this.billerInfo;
    }

}
