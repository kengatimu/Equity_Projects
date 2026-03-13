
package com.huawei.cps.cpsinterface.common;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Reminder Schedule的信息
 * 
 * <p>Java class for ReminderScheduleInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ReminderScheduleInfo"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="ServiceForInitiateTransaction" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="Currency" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="Amount" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="PrimaryParty" type="{http://cps.huawei.com/cpsinterface/common}PrimaryParty" minOccurs="0"/&gt;
 *         &lt;element name="ReceiverParty" type="{http://cps.huawei.com/cpsinterface/common}ReceiverParty" minOccurs="0"/&gt;
 *         &lt;element name="ReminderScheduleName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="FirstPaymentReminderDate" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="IssuePaymentReminderUntil" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="Frequency" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="FreeText" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="ExtraParameter" type="{http://cps.huawei.com/cpsinterface/common}SimpleProperty" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="NeedConfirmation" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="SendPreWarning" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="PreWarningPeriod" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="ReminderScheduleID" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ReminderScheduleInfo", propOrder = {
    "serviceForInitiateTransaction",
    "currency",
    "amount",
    "primaryParty",
    "receiverParty",
    "reminderScheduleName",
    "firstPaymentReminderDate",
    "issuePaymentReminderUntil",
    "frequency",
    "freeText",
    "extraParameter",
    "needConfirmation",
    "sendPreWarning",
    "preWarningPeriod",
    "reminderScheduleID"
})
public class ReminderScheduleInfo {

    @XmlElement(name = "ServiceForInitiateTransaction", required = true)
    protected String serviceForInitiateTransaction;
    @XmlElement(name = "Currency", required = true)
    protected String currency;
    @XmlElement(name = "Amount", required = true)
    protected String amount;
    @XmlElement(name = "PrimaryParty")
    protected PrimaryParty primaryParty;
    @XmlElement(name = "ReceiverParty")
    protected ReceiverParty receiverParty;
    @XmlElement(name = "ReminderScheduleName", required = true)
    protected String reminderScheduleName;
    @XmlElement(name = "FirstPaymentReminderDate", required = true)
    protected String firstPaymentReminderDate;
    @XmlElement(name = "IssuePaymentReminderUntil", required = true)
    protected String issuePaymentReminderUntil;
    @XmlElement(name = "Frequency", required = true)
    protected String frequency;
    @XmlElement(name = "FreeText")
    protected String freeText;
    @XmlElement(name = "ExtraParameter")
    protected List<SimpleProperty> extraParameter;
    @XmlElement(name = "NeedConfirmation")
    protected String needConfirmation;
    @XmlElement(name = "SendPreWarning")
    protected String sendPreWarning;
    @XmlElement(name = "PreWarningPeriod")
    protected String preWarningPeriod;
    @XmlElement(name = "ReminderScheduleID")
    protected String reminderScheduleID;

    /**
     * Gets the value of the serviceForInitiateTransaction property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getServiceForInitiateTransaction() {
        return serviceForInitiateTransaction;
    }

    /**
     * Sets the value of the serviceForInitiateTransaction property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setServiceForInitiateTransaction(String value) {
        this.serviceForInitiateTransaction = value;
    }

    /**
     * Gets the value of the currency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCurrency() {
        return currency;
    }

    /**
     * Sets the value of the currency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCurrency(String value) {
        this.currency = value;
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
     * Gets the value of the primaryParty property.
     * 
     * @return
     *     possible object is
     *     {@link PrimaryParty }
     *     
     */
    public PrimaryParty getPrimaryParty() {
        return primaryParty;
    }

    /**
     * Sets the value of the primaryParty property.
     * 
     * @param value
     *     allowed object is
     *     {@link PrimaryParty }
     *     
     */
    public void setPrimaryParty(PrimaryParty value) {
        this.primaryParty = value;
    }

    /**
     * Gets the value of the receiverParty property.
     * 
     * @return
     *     possible object is
     *     {@link ReceiverParty }
     *     
     */
    public ReceiverParty getReceiverParty() {
        return receiverParty;
    }

    /**
     * Sets the value of the receiverParty property.
     * 
     * @param value
     *     allowed object is
     *     {@link ReceiverParty }
     *     
     */
    public void setReceiverParty(ReceiverParty value) {
        this.receiverParty = value;
    }

    /**
     * Gets the value of the reminderScheduleName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReminderScheduleName() {
        return reminderScheduleName;
    }

    /**
     * Sets the value of the reminderScheduleName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReminderScheduleName(String value) {
        this.reminderScheduleName = value;
    }

    /**
     * Gets the value of the firstPaymentReminderDate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFirstPaymentReminderDate() {
        return firstPaymentReminderDate;
    }

    /**
     * Sets the value of the firstPaymentReminderDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFirstPaymentReminderDate(String value) {
        this.firstPaymentReminderDate = value;
    }

    /**
     * Gets the value of the issuePaymentReminderUntil property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIssuePaymentReminderUntil() {
        return issuePaymentReminderUntil;
    }

    /**
     * Sets the value of the issuePaymentReminderUntil property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIssuePaymentReminderUntil(String value) {
        this.issuePaymentReminderUntil = value;
    }

    /**
     * Gets the value of the frequency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFrequency() {
        return frequency;
    }

    /**
     * Sets the value of the frequency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFrequency(String value) {
        this.frequency = value;
    }

    /**
     * Gets the value of the freeText property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFreeText() {
        return freeText;
    }

    /**
     * Sets the value of the freeText property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFreeText(String value) {
        this.freeText = value;
    }

    /**
     * Gets the value of the extraParameter property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the extraParameter property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getExtraParameter().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link SimpleProperty }
     * 
     * 
     */
    public List<SimpleProperty> getExtraParameter() {
        if (extraParameter == null) {
            extraParameter = new ArrayList<SimpleProperty>();
        }
        return this.extraParameter;
    }

    /**
     * Gets the value of the needConfirmation property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNeedConfirmation() {
        return needConfirmation;
    }

    /**
     * Sets the value of the needConfirmation property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNeedConfirmation(String value) {
        this.needConfirmation = value;
    }

    /**
     * Gets the value of the sendPreWarning property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSendPreWarning() {
        return sendPreWarning;
    }

    /**
     * Sets the value of the sendPreWarning property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSendPreWarning(String value) {
        this.sendPreWarning = value;
    }

    /**
     * Gets the value of the preWarningPeriod property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPreWarningPeriod() {
        return preWarningPeriod;
    }

    /**
     * Sets the value of the preWarningPeriod property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPreWarningPeriod(String value) {
        this.preWarningPeriod = value;
    }

    /**
     * Gets the value of the reminderScheduleID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReminderScheduleID() {
        return reminderScheduleID;
    }

    /**
     * Sets the value of the reminderScheduleID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReminderScheduleID(String value) {
        this.reminderScheduleID = value;
    }

}
