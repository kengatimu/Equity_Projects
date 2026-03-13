
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
import jakarta.xml.bind.annotation.adapters.CollapsedStringAdapter;
import jakarta.xml.bind.annotation.adapters.XmlJavaTypeAdapter;


/**
 * <p>Java class for SendValidationRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="SendValidationRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Request"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="agentStagingChannel" type="{http://www.moneygram.com/AgentConnect1512}EnumType" minOccurs="0"/&gt;
 *         &lt;element name="operatorName" type="{http://www.moneygram.com/AgentConnect1512}stringMax80" minOccurs="0"/&gt;
 *         &lt;element name="amount" type="{http://www.moneygram.com/AgentConnect1512}decimal14nonZero"/&gt;
 *         &lt;element name="feeAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="mgiRewardsNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="agentCustomerNumber" type="{http://www.moneygram.com/AgentConnect1512}agentFrequentCustomerNumber" minOccurs="0"/&gt;
 *         &lt;element name="destinationCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType"/&gt;
 *         &lt;element name="destinationState" type="{http://www.moneygram.com/AgentConnect1512}stateType" minOccurs="0"/&gt;
 *         &lt;element name="deliveryOption" type="{http://www.moneygram.com/AgentConnect1512}deliveryOption"/&gt;
 *         &lt;element name="receiveCurrency" type="{http://www.moneygram.com/AgentConnect1512}stringMax3" minOccurs="0"/&gt;
 *         &lt;element name="receiveAgentID" type="{http://www.moneygram.com/AgentConnect1512}agentID" minOccurs="0"/&gt;
 *         &lt;element name="accountNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax255" minOccurs="0"/&gt;
 *         &lt;element name="customerReceiveNumber" type="{http://www.moneygram.com/AgentConnect1512}customerReceiveNumber" minOccurs="0"/&gt;
 *         &lt;element name="senderFirstName" type="{http://www.moneygram.com/AgentConnect1512}fNameType40" minOccurs="0"/&gt;
 *         &lt;element name="senderMiddleName" type="{http://www.moneygram.com/AgentConnect1512}mNameType40" minOccurs="0"/&gt;
 *         &lt;element name="senderLastName" type="{http://www.moneygram.com/AgentConnect1512}lNameType40"/&gt;
 *         &lt;element name="senderLastName2" type="{http://www.moneygram.com/AgentConnect1512}lNameType40" minOccurs="0"/&gt;
 *         &lt;element name="senderAddress" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong"/&gt;
 *         &lt;element name="senderAddress2" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="senderAddress3" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="senderCity" type="{http://www.moneygram.com/AgentConnect1512}cityTypeLong"/&gt;
 *         &lt;element name="senderState" type="{http://www.moneygram.com/AgentConnect1512}stateType" minOccurs="0"/&gt;
 *         &lt;element name="senderZipCode" type="{http://www.moneygram.com/AgentConnect1512}zipType" minOccurs="0"/&gt;
 *         &lt;element name="senderCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType"/&gt;
 *         &lt;element name="senderHomePhone" type="{http://www.moneygram.com/AgentConnect1512}phoneType14" minOccurs="0"/&gt;
 *         &lt;element name="senderMailingAddress" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="senderMailingAddress2" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="senderMailingAddress3" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="senderMailingCity" type="{http://www.moneygram.com/AgentConnect1512}cityTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="senderMailingState" type="{http://www.moneygram.com/AgentConnect1512}stateType" minOccurs="0"/&gt;
 *         &lt;element name="senderMailingZipCode" type="{http://www.moneygram.com/AgentConnect1512}zipType" minOccurs="0"/&gt;
 *         &lt;element name="senderMailingCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="receiverFirstName" type="{http://www.moneygram.com/AgentConnect1512}fNameType40" minOccurs="0"/&gt;
 *         &lt;element name="receiverMiddleName" type="{http://www.moneygram.com/AgentConnect1512}mNameType40" minOccurs="0"/&gt;
 *         &lt;element name="receiverLastName" type="{http://www.moneygram.com/AgentConnect1512}lNameType40"/&gt;
 *         &lt;element name="receiverLastName2" type="{http://www.moneygram.com/AgentConnect1512}lNameType40" minOccurs="0"/&gt;
 *         &lt;element name="receiverAddress" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="receiverAddress2" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="receiverAddress3" type="{http://www.moneygram.com/AgentConnect1512}addressTypeXLong" minOccurs="0"/&gt;
 *         &lt;element name="direction1" type="{http://www.moneygram.com/AgentConnect1512}directionType" minOccurs="0"/&gt;
 *         &lt;element name="direction2" type="{http://www.moneygram.com/AgentConnect1512}directionType" minOccurs="0"/&gt;
 *         &lt;element name="direction3" type="{http://www.moneygram.com/AgentConnect1512}directionType" minOccurs="0"/&gt;
 *         &lt;element name="receiverCity" type="{http://www.moneygram.com/AgentConnect1512}cityTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="receiverState" type="{http://www.moneygram.com/AgentConnect1512}stateTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="receiverZipCode" type="{http://www.moneygram.com/AgentConnect1512}zipType" minOccurs="0"/&gt;
 *         &lt;element name="receiverCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="receiverPhone" type="{http://www.moneygram.com/AgentConnect1512}phoneType14" minOccurs="0"/&gt;
 *         &lt;element name="receiverPhoneCountryCode" type="{http://www.moneygram.com/AgentConnect1512}countryCodeType" minOccurs="0"/&gt;
 *         &lt;element name="receiverEmail" type="{http://www.moneygram.com/AgentConnect1512}emailType" minOccurs="0"/&gt;
 *         &lt;element name="testQuestion" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="testAnswer" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="messageField1" type="{http://www.moneygram.com/AgentConnect1512}stringMax40" minOccurs="0"/&gt;
 *         &lt;element name="messageField2" type="{http://www.moneygram.com/AgentConnect1512}stringMax40" minOccurs="0"/&gt;
 *         &lt;element name="senderPhotoIdType" type="{http://www.moneygram.com/AgentConnect1512}photoIdType" minOccurs="0"/&gt;
 *         &lt;element name="senderPhotoIdNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax25" minOccurs="0"/&gt;
 *         &lt;element name="senderPhotoIdCity" type="{http://www.moneygram.com/AgentConnect1512}cityType" minOccurs="0"/&gt;
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
 *         &lt;element name="thirdPartyZipCode" type="{http://www.moneygram.com/AgentConnect1512}zipType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdType" type="{http://www.moneygram.com/AgentConnect1512}legalIdType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyDOB" type="{http://www.w3.org/2001/XMLSchema}date" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyOrg" type="{http://www.moneygram.com/AgentConnect1512}stringMax60" minOccurs="0"/&gt;
 *         &lt;element name="senderBirthCity" type="{http://www.moneygram.com/AgentConnect1512}cityTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="senderBirthCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="senderLegalIdIssueCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="senderEmailAddress" type="{http://www.moneygram.com/AgentConnect1512}emailType" minOccurs="0"/&gt;
 *         &lt;element name="senderMobilePhone" type="{http://www.moneygram.com/AgentConnect1512}phoneType14" minOccurs="0"/&gt;
 *         &lt;element name="senderMobilePhoneCountryCode" type="{http://www.moneygram.com/AgentConnect1512}countryCodeType" minOccurs="0"/&gt;
 *         &lt;element name="marketingOptIn" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="pcTerminalNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax10" minOccurs="0"/&gt;
 *         &lt;element name="agentUseSendData" type="{http://www.moneygram.com/AgentConnect1512}stringMax200" minOccurs="0"/&gt;
 *         &lt;element name="sendCurrency" type="{http://www.moneygram.com/AgentConnect1512}currencyCode"/&gt;
 *         &lt;element name="consumerId" type="{http://www.moneygram.com/AgentConnect1512}consumerId"/&gt;
 *         &lt;element name="senderPhotoIdStored" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="senderNationalityCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="senderNationalityAtBirthCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="agentTransactionId" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="mgiTransactionSessionID" type="{http://www.moneygram.com/AgentConnect1512}mgiTransactionSessionID"/&gt;
 *         &lt;element name="formFreeStaging" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="timeToLive" type="{http://www.moneygram.com/AgentConnect1512}int5" minOccurs="0"/&gt;
 *         &lt;element name="primaryReceiptLanguage" type="{http://www.moneygram.com/AgentConnect1512}stringMax3" minOccurs="0"/&gt;
 *         &lt;element name="secondaryReceiptLanguage" type="{http://www.moneygram.com/AgentConnect1512}stringMax3" minOccurs="0"/&gt;
 *         &lt;element name="sendPurposeOfTransaction" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="sendPurposeOfTransactionOther" type="{http://www.moneygram.com/AgentConnect1512}stringMax40" minOccurs="0"/&gt;
 *         &lt;element name="sourceOfFunds" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="sourceOfFundsOther" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="paymentTenderedType" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="relationshipToReceiver" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="relationshipToReceiverOther" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="proofOfFunds" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="proofOfFundsOther" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="senderGender" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="senderOccupationOther" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="senderBirthState" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="senderNameSuffix" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="senderNameSuffixOther" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="senderCitizenshipCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="senderCitizenshipAtBirthCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="senderDualCitizenshipCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="senderPhotoIdIssueMonth" type="{http://www.moneygram.com/AgentConnect1512}monthType" minOccurs="0"/&gt;
 *         &lt;element name="senderPhotoIdIssueYear" type="{http://www.moneygram.com/AgentConnect1512}yearType" minOccurs="0"/&gt;
 *         &lt;element name="senderPhotoIdIssueDay" type="{http://www.moneygram.com/AgentConnect1512}dayType" minOccurs="0"/&gt;
 *         &lt;element name="senderPhotoIdExpirationMonth" type="{http://www.moneygram.com/AgentConnect1512}monthType" minOccurs="0"/&gt;
 *         &lt;element name="senderPhotoIdExpirationYear" type="{http://www.moneygram.com/AgentConnect1512}yearType" minOccurs="0"/&gt;
 *         &lt;element name="senderPhotoIdExpirationDay" type="{http://www.moneygram.com/AgentConnect1512}dayType" minOccurs="0"/&gt;
 *         &lt;element name="senderPhotoIdIssueAuthority" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="senderLegalIdIssueMonth" type="{http://www.moneygram.com/AgentConnect1512}monthType" minOccurs="0"/&gt;
 *         &lt;element name="senderLegalIdIssueYear" type="{http://www.moneygram.com/AgentConnect1512}yearType" minOccurs="0"/&gt;
 *         &lt;element name="senderLegalIdIssueDay" type="{http://www.moneygram.com/AgentConnect1512}dayType" minOccurs="0"/&gt;
 *         &lt;element name="senderLegalIdExpirationMonth" type="{http://www.moneygram.com/AgentConnect1512}monthType" minOccurs="0"/&gt;
 *         &lt;element name="senderLegalIdExpirationYear" type="{http://www.moneygram.com/AgentConnect1512}yearType" minOccurs="0"/&gt;
 *         &lt;element name="senderLegalIdExpirationDay" type="{http://www.moneygram.com/AgentConnect1512}dayType" minOccurs="0"/&gt;
 *         &lt;element name="senderLegalIdIssueAuthority" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="senderLegalIdState" type="{http://www.moneygram.com/AgentConnect1512}stateType" minOccurs="0"/&gt;
 *         &lt;element name="senderTransactionEmailNotificationOptIn" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="senderTransactionSMSNotificationOptIn" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="senderMarketingEmailNotificationOptIn" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="senderMarketingSMSNotificationOptIn" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="receiverTransactionEmailNotificationOptIn" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="receiverTransactionSMSNotificationOptIn" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="senderHomePhoneNotAvailable" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="senderHomePhoneCountryCode" type="{http://www.moneygram.com/AgentConnect1512}countryCodeType" minOccurs="0"/&gt;
 *         &lt;element name="receiverNameSuffix" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="receiverNameSuffixOther" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="senderFirstNameNotAvailable" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="receiverFirstNameNotAvailable" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyFirstNameNotAvailable" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartySenderBirthCity" type="{http://www.moneygram.com/AgentConnect1512}cityTypeLong" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartySenderBirthState" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartySenderBirthCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartySenderGender" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartySenderOccupation" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartySenderOccupationOther" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartySenderNameSuffix" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartySenderNameSuffixOther" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartySenderCitizenshipCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartySenderCitizenshipAtBirthCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartySenderDualCitizenshipCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdIssueMonth" type="{http://www.moneygram.com/AgentConnect1512}monthType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdIssueYear" type="{http://www.moneygram.com/AgentConnect1512}yearType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdIssueDay" type="{http://www.moneygram.com/AgentConnect1512}dayType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdExpirationMonth" type="{http://www.moneygram.com/AgentConnect1512}monthType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdExpirationYear" type="{http://www.moneygram.com/AgentConnect1512}yearType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdExpirationDay" type="{http://www.moneygram.com/AgentConnect1512}dayType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdIssueAuthority" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdState" type="{http://www.moneygram.com/AgentConnect1512}stateType" minOccurs="0"/&gt;
 *         &lt;element name="thirdPartyLegalIdIssueCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType" minOccurs="0"/&gt;
 *         &lt;element name="senderIntendedUseOfMGIServices" type="{http://www.moneygram.com/AgentConnect1512}stringMax30" minOccurs="0"/&gt;
 *         &lt;element name="senderMotherMaidenName" type="{http://www.moneygram.com/AgentConnect1512}lNameType40" minOccurs="0"/&gt;
 *         &lt;element name="senderFatherFirstName" type="{http://www.moneygram.com/AgentConnect1512}fNameType40" minOccurs="0"/&gt;
 *         &lt;element name="receiptImages" type="{http://www.moneygram.com/AgentConnect1512}ReceiptImagesContentType" minOccurs="0"/&gt;
 *         &lt;element name="promoCodeValues" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="promoCode" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" maxOccurs="unbounded" minOccurs="0"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
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
@XmlType(name = "SendValidationRequest", propOrder = {
    "agentStagingChannel",
    "operatorName",
    "amount",
    "feeAmount",
    "mgiRewardsNumber",
    "agentCustomerNumber",
    "destinationCountry",
    "destinationState",
    "deliveryOption",
    "receiveCurrency",
    "receiveAgentID",
    "accountNumber",
    "customerReceiveNumber",
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
    "senderMailingAddress",
    "senderMailingAddress2",
    "senderMailingAddress3",
    "senderMailingCity",
    "senderMailingState",
    "senderMailingZipCode",
    "senderMailingCountry",
    "receiverFirstName",
    "receiverMiddleName",
    "receiverLastName",
    "receiverLastName2",
    "receiverAddress",
    "receiverAddress2",
    "receiverAddress3",
    "direction1",
    "direction2",
    "direction3",
    "receiverCity",
    "receiverState",
    "receiverZipCode",
    "receiverCountry",
    "receiverPhone",
    "receiverPhoneCountryCode",
    "receiverEmail",
    "testQuestion",
    "testAnswer",
    "messageField1",
    "messageField2",
    "senderPhotoIdType",
    "senderPhotoIdNumber",
    "senderPhotoIdCity",
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
    "thirdPartyZipCode",
    "thirdPartyCountry",
    "thirdPartyLegalIdType",
    "thirdPartyLegalIdNumber",
    "thirdPartyDOB",
    "thirdPartyOrg",
    "senderBirthCity",
    "senderBirthCountry",
    "senderLegalIdIssueCountry",
    "senderEmailAddress",
    "senderMobilePhone",
    "senderMobilePhoneCountryCode",
    "marketingOptIn",
    "pcTerminalNumber",
    "agentUseSendData",
    "sendCurrency",
    "consumerId",
    "senderPhotoIdStored",
    "senderNationalityCountry",
    "senderNationalityAtBirthCountry",
    "agentTransactionId",
    "mgiTransactionSessionID",
    "formFreeStaging",
    "timeToLive",
    "primaryReceiptLanguage",
    "secondaryReceiptLanguage",
    "sendPurposeOfTransaction",
    "sendPurposeOfTransactionOther",
    "sourceOfFunds",
    "sourceOfFundsOther",
    "paymentTenderedType",
    "relationshipToReceiver",
    "relationshipToReceiverOther",
    "proofOfFunds",
    "proofOfFundsOther",
    "senderGender",
    "senderOccupationOther",
    "senderBirthState",
    "senderNameSuffix",
    "senderNameSuffixOther",
    "senderCitizenshipCountry",
    "senderCitizenshipAtBirthCountry",
    "senderDualCitizenshipCountry",
    "senderPhotoIdIssueMonth",
    "senderPhotoIdIssueYear",
    "senderPhotoIdIssueDay",
    "senderPhotoIdExpirationMonth",
    "senderPhotoIdExpirationYear",
    "senderPhotoIdExpirationDay",
    "senderPhotoIdIssueAuthority",
    "senderLegalIdIssueMonth",
    "senderLegalIdIssueYear",
    "senderLegalIdIssueDay",
    "senderLegalIdExpirationMonth",
    "senderLegalIdExpirationYear",
    "senderLegalIdExpirationDay",
    "senderLegalIdIssueAuthority",
    "senderLegalIdState",
    "senderTransactionEmailNotificationOptIn",
    "senderTransactionSMSNotificationOptIn",
    "senderMarketingEmailNotificationOptIn",
    "senderMarketingSMSNotificationOptIn",
    "receiverTransactionEmailNotificationOptIn",
    "receiverTransactionSMSNotificationOptIn",
    "senderHomePhoneNotAvailable",
    "senderHomePhoneCountryCode",
    "receiverNameSuffix",
    "receiverNameSuffixOther",
    "senderFirstNameNotAvailable",
    "receiverFirstNameNotAvailable",
    "thirdPartyFirstNameNotAvailable",
    "thirdPartySenderBirthCity",
    "thirdPartySenderBirthState",
    "thirdPartySenderBirthCountry",
    "thirdPartySenderGender",
    "thirdPartySenderOccupation",
    "thirdPartySenderOccupationOther",
    "thirdPartySenderNameSuffix",
    "thirdPartySenderNameSuffixOther",
    "thirdPartySenderCitizenshipCountry",
    "thirdPartySenderCitizenshipAtBirthCountry",
    "thirdPartySenderDualCitizenshipCountry",
    "thirdPartyLegalIdIssueMonth",
    "thirdPartyLegalIdIssueYear",
    "thirdPartyLegalIdIssueDay",
    "thirdPartyLegalIdExpirationMonth",
    "thirdPartyLegalIdExpirationYear",
    "thirdPartyLegalIdExpirationDay",
    "thirdPartyLegalIdIssueAuthority",
    "thirdPartyLegalIdState",
    "thirdPartyLegalIdIssueCountry",
    "senderIntendedUseOfMGIServices",
    "senderMotherMaidenName",
    "senderFatherFirstName",
    "receiptImages",
    "promoCodeValues",
    "fieldValues"
})
public class SendValidationRequest
    extends Request
{

    protected String agentStagingChannel;
    protected String operatorName;
    @XmlElement(required = true)
    protected BigDecimal amount;
    protected BigDecimal feeAmount;
    protected String mgiRewardsNumber;
    protected String agentCustomerNumber;
    @XmlElement(required = true)
    protected String destinationCountry;
    protected String destinationState;
    @XmlElement(required = true)
    protected String deliveryOption;
    protected String receiveCurrency;
    protected String receiveAgentID;
    protected String accountNumber;
    protected String customerReceiveNumber;
    protected String senderFirstName;
    protected String senderMiddleName;
    @XmlElement(required = true)
    protected String senderLastName;
    protected String senderLastName2;
    @XmlElement(required = true)
    protected String senderAddress;
    protected String senderAddress2;
    protected String senderAddress3;
    @XmlElement(required = true)
    protected String senderCity;
    protected String senderState;
    protected String senderZipCode;
    @XmlElement(required = true)
    protected String senderCountry;
    protected String senderHomePhone;
    protected String senderMailingAddress;
    protected String senderMailingAddress2;
    protected String senderMailingAddress3;
    protected String senderMailingCity;
    protected String senderMailingState;
    protected String senderMailingZipCode;
    protected String senderMailingCountry;
    protected String receiverFirstName;
    protected String receiverMiddleName;
    @XmlElement(required = true)
    protected String receiverLastName;
    protected String receiverLastName2;
    protected String receiverAddress;
    protected String receiverAddress2;
    protected String receiverAddress3;
    protected String direction1;
    protected String direction2;
    protected String direction3;
    protected String receiverCity;
    protected String receiverState;
    protected String receiverZipCode;
    protected String receiverCountry;
    protected String receiverPhone;
    protected String receiverPhoneCountryCode;
    @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
    @XmlSchemaType(name = "token")
    protected String receiverEmail;
    protected String testQuestion;
    protected String testAnswer;
    protected String messageField1;
    protected String messageField2;
    protected String senderPhotoIdType;
    protected String senderPhotoIdNumber;
    protected String senderPhotoIdCity;
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
    protected String thirdPartyZipCode;
    protected String thirdPartyCountry;
    protected String thirdPartyLegalIdType;
    protected String thirdPartyLegalIdNumber;
    @XmlSchemaType(name = "date")
    protected XMLGregorianCalendar thirdPartyDOB;
    protected String thirdPartyOrg;
    protected String senderBirthCity;
    protected String senderBirthCountry;
    protected String senderLegalIdIssueCountry;
    @XmlJavaTypeAdapter(CollapsedStringAdapter.class)
    @XmlSchemaType(name = "token")
    protected String senderEmailAddress;
    protected String senderMobilePhone;
    protected String senderMobilePhoneCountryCode;
    protected Boolean marketingOptIn;
    protected String pcTerminalNumber;
    protected String agentUseSendData;
    @XmlElement(required = true)
    protected String sendCurrency;
    @XmlElement(required = true)
    protected String consumerId;
    protected Boolean senderPhotoIdStored;
    protected String senderNationalityCountry;
    protected String senderNationalityAtBirthCountry;
    protected String agentTransactionId;
    @XmlElement(required = true)
    protected String mgiTransactionSessionID;
    protected boolean formFreeStaging;
    protected BigInteger timeToLive;
    protected String primaryReceiptLanguage;
    protected String secondaryReceiptLanguage;
    protected String sendPurposeOfTransaction;
    protected String sendPurposeOfTransactionOther;
    protected String sourceOfFunds;
    protected String sourceOfFundsOther;
    protected String paymentTenderedType;
    protected String relationshipToReceiver;
    protected String relationshipToReceiverOther;
    protected String proofOfFunds;
    protected String proofOfFundsOther;
    protected String senderGender;
    protected String senderOccupationOther;
    protected String senderBirthState;
    protected String senderNameSuffix;
    protected String senderNameSuffixOther;
    protected String senderCitizenshipCountry;
    protected String senderCitizenshipAtBirthCountry;
    protected String senderDualCitizenshipCountry;
    protected String senderPhotoIdIssueMonth;
    protected String senderPhotoIdIssueYear;
    protected String senderPhotoIdIssueDay;
    protected String senderPhotoIdExpirationMonth;
    protected String senderPhotoIdExpirationYear;
    protected String senderPhotoIdExpirationDay;
    protected String senderPhotoIdIssueAuthority;
    protected String senderLegalIdIssueMonth;
    protected String senderLegalIdIssueYear;
    protected String senderLegalIdIssueDay;
    protected String senderLegalIdExpirationMonth;
    protected String senderLegalIdExpirationYear;
    protected String senderLegalIdExpirationDay;
    protected String senderLegalIdIssueAuthority;
    protected String senderLegalIdState;
    protected Boolean senderTransactionEmailNotificationOptIn;
    protected Boolean senderTransactionSMSNotificationOptIn;
    protected Boolean senderMarketingEmailNotificationOptIn;
    protected Boolean senderMarketingSMSNotificationOptIn;
    protected Boolean receiverTransactionEmailNotificationOptIn;
    protected Boolean receiverTransactionSMSNotificationOptIn;
    protected Boolean senderHomePhoneNotAvailable;
    protected String senderHomePhoneCountryCode;
    protected String receiverNameSuffix;
    protected String receiverNameSuffixOther;
    protected Boolean senderFirstNameNotAvailable;
    protected Boolean receiverFirstNameNotAvailable;
    protected Boolean thirdPartyFirstNameNotAvailable;
    protected String thirdPartySenderBirthCity;
    protected String thirdPartySenderBirthState;
    protected String thirdPartySenderBirthCountry;
    protected String thirdPartySenderGender;
    protected String thirdPartySenderOccupation;
    protected String thirdPartySenderOccupationOther;
    protected String thirdPartySenderNameSuffix;
    protected String thirdPartySenderNameSuffixOther;
    protected String thirdPartySenderCitizenshipCountry;
    protected String thirdPartySenderCitizenshipAtBirthCountry;
    protected String thirdPartySenderDualCitizenshipCountry;
    protected String thirdPartyLegalIdIssueMonth;
    protected String thirdPartyLegalIdIssueYear;
    protected String thirdPartyLegalIdIssueDay;
    protected String thirdPartyLegalIdExpirationMonth;
    protected String thirdPartyLegalIdExpirationYear;
    protected String thirdPartyLegalIdExpirationDay;
    protected String thirdPartyLegalIdIssueAuthority;
    protected String thirdPartyLegalIdState;
    protected String thirdPartyLegalIdIssueCountry;
    protected String senderIntendedUseOfMGIServices;
    protected String senderMotherMaidenName;
    protected String senderFatherFirstName;
    protected ReceiptImagesContentType receiptImages;
    protected SendValidationRequest.PromoCodeValues promoCodeValues;
    protected SendValidationRequest.FieldValues fieldValues;

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
     * Gets the value of the amount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getAmount() {
        return amount;
    }

    /**
     * Sets the value of the amount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setAmount(BigDecimal value) {
        this.amount = value;
    }

    /**
     * Gets the value of the feeAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getFeeAmount() {
        return feeAmount;
    }

    /**
     * Sets the value of the feeAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setFeeAmount(BigDecimal value) {
        this.feeAmount = value;
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
     * Gets the value of the agentCustomerNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAgentCustomerNumber() {
        return agentCustomerNumber;
    }

    /**
     * Sets the value of the agentCustomerNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAgentCustomerNumber(String value) {
        this.agentCustomerNumber = value;
    }

    /**
     * Gets the value of the destinationCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDestinationCountry() {
        return destinationCountry;
    }

    /**
     * Sets the value of the destinationCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDestinationCountry(String value) {
        this.destinationCountry = value;
    }

    /**
     * Gets the value of the destinationState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDestinationState() {
        return destinationState;
    }

    /**
     * Sets the value of the destinationState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDestinationState(String value) {
        this.destinationState = value;
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
     * Gets the value of the accountNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAccountNumber() {
        return accountNumber;
    }

    /**
     * Sets the value of the accountNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAccountNumber(String value) {
        this.accountNumber = value;
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
     * Gets the value of the senderMailingAddress property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderMailingAddress() {
        return senderMailingAddress;
    }

    /**
     * Sets the value of the senderMailingAddress property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderMailingAddress(String value) {
        this.senderMailingAddress = value;
    }

    /**
     * Gets the value of the senderMailingAddress2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderMailingAddress2() {
        return senderMailingAddress2;
    }

    /**
     * Sets the value of the senderMailingAddress2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderMailingAddress2(String value) {
        this.senderMailingAddress2 = value;
    }

    /**
     * Gets the value of the senderMailingAddress3 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderMailingAddress3() {
        return senderMailingAddress3;
    }

    /**
     * Sets the value of the senderMailingAddress3 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderMailingAddress3(String value) {
        this.senderMailingAddress3 = value;
    }

    /**
     * Gets the value of the senderMailingCity property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderMailingCity() {
        return senderMailingCity;
    }

    /**
     * Sets the value of the senderMailingCity property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderMailingCity(String value) {
        this.senderMailingCity = value;
    }

    /**
     * Gets the value of the senderMailingState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderMailingState() {
        return senderMailingState;
    }

    /**
     * Sets the value of the senderMailingState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderMailingState(String value) {
        this.senderMailingState = value;
    }

    /**
     * Gets the value of the senderMailingZipCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderMailingZipCode() {
        return senderMailingZipCode;
    }

    /**
     * Sets the value of the senderMailingZipCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderMailingZipCode(String value) {
        this.senderMailingZipCode = value;
    }

    /**
     * Gets the value of the senderMailingCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderMailingCountry() {
        return senderMailingCountry;
    }

    /**
     * Sets the value of the senderMailingCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderMailingCountry(String value) {
        this.senderMailingCountry = value;
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
     * Gets the value of the receiverEmail property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverEmail() {
        return receiverEmail;
    }

    /**
     * Sets the value of the receiverEmail property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverEmail(String value) {
        this.receiverEmail = value;
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
     * Gets the value of the senderPhotoIdCity property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderPhotoIdCity() {
        return senderPhotoIdCity;
    }

    /**
     * Sets the value of the senderPhotoIdCity property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderPhotoIdCity(String value) {
        this.senderPhotoIdCity = value;
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
     * Gets the value of the senderLegalIdIssueCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderLegalIdIssueCountry() {
        return senderLegalIdIssueCountry;
    }

    /**
     * Sets the value of the senderLegalIdIssueCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderLegalIdIssueCountry(String value) {
        this.senderLegalIdIssueCountry = value;
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
     * Gets the value of the senderMobilePhoneCountryCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderMobilePhoneCountryCode() {
        return senderMobilePhoneCountryCode;
    }

    /**
     * Sets the value of the senderMobilePhoneCountryCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderMobilePhoneCountryCode(String value) {
        this.senderMobilePhoneCountryCode = value;
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
     * Gets the value of the sendCurrency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSendCurrency() {
        return sendCurrency;
    }

    /**
     * Sets the value of the sendCurrency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSendCurrency(String value) {
        this.sendCurrency = value;
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
     * Gets the value of the senderPhotoIdStored property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isSenderPhotoIdStored() {
        return senderPhotoIdStored;
    }

    /**
     * Sets the value of the senderPhotoIdStored property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setSenderPhotoIdStored(Boolean value) {
        this.senderPhotoIdStored = value;
    }

    /**
     * Gets the value of the senderNationalityCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderNationalityCountry() {
        return senderNationalityCountry;
    }

    /**
     * Sets the value of the senderNationalityCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderNationalityCountry(String value) {
        this.senderNationalityCountry = value;
    }

    /**
     * Gets the value of the senderNationalityAtBirthCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderNationalityAtBirthCountry() {
        return senderNationalityAtBirthCountry;
    }

    /**
     * Sets the value of the senderNationalityAtBirthCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderNationalityAtBirthCountry(String value) {
        this.senderNationalityAtBirthCountry = value;
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
     * Gets the value of the sendPurposeOfTransaction property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSendPurposeOfTransaction() {
        return sendPurposeOfTransaction;
    }

    /**
     * Sets the value of the sendPurposeOfTransaction property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSendPurposeOfTransaction(String value) {
        this.sendPurposeOfTransaction = value;
    }

    /**
     * Gets the value of the sendPurposeOfTransactionOther property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSendPurposeOfTransactionOther() {
        return sendPurposeOfTransactionOther;
    }

    /**
     * Sets the value of the sendPurposeOfTransactionOther property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSendPurposeOfTransactionOther(String value) {
        this.sendPurposeOfTransactionOther = value;
    }

    /**
     * Gets the value of the sourceOfFunds property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSourceOfFunds() {
        return sourceOfFunds;
    }

    /**
     * Sets the value of the sourceOfFunds property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSourceOfFunds(String value) {
        this.sourceOfFunds = value;
    }

    /**
     * Gets the value of the sourceOfFundsOther property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSourceOfFundsOther() {
        return sourceOfFundsOther;
    }

    /**
     * Sets the value of the sourceOfFundsOther property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSourceOfFundsOther(String value) {
        this.sourceOfFundsOther = value;
    }

    /**
     * Gets the value of the paymentTenderedType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPaymentTenderedType() {
        return paymentTenderedType;
    }

    /**
     * Sets the value of the paymentTenderedType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPaymentTenderedType(String value) {
        this.paymentTenderedType = value;
    }

    /**
     * Gets the value of the relationshipToReceiver property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRelationshipToReceiver() {
        return relationshipToReceiver;
    }

    /**
     * Sets the value of the relationshipToReceiver property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRelationshipToReceiver(String value) {
        this.relationshipToReceiver = value;
    }

    /**
     * Gets the value of the relationshipToReceiverOther property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRelationshipToReceiverOther() {
        return relationshipToReceiverOther;
    }

    /**
     * Sets the value of the relationshipToReceiverOther property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRelationshipToReceiverOther(String value) {
        this.relationshipToReceiverOther = value;
    }

    /**
     * Gets the value of the proofOfFunds property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getProofOfFunds() {
        return proofOfFunds;
    }

    /**
     * Sets the value of the proofOfFunds property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setProofOfFunds(String value) {
        this.proofOfFunds = value;
    }

    /**
     * Gets the value of the proofOfFundsOther property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getProofOfFundsOther() {
        return proofOfFundsOther;
    }

    /**
     * Sets the value of the proofOfFundsOther property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setProofOfFundsOther(String value) {
        this.proofOfFundsOther = value;
    }

    /**
     * Gets the value of the senderGender property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderGender() {
        return senderGender;
    }

    /**
     * Sets the value of the senderGender property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderGender(String value) {
        this.senderGender = value;
    }

    /**
     * Gets the value of the senderOccupationOther property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderOccupationOther() {
        return senderOccupationOther;
    }

    /**
     * Sets the value of the senderOccupationOther property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderOccupationOther(String value) {
        this.senderOccupationOther = value;
    }

    /**
     * Gets the value of the senderBirthState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderBirthState() {
        return senderBirthState;
    }

    /**
     * Sets the value of the senderBirthState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderBirthState(String value) {
        this.senderBirthState = value;
    }

    /**
     * Gets the value of the senderNameSuffix property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderNameSuffix() {
        return senderNameSuffix;
    }

    /**
     * Sets the value of the senderNameSuffix property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderNameSuffix(String value) {
        this.senderNameSuffix = value;
    }

    /**
     * Gets the value of the senderNameSuffixOther property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderNameSuffixOther() {
        return senderNameSuffixOther;
    }

    /**
     * Sets the value of the senderNameSuffixOther property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderNameSuffixOther(String value) {
        this.senderNameSuffixOther = value;
    }

    /**
     * Gets the value of the senderCitizenshipCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderCitizenshipCountry() {
        return senderCitizenshipCountry;
    }

    /**
     * Sets the value of the senderCitizenshipCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderCitizenshipCountry(String value) {
        this.senderCitizenshipCountry = value;
    }

    /**
     * Gets the value of the senderCitizenshipAtBirthCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderCitizenshipAtBirthCountry() {
        return senderCitizenshipAtBirthCountry;
    }

    /**
     * Sets the value of the senderCitizenshipAtBirthCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderCitizenshipAtBirthCountry(String value) {
        this.senderCitizenshipAtBirthCountry = value;
    }

    /**
     * Gets the value of the senderDualCitizenshipCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderDualCitizenshipCountry() {
        return senderDualCitizenshipCountry;
    }

    /**
     * Sets the value of the senderDualCitizenshipCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderDualCitizenshipCountry(String value) {
        this.senderDualCitizenshipCountry = value;
    }

    /**
     * Gets the value of the senderPhotoIdIssueMonth property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderPhotoIdIssueMonth() {
        return senderPhotoIdIssueMonth;
    }

    /**
     * Sets the value of the senderPhotoIdIssueMonth property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderPhotoIdIssueMonth(String value) {
        this.senderPhotoIdIssueMonth = value;
    }

    /**
     * Gets the value of the senderPhotoIdIssueYear property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderPhotoIdIssueYear() {
        return senderPhotoIdIssueYear;
    }

    /**
     * Sets the value of the senderPhotoIdIssueYear property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderPhotoIdIssueYear(String value) {
        this.senderPhotoIdIssueYear = value;
    }

    /**
     * Gets the value of the senderPhotoIdIssueDay property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderPhotoIdIssueDay() {
        return senderPhotoIdIssueDay;
    }

    /**
     * Sets the value of the senderPhotoIdIssueDay property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderPhotoIdIssueDay(String value) {
        this.senderPhotoIdIssueDay = value;
    }

    /**
     * Gets the value of the senderPhotoIdExpirationMonth property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderPhotoIdExpirationMonth() {
        return senderPhotoIdExpirationMonth;
    }

    /**
     * Sets the value of the senderPhotoIdExpirationMonth property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderPhotoIdExpirationMonth(String value) {
        this.senderPhotoIdExpirationMonth = value;
    }

    /**
     * Gets the value of the senderPhotoIdExpirationYear property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderPhotoIdExpirationYear() {
        return senderPhotoIdExpirationYear;
    }

    /**
     * Sets the value of the senderPhotoIdExpirationYear property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderPhotoIdExpirationYear(String value) {
        this.senderPhotoIdExpirationYear = value;
    }

    /**
     * Gets the value of the senderPhotoIdExpirationDay property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderPhotoIdExpirationDay() {
        return senderPhotoIdExpirationDay;
    }

    /**
     * Sets the value of the senderPhotoIdExpirationDay property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderPhotoIdExpirationDay(String value) {
        this.senderPhotoIdExpirationDay = value;
    }

    /**
     * Gets the value of the senderPhotoIdIssueAuthority property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderPhotoIdIssueAuthority() {
        return senderPhotoIdIssueAuthority;
    }

    /**
     * Sets the value of the senderPhotoIdIssueAuthority property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderPhotoIdIssueAuthority(String value) {
        this.senderPhotoIdIssueAuthority = value;
    }

    /**
     * Gets the value of the senderLegalIdIssueMonth property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderLegalIdIssueMonth() {
        return senderLegalIdIssueMonth;
    }

    /**
     * Sets the value of the senderLegalIdIssueMonth property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderLegalIdIssueMonth(String value) {
        this.senderLegalIdIssueMonth = value;
    }

    /**
     * Gets the value of the senderLegalIdIssueYear property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderLegalIdIssueYear() {
        return senderLegalIdIssueYear;
    }

    /**
     * Sets the value of the senderLegalIdIssueYear property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderLegalIdIssueYear(String value) {
        this.senderLegalIdIssueYear = value;
    }

    /**
     * Gets the value of the senderLegalIdIssueDay property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderLegalIdIssueDay() {
        return senderLegalIdIssueDay;
    }

    /**
     * Sets the value of the senderLegalIdIssueDay property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderLegalIdIssueDay(String value) {
        this.senderLegalIdIssueDay = value;
    }

    /**
     * Gets the value of the senderLegalIdExpirationMonth property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderLegalIdExpirationMonth() {
        return senderLegalIdExpirationMonth;
    }

    /**
     * Sets the value of the senderLegalIdExpirationMonth property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderLegalIdExpirationMonth(String value) {
        this.senderLegalIdExpirationMonth = value;
    }

    /**
     * Gets the value of the senderLegalIdExpirationYear property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderLegalIdExpirationYear() {
        return senderLegalIdExpirationYear;
    }

    /**
     * Sets the value of the senderLegalIdExpirationYear property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderLegalIdExpirationYear(String value) {
        this.senderLegalIdExpirationYear = value;
    }

    /**
     * Gets the value of the senderLegalIdExpirationDay property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderLegalIdExpirationDay() {
        return senderLegalIdExpirationDay;
    }

    /**
     * Sets the value of the senderLegalIdExpirationDay property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderLegalIdExpirationDay(String value) {
        this.senderLegalIdExpirationDay = value;
    }

    /**
     * Gets the value of the senderLegalIdIssueAuthority property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderLegalIdIssueAuthority() {
        return senderLegalIdIssueAuthority;
    }

    /**
     * Sets the value of the senderLegalIdIssueAuthority property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderLegalIdIssueAuthority(String value) {
        this.senderLegalIdIssueAuthority = value;
    }

    /**
     * Gets the value of the senderLegalIdState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderLegalIdState() {
        return senderLegalIdState;
    }

    /**
     * Sets the value of the senderLegalIdState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderLegalIdState(String value) {
        this.senderLegalIdState = value;
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
     * Gets the value of the receiverTransactionEmailNotificationOptIn property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isReceiverTransactionEmailNotificationOptIn() {
        return receiverTransactionEmailNotificationOptIn;
    }

    /**
     * Sets the value of the receiverTransactionEmailNotificationOptIn property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setReceiverTransactionEmailNotificationOptIn(Boolean value) {
        this.receiverTransactionEmailNotificationOptIn = value;
    }

    /**
     * Gets the value of the receiverTransactionSMSNotificationOptIn property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isReceiverTransactionSMSNotificationOptIn() {
        return receiverTransactionSMSNotificationOptIn;
    }

    /**
     * Sets the value of the receiverTransactionSMSNotificationOptIn property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setReceiverTransactionSMSNotificationOptIn(Boolean value) {
        this.receiverTransactionSMSNotificationOptIn = value;
    }

    /**
     * Gets the value of the senderHomePhoneNotAvailable property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isSenderHomePhoneNotAvailable() {
        return senderHomePhoneNotAvailable;
    }

    /**
     * Sets the value of the senderHomePhoneNotAvailable property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setSenderHomePhoneNotAvailable(Boolean value) {
        this.senderHomePhoneNotAvailable = value;
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
     * Gets the value of the receiverNameSuffix property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverNameSuffix() {
        return receiverNameSuffix;
    }

    /**
     * Sets the value of the receiverNameSuffix property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverNameSuffix(String value) {
        this.receiverNameSuffix = value;
    }

    /**
     * Gets the value of the receiverNameSuffixOther property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverNameSuffixOther() {
        return receiverNameSuffixOther;
    }

    /**
     * Sets the value of the receiverNameSuffixOther property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverNameSuffixOther(String value) {
        this.receiverNameSuffixOther = value;
    }

    /**
     * Gets the value of the senderFirstNameNotAvailable property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isSenderFirstNameNotAvailable() {
        return senderFirstNameNotAvailable;
    }

    /**
     * Sets the value of the senderFirstNameNotAvailable property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setSenderFirstNameNotAvailable(Boolean value) {
        this.senderFirstNameNotAvailable = value;
    }

    /**
     * Gets the value of the receiverFirstNameNotAvailable property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isReceiverFirstNameNotAvailable() {
        return receiverFirstNameNotAvailable;
    }

    /**
     * Sets the value of the receiverFirstNameNotAvailable property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setReceiverFirstNameNotAvailable(Boolean value) {
        this.receiverFirstNameNotAvailable = value;
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
     * Gets the value of the thirdPartySenderBirthCity property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartySenderBirthCity() {
        return thirdPartySenderBirthCity;
    }

    /**
     * Sets the value of the thirdPartySenderBirthCity property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartySenderBirthCity(String value) {
        this.thirdPartySenderBirthCity = value;
    }

    /**
     * Gets the value of the thirdPartySenderBirthState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartySenderBirthState() {
        return thirdPartySenderBirthState;
    }

    /**
     * Sets the value of the thirdPartySenderBirthState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartySenderBirthState(String value) {
        this.thirdPartySenderBirthState = value;
    }

    /**
     * Gets the value of the thirdPartySenderBirthCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartySenderBirthCountry() {
        return thirdPartySenderBirthCountry;
    }

    /**
     * Sets the value of the thirdPartySenderBirthCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartySenderBirthCountry(String value) {
        this.thirdPartySenderBirthCountry = value;
    }

    /**
     * Gets the value of the thirdPartySenderGender property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartySenderGender() {
        return thirdPartySenderGender;
    }

    /**
     * Sets the value of the thirdPartySenderGender property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartySenderGender(String value) {
        this.thirdPartySenderGender = value;
    }

    /**
     * Gets the value of the thirdPartySenderOccupation property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartySenderOccupation() {
        return thirdPartySenderOccupation;
    }

    /**
     * Sets the value of the thirdPartySenderOccupation property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartySenderOccupation(String value) {
        this.thirdPartySenderOccupation = value;
    }

    /**
     * Gets the value of the thirdPartySenderOccupationOther property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartySenderOccupationOther() {
        return thirdPartySenderOccupationOther;
    }

    /**
     * Sets the value of the thirdPartySenderOccupationOther property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartySenderOccupationOther(String value) {
        this.thirdPartySenderOccupationOther = value;
    }

    /**
     * Gets the value of the thirdPartySenderNameSuffix property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartySenderNameSuffix() {
        return thirdPartySenderNameSuffix;
    }

    /**
     * Sets the value of the thirdPartySenderNameSuffix property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartySenderNameSuffix(String value) {
        this.thirdPartySenderNameSuffix = value;
    }

    /**
     * Gets the value of the thirdPartySenderNameSuffixOther property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartySenderNameSuffixOther() {
        return thirdPartySenderNameSuffixOther;
    }

    /**
     * Sets the value of the thirdPartySenderNameSuffixOther property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartySenderNameSuffixOther(String value) {
        this.thirdPartySenderNameSuffixOther = value;
    }

    /**
     * Gets the value of the thirdPartySenderCitizenshipCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartySenderCitizenshipCountry() {
        return thirdPartySenderCitizenshipCountry;
    }

    /**
     * Sets the value of the thirdPartySenderCitizenshipCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartySenderCitizenshipCountry(String value) {
        this.thirdPartySenderCitizenshipCountry = value;
    }

    /**
     * Gets the value of the thirdPartySenderCitizenshipAtBirthCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartySenderCitizenshipAtBirthCountry() {
        return thirdPartySenderCitizenshipAtBirthCountry;
    }

    /**
     * Sets the value of the thirdPartySenderCitizenshipAtBirthCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartySenderCitizenshipAtBirthCountry(String value) {
        this.thirdPartySenderCitizenshipAtBirthCountry = value;
    }

    /**
     * Gets the value of the thirdPartySenderDualCitizenshipCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getThirdPartySenderDualCitizenshipCountry() {
        return thirdPartySenderDualCitizenshipCountry;
    }

    /**
     * Sets the value of the thirdPartySenderDualCitizenshipCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setThirdPartySenderDualCitizenshipCountry(String value) {
        this.thirdPartySenderDualCitizenshipCountry = value;
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
     * Gets the value of the senderIntendedUseOfMGIServices property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderIntendedUseOfMGIServices() {
        return senderIntendedUseOfMGIServices;
    }

    /**
     * Sets the value of the senderIntendedUseOfMGIServices property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderIntendedUseOfMGIServices(String value) {
        this.senderIntendedUseOfMGIServices = value;
    }

    /**
     * Gets the value of the senderMotherMaidenName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderMotherMaidenName() {
        return senderMotherMaidenName;
    }

    /**
     * Sets the value of the senderMotherMaidenName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderMotherMaidenName(String value) {
        this.senderMotherMaidenName = value;
    }

    /**
     * Gets the value of the senderFatherFirstName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderFatherFirstName() {
        return senderFatherFirstName;
    }

    /**
     * Sets the value of the senderFatherFirstName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderFatherFirstName(String value) {
        this.senderFatherFirstName = value;
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
     * Gets the value of the promoCodeValues property.
     * 
     * @return
     *     possible object is
     *     {@link SendValidationRequest.PromoCodeValues }
     *     
     */
    public SendValidationRequest.PromoCodeValues getPromoCodeValues() {
        return promoCodeValues;
    }

    /**
     * Sets the value of the promoCodeValues property.
     * 
     * @param value
     *     allowed object is
     *     {@link SendValidationRequest.PromoCodeValues }
     *     
     */
    public void setPromoCodeValues(SendValidationRequest.PromoCodeValues value) {
        this.promoCodeValues = value;
    }

    /**
     * Gets the value of the fieldValues property.
     * 
     * @return
     *     possible object is
     *     {@link SendValidationRequest.FieldValues }
     *     
     */
    public SendValidationRequest.FieldValues getFieldValues() {
        return fieldValues;
    }

    /**
     * Sets the value of the fieldValues property.
     * 
     * @param value
     *     allowed object is
     *     {@link SendValidationRequest.FieldValues }
     *     
     */
    public void setFieldValues(SendValidationRequest.FieldValues value) {
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
     *         &lt;element name="promoCode" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "promoCode"
    })
    public static class PromoCodeValues {

        protected List<String> promoCode;

        /**
         * Gets the value of the promoCode property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the promoCode property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getPromoCode().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link String }
         * 
         * 
         */
        public List<String> getPromoCode() {
            if (promoCode == null) {
                promoCode = new ArrayList<String>();
            }
            return this.promoCode;
        }

    }

}
