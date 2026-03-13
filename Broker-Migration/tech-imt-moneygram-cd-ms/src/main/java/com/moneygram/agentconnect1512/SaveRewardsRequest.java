
package com.moneygram.agentconnect1512;

import javax.xml.datatype.XMLGregorianCalendar;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;
import jakarta.xml.bind.annotation.adapters.CollapsedStringAdapter;
import jakarta.xml.bind.annotation.adapters.XmlJavaTypeAdapter;


/**
 * <p>Java class for SaveRewardsRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="SaveRewardsRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Request"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="cardTypeCode" type="{http://www.moneygram.com/AgentConnect1512}cardTypeCode" minOccurs="0"/&gt;
 *         &lt;element name="freqCustCardNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="operatorID" type="{http://www.moneygram.com/AgentConnect1512}operatorIdType" minOccurs="0"/&gt;
 *         &lt;element name="consumerTitle" type="{http://www.moneygram.com/AgentConnect1512}titleType" minOccurs="0"/&gt;
 *         &lt;element name="consumerFirstName" type="{http://www.moneygram.com/AgentConnect1512}fNameType40" minOccurs="0"/&gt;
 *         &lt;element name="consumerMiddleName" type="{http://www.moneygram.com/AgentConnect1512}mNameType40" minOccurs="0"/&gt;
 *         &lt;element name="consumerLastName" type="{http://www.moneygram.com/AgentConnect1512}lNameType40" minOccurs="0"/&gt;
 *         &lt;element name="consumerLastName2" type="{http://www.moneygram.com/AgentConnect1512}lNameType40" minOccurs="0"/&gt;
 *         &lt;element name="consumerAddress" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="consumerAddress2" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="consumerAddress3" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="consumerCity" type="{http://www.moneygram.com/AgentConnect1512}cityType60" minOccurs="0"/&gt;
 *         &lt;element name="consumerState" type="{http://www.moneygram.com/AgentConnect1512}stateType40" minOccurs="0"/&gt;
 *         &lt;element name="consumerZipCode" type="{http://www.moneygram.com/AgentConnect1512}zipType14" minOccurs="0"/&gt;
 *         &lt;element name="consumerCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="consumerHomePhone" type="{http://www.moneygram.com/AgentConnect1512}phoneType20" minOccurs="0"/&gt;
 *         &lt;element name="consumerEmailAddress" type="{http://www.moneygram.com/AgentConnect1512}emailType128" minOccurs="0"/&gt;
 *         &lt;element name="consumerMobilePhone" type="{http://www.moneygram.com/AgentConnect1512}phoneType20" minOccurs="0"/&gt;
 *         &lt;element name="personalIdNumber1" type="{http://www.moneygram.com/AgentConnect1512}personalIdNumber" minOccurs="0"/&gt;
 *         &lt;element name="personalIdTypeCode1" type="{http://www.moneygram.com/AgentConnect1512}personalIdType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueOfficeCode1" type="{http://www.moneygram.com/AgentConnect1512}personalIdOffice" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueCity1" type="{http://www.moneygram.com/AgentConnect1512}cityType60" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueState1" type="{http://www.moneygram.com/AgentConnect1512}stateType40" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueCountry1" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueMonth1" type="{http://www.moneygram.com/AgentConnect1512}monthType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueDay1" type="{http://www.moneygram.com/AgentConnect1512}dayType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueYear1" type="{http://www.moneygram.com/AgentConnect1512}yearType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdExpirationMonth1" type="{http://www.moneygram.com/AgentConnect1512}monthType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdExpirationDay1" type="{http://www.moneygram.com/AgentConnect1512}dayType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdExpirationYear1" type="{http://www.moneygram.com/AgentConnect1512}yearType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdNumber2" type="{http://www.moneygram.com/AgentConnect1512}personalIdNumber" minOccurs="0"/&gt;
 *         &lt;element name="personalIdTypeCode2" type="{http://www.moneygram.com/AgentConnect1512}personalIdType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueOfficeCode2" type="{http://www.moneygram.com/AgentConnect1512}personalIdOffice" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueCity2" type="{http://www.moneygram.com/AgentConnect1512}cityType60" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueState2" type="{http://www.moneygram.com/AgentConnect1512}stateType40" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueCountry2" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueMonth2" type="{http://www.moneygram.com/AgentConnect1512}monthType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueDay2" type="{http://www.moneygram.com/AgentConnect1512}dayType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueYear2" type="{http://www.moneygram.com/AgentConnect1512}yearType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdExpirationMonth2" type="{http://www.moneygram.com/AgentConnect1512}monthType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdExpirationDay2" type="{http://www.moneygram.com/AgentConnect1512}dayType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdExpirationYear2" type="{http://www.moneygram.com/AgentConnect1512}yearType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdNumber3" type="{http://www.moneygram.com/AgentConnect1512}personalIdNumber" minOccurs="0"/&gt;
 *         &lt;element name="personalIdTypeCode3" type="{http://www.moneygram.com/AgentConnect1512}personalIdType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueOfficeCode3" type="{http://www.moneygram.com/AgentConnect1512}personalIdOffice" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueCity3" type="{http://www.moneygram.com/AgentConnect1512}cityType60" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueState3" type="{http://www.moneygram.com/AgentConnect1512}stateType40" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueCountry3" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueMonth3" type="{http://www.moneygram.com/AgentConnect1512}monthType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueDay3" type="{http://www.moneygram.com/AgentConnect1512}dayType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdIssueYear3" type="{http://www.moneygram.com/AgentConnect1512}yearType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdExpirationMonth3" type="{http://www.moneygram.com/AgentConnect1512}monthType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdExpirationDay3" type="{http://www.moneygram.com/AgentConnect1512}dayType" minOccurs="0"/&gt;
 *         &lt;element name="personalIdExpirationYear3" type="{http://www.moneygram.com/AgentConnect1512}yearType" minOccurs="0"/&gt;
 *         &lt;element name="consumerDOB" type="{http://www.w3.org/2001/XMLSchema}date" minOccurs="0"/&gt;
 *         &lt;element name="consumerBirthCity" type="{http://www.moneygram.com/AgentConnect1512}cityType60" minOccurs="0"/&gt;
 *         &lt;element name="consumerBirthState" type="{http://www.moneygram.com/AgentConnect1512}stateType40" minOccurs="0"/&gt;
 *         &lt;element name="consumerBirthCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="gender" type="{http://www.moneygram.com/AgentConnect1512}genderType" minOccurs="0"/&gt;
 *         &lt;element name="marketingOptIn" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="marketingByCellPhone" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="marketingByEmail" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="marketingByHomePhone" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="marketingByMail" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="marketingBySMS" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="marketingLanguage" type="{http://www.moneygram.com/AgentConnect1512}languageType5" minOccurs="0"/&gt;
 *         &lt;element name="receiveNoticeOptIn" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="receiveNoticeEmailAddress" type="{http://www.moneygram.com/AgentConnect1512}emailType128" minOccurs="0"/&gt;
 *         &lt;element name="receiveNoticeViaEMail" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="receiveNoticeViaSMS" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="receiveNoticeMobilePhone" type="{http://www.moneygram.com/AgentConnect1512}phoneType20" minOccurs="0"/&gt;
 *         &lt;element name="receiveNoticeLanguage" type="{http://www.moneygram.com/AgentConnect1512}languageType5" minOccurs="0"/&gt;
 *         &lt;element name="quarterlyStatements" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="quarterlyStatementsByEmail" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="quarterlyStatementsByMail" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="consentOfPersonalInformationThirdParty" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="agentAcknowledgement" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "SaveRewardsRequest", propOrder = {
    "cardTypeCode",
    "freqCustCardNumber",
    "operatorID",
    "consumerTitle",
    "consumerFirstName",
    "consumerMiddleName",
    "consumerLastName",
    "consumerLastName2",
    "consumerAddress",
    "consumerAddress2",
    "consumerAddress3",
    "consumerCity",
    "consumerState",
    "consumerZipCode",
    "consumerCountry",
    "consumerHomePhone",
    "consumerEmailAddress",
    "consumerMobilePhone",
    "personalIdNumber1",
    "personalIdTypeCode1",
    "personalIdIssueOfficeCode1",
    "personalIdIssueCity1",
    "personalIdIssueState1",
    "personalIdIssueCountry1",
    "personalIdIssueMonth1",
    "personalIdIssueDay1",
    "personalIdIssueYear1",
    "personalIdExpirationMonth1",
    "personalIdExpirationDay1",
    "personalIdExpirationYear1",
    "personalIdNumber2",
    "personalIdTypeCode2",
    "personalIdIssueOfficeCode2",
    "personalIdIssueCity2",
    "personalIdIssueState2",
    "personalIdIssueCountry2",
    "personalIdIssueMonth2",
    "personalIdIssueDay2",
    "personalIdIssueYear2",
    "personalIdExpirationMonth2",
    "personalIdExpirationDay2",
    "personalIdExpirationYear2",
    "personalIdNumber3",
    "personalIdTypeCode3",
    "personalIdIssueOfficeCode3",
    "personalIdIssueCity3",
    "personalIdIssueState3",
    "personalIdIssueCountry3",
    "personalIdIssueMonth3",
    "personalIdIssueDay3",
    "personalIdIssueYear3",
    "personalIdExpirationMonth3",
    "personalIdExpirationDay3",
    "personalIdExpirationYear3",
    "consumerDOB",
    "consumerBirthCity",
    "consumerBirthState",
    "consumerBirthCountry",
    "gender",
    "marketingOptIn",
    "marketingByCellPhone",
    "marketingByEmail",
    "marketingByHomePhone",
    "marketingByMail",
    "marketingBySMS",
    "marketingLanguage",
    "receiveNoticeOptIn",
    "receiveNoticeEmailAddress",
    "receiveNoticeViaEMail",
    "receiveNoticeViaSMS",
    "receiveNoticeMobilePhone",
    "receiveNoticeLanguage",
    "quarterlyStatements",
    "quarterlyStatementsByEmail",
    "quarterlyStatementsByMail",
    "consentOfPersonalInformationThirdParty",
    "agentAcknowledgement"
})
public class SaveRewardsRequest
    extends Request
{

    protected String cardTypeCode;
    protected String freqCustCardNumber;
    protected String operatorID;
    protected String consumerTitle;
    protected String consumerFirstName;
    protected String consumerMiddleName;
    protected String consumerLastName;
    protected String consumerLastName2;
    protected String consumerAddress;
    protected String consumerAddress2;
    protected String consumerAddress3;
    protected String consumerCity;
    protected String consumerState;
    protected String consumerZipCode;
    protected String consumerCountry;
    protected String consumerHomePhone;
    @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
    @XmlSchemaType(name = "token")
    protected String consumerEmailAddress;
    protected String consumerMobilePhone;
    protected String personalIdNumber1;
    protected String personalIdTypeCode1;
    protected String personalIdIssueOfficeCode1;
    protected String personalIdIssueCity1;
    protected String personalIdIssueState1;
    protected String personalIdIssueCountry1;
    protected String personalIdIssueMonth1;
    protected String personalIdIssueDay1;
    protected String personalIdIssueYear1;
    protected String personalIdExpirationMonth1;
    protected String personalIdExpirationDay1;
    protected String personalIdExpirationYear1;
    protected String personalIdNumber2;
    protected String personalIdTypeCode2;
    protected String personalIdIssueOfficeCode2;
    protected String personalIdIssueCity2;
    protected String personalIdIssueState2;
    protected String personalIdIssueCountry2;
    protected String personalIdIssueMonth2;
    protected String personalIdIssueDay2;
    protected String personalIdIssueYear2;
    protected String personalIdExpirationMonth2;
    protected String personalIdExpirationDay2;
    protected String personalIdExpirationYear2;
    protected String personalIdNumber3;
    protected String personalIdTypeCode3;
    protected String personalIdIssueOfficeCode3;
    protected String personalIdIssueCity3;
    protected String personalIdIssueState3;
    protected String personalIdIssueCountry3;
    protected String personalIdIssueMonth3;
    protected String personalIdIssueDay3;
    protected String personalIdIssueYear3;
    protected String personalIdExpirationMonth3;
    protected String personalIdExpirationDay3;
    protected String personalIdExpirationYear3;
    @XmlSchemaType(name = "date")
    protected XMLGregorianCalendar consumerDOB;
    protected String consumerBirthCity;
    protected String consumerBirthState;
    protected String consumerBirthCountry;
    @XmlSchemaType(name = "string")
    protected GenderType gender;
    protected Boolean marketingOptIn;
    protected Boolean marketingByCellPhone;
    protected Boolean marketingByEmail;
    protected Boolean marketingByHomePhone;
    protected Boolean marketingByMail;
    protected Boolean marketingBySMS;
    protected String marketingLanguage;
    protected Boolean receiveNoticeOptIn;
    @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
    @XmlSchemaType(name = "token")
    protected String receiveNoticeEmailAddress;
    protected Boolean receiveNoticeViaEMail;
    protected Boolean receiveNoticeViaSMS;
    protected String receiveNoticeMobilePhone;
    protected String receiveNoticeLanguage;
    protected Boolean quarterlyStatements;
    protected Boolean quarterlyStatementsByEmail;
    protected Boolean quarterlyStatementsByMail;
    protected Boolean consentOfPersonalInformationThirdParty;
    protected Boolean agentAcknowledgement;

    /**
     * Gets the value of the cardTypeCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCardTypeCode() {
        return cardTypeCode;
    }

    /**
     * Sets the value of the cardTypeCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCardTypeCode(String value) {
        this.cardTypeCode = value;
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
     * Gets the value of the operatorID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOperatorID() {
        return operatorID;
    }

    /**
     * Sets the value of the operatorID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOperatorID(String value) {
        this.operatorID = value;
    }

    /**
     * Gets the value of the consumerTitle property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerTitle() {
        return consumerTitle;
    }

    /**
     * Sets the value of the consumerTitle property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerTitle(String value) {
        this.consumerTitle = value;
    }

    /**
     * Gets the value of the consumerFirstName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerFirstName() {
        return consumerFirstName;
    }

    /**
     * Sets the value of the consumerFirstName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerFirstName(String value) {
        this.consumerFirstName = value;
    }

    /**
     * Gets the value of the consumerMiddleName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerMiddleName() {
        return consumerMiddleName;
    }

    /**
     * Sets the value of the consumerMiddleName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerMiddleName(String value) {
        this.consumerMiddleName = value;
    }

    /**
     * Gets the value of the consumerLastName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerLastName() {
        return consumerLastName;
    }

    /**
     * Sets the value of the consumerLastName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerLastName(String value) {
        this.consumerLastName = value;
    }

    /**
     * Gets the value of the consumerLastName2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerLastName2() {
        return consumerLastName2;
    }

    /**
     * Sets the value of the consumerLastName2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerLastName2(String value) {
        this.consumerLastName2 = value;
    }

    /**
     * Gets the value of the consumerAddress property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerAddress() {
        return consumerAddress;
    }

    /**
     * Sets the value of the consumerAddress property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerAddress(String value) {
        this.consumerAddress = value;
    }

    /**
     * Gets the value of the consumerAddress2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerAddress2() {
        return consumerAddress2;
    }

    /**
     * Sets the value of the consumerAddress2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerAddress2(String value) {
        this.consumerAddress2 = value;
    }

    /**
     * Gets the value of the consumerAddress3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerAddress3() {
        return consumerAddress3;
    }

    /**
     * Sets the value of the consumerAddress3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerAddress3(String value) {
        this.consumerAddress3 = value;
    }

    /**
     * Gets the value of the consumerCity property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerCity() {
        return consumerCity;
    }

    /**
     * Sets the value of the consumerCity property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerCity(String value) {
        this.consumerCity = value;
    }

    /**
     * Gets the value of the consumerState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerState() {
        return consumerState;
    }

    /**
     * Sets the value of the consumerState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerState(String value) {
        this.consumerState = value;
    }

    /**
     * Gets the value of the consumerZipCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerZipCode() {
        return consumerZipCode;
    }

    /**
     * Sets the value of the consumerZipCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerZipCode(String value) {
        this.consumerZipCode = value;
    }

    /**
     * Gets the value of the consumerCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerCountry() {
        return consumerCountry;
    }

    /**
     * Sets the value of the consumerCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerCountry(String value) {
        this.consumerCountry = value;
    }

    /**
     * Gets the value of the consumerHomePhone property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerHomePhone() {
        return consumerHomePhone;
    }

    /**
     * Sets the value of the consumerHomePhone property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerHomePhone(String value) {
        this.consumerHomePhone = value;
    }

    /**
     * Gets the value of the consumerEmailAddress property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerEmailAddress() {
        return consumerEmailAddress;
    }

    /**
     * Sets the value of the consumerEmailAddress property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerEmailAddress(String value) {
        this.consumerEmailAddress = value;
    }

    /**
     * Gets the value of the consumerMobilePhone property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerMobilePhone() {
        return consumerMobilePhone;
    }

    /**
     * Sets the value of the consumerMobilePhone property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerMobilePhone(String value) {
        this.consumerMobilePhone = value;
    }

    /**
     * Gets the value of the personalIdNumber1 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdNumber1() {
        return personalIdNumber1;
    }

    /**
     * Sets the value of the personalIdNumber1 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdNumber1(String value) {
        this.personalIdNumber1 = value;
    }

    /**
     * Gets the value of the personalIdTypeCode1 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdTypeCode1() {
        return personalIdTypeCode1;
    }

    /**
     * Sets the value of the personalIdTypeCode1 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdTypeCode1(String value) {
        this.personalIdTypeCode1 = value;
    }

    /**
     * Gets the value of the personalIdIssueOfficeCode1 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueOfficeCode1() {
        return personalIdIssueOfficeCode1;
    }

    /**
     * Sets the value of the personalIdIssueOfficeCode1 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueOfficeCode1(String value) {
        this.personalIdIssueOfficeCode1 = value;
    }

    /**
     * Gets the value of the personalIdIssueCity1 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueCity1() {
        return personalIdIssueCity1;
    }

    /**
     * Sets the value of the personalIdIssueCity1 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueCity1(String value) {
        this.personalIdIssueCity1 = value;
    }

    /**
     * Gets the value of the personalIdIssueState1 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueState1() {
        return personalIdIssueState1;
    }

    /**
     * Sets the value of the personalIdIssueState1 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueState1(String value) {
        this.personalIdIssueState1 = value;
    }

    /**
     * Gets the value of the personalIdIssueCountry1 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueCountry1() {
        return personalIdIssueCountry1;
    }

    /**
     * Sets the value of the personalIdIssueCountry1 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueCountry1(String value) {
        this.personalIdIssueCountry1 = value;
    }

    /**
     * Gets the value of the personalIdIssueMonth1 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueMonth1() {
        return personalIdIssueMonth1;
    }

    /**
     * Sets the value of the personalIdIssueMonth1 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueMonth1(String value) {
        this.personalIdIssueMonth1 = value;
    }

    /**
     * Gets the value of the personalIdIssueDay1 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueDay1() {
        return personalIdIssueDay1;
    }

    /**
     * Sets the value of the personalIdIssueDay1 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueDay1(String value) {
        this.personalIdIssueDay1 = value;
    }

    /**
     * Gets the value of the personalIdIssueYear1 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueYear1() {
        return personalIdIssueYear1;
    }

    /**
     * Sets the value of the personalIdIssueYear1 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueYear1(String value) {
        this.personalIdIssueYear1 = value;
    }

    /**
     * Gets the value of the personalIdExpirationMonth1 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdExpirationMonth1() {
        return personalIdExpirationMonth1;
    }

    /**
     * Sets the value of the personalIdExpirationMonth1 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdExpirationMonth1(String value) {
        this.personalIdExpirationMonth1 = value;
    }

    /**
     * Gets the value of the personalIdExpirationDay1 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdExpirationDay1() {
        return personalIdExpirationDay1;
    }

    /**
     * Sets the value of the personalIdExpirationDay1 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdExpirationDay1(String value) {
        this.personalIdExpirationDay1 = value;
    }

    /**
     * Gets the value of the personalIdExpirationYear1 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdExpirationYear1() {
        return personalIdExpirationYear1;
    }

    /**
     * Sets the value of the personalIdExpirationYear1 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdExpirationYear1(String value) {
        this.personalIdExpirationYear1 = value;
    }

    /**
     * Gets the value of the personalIdNumber2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdNumber2() {
        return personalIdNumber2;
    }

    /**
     * Sets the value of the personalIdNumber2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdNumber2(String value) {
        this.personalIdNumber2 = value;
    }

    /**
     * Gets the value of the personalIdTypeCode2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdTypeCode2() {
        return personalIdTypeCode2;
    }

    /**
     * Sets the value of the personalIdTypeCode2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdTypeCode2(String value) {
        this.personalIdTypeCode2 = value;
    }

    /**
     * Gets the value of the personalIdIssueOfficeCode2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueOfficeCode2() {
        return personalIdIssueOfficeCode2;
    }

    /**
     * Sets the value of the personalIdIssueOfficeCode2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueOfficeCode2(String value) {
        this.personalIdIssueOfficeCode2 = value;
    }

    /**
     * Gets the value of the personalIdIssueCity2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueCity2() {
        return personalIdIssueCity2;
    }

    /**
     * Sets the value of the personalIdIssueCity2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueCity2(String value) {
        this.personalIdIssueCity2 = value;
    }

    /**
     * Gets the value of the personalIdIssueState2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueState2() {
        return personalIdIssueState2;
    }

    /**
     * Sets the value of the personalIdIssueState2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueState2(String value) {
        this.personalIdIssueState2 = value;
    }

    /**
     * Gets the value of the personalIdIssueCountry2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueCountry2() {
        return personalIdIssueCountry2;
    }

    /**
     * Sets the value of the personalIdIssueCountry2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueCountry2(String value) {
        this.personalIdIssueCountry2 = value;
    }

    /**
     * Gets the value of the personalIdIssueMonth2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueMonth2() {
        return personalIdIssueMonth2;
    }

    /**
     * Sets the value of the personalIdIssueMonth2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueMonth2(String value) {
        this.personalIdIssueMonth2 = value;
    }

    /**
     * Gets the value of the personalIdIssueDay2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueDay2() {
        return personalIdIssueDay2;
    }

    /**
     * Sets the value of the personalIdIssueDay2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueDay2(String value) {
        this.personalIdIssueDay2 = value;
    }

    /**
     * Gets the value of the personalIdIssueYear2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueYear2() {
        return personalIdIssueYear2;
    }

    /**
     * Sets the value of the personalIdIssueYear2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueYear2(String value) {
        this.personalIdIssueYear2 = value;
    }

    /**
     * Gets the value of the personalIdExpirationMonth2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdExpirationMonth2() {
        return personalIdExpirationMonth2;
    }

    /**
     * Sets the value of the personalIdExpirationMonth2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdExpirationMonth2(String value) {
        this.personalIdExpirationMonth2 = value;
    }

    /**
     * Gets the value of the personalIdExpirationDay2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdExpirationDay2() {
        return personalIdExpirationDay2;
    }

    /**
     * Sets the value of the personalIdExpirationDay2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdExpirationDay2(String value) {
        this.personalIdExpirationDay2 = value;
    }

    /**
     * Gets the value of the personalIdExpirationYear2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdExpirationYear2() {
        return personalIdExpirationYear2;
    }

    /**
     * Sets the value of the personalIdExpirationYear2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdExpirationYear2(String value) {
        this.personalIdExpirationYear2 = value;
    }

    /**
     * Gets the value of the personalIdNumber3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdNumber3() {
        return personalIdNumber3;
    }

    /**
     * Sets the value of the personalIdNumber3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdNumber3(String value) {
        this.personalIdNumber3 = value;
    }

    /**
     * Gets the value of the personalIdTypeCode3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdTypeCode3() {
        return personalIdTypeCode3;
    }

    /**
     * Sets the value of the personalIdTypeCode3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdTypeCode3(String value) {
        this.personalIdTypeCode3 = value;
    }

    /**
     * Gets the value of the personalIdIssueOfficeCode3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueOfficeCode3() {
        return personalIdIssueOfficeCode3;
    }

    /**
     * Sets the value of the personalIdIssueOfficeCode3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueOfficeCode3(String value) {
        this.personalIdIssueOfficeCode3 = value;
    }

    /**
     * Gets the value of the personalIdIssueCity3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueCity3() {
        return personalIdIssueCity3;
    }

    /**
     * Sets the value of the personalIdIssueCity3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueCity3(String value) {
        this.personalIdIssueCity3 = value;
    }

    /**
     * Gets the value of the personalIdIssueState3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueState3() {
        return personalIdIssueState3;
    }

    /**
     * Sets the value of the personalIdIssueState3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueState3(String value) {
        this.personalIdIssueState3 = value;
    }

    /**
     * Gets the value of the personalIdIssueCountry3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueCountry3() {
        return personalIdIssueCountry3;
    }

    /**
     * Sets the value of the personalIdIssueCountry3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueCountry3(String value) {
        this.personalIdIssueCountry3 = value;
    }

    /**
     * Gets the value of the personalIdIssueMonth3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueMonth3() {
        return personalIdIssueMonth3;
    }

    /**
     * Sets the value of the personalIdIssueMonth3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueMonth3(String value) {
        this.personalIdIssueMonth3 = value;
    }

    /**
     * Gets the value of the personalIdIssueDay3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueDay3() {
        return personalIdIssueDay3;
    }

    /**
     * Sets the value of the personalIdIssueDay3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueDay3(String value) {
        this.personalIdIssueDay3 = value;
    }

    /**
     * Gets the value of the personalIdIssueYear3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdIssueYear3() {
        return personalIdIssueYear3;
    }

    /**
     * Sets the value of the personalIdIssueYear3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdIssueYear3(String value) {
        this.personalIdIssueYear3 = value;
    }

    /**
     * Gets the value of the personalIdExpirationMonth3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdExpirationMonth3() {
        return personalIdExpirationMonth3;
    }

    /**
     * Sets the value of the personalIdExpirationMonth3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdExpirationMonth3(String value) {
        this.personalIdExpirationMonth3 = value;
    }

    /**
     * Gets the value of the personalIdExpirationDay3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdExpirationDay3() {
        return personalIdExpirationDay3;
    }

    /**
     * Sets the value of the personalIdExpirationDay3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdExpirationDay3(String value) {
        this.personalIdExpirationDay3 = value;
    }

    /**
     * Gets the value of the personalIdExpirationYear3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPersonalIdExpirationYear3() {
        return personalIdExpirationYear3;
    }

    /**
     * Sets the value of the personalIdExpirationYear3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPersonalIdExpirationYear3(String value) {
        this.personalIdExpirationYear3 = value;
    }

    /**
     * Gets the value of the consumerDOB property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getConsumerDOB() {
        return consumerDOB;
    }

    /**
     * Sets the value of the consumerDOB property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setConsumerDOB(XMLGregorianCalendar value) {
        this.consumerDOB = value;
    }

    /**
     * Gets the value of the consumerBirthCity property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerBirthCity() {
        return consumerBirthCity;
    }

    /**
     * Sets the value of the consumerBirthCity property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerBirthCity(String value) {
        this.consumerBirthCity = value;
    }

    /**
     * Gets the value of the consumerBirthState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerBirthState() {
        return consumerBirthState;
    }

    /**
     * Sets the value of the consumerBirthState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerBirthState(String value) {
        this.consumerBirthState = value;
    }

    /**
     * Gets the value of the consumerBirthCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConsumerBirthCountry() {
        return consumerBirthCountry;
    }

    /**
     * Sets the value of the consumerBirthCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConsumerBirthCountry(String value) {
        this.consumerBirthCountry = value;
    }

    /**
     * Gets the value of the gender property.
     * 
     * @return
     *     possible object is
     *     {@link GenderType }
     *     
     */
    public GenderType getGender() {
        return gender;
    }

    /**
     * Sets the value of the gender property.
     * 
     * @param value
     *     allowed object is
     *     {@link GenderType }
     *     
     */
    public void setGender(GenderType value) {
        this.gender = value;
    }

    /**
     * Gets the value of the marketingOptIn property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isMarketingOptIn() {
        return marketingOptIn;
    }

    /**
     * Sets the value of the marketingOptIn property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setMarketingOptIn(Boolean value) {
        this.marketingOptIn = value;
    }

    /**
     * Gets the value of the marketingByCellPhone property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isMarketingByCellPhone() {
        return marketingByCellPhone;
    }

    /**
     * Sets the value of the marketingByCellPhone property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setMarketingByCellPhone(Boolean value) {
        this.marketingByCellPhone = value;
    }

    /**
     * Gets the value of the marketingByEmail property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isMarketingByEmail() {
        return marketingByEmail;
    }

    /**
     * Sets the value of the marketingByEmail property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setMarketingByEmail(Boolean value) {
        this.marketingByEmail = value;
    }

    /**
     * Gets the value of the marketingByHomePhone property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isMarketingByHomePhone() {
        return marketingByHomePhone;
    }

    /**
     * Sets the value of the marketingByHomePhone property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setMarketingByHomePhone(Boolean value) {
        this.marketingByHomePhone = value;
    }

    /**
     * Gets the value of the marketingByMail property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isMarketingByMail() {
        return marketingByMail;
    }

    /**
     * Sets the value of the marketingByMail property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setMarketingByMail(Boolean value) {
        this.marketingByMail = value;
    }

    /**
     * Gets the value of the marketingBySMS property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isMarketingBySMS() {
        return marketingBySMS;
    }

    /**
     * Sets the value of the marketingBySMS property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setMarketingBySMS(Boolean value) {
        this.marketingBySMS = value;
    }

    /**
     * Gets the value of the marketingLanguage property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMarketingLanguage() {
        return marketingLanguage;
    }

    /**
     * Sets the value of the marketingLanguage property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMarketingLanguage(String value) {
        this.marketingLanguage = value;
    }

    /**
     * Gets the value of the receiveNoticeOptIn property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isReceiveNoticeOptIn() {
        return receiveNoticeOptIn;
    }

    /**
     * Sets the value of the receiveNoticeOptIn property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setReceiveNoticeOptIn(Boolean value) {
        this.receiveNoticeOptIn = value;
    }

    /**
     * Gets the value of the receiveNoticeEmailAddress property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiveNoticeEmailAddress() {
        return receiveNoticeEmailAddress;
    }

    /**
     * Sets the value of the receiveNoticeEmailAddress property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiveNoticeEmailAddress(String value) {
        this.receiveNoticeEmailAddress = value;
    }

    /**
     * Gets the value of the receiveNoticeViaEMail property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isReceiveNoticeViaEMail() {
        return receiveNoticeViaEMail;
    }

    /**
     * Sets the value of the receiveNoticeViaEMail property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setReceiveNoticeViaEMail(Boolean value) {
        this.receiveNoticeViaEMail = value;
    }

    /**
     * Gets the value of the receiveNoticeViaSMS property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isReceiveNoticeViaSMS() {
        return receiveNoticeViaSMS;
    }

    /**
     * Sets the value of the receiveNoticeViaSMS property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setReceiveNoticeViaSMS(Boolean value) {
        this.receiveNoticeViaSMS = value;
    }

    /**
     * Gets the value of the receiveNoticeMobilePhone property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiveNoticeMobilePhone() {
        return receiveNoticeMobilePhone;
    }

    /**
     * Sets the value of the receiveNoticeMobilePhone property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiveNoticeMobilePhone(String value) {
        this.receiveNoticeMobilePhone = value;
    }

    /**
     * Gets the value of the receiveNoticeLanguage property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiveNoticeLanguage() {
        return receiveNoticeLanguage;
    }

    /**
     * Sets the value of the receiveNoticeLanguage property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiveNoticeLanguage(String value) {
        this.receiveNoticeLanguage = value;
    }

    /**
     * Gets the value of the quarterlyStatements property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isQuarterlyStatements() {
        return quarterlyStatements;
    }

    /**
     * Sets the value of the quarterlyStatements property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setQuarterlyStatements(Boolean value) {
        this.quarterlyStatements = value;
    }

    /**
     * Gets the value of the quarterlyStatementsByEmail property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isQuarterlyStatementsByEmail() {
        return quarterlyStatementsByEmail;
    }

    /**
     * Sets the value of the quarterlyStatementsByEmail property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setQuarterlyStatementsByEmail(Boolean value) {
        this.quarterlyStatementsByEmail = value;
    }

    /**
     * Gets the value of the quarterlyStatementsByMail property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isQuarterlyStatementsByMail() {
        return quarterlyStatementsByMail;
    }

    /**
     * Sets the value of the quarterlyStatementsByMail property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setQuarterlyStatementsByMail(Boolean value) {
        this.quarterlyStatementsByMail = value;
    }

    /**
     * Gets the value of the consentOfPersonalInformationThirdParty property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isConsentOfPersonalInformationThirdParty() {
        return consentOfPersonalInformationThirdParty;
    }

    /**
     * Sets the value of the consentOfPersonalInformationThirdParty property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setConsentOfPersonalInformationThirdParty(Boolean value) {
        this.consentOfPersonalInformationThirdParty = value;
    }

    /**
     * Gets the value of the agentAcknowledgement property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isAgentAcknowledgement() {
        return agentAcknowledgement;
    }

    /**
     * Sets the value of the agentAcknowledgement property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setAgentAcknowledgement(Boolean value) {
        this.agentAcknowledgement = value;
    }

}
