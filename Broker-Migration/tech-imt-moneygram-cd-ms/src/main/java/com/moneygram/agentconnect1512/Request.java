
package com.moneygram.agentconnect1512;

import java.util.ArrayList;
import java.util.List;
import javax.xml.datatype.XMLGregorianCalendar;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlSeeAlso;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for Request complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="Request"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="unitProfileID" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/&gt;
 *         &lt;element name="agentID" type="{http://www.moneygram.com/AgentConnect1512}agentID" minOccurs="0"/&gt;
 *         &lt;element name="locationCode" type="{http://www.moneygram.com/AgentConnect1512}locationCode" minOccurs="0"/&gt;
 *         &lt;element name="agentSequence" type="{http://www.moneygram.com/AgentConnect1512}stringMax2" minOccurs="0"/&gt;
 *         &lt;element name="token" type="{http://www.moneygram.com/AgentConnect1512}token"/&gt;
 *         &lt;element name="language" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="timeStamp" type="{http://www.w3.org/2001/XMLSchema}dateTime"/&gt;
 *         &lt;element name="apiVersion" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="clientSoftwareVersion" type="{http://www.moneygram.com/AgentConnect1512}stringMax6"/&gt;
 *         &lt;element name="userID" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="channelType" type="{http://www.moneygram.com/AgentConnect1512}channelTypeEnum"/&gt;
 *         &lt;element name="targetAudience" type="{http://www.moneygram.com/AgentConnect1512}targetAudienceType" minOccurs="0"/&gt;
 *         &lt;element name="poeCapabilities" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="poeCapability" type="{http://www.moneygram.com/AgentConnect1512}KeyValuePairType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "Request", propOrder = {
    "unitProfileID",
    "agentID",
    "locationCode",
    "agentSequence",
    "token",
    "language",
    "timeStamp",
    "apiVersion",
    "clientSoftwareVersion",
    "userID",
    "channelType",
    "targetAudience",
    "poeCapabilities"
})
@XmlSeeAlso({
    VariableReceiptInfoRequest.class,
    DoddFrankStateRegulatorInfoRequest.class,
    CommitTransactionRequest.class,
    AmendTransactionRequest.class,
    MoneyGramConsumerLookupRequest.class,
    BillPaymentConsumerLookupRequest.class,
    BillPaymentDetailReportRequest.class,
    BillPaymentSummaryReportRequest.class,
    BillerSearchRequest.class,
    CheckInRequest.class,
    CityListRequest.class,
    CodeTableRequest.class,
    CurrencyInfoRequest.class,
    StateProvinceInfoRequest.class,
    CountryInfoRequest.class,
    ConfirmTokenRequest.class,
    DetailLookupRequest.class,
    DirectedSendRegistrationFieldsRequest.class,
    DirectoryOfAgentsByAreaCodePrefixRequest.class,
    DirectoryOfAgentsByCityRequest.class,
    DirectoryOfAgentsByZipRequest.class,
    FeeLookupRequest.class,
    FormFreeBPLookupRequest.class,
    FormFreeReceiveLookupRequest.class,
    FormFreeSendLookupRequest.class,
    FormFreeTypeLookupRequest.class,
    FormFreeTranLookupRequest.class,
    GetFieldsForProductRequest.class,
    GetFieldsForRewardsRequest.class,
    SaveRewardsRequest.class,
    GetFQDOByCustomerReceiveNumberRequest.class,
    FQDOsForCountryRequest.class,
    ReceiveCountryRequirementsRequest.class,
    GetRelatedProfilesRequest.class,
    IndustryRequest.class,
    InitialSetupRequest.class,
    MoneyGramReceiveDetailReportRequest.class,
    MoneyGramReceiveSummaryReportRequest.class,
    MoneyGramSendDetailReportRequest.class,
    MoneyGramSendSummaryReportRequest.class,
    ProfileRequest.class,
    QueryRegistrationByNamesRequest.class,
    ReceiveReversalRequest.class,
    ReferenceNumberNameRequest.class,
    ReferenceNumberPhoneRequest.class,
    ReferenceNumberRequest.class,
    SaveRegistrationRequest.class,
    SendReversalRequest.class,
    BillPaymentCancelRequest.class,
    TranslationsRequest.class,
    SendValidationRequest.class,
    ReceiveValidationRequest.class,
    BpValidationRequest.class
})
public class Request {

    protected Integer unitProfileID;
    protected String agentID;
    protected String locationCode;
    protected String agentSequence;
    @XmlElement(required = true)
    protected String token;
    protected String language;
    @XmlElement(required = true)
    @XmlSchemaType(name = "dateTime")
    protected XMLGregorianCalendar timeStamp;
    @XmlElement(required = true)
    protected String apiVersion;
    @XmlElement(required = true)
    protected String clientSoftwareVersion;
    protected String userID;
    @XmlElement(required = true)
    @XmlSchemaType(name = "string")
    protected ChannelTypeEnum channelType;
    @XmlSchemaType(name = "string")
    protected TargetAudienceType targetAudience;
    protected Request.PoeCapabilities poeCapabilities;

    /**
     * Gets the value of the unitProfileID property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getUnitProfileID() {
        return unitProfileID;
    }

    /**
     * Sets the value of the unitProfileID property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setUnitProfileID(Integer value) {
        this.unitProfileID = value;
    }

    /**
     * Gets the value of the agentID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAgentID() {
        return agentID;
    }

    /**
     * Sets the value of the agentID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAgentID(String value) {
        this.agentID = value;
    }

    /**
     * Gets the value of the locationCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getLocationCode() {
        return locationCode;
    }

    /**
     * Sets the value of the locationCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setLocationCode(String value) {
        this.locationCode = value;
    }

    /**
     * Gets the value of the agentSequence property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAgentSequence() {
        return agentSequence;
    }

    /**
     * Sets the value of the agentSequence property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAgentSequence(String value) {
        this.agentSequence = value;
    }

    /**
     * Gets the value of the token property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getToken() {
        return token;
    }

    /**
     * Sets the value of the token property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setToken(String value) {
        this.token = value;
    }

    /**
     * Gets the value of the language property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getLanguage() {
        return language;
    }

    /**
     * Sets the value of the language property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setLanguage(String value) {
        this.language = value;
    }

    /**
     * Gets the value of the timeStamp property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getTimeStamp() {
        return timeStamp;
    }

    /**
     * Sets the value of the timeStamp property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setTimeStamp(XMLGregorianCalendar value) {
        this.timeStamp = value;
    }

    /**
     * Gets the value of the apiVersion property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getApiVersion() {
        return apiVersion;
    }

    /**
     * Sets the value of the apiVersion property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setApiVersion(String value) {
        this.apiVersion = value;
    }

    /**
     * Gets the value of the clientSoftwareVersion property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getClientSoftwareVersion() {
        return clientSoftwareVersion;
    }

    /**
     * Sets the value of the clientSoftwareVersion property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setClientSoftwareVersion(String value) {
        this.clientSoftwareVersion = value;
    }

    /**
     * Gets the value of the userID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUserID() {
        return userID;
    }

    /**
     * Sets the value of the userID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUserID(String value) {
        this.userID = value;
    }

    /**
     * Gets the value of the channelType property.
     * 
     * @return
     *     possible object is
     *     {@link ChannelTypeEnum }
     *     
     */
    public ChannelTypeEnum getChannelType() {
        return channelType;
    }

    /**
     * Sets the value of the channelType property.
     * 
     * @param value
     *     allowed object is
     *     {@link ChannelTypeEnum }
     *     
     */
    public void setChannelType(ChannelTypeEnum value) {
        this.channelType = value;
    }

    /**
     * Gets the value of the targetAudience property.
     * 
     * @return
     *     possible object is
     *     {@link TargetAudienceType }
     *     
     */
    public TargetAudienceType getTargetAudience() {
        return targetAudience;
    }

    /**
     * Sets the value of the targetAudience property.
     * 
     * @param value
     *     allowed object is
     *     {@link TargetAudienceType }
     *     
     */
    public void setTargetAudience(TargetAudienceType value) {
        this.targetAudience = value;
    }

    /**
     * Gets the value of the poeCapabilities property.
     * 
     * @return
     *     possible object is
     *     {@link Request.PoeCapabilities }
     *     
     */
    public Request.PoeCapabilities getPoeCapabilities() {
        return poeCapabilities;
    }

    /**
     * Sets the value of the poeCapabilities property.
     * 
     * @param value
     *     allowed object is
     *     {@link Request.PoeCapabilities }
     *     
     */
    public void setPoeCapabilities(Request.PoeCapabilities value) {
        this.poeCapabilities = value;
    }


    /**
     * <p>Java class for anonymous complex type.
     * 
     * <p>The following schema fragment specifies the expected content contained within this class.
     * 
     * <pre>
     * &lt;complexType&gt;
     *   &lt;complexContent&gt;
     *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *       &lt;sequence&gt;
     *         &lt;element name="poeCapability" type="{http://www.moneygram.com/AgentConnect1512}KeyValuePairType" maxOccurs="unbounded" minOccurs="0"/&gt;
     *       &lt;/sequence&gt;
     *     &lt;/restriction&gt;
     *   &lt;/complexContent&gt;
     * &lt;/complexType&gt;
     * </pre>
     * 
     * 
     */
    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "", propOrder = {
        "poeCapability"
    })
    public static class PoeCapabilities {

        protected List<KeyValuePairType> poeCapability;

        /**
         * Gets the value of the poeCapability property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the poeCapability property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getPoeCapability().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link KeyValuePairType }
         * 
         * 
         */
        public List<KeyValuePairType> getPoeCapability() {
            if (poeCapability == null) {
                poeCapability = new ArrayList<KeyValuePairType>();
            }
            return this.poeCapability;
        }

    }

}
