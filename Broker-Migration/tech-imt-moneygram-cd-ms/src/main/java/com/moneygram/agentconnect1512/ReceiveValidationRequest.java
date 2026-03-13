
package com.moneygram.agentconnect1512;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import javax.xml.datatype.XMLGregorianCalendar;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for ReceiveValidationRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ReceiveValidationRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Request"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="agentStagingChannel" type="{http://www.moneygram.com/AgentConnect1512}EnumType" minOccurs="0"/&gt;
 *         &lt;element name="operatorName" type="{http://www.moneygram.com/AgentConnect1512}stringMax80" minOccurs="0"/&gt;
 *         &lt;element name="referenceNumber" type="{http://www.moneygram.com/AgentConnect1512}referenceNumber"/&gt;
 *         &lt;element name="pin" type="{http://www.moneygram.com/AgentConnect1512}stringMax8" minOccurs="0"/&gt;
 *         &lt;element name="receiveCurrency" type="{http://www.moneygram.com/AgentConnect1512}currencyCode"/&gt;
 *         &lt;element name="agentCheckNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax12" minOccurs="0"/&gt;
 *         &lt;element name="agentCheckType" type="{http://www.moneygram.com/AgentConnect1512}checkType" minOccurs="0"/&gt;
 *         &lt;element name="agentCheckAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="customerCheckNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax12" minOccurs="0"/&gt;
 *         &lt;element name="customerCheckType" type="{http://www.moneygram.com/AgentConnect1512}checkType" minOccurs="0"/&gt;
 *         &lt;element name="customerCheckAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="receiverAddress" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="receiverAddress2" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="receiverAddress3" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="receiverCity" type="{http://www.moneygram.com/AgentConnect1512}cityTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="receiverState" type="{http://www.moneygram.com/AgentConnect1512}stateType" minOccurs="0"/&gt;
 *         &lt;element name="receiverZipCode" type="{http://www.moneygram.com/AgentConnect1512}zipType" minOccurs="0"/&gt;
 *         &lt;element name="receiverCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="receiverMailingAddress" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="receiverMailingAddress2" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="receiverMailingAddress3" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="receiverMailingCity" type="{http://www.moneygram.com/AgentConnect1512}cityTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="receiverMailingState" type="{http://www.moneygram.com/AgentConnect1512}stateType" minOccurs="0"/&gt;
 *         &lt;element name="receiverMailingZipCode" type="{http://www.moneygram.com/AgentConnect1512}zipType" minOccurs="0"/&gt;
 *         &lt;element name="receiverMailingCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="receiverPhotoIdType" type="{http://www.moneygram.com/AgentConnect1512}photoIdType" minOccurs="0"/&gt;
 *         &lt;element name="receiverPhotoIdNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax25" minOccurs="0"/&gt;
 *         &lt;element name="receiverPhotoIdCity" type="{http://www.moneygram.com/AgentConnect1512}cityType" minOccurs="0"/&gt;
 *         &lt;element name="receiverPhotoIdState" type="{http://www.moneygram.com/AgentConnect1512}stateType" minOccurs="0"/&gt;
 *         &lt;element name="receiverPhotoIdCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="receiverLegalIdType" type="{http://www.moneygram.com/AgentConnect1512}legalIdType" minOccurs="0"/&gt;
 *         &lt;element name="receiverLegalIdNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="receiverDOB" type="{http://www.w3.org/2001/XMLSchema}date" minOccurs="0"/&gt;
 *         &lt;element name="receiverOccupation" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyFirstName" type="{http://www.moneygram.com/AgentConnect1512}fNameType40" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyMiddleName" type="{http://www.moneygram.com/AgentConnect1512}mNameType40" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLastName" type="{http://www.moneygram.com/AgentConnect1512}lNameType40" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLastName2" type="{http://www.moneygram.com/AgentConnect1512}lNameType40" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyAddress" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyAddress2" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyAddress3" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyCity" type="{http://www.moneygram.com/AgentConnect1512}cityTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyState" type="{http://www.moneygram.com/AgentConnect1512}stateType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyZipCode" type="{http://www.moneygram.com/AgentConnect1512}zipType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdType" type="{http://www.moneygram.com/AgentConnect1512}legalIdType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyDOB" type="{http://www.w3.org/2001/XMLSchema}date" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyOrg" type="{http://www.moneygram.com/AgentConnect1512}stringMax60" minOccurs="0"/&gt;
 *         &lt;element name="receiverBirthCity" type="{http://www.moneygram.com/AgentConnect1512}cityTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="receiverBirthCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="receiverNationalityCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="receiverNationalityAtBirthCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="pcTerminalNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax10" minOccurs="0"/&gt;
 *         &lt;element name="agentUseReceiveData" type="{http://www.moneygram.com/AgentConnect1512}stringMax200" minOccurs="0"/&gt;
 *         &lt;element name="billerAccountNumber" type="{http://www.moneygram.com/AgentConnect1512}billerAccountNumber" minOccurs="0"/&gt;
 *         &lt;element name="otherPayoutType" type="{http://www.moneygram.com/AgentConnect1512}otherPayoutType" minOccurs="0"/&gt;
 *         &lt;element name="otherPayoutAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="cardExpirationMonth" type="{http://www.moneygram.com/AgentConnect1512}month" minOccurs="0"/&gt;
 *         &lt;element name="cardExpirationYear" type="{http://www.moneygram.com/AgentConnect1512}year" minOccurs="0"/&gt;
 *         &lt;element name="cardSwiped" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="consumerId" type="{http://www.moneygram.com/AgentConnect1512}consumerId"/&gt;
 *         &lt;element name="receiverPhone" type="{http://www.moneygram.com/AgentConnect1512}phoneType14" minOccurs="0"/&gt;
 *         &lt;element name="agentConsumerID" type="{http://www.moneygram.com/AgentConnect1512}agentConsumerId" minOccurs="0"/&gt;
 *         &lt;element name="agentTransactionId" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="mgiTransactionSessionID" type="{http://www.moneygram.com/AgentConnect1512}mgiTransactionSessionID"/&gt;
 *         &lt;element name="formFreeStaging" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="timeToLive" type="{http://www.moneygram.com/AgentConnect1512}int5" minOccurs="0"/&gt;
 *         &lt;element name="receivePurposeOfTransaction" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="receivePurposeOfTransactionOther" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="relationshipToSender" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="relationshipToSenderOther" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="receiverOccupationOther" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="receiverGender" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="receiverBirthState" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="receiverCitizenshipCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="receiverCitizenshipAtBirthCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="receiverDualCitizenshipCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="receiverPhotoIdIssueMonth" type="{http://www.moneygram.com/AgentConnect1512}monthType" minOccurs="0"/&gt;
 *         &lt;element name="receiverPhotoIdIssueYear" type="{http://www.moneygram.com/AgentConnect1512}yearType" minOccurs="0"/&gt;
 *         &lt;element name="receiverPhotoIdIssueDay" type="{http://www.moneygram.com/AgentConnect1512}dayType" minOccurs="0"/&gt;
 *         &lt;element name="receiverPhotoIdExpirationMonth" type="{http://www.moneygram.com/AgentConnect1512}monthType" minOccurs="0"/&gt;
 *         &lt;element name="receiverPhotoIdExpirationYear" type="{http://www.moneygram.com/AgentConnect1512}yearType" minOccurs="0"/&gt;
 *         &lt;element name="receiverPhotoIdExpirationDay" type="{http://www.moneygram.com/AgentConnect1512}dayType" minOccurs="0"/&gt;
 *         &lt;element name="receiverPhotoIdIssueAuthority" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="receiverLegalIdIssueMonth" type="{http://www.moneygram.com/AgentConnect1512}monthType" minOccurs="0"/&gt;
 *         &lt;element name="receiverLegalIdIssueYear" type="{http://www.moneygram.com/AgentConnect1512}yearType" minOccurs="0"/&gt;
 *         &lt;element name="receiverLegalIdIssueDay" type="{http://www.moneygram.com/AgentConnect1512}dayType" minOccurs="0"/&gt;
 *         &lt;element name="receiverLegalIdExpirationMonth" type="{http://www.moneygram.com/AgentConnect1512}monthType" minOccurs="0"/&gt;
 *         &lt;element name="receiverLegalIdExpirationYear" type="{http://www.moneygram.com/AgentConnect1512}yearType" minOccurs="0"/&gt;
 *         &lt;element name="receiverLegalIdExpirationDay" type="{http://www.moneygram.com/AgentConnect1512}dayType" minOccurs="0"/&gt;
 *         &lt;element name="receiverLegalIdIssueAuthority" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="receiverLegalIdState" type="{http://www.moneygram.com/AgentConnect1512}stateType" minOccurs="0"/&gt;
 *         &lt;element name="receiverLegalIdIssueCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="receiverPhoneNotAvailable" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="receiverPhoneCountryCode" type="{http://www.moneygram.com/AgentConnect1512}countryCodeType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyFirstNameNotAvailable" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyReceiverNameSuffix" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyReceiverNameSuffixOther" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyReceiverGender" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyReceiverOccupation" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyReceiverOccupationOther" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyReceiverBirthCity" type="{http://www.moneygram.com/AgentConnect1512}cityTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyReceiverBirthState" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyReceiverBirthCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyReceiverCitizenshipCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyReceiverCitizenshipAtBirthCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyReceiverDualCitizenshipCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdIssueMonth" type="{http://www.moneygram.com/AgentConnect1512}monthType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdIssueYear" type="{http://www.moneygram.com/AgentConnect1512}yearType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdIssueDay" type="{http://www.moneygram.com/AgentConnect1512}dayType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdExpirationMonth" type="{http://www.moneygram.com/AgentConnect1512}monthType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdExpirationYear" type="{http://www.moneygram.com/AgentConnect1512}yearType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdExpirationDay" type="{http://www.moneygram.com/AgentConnect1512}dayType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdIssueAuthority" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdState" type="{http://www.moneygram.com/AgentConnect1512}stateType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdIssueCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="primaryReceiptLanguage" type="{http://www.moneygram.com/AgentConnect1512}stringMax3" minOccurs="0"/&gt;
 *         &lt;element name="secondaryReceiptLanguage" type="{http://www.moneygram.com/AgentConnect1512}stringMax3" minOccurs="0"/&gt;
 *         &lt;element name="receiverIntendedUseOfMGIServices" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="receiverMotherMaidenName" type="{http://www.moneygram.com/AgentConnect1512}lNameType40" minOccurs="0"/&gt;
 *         &lt;element name="receiverFatherFirstName" type="{http://www.moneygram.com/AgentConnect1512}fNameType40" minOccurs="0"/&gt;
 *         &lt;element name="receiptImages" type="{http://www.moneygram.com/AgentConnect1512}ReceiptImagesContentType" minOccurs="0"/&gt;
 *         &lt;element name="fieldValues" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="keyValuePair" type="{http://www.moneygram.com/AgentConnect1512}KeyValuePair" maxOccurs="unbounded" minOccurs="0"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ReceiveValidationRequest", propOrder = {
    "agentStagingChannel",
    "operatorName",
    "referenceNumber",
    "pin",
    "receiveCurrency",
    "agentCheckNumber",
    "agentCheckType",
    "agentCheckAmount",
    "customerCheckNumber",
    "customerCheckType",
    "customerCheckAmount",
    "receiverAddress",
    "receiverAddress2",
    "receiverAddress3",
    "receiverCity",
    "receiverState",
    "receiverZipCode",
    "receiverCountry",
    "receiverMailingAddress",
    "receiverMailingAddress2",
    "receiverMailingAddress3",
    "receiverMailingCity",
    "receiverMailingState",
    "receiverMailingZipCode",
    "receiverMailingCountry",
    "receiverPhotoIdType",
    "receiverPhotoIdNumber",
    "receiverPhotoIdCity",
    "receiverPhotoIdState",
    "receiverPhotoIdCountry",
    "receiverLegalIdType",
    "receiverLegalIdNumber",
    "receiverDOB",
    "receiverOccupation",
    "thirdPartyFirstName",
    "thirdPartyMiddleName",
    "thirdPartyLastName",
    "thirdPartyLastName2",
    "thirdPartyAddress",
    "thirdPartyAddress2",
    "thirdPartyAddress3",
    "thirdPartyCity",
    "thirdPartyState",
    "thirdPartyZipCode",
    "thirdPartyCountry",
    "thirdPartyLegalIdType",
    "thirdPartyLegalIdNumber",
    "thirdPartyDOB",
    "thirdPartyOrg",
    "receiverBirthCity",
    "receiverBirthCountry",
    "receiverNationalityCountry",
    "receiverNationalityAtBirthCountry",
    "pcTerminalNumber",
    "agentUseReceiveData",
    "billerAccountNumber",
    "otherPayoutType",
    "otherPayoutAmount",
    "cardExpirationMonth",
    "cardExpirationYear",
    "cardSwiped",
    "consumerId",
    "receiverPhone",
    "agentConsumerID",
    "agentTransactionId",
    "mgiTransactionSessionID",
    "formFreeStaging",
    "timeToLive",
    "receivePurposeOfTransaction",
    "receivePurposeOfTransactionOther",
    "relationshipToSender",
    "relationshipToSenderOther",
    "receiverOccupationOther",
    "receiverGender",
    "receiverBirthState",
    "receiverCitizenshipCountry",
    "receiverCitizenshipAtBirthCountry",
    "receiverDualCitizenshipCountry",
    "receiverPhotoIdIssueMonth",
    "receiverPhotoIdIssueYear",
    "receiverPhotoIdIssueDay",
    "receiverPhotoIdExpirationMonth",
    "receiverPhotoIdExpirationYear",
    "receiverPhotoIdExpirationDay",
    "receiverPhotoIdIssueAuthority",
    "receiverLegalIdIssueMonth",
    "receiverLegalIdIssueYear",
    "receiverLegalIdIssueDay",
    "receiverLegalIdExpirationMonth",
    "receiverLegalIdExpirationYear",
    "receiverLegalIdExpirationDay",
    "receiverLegalIdIssueAuthority",
    "receiverLegalIdState",
    "receiverLegalIdIssueCountry",
    "receiverPhoneNotAvailable",
    "receiverPhoneCountryCode",
    "thirdPartyFirstNameNotAvailable",
    "thirdPartyReceiverNameSuffix",
    "thirdPartyReceiverNameSuffixOther",
    "thirdPartyReceiverGender",
    "thirdPartyReceiverOccupation",
    "thirdPartyReceiverOccupationOther",
    "thirdPartyReceiverBirthCity",
    "thirdPartyReceiverBirthState",
    "thirdPartyReceiverBirthCountry",
    "thirdPartyReceiverCitizenshipCountry",
    "thirdPartyReceiverCitizenshipAtBirthCountry",
    "thirdPartyReceiverDualCitizenshipCountry",
    "thirdPartyLegalIdIssueMonth",
    "thirdPartyLegalIdIssueYear",
    "thirdPartyLegalIdIssueDay",
    "thirdPartyLegalIdExpirationMonth",
    "thirdPartyLegalIdExpirationYear",
    "thirdPartyLegalIdExpirationDay",
    "thirdPartyLegalIdIssueAuthority",
    "thirdPartyLegalIdState",
    "thirdPartyLegalIdIssueCountry",
    "primaryReceiptLanguage",
    "secondaryReceiptLanguage",
    "receiverIntendedUseOfMGIServices",
    "receiverMotherMaidenName",
    "receiverFatherFirstName",
    "receiptImages",
    "fieldValues"
})
public class ReceiveValidationRequest
    extends Request
{

    protected String agentStagingChannel;
    protected String operatorName;
    @XmlElement(required = true)
    protected String referenceNumber;
    protected String pin;
    @XmlElement(required = true)
    protected String receiveCurrency;
    protected String agentCheckNumber;
    protected String agentCheckType;
    protected BigDecimal agentCheckAmount;
    protected String customerCheckNumber;
    protected String customerCheckType;
    protected BigDecimal customerCheckAmount;
    protected String receiverAddress;
    protected String receiverAddress2;
    protected String receiverAddress3;
    protected String receiverCity;
    protected String receiverState;
    protected String receiverZipCode;
    protected String receiverCountry;
    protected String receiverMailingAddress;
    protected String receiverMailingAddress2;
    protected String receiverMailingAddress3;
    protected String receiverMailingCity;
    protected String receiverMailingState;
    protected String receiverMailingZipCode;
    protected String receiverMailingCountry;
    protected String receiverPhotoIdType;
    protected String receiverPhotoIdNumber;
    protected String receiverPhotoIdCity;
    protected String receiverPhotoIdState;
    protected String receiverPhotoIdCountry;
    protected String receiverLegalIdType;
    protected String receiverLegalIdNumber;
    @XmlSchemaType(name = "date")
    protected XMLGregorianCalendar receiverDOB;
    protected String receiverOccupation;
    protected String thirdPartyFirstName;
    protected String thirdPartyMiddleName;
    protected String thirdPartyLastName;
    protected String thirdPartyLastName2;
    protected String thirdPartyAddress;
    protected String thirdPartyAddress2;
    protected String thirdPartyAddress3;
    protected String thirdPartyCity;
    protected String thirdPartyState;
    protected String thirdPartyZipCode;
    protected String thirdPartyCountry;
    protected String thirdPartyLegalIdType;
    protected String thirdPartyLegalIdNumber;
    @XmlSchemaType(name = "date")
    protected XMLGregorianCalendar thirdPartyDOB;
    protected String thirdPartyOrg;
    protected String receiverBirthCity;
    protected String receiverBirthCountry;
    protected String receiverNationalityCountry;
    protected String receiverNationalityAtBirthCountry;
    protected String pcTerminalNumber;
    protected String agentUseReceiveData;
    protected String billerAccountNumber;
    protected String otherPayoutType;
    protected BigDecimal otherPayoutAmount;
    protected String cardExpirationMonth;
    protected String cardExpirationYear;
    protected Boolean cardSwiped;
    @XmlElement(required = true)
    protected String consumerId;
    protected String receiverPhone;
    protected String agentConsumerID;
    protected String agentTransactionId;
    @XmlElement(required = true)
    protected String mgiTransactionSessionID;
    protected boolean formFreeStaging;
    protected BigInteger timeToLive;
    protected String receivePurposeOfTransaction;
    protected String receivePurposeOfTransactionOther;
    protected String relationshipToSender;
    protected String relationshipToSenderOther;
    protected String receiverOccupationOther;
    protected String receiverGender;
    protected String receiverBirthState;
    protected String receiverCitizenshipCountry;
    protected String receiverCitizenshipAtBirthCountry;
    protected String receiverDualCitizenshipCountry;
    protected String receiverPhotoIdIssueMonth;
    protected String receiverPhotoIdIssueYear;
    protected String receiverPhotoIdIssueDay;
    protected String receiverPhotoIdExpirationMonth;
    protected String receiverPhotoIdExpirationYear;
    protected String receiverPhotoIdExpirationDay;
    protected String receiverPhotoIdIssueAuthority;
    protected String receiverLegalIdIssueMonth;
    protected String receiverLegalIdIssueYear;
    protected String receiverLegalIdIssueDay;
    protected String receiverLegalIdExpirationMonth;
    protected String receiverLegalIdExpirationYear;
    protected String receiverLegalIdExpirationDay;
    protected String receiverLegalIdIssueAuthority;
    protected String receiverLegalIdState;
    protected String receiverLegalIdIssueCountry;
    protected Boolean receiverPhoneNotAvailable;
    protected String receiverPhoneCountryCode;
    protected Boolean thirdPartyFirstNameNotAvailable;
    protected String thirdPartyReceiverNameSuffix;
    protected String thirdPartyReceiverNameSuffixOther;
    protected String thirdPartyReceiverGender;
    protected String thirdPartyReceiverOccupation;
    protected String thirdPartyReceiverOccupationOther;
    protected String thirdPartyReceiverBirthCity;
    protected String thirdPartyReceiverBirthState;
    protected String thirdPartyReceiverBirthCountry;
    protected String thirdPartyReceiverCitizenshipCountry;
    protected String thirdPartyReceiverCitizenshipAtBirthCountry;
    protected String thirdPartyReceiverDualCitizenshipCountry;
    protected String thirdPartyLegalIdIssueMonth;
    protected String thirdPartyLegalIdIssueYear;
    protected String thirdPartyLegalIdIssueDay;
    protected String thirdPartyLegalIdExpirationMonth;
    protected String thirdPartyLegalIdExpirationYear;
    protected String thirdPartyLegalIdExpirationDay;
    protected String thirdPartyLegalIdIssueAuthority;
    protected String thirdPartyLegalIdState;
    protected String thirdPartyLegalIdIssueCountry;
    protected String primaryReceiptLanguage;
    protected String secondaryReceiptLanguage;
    protected String receiverIntendedUseOfMGIServices;
    protected String receiverMotherMaidenName;
    protected String receiverFatherFirstName;
    protected ReceiptImagesContentType receiptImages;
    protected ReceiveValidationRequest.FieldValues fieldValues;

    /**
     * Gets the value of the agentStagingChannel property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAgentStagingChannel() {
        return agentStagingChannel;
    }

    /**
     * Sets the value of the agentStagingChannel property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAgentStagingChannel(String value) {
        this.agentStagingChannel = value;
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
     * Gets the value of the pin property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPin() {
        return pin;
    }

    /**
     * Sets the value of the pin property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPin(String value) {
        this.pin = value;
    }

    /**
     * Gets the value of the receiveCurrency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiveCurrency() {
        return receiveCurrency;
    }

    /**
     * Sets the value of the receiveCurrency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiveCurrency(String value) {
        this.receiveCurrency = value;
    }

    /**
     * Gets the value of the agentCheckNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAgentCheckNumber() {
        return agentCheckNumber;
    }

    /**
     * Sets the value of the agentCheckNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAgentCheckNumber(String value) {
        this.agentCheckNumber = value;
    }

    /**
     * Gets the value of the agentCheckType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAgentCheckType() {
        return agentCheckType;
    }

    /**
     * Sets the value of the agentCheckType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAgentCheckType(String value) {
        this.agentCheckType = value;
    }

    /**
     * Gets the value of the agentCheckAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getAgentCheckAmount() {
        return agentCheckAmount;
    }

    /**
     * Sets the value of the agentCheckAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setAgentCheckAmount(BigDecimal value) {
        this.agentCheckAmount = value;
    }

    /**
     * Gets the value of the customerCheckNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomerCheckNumber() {
        return customerCheckNumber;
    }

    /**
     * Sets the value of the customerCheckNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomerCheckNumber(String value) {
        this.customerCheckNumber = value;
    }

    /**
     * Gets the value of the customerCheckType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomerCheckType() {
        return customerCheckType;
    }

    /**
     * Sets the value of the customerCheckType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomerCheckType(String value) {
        this.customerCheckType = value;
    }

    /**
     * Gets the value of the customerCheckAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getCustomerCheckAmount() {
        return customerCheckAmount;
    }

    /**
     * Sets the value of the customerCheckAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setCustomerCheckAmount(BigDecimal value) {
        this.customerCheckAmount = value;
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
     * Gets the value of the receiverMailingAddress property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverMailingAddress() {
        return receiverMailingAddress;
    }

    /**
     * Sets the value of the receiverMailingAddress property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverMailingAddress(String value) {
        this.receiverMailingAddress = value;
    }

    /**
     * Gets the value of the receiverMailingAddress2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverMailingAddress2() {
        return receiverMailingAddress2;
    }

    /**
     * Sets the value of the receiverMailingAddress2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverMailingAddress2(String value) {
        this.receiverMailingAddress2 = value;
    }

    /**
     * Gets the value of the receiverMailingAddress3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverMailingAddress3() {
        return receiverMailingAddress3;
    }

    /**
     * Sets the value of the receiverMailingAddress3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverMailingAddress3(String value) {
        this.receiverMailingAddress3 = value;
    }

    /**
     * Gets the value of the receiverMailingCity property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverMailingCity() {
        return receiverMailingCity;
    }

    /**
     * Sets the value of the receiverMailingCity property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverMailingCity(String value) {
        this.receiverMailingCity = value;
    }

    /**
     * Gets the value of the receiverMailingState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverMailingState() {
        return receiverMailingState;
    }

    /**
     * Sets the value of the receiverMailingState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverMailingState(String value) {
        this.receiverMailingState = value;
    }

    /**
     * Gets the value of the receiverMailingZipCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverMailingZipCode() {
        return receiverMailingZipCode;
    }

    /**
     * Sets the value of the receiverMailingZipCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverMailingZipCode(String value) {
        this.receiverMailingZipCode = value;
    }

    /**
     * Gets the value of the receiverMailingCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverMailingCountry() {
        return receiverMailingCountry;
    }

    /**
     * Sets the value of the receiverMailingCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverMailingCountry(String value) {
        this.receiverMailingCountry = value;
    }

    /**
     * Gets the value of the receiverPhotoIdType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverPhotoIdType() {
        return receiverPhotoIdType;
    }

    /**
     * Sets the value of the receiverPhotoIdType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverPhotoIdType(String value) {
        this.receiverPhotoIdType = value;
    }

    /**
     * Gets the value of the receiverPhotoIdNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverPhotoIdNumber() {
        return receiverPhotoIdNumber;
    }

    /**
     * Sets the value of the receiverPhotoIdNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverPhotoIdNumber(String value) {
        this.receiverPhotoIdNumber = value;
    }

    /**
     * Gets the value of the receiverPhotoIdCity property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverPhotoIdCity() {
        return receiverPhotoIdCity;
    }

    /**
     * Sets the value of the receiverPhotoIdCity property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverPhotoIdCity(String value) {
        this.receiverPhotoIdCity = value;
    }

    /**
     * Gets the value of the receiverPhotoIdState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverPhotoIdState() {
        return receiverPhotoIdState;
    }

    /**
     * Sets the value of the receiverPhotoIdState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverPhotoIdState(String value) {
        this.receiverPhotoIdState = value;
    }

    /**
     * Gets the value of the receiverPhotoIdCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverPhotoIdCountry() {
        return receiverPhotoIdCountry;
    }

    /**
     * Sets the value of the receiverPhotoIdCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverPhotoIdCountry(String value) {
        this.receiverPhotoIdCountry = value;
    }

    /**
     * Gets the value of the receiverLegalIdType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverLegalIdType() {
        return receiverLegalIdType;
    }

    /**
     * Sets the value of the receiverLegalIdType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverLegalIdType(String value) {
        this.receiverLegalIdType = value;
    }

    /**
     * Gets the value of the receiverLegalIdNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverLegalIdNumber() {
        return receiverLegalIdNumber;
    }

    /**
     * Sets the value of the receiverLegalIdNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverLegalIdNumber(String value) {
        this.receiverLegalIdNumber = value;
    }

    /**
     * Gets the value of the receiverDOB property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getReceiverDOB() {
        return receiverDOB;
    }

    /**
     * Sets the value of the receiverDOB property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setReceiverDOB(XMLGregorianCalendar value) {
        this.receiverDOB = value;
    }

    /**
     * Gets the value of the receiverOccupation property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverOccupation() {
        return receiverOccupation;
    }

    /**
     * Sets the value of the receiverOccupation property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverOccupation(String value) {
        this.receiverOccupation = value;
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
     * Gets the value of the receiverBirthCity property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverBirthCity() {
        return receiverBirthCity;
    }

    /**
     * Sets the value of the receiverBirthCity property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverBirthCity(String value) {
        this.receiverBirthCity = value;
    }

    /**
     * Gets the value of the receiverBirthCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverBirthCountry() {
        return receiverBirthCountry;
    }

    /**
     * Sets the value of the receiverBirthCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverBirthCountry(String value) {
        this.receiverBirthCountry = value;
    }

    /**
     * Gets the value of the receiverNationalityCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverNationalityCountry() {
        return receiverNationalityCountry;
    }

    /**
     * Sets the value of the receiverNationalityCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverNationalityCountry(String value) {
        this.receiverNationalityCountry = value;
    }

    /**
     * Gets the value of the receiverNationalityAtBirthCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverNationalityAtBirthCountry() {
        return receiverNationalityAtBirthCountry;
    }

    /**
     * Sets the value of the receiverNationalityAtBirthCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverNationalityAtBirthCountry(String value) {
        this.receiverNationalityAtBirthCountry = value;
    }

    /**
     * Gets the value of the pcTerminalNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPcTerminalNumber() {
        return pcTerminalNumber;
    }

    /**
     * Sets the value of the pcTerminalNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPcTerminalNumber(String value) {
        this.pcTerminalNumber = value;
    }

    /**
     * Gets the value of the agentUseReceiveData property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAgentUseReceiveData() {
        return agentUseReceiveData;
    }

    /**
     * Sets the value of the agentUseReceiveData property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAgentUseReceiveData(String value) {
        this.agentUseReceiveData = value;
    }

    /**
     * Gets the value of the billerAccountNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillerAccountNumber() {
        return billerAccountNumber;
    }

    /**
     * Sets the value of the billerAccountNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillerAccountNumber(String value) {
        this.billerAccountNumber = value;
    }

    /**
     * Gets the value of the otherPayoutType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOtherPayoutType() {
        return otherPayoutType;
    }

    /**
     * Sets the value of the otherPayoutType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOtherPayoutType(String value) {
        this.otherPayoutType = value;
    }

    /**
     * Gets the value of the otherPayoutAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getOtherPayoutAmount() {
        return otherPayoutAmount;
    }

    /**
     * Sets the value of the otherPayoutAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setOtherPayoutAmount(BigDecimal value) {
        this.otherPayoutAmount = value;
    }

    /**
     * Gets the value of the cardExpirationMonth property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCardExpirationMonth() {
        return cardExpirationMonth;
    }

    /**
     * Sets the value of the cardExpirationMonth property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCardExpirationMonth(String value) {
        this.cardExpirationMonth = value;
    }

    /**
     * Gets the value of the cardExpirationYear property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCardExpirationYear() {
        return cardExpirationYear;
    }

    /**
     * Sets the value of the cardExpirationYear property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCardExpirationYear(String value) {
        this.cardExpirationYear = value;
    }

    /**
     * Gets the value of the cardSwiped property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isCardSwiped() {
        return cardSwiped;
    }

    /**
     * Sets the value of the cardSwiped property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setCardSwiped(Boolean value) {
        this.cardSwiped = value;
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
     * Gets the value of the agentConsumerID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAgentConsumerID() {
        return agentConsumerID;
    }

    /**
     * Sets the value of the agentConsumerID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAgentConsumerID(String value) {
        this.agentConsumerID = value;
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
     * Gets the value of the formFreeStaging property.
     * 
     */
    public boolean isFormFreeStaging() {
        return formFreeStaging;
    }

    /**
     * Sets the value of the formFreeStaging property.
     * 
     */
    public void setFormFreeStaging(boolean value) {
        this.formFreeStaging = value;
    }

    /**
     * Gets the value of the timeToLive property.
     * 
     * @return
     *     possible object is
     *     {@link BigInteger }
     *     
     */
    public BigInteger getTimeToLive() {
        return timeToLive;
    }

    /**
     * Sets the value of the timeToLive property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigInteger }
     *     
     */
    public void setTimeToLive(BigInteger value) {
        this.timeToLive = value;
    }

    /**
     * Gets the value of the receivePurposeOfTransaction property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceivePurposeOfTransaction() {
        return receivePurposeOfTransaction;
    }

    /**
     * Sets the value of the receivePurposeOfTransaction property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceivePurposeOfTransaction(String value) {
        this.receivePurposeOfTransaction = value;
    }

    /**
     * Gets the value of the receivePurposeOfTransactionOther property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceivePurposeOfTransactionOther() {
        return receivePurposeOfTransactionOther;
    }

    /**
     * Sets the value of the receivePurposeOfTransactionOther property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceivePurposeOfTransactionOther(String value) {
        this.receivePurposeOfTransactionOther = value;
    }

    /**
     * Gets the value of the relationshipToSender property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRelationshipToSender() {
        return relationshipToSender;
    }

    /**
     * Sets the value of the relationshipToSender property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRelationshipToSender(String value) {
        this.relationshipToSender = value;
    }

    /**
     * Gets the value of the relationshipToSenderOther property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRelationshipToSenderOther() {
        return relationshipToSenderOther;
    }

    /**
     * Sets the value of the relationshipToSenderOther property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRelationshipToSenderOther(String value) {
        this.relationshipToSenderOther = value;
    }

    /**
     * Gets the value of the receiverOccupationOther property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverOccupationOther() {
        return receiverOccupationOther;
    }

    /**
     * Sets the value of the receiverOccupationOther property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverOccupationOther(String value) {
        this.receiverOccupationOther = value;
    }

    /**
     * Gets the value of the receiverGender property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverGender() {
        return receiverGender;
    }

    /**
     * Sets the value of the receiverGender property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverGender(String value) {
        this.receiverGender = value;
    }

    /**
     * Gets the value of the receiverBirthState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverBirthState() {
        return receiverBirthState;
    }

    /**
     * Sets the value of the receiverBirthState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverBirthState(String value) {
        this.receiverBirthState = value;
    }

    /**
     * Gets the value of the receiverCitizenshipCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverCitizenshipCountry() {
        return receiverCitizenshipCountry;
    }

    /**
     * Sets the value of the receiverCitizenshipCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverCitizenshipCountry(String value) {
        this.receiverCitizenshipCountry = value;
    }

    /**
     * Gets the value of the receiverCitizenshipAtBirthCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverCitizenshipAtBirthCountry() {
        return receiverCitizenshipAtBirthCountry;
    }

    /**
     * Sets the value of the receiverCitizenshipAtBirthCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverCitizenshipAtBirthCountry(String value) {
        this.receiverCitizenshipAtBirthCountry = value;
    }

    /**
     * Gets the value of the receiverDualCitizenshipCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverDualCitizenshipCountry() {
        return receiverDualCitizenshipCountry;
    }

    /**
     * Sets the value of the receiverDualCitizenshipCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverDualCitizenshipCountry(String value) {
        this.receiverDualCitizenshipCountry = value;
    }

    /**
     * Gets the value of the receiverPhotoIdIssueMonth property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverPhotoIdIssueMonth() {
        return receiverPhotoIdIssueMonth;
    }

    /**
     * Sets the value of the receiverPhotoIdIssueMonth property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverPhotoIdIssueMonth(String value) {
        this.receiverPhotoIdIssueMonth = value;
    }

    /**
     * Gets the value of the receiverPhotoIdIssueYear property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverPhotoIdIssueYear() {
        return receiverPhotoIdIssueYear;
    }

    /**
     * Sets the value of the receiverPhotoIdIssueYear property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverPhotoIdIssueYear(String value) {
        this.receiverPhotoIdIssueYear = value;
    }

    /**
     * Gets the value of the receiverPhotoIdIssueDay property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverPhotoIdIssueDay() {
        return receiverPhotoIdIssueDay;
    }

    /**
     * Sets the value of the receiverPhotoIdIssueDay property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverPhotoIdIssueDay(String value) {
        this.receiverPhotoIdIssueDay = value;
    }

    /**
     * Gets the value of the receiverPhotoIdExpirationMonth property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverPhotoIdExpirationMonth() {
        return receiverPhotoIdExpirationMonth;
    }

    /**
     * Sets the value of the receiverPhotoIdExpirationMonth property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverPhotoIdExpirationMonth(String value) {
        this.receiverPhotoIdExpirationMonth = value;
    }

    /**
     * Gets the value of the receiverPhotoIdExpirationYear property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverPhotoIdExpirationYear() {
        return receiverPhotoIdExpirationYear;
    }

    /**
     * Sets the value of the receiverPhotoIdExpirationYear property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverPhotoIdExpirationYear(String value) {
        this.receiverPhotoIdExpirationYear = value;
    }

    /**
     * Gets the value of the receiverPhotoIdExpirationDay property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverPhotoIdExpirationDay() {
        return receiverPhotoIdExpirationDay;
    }

    /**
     * Sets the value of the receiverPhotoIdExpirationDay property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverPhotoIdExpirationDay(String value) {
        this.receiverPhotoIdExpirationDay = value;
    }

    /**
     * Gets the value of the receiverPhotoIdIssueAuthority property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverPhotoIdIssueAuthority() {
        return receiverPhotoIdIssueAuthority;
    }

    /**
     * Sets the value of the receiverPhotoIdIssueAuthority property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverPhotoIdIssueAuthority(String value) {
        this.receiverPhotoIdIssueAuthority = value;
    }

    /**
     * Gets the value of the receiverLegalIdIssueMonth property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverLegalIdIssueMonth() {
        return receiverLegalIdIssueMonth;
    }

    /**
     * Sets the value of the receiverLegalIdIssueMonth property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverLegalIdIssueMonth(String value) {
        this.receiverLegalIdIssueMonth = value;
    }

    /**
     * Gets the value of the receiverLegalIdIssueYear property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverLegalIdIssueYear() {
        return receiverLegalIdIssueYear;
    }

    /**
     * Sets the value of the receiverLegalIdIssueYear property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverLegalIdIssueYear(String value) {
        this.receiverLegalIdIssueYear = value;
    }

    /**
     * Gets the value of the receiverLegalIdIssueDay property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverLegalIdIssueDay() {
        return receiverLegalIdIssueDay;
    }

    /**
     * Sets the value of the receiverLegalIdIssueDay property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverLegalIdIssueDay(String value) {
        this.receiverLegalIdIssueDay = value;
    }

    /**
     * Gets the value of the receiverLegalIdExpirationMonth property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverLegalIdExpirationMonth() {
        return receiverLegalIdExpirationMonth;
    }

    /**
     * Sets the value of the receiverLegalIdExpirationMonth property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverLegalIdExpirationMonth(String value) {
        this.receiverLegalIdExpirationMonth = value;
    }

    /**
     * Gets the value of the receiverLegalIdExpirationYear property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverLegalIdExpirationYear() {
        return receiverLegalIdExpirationYear;
    }

    /**
     * Sets the value of the receiverLegalIdExpirationYear property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverLegalIdExpirationYear(String value) {
        this.receiverLegalIdExpirationYear = value;
    }

    /**
     * Gets the value of the receiverLegalIdExpirationDay property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverLegalIdExpirationDay() {
        return receiverLegalIdExpirationDay;
    }

    /**
     * Sets the value of the receiverLegalIdExpirationDay property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverLegalIdExpirationDay(String value) {
        this.receiverLegalIdExpirationDay = value;
    }

    /**
     * Gets the value of the receiverLegalIdIssueAuthority property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverLegalIdIssueAuthority() {
        return receiverLegalIdIssueAuthority;
    }

    /**
     * Sets the value of the receiverLegalIdIssueAuthority property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverLegalIdIssueAuthority(String value) {
        this.receiverLegalIdIssueAuthority = value;
    }

    /**
     * Gets the value of the receiverLegalIdState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverLegalIdState() {
        return receiverLegalIdState;
    }

    /**
     * Sets the value of the receiverLegalIdState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverLegalIdState(String value) {
        this.receiverLegalIdState = value;
    }

    /**
     * Gets the value of the receiverLegalIdIssueCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverLegalIdIssueCountry() {
        return receiverLegalIdIssueCountry;
    }

    /**
     * Sets the value of the receiverLegalIdIssueCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverLegalIdIssueCountry(String value) {
        this.receiverLegalIdIssueCountry = value;
    }

    /**
     * Gets the value of the receiverPhoneNotAvailable property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isReceiverPhoneNotAvailable() {
        return receiverPhoneNotAvailable;
    }

    /**
     * Sets the value of the receiverPhoneNotAvailable property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setReceiverPhoneNotAvailable(Boolean value) {
        this.receiverPhoneNotAvailable = value;
    }

    /**
     * Gets the value of the receiverPhoneCountryCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverPhoneCountryCode() {
        return receiverPhoneCountryCode;
    }

    /**
     * Sets the value of the receiverPhoneCountryCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverPhoneCountryCode(String value) {
        this.receiverPhoneCountryCode = value;
    }

    /**
     * Gets the value of the thirdPartyFirstNameNotAvailable property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isThirdPartyFirstNameNotAvailable() {
        return thirdPartyFirstNameNotAvailable;
    }

    /**
     * Sets the value of the thirdPartyFirstNameNotAvailable property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setThirdPartyFirstNameNotAvailable(Boolean value) {
        this.thirdPartyFirstNameNotAvailable = value;
    }

    /**
     * Gets the value of the thirdPartyReceiverNameSuffix property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyReceiverNameSuffix() {
        return thirdPartyReceiverNameSuffix;
    }

    /**
     * Sets the value of the thirdPartyReceiverNameSuffix property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyReceiverNameSuffix(String value) {
        this.thirdPartyReceiverNameSuffix = value;
    }

    /**
     * Gets the value of the thirdPartyReceiverNameSuffixOther property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyReceiverNameSuffixOther() {
        return thirdPartyReceiverNameSuffixOther;
    }

    /**
     * Sets the value of the thirdPartyReceiverNameSuffixOther property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyReceiverNameSuffixOther(String value) {
        this.thirdPartyReceiverNameSuffixOther = value;
    }

    /**
     * Gets the value of the thirdPartyReceiverGender property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyReceiverGender() {
        return thirdPartyReceiverGender;
    }

    /**
     * Sets the value of the thirdPartyReceiverGender property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyReceiverGender(String value) {
        this.thirdPartyReceiverGender = value;
    }

    /**
     * Gets the value of the thirdPartyReceiverOccupation property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyReceiverOccupation() {
        return thirdPartyReceiverOccupation;
    }

    /**
     * Sets the value of the thirdPartyReceiverOccupation property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyReceiverOccupation(String value) {
        this.thirdPartyReceiverOccupation = value;
    }

    /**
     * Gets the value of the thirdPartyReceiverOccupationOther property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyReceiverOccupationOther() {
        return thirdPartyReceiverOccupationOther;
    }

    /**
     * Sets the value of the thirdPartyReceiverOccupationOther property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyReceiverOccupationOther(String value) {
        this.thirdPartyReceiverOccupationOther = value;
    }

    /**
     * Gets the value of the thirdPartyReceiverBirthCity property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyReceiverBirthCity() {
        return thirdPartyReceiverBirthCity;
    }

    /**
     * Sets the value of the thirdPartyReceiverBirthCity property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyReceiverBirthCity(String value) {
        this.thirdPartyReceiverBirthCity = value;
    }

    /**
     * Gets the value of the thirdPartyReceiverBirthState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyReceiverBirthState() {
        return thirdPartyReceiverBirthState;
    }

    /**
     * Sets the value of the thirdPartyReceiverBirthState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyReceiverBirthState(String value) {
        this.thirdPartyReceiverBirthState = value;
    }

    /**
     * Gets the value of the thirdPartyReceiverBirthCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyReceiverBirthCountry() {
        return thirdPartyReceiverBirthCountry;
    }

    /**
     * Sets the value of the thirdPartyReceiverBirthCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyReceiverBirthCountry(String value) {
        this.thirdPartyReceiverBirthCountry = value;
    }

    /**
     * Gets the value of the thirdPartyReceiverCitizenshipCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyReceiverCitizenshipCountry() {
        return thirdPartyReceiverCitizenshipCountry;
    }

    /**
     * Sets the value of the thirdPartyReceiverCitizenshipCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyReceiverCitizenshipCountry(String value) {
        this.thirdPartyReceiverCitizenshipCountry = value;
    }

    /**
     * Gets the value of the thirdPartyReceiverCitizenshipAtBirthCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyReceiverCitizenshipAtBirthCountry() {
        return thirdPartyReceiverCitizenshipAtBirthCountry;
    }

    /**
     * Sets the value of the thirdPartyReceiverCitizenshipAtBirthCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyReceiverCitizenshipAtBirthCountry(String value) {
        this.thirdPartyReceiverCitizenshipAtBirthCountry = value;
    }

    /**
     * Gets the value of the thirdPartyReceiverDualCitizenshipCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyReceiverDualCitizenshipCountry() {
        return thirdPartyReceiverDualCitizenshipCountry;
    }

    /**
     * Sets the value of the thirdPartyReceiverDualCitizenshipCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyReceiverDualCitizenshipCountry(String value) {
        this.thirdPartyReceiverDualCitizenshipCountry = value;
    }

    /**
     * Gets the value of the thirdPartyLegalIdIssueMonth property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyLegalIdIssueMonth() {
        return thirdPartyLegalIdIssueMonth;
    }

    /**
     * Sets the value of the thirdPartyLegalIdIssueMonth property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyLegalIdIssueMonth(String value) {
        this.thirdPartyLegalIdIssueMonth = value;
    }

    /**
     * Gets the value of the thirdPartyLegalIdIssueYear property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyLegalIdIssueYear() {
        return thirdPartyLegalIdIssueYear;
    }

    /**
     * Sets the value of the thirdPartyLegalIdIssueYear property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyLegalIdIssueYear(String value) {
        this.thirdPartyLegalIdIssueYear = value;
    }

    /**
     * Gets the value of the thirdPartyLegalIdIssueDay property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyLegalIdIssueDay() {
        return thirdPartyLegalIdIssueDay;
    }

    /**
     * Sets the value of the thirdPartyLegalIdIssueDay property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyLegalIdIssueDay(String value) {
        this.thirdPartyLegalIdIssueDay = value;
    }

    /**
     * Gets the value of the thirdPartyLegalIdExpirationMonth property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyLegalIdExpirationMonth() {
        return thirdPartyLegalIdExpirationMonth;
    }

    /**
     * Sets the value of the thirdPartyLegalIdExpirationMonth property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyLegalIdExpirationMonth(String value) {
        this.thirdPartyLegalIdExpirationMonth = value;
    }

    /**
     * Gets the value of the thirdPartyLegalIdExpirationYear property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyLegalIdExpirationYear() {
        return thirdPartyLegalIdExpirationYear;
    }

    /**
     * Sets the value of the thirdPartyLegalIdExpirationYear property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyLegalIdExpirationYear(String value) {
        this.thirdPartyLegalIdExpirationYear = value;
    }

    /**
     * Gets the value of the thirdPartyLegalIdExpirationDay property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyLegalIdExpirationDay() {
        return thirdPartyLegalIdExpirationDay;
    }

    /**
     * Sets the value of the thirdPartyLegalIdExpirationDay property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyLegalIdExpirationDay(String value) {
        this.thirdPartyLegalIdExpirationDay = value;
    }

    /**
     * Gets the value of the thirdPartyLegalIdIssueAuthority property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyLegalIdIssueAuthority() {
        return thirdPartyLegalIdIssueAuthority;
    }

    /**
     * Sets the value of the thirdPartyLegalIdIssueAuthority property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyLegalIdIssueAuthority(String value) {
        this.thirdPartyLegalIdIssueAuthority = value;
    }

    /**
     * Gets the value of the thirdPartyLegalIdState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyLegalIdState() {
        return thirdPartyLegalIdState;
    }

    /**
     * Sets the value of the thirdPartyLegalIdState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyLegalIdState(String value) {
        this.thirdPartyLegalIdState = value;
    }

    /**
     * Gets the value of the thirdPartyLegalIdIssueCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartyLegalIdIssueCountry() {
        return thirdPartyLegalIdIssueCountry;
    }

    /**
     * Sets the value of the thirdPartyLegalIdIssueCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartyLegalIdIssueCountry(String value) {
        this.thirdPartyLegalIdIssueCountry = value;
    }

    /**
     * Gets the value of the primaryReceiptLanguage property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPrimaryReceiptLanguage() {
        return primaryReceiptLanguage;
    }

    /**
     * Sets the value of the primaryReceiptLanguage property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPrimaryReceiptLanguage(String value) {
        this.primaryReceiptLanguage = value;
    }

    /**
     * Gets the value of the secondaryReceiptLanguage property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSecondaryReceiptLanguage() {
        return secondaryReceiptLanguage;
    }

    /**
     * Sets the value of the secondaryReceiptLanguage property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSecondaryReceiptLanguage(String value) {
        this.secondaryReceiptLanguage = value;
    }

    /**
     * Gets the value of the receiverIntendedUseOfMGIServices property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverIntendedUseOfMGIServices() {
        return receiverIntendedUseOfMGIServices;
    }

    /**
     * Sets the value of the receiverIntendedUseOfMGIServices property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverIntendedUseOfMGIServices(String value) {
        this.receiverIntendedUseOfMGIServices = value;
    }

    /**
     * Gets the value of the receiverMotherMaidenName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverMotherMaidenName() {
        return receiverMotherMaidenName;
    }

    /**
     * Sets the value of the receiverMotherMaidenName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverMotherMaidenName(String value) {
        this.receiverMotherMaidenName = value;
    }

    /**
     * Gets the value of the receiverFatherFirstName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverFatherFirstName() {
        return receiverFatherFirstName;
    }

    /**
     * Sets the value of the receiverFatherFirstName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverFatherFirstName(String value) {
        this.receiverFatherFirstName = value;
    }

    /**
     * Gets the value of the receiptImages property.
     * 
     * @return
     *     possible object is
     *     {@link ReceiptImagesContentType }
     *     
     */
    public ReceiptImagesContentType getReceiptImages() {
        return receiptImages;
    }

    /**
     * Sets the value of the receiptImages property.
     * 
     * @param value
     *     allowed object is
     *     {@link ReceiptImagesContentType }
     *     
     */
    public void setReceiptImages(ReceiptImagesContentType value) {
        this.receiptImages = value;
    }

    /**
     * Gets the value of the fieldValues property.
     * 
     * @return
     *     possible object is
     *     {@link ReceiveValidationRequest.FieldValues }
     *     
     */
    public ReceiveValidationRequest.FieldValues getFieldValues() {
        return fieldValues;
    }

    /**
     * Sets the value of the fieldValues property.
     * 
     * @param value
     *     allowed object is
     *     {@link ReceiveValidationRequest.FieldValues }
     *     
     */
    public void setFieldValues(ReceiveValidationRequest.FieldValues value) {
        this.fieldValues = value;
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
     *         &lt;element name="keyValuePair" type="{http://www.moneygram.com/AgentConnect1512}KeyValuePair" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "keyValuePair"
    })
    public static class FieldValues {

        protected List<KeyValuePair> keyValuePair;

        /**
         * Gets the value of the keyValuePair property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the keyValuePair property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getKeyValuePair().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link KeyValuePair }
         * 
         * 
         */
        public List<KeyValuePair> getKeyValuePair() {
            if (keyValuePair == null) {
                keyValuePair = new ArrayList<KeyValuePair>();
            }
            return this.keyValuePair;
        }

    }

}
