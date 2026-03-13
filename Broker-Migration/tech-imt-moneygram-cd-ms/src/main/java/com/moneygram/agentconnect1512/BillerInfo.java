
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
 * <p>Java class for BillerInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="BillerInfo"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="receiveAgentID" type="{http://www.moneygram.com/AgentConnect1512}agentID"/&gt;
 *         &lt;element name="receiveCode" type="{http://www.moneygram.com/AgentConnect1512}receiveCodeType"/&gt;
 *         &lt;element name="billerGroupID" type="{http://www.moneygram.com/AgentConnect1512}stringMax12" minOccurs="0"/&gt;
 *         &lt;element name="billerGroupName" type="{http://www.moneygram.com/AgentConnect1512}stringMax64" minOccurs="0"/&gt;
 *         &lt;element name="billerName" type="{http://www.moneygram.com/AgentConnect1512}stringMax64"/&gt;
 *         &lt;element name="address1" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="address2" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="address3" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="billerCity" type="{http://www.moneygram.com/AgentConnect1512}cityTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="billerState" type="{http://www.moneygram.com/AgentConnect1512}stateTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="serviceOfferingID" type="{http://www.moneygram.com/AgentConnect1512}stringMax21" minOccurs="0"/&gt;
 *         &lt;element name="serviceOffering" type="{http://www.moneygram.com/AgentConnect1512}stringMax80" minOccurs="0"/&gt;
 *         &lt;element name="serviceOfferingSecondary" type="{http://www.moneygram.com/AgentConnect1512}stringMax80" minOccurs="0"/&gt;
 *         &lt;element name="serviceOfferingShort" type="{http://www.moneygram.com/AgentConnect1512}stringMax40" minOccurs="0"/&gt;
 *         &lt;element name="serviceOfferingShortSecondary" type="{http://www.moneygram.com/AgentConnect1512}stringMax40" minOccurs="0"/&gt;
 *         &lt;element name="industryID" type="{http://www.moneygram.com/AgentConnect1512}industryID" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="expectedPostingTimeFrame" type="{http://www.moneygram.com/AgentConnect1512}stringMax150" minOccurs="0"/&gt;
 *         &lt;element name="expectedPostingTimeFrameSecondary" type="{http://www.moneygram.com/AgentConnect1512}stringMax150" minOccurs="0"/&gt;
 *         &lt;element name="billerNotes" type="{http://www.moneygram.com/AgentConnect1512}stringMax80" minOccurs="0"/&gt;
 *         &lt;element name="billerNotesSecondary" type="{http://www.moneygram.com/AgentConnect1512}stringMax80" minOccurs="0"/&gt;
 *         &lt;element name="secondaryLang" type="{http://www.moneygram.com/AgentConnect1512}stringMax2" minOccurs="0"/&gt;
 *         &lt;element name="productVariant" type="{http://www.moneygram.com/AgentConnect1512}productVariant"/&gt;
 *         &lt;element name="billerCutoffTime" type="{http://www.moneygram.com/AgentConnect1512}stringMax12" minOccurs="0"/&gt;
 *         &lt;element name="billerWebsite" type="{http://www.moneygram.com/AgentConnect1512}stringMax40" minOccurs="0"/&gt;
 *         &lt;element name="billerPhoneNumber" type="{http://www.moneygram.com/AgentConnect1512}phoneType" minOccurs="0"/&gt;
 *         &lt;element name="maskAccountNumber" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="nationalBillerFlag" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="useStandardUBPFields" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="acctNumberNumericOnly" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="sendFixedAmountFlag" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="cancelWarnFlag" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="refundWarnFlag" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="doubleAcctNumberEntryFlag" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="minimumFeeAmt" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="feeType" type="{http://www.moneygram.com/AgentConnect1512}feeType" minOccurs="0"/&gt;
 *         &lt;element name="consolidatorLocationId" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="consolidatorName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="classOfTradeCode" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="expeditedEligibleFlag" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "BillerInfo", propOrder = {
    "receiveAgentID",
    "receiveCode",
    "billerGroupID",
    "billerGroupName",
    "billerName",
    "address1",
    "address2",
    "address3",
    "billerCity",
    "billerState",
    "serviceOfferingID",
    "serviceOffering",
    "serviceOfferingSecondary",
    "serviceOfferingShort",
    "serviceOfferingShortSecondary",
    "industryID",
    "expectedPostingTimeFrame",
    "expectedPostingTimeFrameSecondary",
    "billerNotes",
    "billerNotesSecondary",
    "secondaryLang",
    "productVariant",
    "billerCutoffTime",
    "billerWebsite",
    "billerPhoneNumber",
    "maskAccountNumber",
    "nationalBillerFlag",
    "useStandardUBPFields",
    "acctNumberNumericOnly",
    "sendFixedAmountFlag",
    "cancelWarnFlag",
    "refundWarnFlag",
    "doubleAcctNumberEntryFlag",
    "minimumFeeAmt",
    "feeType",
    "consolidatorLocationId",
    "consolidatorName",
    "classOfTradeCode",
    "expeditedEligibleFlag"
})
public class BillerInfo {

    @XmlElement(required = true)
    protected String receiveAgentID;
    @XmlElement(required = true)
    protected String receiveCode;
    protected String billerGroupID;
    protected String billerGroupName;
    @XmlElement(required = true)
    protected String billerName;
    protected String address1;
    protected String address2;
    protected String address3;
    protected String billerCity;
    protected String billerState;
    protected String serviceOfferingID;
    protected String serviceOffering;
    protected String serviceOfferingSecondary;
    protected String serviceOfferingShort;
    protected String serviceOfferingShortSecondary;
    protected List<String> industryID;
    protected String expectedPostingTimeFrame;
    protected String expectedPostingTimeFrameSecondary;
    protected String billerNotes;
    protected String billerNotesSecondary;
    protected String secondaryLang;
    @XmlElement(required = true)
    @XmlSchemaType(name = "string")
    protected ProductVariant productVariant;
    protected String billerCutoffTime;
    protected String billerWebsite;
    protected String billerPhoneNumber;
    protected Boolean maskAccountNumber;
    protected Boolean nationalBillerFlag;
    protected Boolean useStandardUBPFields;
    protected Boolean acctNumberNumericOnly;
    protected Boolean sendFixedAmountFlag;
    protected Boolean cancelWarnFlag;
    protected Boolean refundWarnFlag;
    protected Boolean doubleAcctNumberEntryFlag;
    protected BigDecimal minimumFeeAmt;
    @XmlSchemaType(name = "string")
    protected FeeType feeType;
    protected String consolidatorLocationId;
    protected String consolidatorName;
    protected String classOfTradeCode;
    protected Boolean expeditedEligibleFlag;

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
     * Gets the value of the receiveCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiveCode() {
        return receiveCode;
    }

    /**
     * Sets the value of the receiveCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiveCode(String value) {
        this.receiveCode = value;
    }

    /**
     * Gets the value of the billerGroupID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillerGroupID() {
        return billerGroupID;
    }

    /**
     * Sets the value of the billerGroupID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillerGroupID(String value) {
        this.billerGroupID = value;
    }

    /**
     * Gets the value of the billerGroupName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillerGroupName() {
        return billerGroupName;
    }

    /**
     * Sets the value of the billerGroupName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillerGroupName(String value) {
        this.billerGroupName = value;
    }

    /**
     * Gets the value of the billerName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillerName() {
        return billerName;
    }

    /**
     * Sets the value of the billerName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillerName(String value) {
        this.billerName = value;
    }

    /**
     * Gets the value of the address1 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAddress1() {
        return address1;
    }

    /**
     * Sets the value of the address1 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAddress1(String value) {
        this.address1 = value;
    }

    /**
     * Gets the value of the address2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAddress2() {
        return address2;
    }

    /**
     * Sets the value of the address2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAddress2(String value) {
        this.address2 = value;
    }

    /**
     * Gets the value of the address3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAddress3() {
        return address3;
    }

    /**
     * Sets the value of the address3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAddress3(String value) {
        this.address3 = value;
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
     * Gets the value of the serviceOffering property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getServiceOffering() {
        return serviceOffering;
    }

    /**
     * Sets the value of the serviceOffering property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setServiceOffering(String value) {
        this.serviceOffering = value;
    }

    /**
     * Gets the value of the serviceOfferingSecondary property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getServiceOfferingSecondary() {
        return serviceOfferingSecondary;
    }

    /**
     * Sets the value of the serviceOfferingSecondary property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setServiceOfferingSecondary(String value) {
        this.serviceOfferingSecondary = value;
    }

    /**
     * Gets the value of the serviceOfferingShort property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getServiceOfferingShort() {
        return serviceOfferingShort;
    }

    /**
     * Sets the value of the serviceOfferingShort property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setServiceOfferingShort(String value) {
        this.serviceOfferingShort = value;
    }

    /**
     * Gets the value of the serviceOfferingShortSecondary property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getServiceOfferingShortSecondary() {
        return serviceOfferingShortSecondary;
    }

    /**
     * Sets the value of the serviceOfferingShortSecondary property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setServiceOfferingShortSecondary(String value) {
        this.serviceOfferingShortSecondary = value;
    }

    /**
     * Gets the value of the industryID property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the industryID property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getIndustryID().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link String }
     * 
     * 
     */
    public List<String> getIndustryID() {
        if (industryID == null) {
            industryID = new ArrayList<String>();
        }
        return this.industryID;
    }

    /**
     * Gets the value of the expectedPostingTimeFrame property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getExpectedPostingTimeFrame() {
        return expectedPostingTimeFrame;
    }

    /**
     * Sets the value of the expectedPostingTimeFrame property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setExpectedPostingTimeFrame(String value) {
        this.expectedPostingTimeFrame = value;
    }

    /**
     * Gets the value of the expectedPostingTimeFrameSecondary property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getExpectedPostingTimeFrameSecondary() {
        return expectedPostingTimeFrameSecondary;
    }

    /**
     * Sets the value of the expectedPostingTimeFrameSecondary property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setExpectedPostingTimeFrameSecondary(String value) {
        this.expectedPostingTimeFrameSecondary = value;
    }

    /**
     * Gets the value of the billerNotes property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillerNotes() {
        return billerNotes;
    }

    /**
     * Sets the value of the billerNotes property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillerNotes(String value) {
        this.billerNotes = value;
    }

    /**
     * Gets the value of the billerNotesSecondary property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillerNotesSecondary() {
        return billerNotesSecondary;
    }

    /**
     * Sets the value of the billerNotesSecondary property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillerNotesSecondary(String value) {
        this.billerNotesSecondary = value;
    }

    /**
     * Gets the value of the secondaryLang property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSecondaryLang() {
        return secondaryLang;
    }

    /**
     * Sets the value of the secondaryLang property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSecondaryLang(String value) {
        this.secondaryLang = value;
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
     * Gets the value of the billerPhoneNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillerPhoneNumber() {
        return billerPhoneNumber;
    }

    /**
     * Sets the value of the billerPhoneNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillerPhoneNumber(String value) {
        this.billerPhoneNumber = value;
    }

    /**
     * Gets the value of the maskAccountNumber property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isMaskAccountNumber() {
        return maskAccountNumber;
    }

    /**
     * Sets the value of the maskAccountNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setMaskAccountNumber(Boolean value) {
        this.maskAccountNumber = value;
    }

    /**
     * Gets the value of the nationalBillerFlag property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isNationalBillerFlag() {
        return nationalBillerFlag;
    }

    /**
     * Sets the value of the nationalBillerFlag property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setNationalBillerFlag(Boolean value) {
        this.nationalBillerFlag = value;
    }

    /**
     * Gets the value of the useStandardUBPFields property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isUseStandardUBPFields() {
        return useStandardUBPFields;
    }

    /**
     * Sets the value of the useStandardUBPFields property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setUseStandardUBPFields(Boolean value) {
        this.useStandardUBPFields = value;
    }

    /**
     * Gets the value of the acctNumberNumericOnly property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isAcctNumberNumericOnly() {
        return acctNumberNumericOnly;
    }

    /**
     * Sets the value of the acctNumberNumericOnly property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setAcctNumberNumericOnly(Boolean value) {
        this.acctNumberNumericOnly = value;
    }

    /**
     * Gets the value of the sendFixedAmountFlag property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isSendFixedAmountFlag() {
        return sendFixedAmountFlag;
    }

    /**
     * Sets the value of the sendFixedAmountFlag property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setSendFixedAmountFlag(Boolean value) {
        this.sendFixedAmountFlag = value;
    }

    /**
     * Gets the value of the cancelWarnFlag property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isCancelWarnFlag() {
        return cancelWarnFlag;
    }

    /**
     * Sets the value of the cancelWarnFlag property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setCancelWarnFlag(Boolean value) {
        this.cancelWarnFlag = value;
    }

    /**
     * Gets the value of the refundWarnFlag property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isRefundWarnFlag() {
        return refundWarnFlag;
    }

    /**
     * Sets the value of the refundWarnFlag property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setRefundWarnFlag(Boolean value) {
        this.refundWarnFlag = value;
    }

    /**
     * Gets the value of the doubleAcctNumberEntryFlag property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isDoubleAcctNumberEntryFlag() {
        return doubleAcctNumberEntryFlag;
    }

    /**
     * Sets the value of the doubleAcctNumberEntryFlag property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setDoubleAcctNumberEntryFlag(Boolean value) {
        this.doubleAcctNumberEntryFlag = value;
    }

    /**
     * Gets the value of the minimumFeeAmt property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getMinimumFeeAmt() {
        return minimumFeeAmt;
    }

    /**
     * Sets the value of the minimumFeeAmt property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setMinimumFeeAmt(BigDecimal value) {
        this.minimumFeeAmt = value;
    }

    /**
     * Gets the value of the feeType property.
     * 
     * @return
     *     possible object is
     *     {@link FeeType }
     *     
     */
    public FeeType getFeeType() {
        return feeType;
    }

    /**
     * Sets the value of the feeType property.
     * 
     * @param value
     *     allowed object is
     *     {@link FeeType }
     *     
     */
    public void setFeeType(FeeType value) {
        this.feeType = value;
    }

    /**
     * Gets the value of the consolidatorLocationId property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsolidatorLocationId() {
        return consolidatorLocationId;
    }

    /**
     * Sets the value of the consolidatorLocationId property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsolidatorLocationId(String value) {
        this.consolidatorLocationId = value;
    }

    /**
     * Gets the value of the consolidatorName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsolidatorName() {
        return consolidatorName;
    }

    /**
     * Sets the value of the consolidatorName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsolidatorName(String value) {
        this.consolidatorName = value;
    }

    /**
     * Gets the value of the classOfTradeCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getClassOfTradeCode() {
        return classOfTradeCode;
    }

    /**
     * Sets the value of the classOfTradeCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setClassOfTradeCode(String value) {
        this.classOfTradeCode = value;
    }

    /**
     * Gets the value of the expeditedEligibleFlag property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isExpeditedEligibleFlag() {
        return expeditedEligibleFlag;
    }

    /**
     * Sets the value of the expeditedEligibleFlag property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setExpeditedEligibleFlag(Boolean value) {
        this.expeditedEligibleFlag = value;
    }

}
