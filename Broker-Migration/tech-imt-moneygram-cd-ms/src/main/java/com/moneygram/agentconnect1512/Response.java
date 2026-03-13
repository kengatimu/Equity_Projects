
package com.moneygram.agentconnect1512;

import javax.xml.datatype.XMLGregorianCalendar;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlSeeAlso;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for Response complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="Response"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="doCheckIn" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="timeStamp" type="{http://www.w3.org/2001/XMLSchema}dateTime"/&gt;
 *         &lt;element name="flags" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "Response", propOrder = {
    "doCheckIn",
    "timeStamp",
    "flags"
})
@XmlSeeAlso({
    VariableReceiptInfoResponse.class,
    DoddFrankStateRegulatorInfoResponse.class,
    CommitTransactionResponse.class,
    AmendTransactionResponse.class,
    MoneyGramConsumerLookupResponse.class,
    BillPaymentConsumerLookupResponse.class,
    BillPaymentDetailReportResponse.class,
    BillPaymentSummaryReportResponse.class,
    BillerSearchResponse.class,
    CheckInResponse.class,
    CityListResponse.class,
    CodeTableResponse.class,
    CurrencyInfoResponse.class,
    StateProvinceInfoResponse.class,
    CountryInfoResponse.class,
    ConfirmTokenResponse.class,
    DetailLookupResponse.class,
    DirectedSendRegistrationFieldsResponse.class,
    DirectoryOfAgentsByAreaCodePrefixResponse.class,
    DirectoryOfAgentsByCityResponse.class,
    DirectoryOfAgentsByZipResponse.class,
    FeeLookupResponse.class,
    FormFreeBPLookupResponse.class,
    FormFreeReceiveLookupResponse.class,
    FormFreeSendLookupResponse.class,
    FormFreeTypeLookupResponse.class,
    FormFreeTranLookupResponse.class,
    FormFreeTranLookupWithAmountResponse.class,
    GetFieldsForProductResponse.class,
    GetFieldsForRewardsResponse.class,
    SaveRewardsResponse.class,
    GetFQDOByCustomerReceiveNumberResponse.class,
    FQDOsForCountryResponse.class,
    ReceiveCountryRequirementsResponse.class,
    GetRelatedProfilesResponse.class,
    IndustryResponse.class,
    InitialSetupResponse.class,
    MoneyGramReceiveDetailReportResponse.class,
    MoneyGramReceiveSummaryReportResponse.class,
    MoneyGramSendDetailReportResponse.class,
    MoneyGramSendSummaryReportResponse.class,
    ProfileResponse.class,
    QueryRegistrationByNamesResponse.class,
    ReceiveReversalResponse.class,
    ReferenceNumberNameResponse.class,
    ReferenceNumberPhoneResponse.class,
    ReferenceNumberResponse.class,
    SaveRegistrationResponse.class,
    SendReversalResponse.class,
    BillPaymentCancelResponse.class,
    TranslationsResponse.class,
    SendValidationResponse.class,
    ReceiveValidationResponse.class,
    BpValidationResponse.class
})
public class Response {

    protected boolean doCheckIn;
    @XmlElement(required = true)
    @XmlSchemaType(name = "dateTime")
    protected XMLGregorianCalendar timeStamp;
    protected int flags;

    /**
     * Gets the value of the doCheckIn property.
     * 
     */
    public boolean isDoCheckIn() {
        return doCheckIn;
    }

    /**
     * Sets the value of the doCheckIn property.
     * 
     */
    public void setDoCheckIn(boolean value) {
        this.doCheckIn = value;
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
     * Gets the value of the flags property.
     * 
     */
    public int getFlags() {
        return flags;
    }

    /**
     * Sets the value of the flags property.
     * 
     */
    public void setFlags(int value) {
        this.flags = value;
    }

}
