
package com.huawei.cps.cpsinterface.request;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import com.huawei.cps.cpsinterface.common.ParameterType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Transaction或BO的请求消息
 * 
 * <p>Java class for Request complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="Request"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="Header"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="Version"&gt;
 *                     &lt;simpleType&gt;
 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                         &lt;maxLength value="32"/&gt;
 *                       &lt;/restriction&gt;
 *                     &lt;/simpleType&gt;
 *                   &lt;/element&gt;
 *                   &lt;element name="CommandID"&gt;
 *                     &lt;simpleType&gt;
 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                         &lt;maxLength value="64"/&gt;
 *                       &lt;/restriction&gt;
 *                     &lt;/simpleType&gt;
 *                   &lt;/element&gt;
 *                   &lt;element name="LanguageCode" minOccurs="0"&gt;
 *                     &lt;simpleType&gt;
 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                         &lt;maxLength value="10"/&gt;
 *                       &lt;/restriction&gt;
 *                     &lt;/simpleType&gt;
 *                   &lt;/element&gt;
 *                   &lt;element name="OriginatorConversationID" minOccurs="0"&gt;
 *                     &lt;simpleType&gt;
 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                         &lt;maxLength value="128"/&gt;
 *                       &lt;/restriction&gt;
 *                     &lt;/simpleType&gt;
 *                   &lt;/element&gt;
 *                   &lt;element name="ConversationID" minOccurs="0"&gt;
 *                     &lt;simpleType&gt;
 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                         &lt;maxLength value="36"/&gt;
 *                       &lt;/restriction&gt;
 *                     &lt;/simpleType&gt;
 *                   &lt;/element&gt;
 *                   &lt;element name="Caller"&gt;
 *                     &lt;complexType&gt;
 *                       &lt;complexContent&gt;
 *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                           &lt;sequence&gt;
 *                             &lt;element name="CallerType" type="{http://www.w3.org/2001/XMLSchema}integer"/&gt;
 *                             &lt;element name="ThirdPartyID"&gt;
 *                               &lt;simpleType&gt;
 *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                   &lt;maxLength value="20"/&gt;
 *                                 &lt;/restriction&gt;
 *                               &lt;/simpleType&gt;
 *                             &lt;/element&gt;
 *                             &lt;element name="Password" type="{http://cps.huawei.com/cpsinterface/common}SecurityCredentialType"/&gt;
 *                             &lt;element name="CheckSum" minOccurs="0"&gt;
 *                               &lt;simpleType&gt;
 *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                   &lt;maxLength value="1024"/&gt;
 *                                 &lt;/restriction&gt;
 *                               &lt;/simpleType&gt;
 *                             &lt;/element&gt;
 *                             &lt;element name="ResultURL" minOccurs="0"&gt;
 *                               &lt;simpleType&gt;
 *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                   &lt;maxLength value="1024"/&gt;
 *                                 &lt;/restriction&gt;
 *                               &lt;/simpleType&gt;
 *                             &lt;/element&gt;
 *                           &lt;/sequence&gt;
 *                         &lt;/restriction&gt;
 *                       &lt;/complexContent&gt;
 *                     &lt;/complexType&gt;
 *                   &lt;/element&gt;
 *                   &lt;element name="KeyOwner" type="{http://www.w3.org/2001/XMLSchema}integer"/&gt;
 *                   &lt;element name="AccessDevice" minOccurs="0"&gt;
 *                     &lt;complexType&gt;
 *                       &lt;complexContent&gt;
 *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                           &lt;sequence&gt;
 *                             &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
 *                             &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
 *                           &lt;/sequence&gt;
 *                         &lt;/restriction&gt;
 *                       &lt;/complexContent&gt;
 *                     &lt;/complexType&gt;
 *                   &lt;/element&gt;
 *                   &lt;element name="Timestamp"&gt;
 *                     &lt;simpleType&gt;
 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                         &lt;maxLength value="25"/&gt;
 *                       &lt;/restriction&gt;
 *                     &lt;/simpleType&gt;
 *                   &lt;/element&gt;
 *                   &lt;element name="ChannelCode" minOccurs="0"&gt;
 *                     &lt;simpleType&gt;
 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                         &lt;minLength value="1"/&gt;
 *                         &lt;maxLength value="64"/&gt;
 *                       &lt;/restriction&gt;
 *                     &lt;/simpleType&gt;
 *                   &lt;/element&gt;
 *                   &lt;element name="ChannelSessionId" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *                   &lt;element name="HeaderExtension" minOccurs="0"&gt;
 *                     &lt;complexType&gt;
 *                       &lt;complexContent&gt;
 *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                           &lt;sequence&gt;
 *                             &lt;element name="Extension" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
 *                           &lt;/sequence&gt;
 *                         &lt;/restriction&gt;
 *                       &lt;/complexContent&gt;
 *                     &lt;/complexType&gt;
 *                   &lt;/element&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="Body"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="Identity"&gt;
 *                     &lt;complexType&gt;
 *                       &lt;complexContent&gt;
 *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                           &lt;sequence&gt;
 *                             &lt;element name="Initiator"&gt;
 *                               &lt;complexType&gt;
 *                                 &lt;complexContent&gt;
 *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                     &lt;sequence&gt;
 *                                       &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
 *                                       &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
 *                                       &lt;element name="SecurityCredential" type="{http://cps.huawei.com/cpsinterface/common}SecurityCredentialType"/&gt;
 *                                       &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
 *                                       &lt;element name="InitiatorKYC" minOccurs="0"&gt;
 *                                         &lt;complexType&gt;
 *                                           &lt;complexContent&gt;
 *                                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                               &lt;sequence&gt;
 *                                                 &lt;element name="SimpleKYC" maxOccurs="unbounded" minOccurs="0"&gt;
 *                                                   &lt;complexType&gt;
 *                                                     &lt;complexContent&gt;
 *                                                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                                         &lt;sequence&gt;
 *                                                           &lt;element name="KYCFieldName"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="256"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="KYCValue"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="512"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                         &lt;/sequence&gt;
 *                                                       &lt;/restriction&gt;
 *                                                     &lt;/complexContent&gt;
 *                                                   &lt;/complexType&gt;
 *                                                 &lt;/element&gt;
 *                                                 &lt;element name="IDDetails" minOccurs="0"&gt;
 *                                                   &lt;complexType&gt;
 *                                                     &lt;complexContent&gt;
 *                                                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                                         &lt;sequence&gt;
 *                                                           &lt;element name="IDType" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="32"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="IDNumber"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                         &lt;/sequence&gt;
 *                                                       &lt;/restriction&gt;
 *                                                     &lt;/complexContent&gt;
 *                                                   &lt;/complexType&gt;
 *                                                 &lt;/element&gt;
 *                                                 &lt;element name="ContactDetails" minOccurs="0"&gt;
 *                                                   &lt;complexType&gt;
 *                                                     &lt;complexContent&gt;
 *                                                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                                         &lt;sequence&gt;
 *                                                           &lt;element name="ContactType" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="32"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="FirstName" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="LastName" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="SurName" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="PhoneNumber" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="EMail" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="256"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="IDNumber" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                         &lt;/sequence&gt;
 *                                                       &lt;/restriction&gt;
 *                                                     &lt;/complexContent&gt;
 *                                                   &lt;/complexType&gt;
 *                                                 &lt;/element&gt;
 *                                                 &lt;element name="CertificateDetails" minOccurs="0"&gt;
 *                                                   &lt;complexType&gt;
 *                                                     &lt;complexContent&gt;
 *                                                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                                         &lt;sequence&gt;
 *                                                           &lt;element name="CertificateType" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="32"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="CertificateNumber"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                         &lt;/sequence&gt;
 *                                                       &lt;/restriction&gt;
 *                                                     &lt;/complexContent&gt;
 *                                                   &lt;/complexType&gt;
 *                                                 &lt;/element&gt;
 *                                               &lt;/sequence&gt;
 *                                             &lt;/restriction&gt;
 *                                           &lt;/complexContent&gt;
 *                                         &lt;/complexType&gt;
 *                                       &lt;/element&gt;
 *                                       &lt;element name="GPSPosition" minOccurs="0"&gt;
 *                                         &lt;simpleType&gt;
 *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                             &lt;maxLength value="32"/&gt;
 *                                           &lt;/restriction&gt;
 *                                         &lt;/simpleType&gt;
 *                                       &lt;/element&gt;
 *                                     &lt;/sequence&gt;
 *                                   &lt;/restriction&gt;
 *                                 &lt;/complexContent&gt;
 *                               &lt;/complexType&gt;
 *                             &lt;/element&gt;
 *                             &lt;element name="PrimaryParty" minOccurs="0"&gt;
 *                               &lt;complexType&gt;
 *                                 &lt;complexContent&gt;
 *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                     &lt;sequence&gt;
 *                                       &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
 *                                       &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
 *                                       &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
 *                                       &lt;element name="PrimaryPartyKYC" minOccurs="0"&gt;
 *                                         &lt;complexType&gt;
 *                                           &lt;complexContent&gt;
 *                                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                               &lt;sequence&gt;
 *                                                 &lt;element name="SimpleKYC" maxOccurs="unbounded" minOccurs="0"&gt;
 *                                                   &lt;complexType&gt;
 *                                                     &lt;complexContent&gt;
 *                                                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                                         &lt;sequence&gt;
 *                                                           &lt;element name="KYCFieldName"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="256"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="KYCValue"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="512"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                         &lt;/sequence&gt;
 *                                                       &lt;/restriction&gt;
 *                                                     &lt;/complexContent&gt;
 *                                                   &lt;/complexType&gt;
 *                                                 &lt;/element&gt;
 *                                                 &lt;element name="IDDetails" minOccurs="0"&gt;
 *                                                   &lt;complexType&gt;
 *                                                     &lt;complexContent&gt;
 *                                                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                                         &lt;sequence&gt;
 *                                                           &lt;element name="IDType" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="32"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="IDNumber"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                         &lt;/sequence&gt;
 *                                                       &lt;/restriction&gt;
 *                                                     &lt;/complexContent&gt;
 *                                                   &lt;/complexType&gt;
 *                                                 &lt;/element&gt;
 *                                                 &lt;element name="ContactDetails" minOccurs="0"&gt;
 *                                                   &lt;complexType&gt;
 *                                                     &lt;complexContent&gt;
 *                                                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                                         &lt;sequence&gt;
 *                                                           &lt;element name="ContactType" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="32"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="FirstName" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="LastName" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="SurName" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="PhoneNumber" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="EMail" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="256"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="IDNumber" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                         &lt;/sequence&gt;
 *                                                       &lt;/restriction&gt;
 *                                                     &lt;/complexContent&gt;
 *                                                   &lt;/complexType&gt;
 *                                                 &lt;/element&gt;
 *                                                 &lt;element name="CertificateDetails" minOccurs="0"&gt;
 *                                                   &lt;complexType&gt;
 *                                                     &lt;complexContent&gt;
 *                                                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                                         &lt;sequence&gt;
 *                                                           &lt;element name="CertificateType" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="32"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="CertificateNumber"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                         &lt;/sequence&gt;
 *                                                       &lt;/restriction&gt;
 *                                                     &lt;/complexContent&gt;
 *                                                   &lt;/complexType&gt;
 *                                                 &lt;/element&gt;
 *                                               &lt;/sequence&gt;
 *                                             &lt;/restriction&gt;
 *                                           &lt;/complexContent&gt;
 *                                         &lt;/complexType&gt;
 *                                       &lt;/element&gt;
 *                                     &lt;/sequence&gt;
 *                                   &lt;/restriction&gt;
 *                                 &lt;/complexContent&gt;
 *                               &lt;/complexType&gt;
 *                             &lt;/element&gt;
 *                             &lt;element name="ReceiverParty" minOccurs="0"&gt;
 *                               &lt;complexType&gt;
 *                                 &lt;complexContent&gt;
 *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                     &lt;sequence&gt;
 *                                       &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
 *                                       &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
 *                                       &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
 *                                       &lt;element name="ReceiverKYC" minOccurs="0"&gt;
 *                                         &lt;complexType&gt;
 *                                           &lt;complexContent&gt;
 *                                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                               &lt;sequence&gt;
 *                                                 &lt;element name="SimpleKYC" maxOccurs="unbounded" minOccurs="0"&gt;
 *                                                   &lt;complexType&gt;
 *                                                     &lt;complexContent&gt;
 *                                                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                                         &lt;sequence&gt;
 *                                                           &lt;element name="KYCFieldName"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="256"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="KYCValue"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="512"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                         &lt;/sequence&gt;
 *                                                       &lt;/restriction&gt;
 *                                                     &lt;/complexContent&gt;
 *                                                   &lt;/complexType&gt;
 *                                                 &lt;/element&gt;
 *                                                 &lt;element name="IDDetails" minOccurs="0"&gt;
 *                                                   &lt;complexType&gt;
 *                                                     &lt;complexContent&gt;
 *                                                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                                         &lt;sequence&gt;
 *                                                           &lt;element name="IDType" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="32"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="IDNumber"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                         &lt;/sequence&gt;
 *                                                       &lt;/restriction&gt;
 *                                                     &lt;/complexContent&gt;
 *                                                   &lt;/complexType&gt;
 *                                                 &lt;/element&gt;
 *                                                 &lt;element name="ContactDetails" minOccurs="0"&gt;
 *                                                   &lt;complexType&gt;
 *                                                     &lt;complexContent&gt;
 *                                                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                                         &lt;sequence&gt;
 *                                                           &lt;element name="ContactType" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="32"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="FirstName" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="LastName" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="SurName" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="PhoneNumber" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="EMail" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="256"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="IDNumber" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                         &lt;/sequence&gt;
 *                                                       &lt;/restriction&gt;
 *                                                     &lt;/complexContent&gt;
 *                                                   &lt;/complexType&gt;
 *                                                 &lt;/element&gt;
 *                                                 &lt;element name="CertificateDetails" minOccurs="0"&gt;
 *                                                   &lt;complexType&gt;
 *                                                     &lt;complexContent&gt;
 *                                                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                                         &lt;sequence&gt;
 *                                                           &lt;element name="CertificateType" minOccurs="0"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="32"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                           &lt;element name="CertificateNumber"&gt;
 *                                                             &lt;simpleType&gt;
 *                                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                                 &lt;maxLength value="64"/&gt;
 *                                                               &lt;/restriction&gt;
 *                                                             &lt;/simpleType&gt;
 *                                                           &lt;/element&gt;
 *                                                         &lt;/sequence&gt;
 *                                                       &lt;/restriction&gt;
 *                                                     &lt;/complexContent&gt;
 *                                                   &lt;/complexType&gt;
 *                                                 &lt;/element&gt;
 *                                               &lt;/sequence&gt;
 *                                             &lt;/restriction&gt;
 *                                           &lt;/complexContent&gt;
 *                                         &lt;/complexType&gt;
 *                                       &lt;/element&gt;
 *                                     &lt;/sequence&gt;
 *                                   &lt;/restriction&gt;
 *                                 &lt;/complexContent&gt;
 *                               &lt;/complexType&gt;
 *                             &lt;/element&gt;
 *                             &lt;element name="Requester" minOccurs="0"&gt;
 *                               &lt;complexType&gt;
 *                                 &lt;complexContent&gt;
 *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                     &lt;sequence&gt;
 *                                       &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
 *                                       &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
 *                                       &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
 *                                     &lt;/sequence&gt;
 *                                   &lt;/restriction&gt;
 *                                 &lt;/complexContent&gt;
 *                               &lt;/complexType&gt;
 *                             &lt;/element&gt;
 *                           &lt;/sequence&gt;
 *                         &lt;/restriction&gt;
 *                       &lt;/complexContent&gt;
 *                     &lt;/complexType&gt;
 *                   &lt;/element&gt;
 *                   &lt;element name="Verification" minOccurs="0"&gt;
 *                     &lt;complexType&gt;
 *                       &lt;complexContent&gt;
 *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                           &lt;sequence&gt;
 *                             &lt;element name="ApplicationCode"&gt;
 *                               &lt;simpleType&gt;
 *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                   &lt;maxLength value="20"/&gt;
 *                                 &lt;/restriction&gt;
 *                               &lt;/simpleType&gt;
 *                             &lt;/element&gt;
 *                             &lt;element name="FunctionCode"&gt;
 *                               &lt;simpleType&gt;
 *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                   &lt;maxLength value="20"/&gt;
 *                                 &lt;/restriction&gt;
 *                               &lt;/simpleType&gt;
 *                             &lt;/element&gt;
 *                             &lt;element name="VerificationCode"&gt;
 *                               &lt;simpleType&gt;
 *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                   &lt;maxLength value="20"/&gt;
 *                                 &lt;/restriction&gt;
 *                               &lt;/simpleType&gt;
 *                             &lt;/element&gt;
 *                             &lt;element name="CustomerAccount" minOccurs="0"&gt;
 *                               &lt;simpleType&gt;
 *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                   &lt;maxLength value="1024"/&gt;
 *                                 &lt;/restriction&gt;
 *                               &lt;/simpleType&gt;
 *                             &lt;/element&gt;
 *                             &lt;element name="Destination" minOccurs="0"&gt;
 *                               &lt;simpleType&gt;
 *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                   &lt;maxLength value="1024"/&gt;
 *                                 &lt;/restriction&gt;
 *                               &lt;/simpleType&gt;
 *                             &lt;/element&gt;
 *                             &lt;element name="DestinationType" minOccurs="0"&gt;
 *                               &lt;simpleType&gt;
 *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                   &lt;maxLength value="1024"/&gt;
 *                                 &lt;/restriction&gt;
 *                               &lt;/simpleType&gt;
 *                             &lt;/element&gt;
 *                             &lt;element name="TransactionID" minOccurs="0"&gt;
 *                               &lt;simpleType&gt;
 *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                   &lt;maxLength value="1024"/&gt;
 *                                 &lt;/restriction&gt;
 *                               &lt;/simpleType&gt;
 *                             &lt;/element&gt;
 *                           &lt;/sequence&gt;
 *                         &lt;/restriction&gt;
 *                       &lt;/complexContent&gt;
 *                     &lt;/complexType&gt;
 *                   &lt;/element&gt;
 *                   &lt;choice&gt;
 *                     &lt;element name="EncryptedParameters" type="{http://www.w3.org/2001/XMLSchema}base64Binary"/&gt;
 *                     &lt;choice&gt;
 *                       &lt;element name="TransactionRequest"&gt;
 *                         &lt;complexType&gt;
 *                           &lt;complexContent&gt;
 *                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                               &lt;sequence&gt;
 *                                 &lt;element name="Parameters" minOccurs="0"&gt;
 *                                   &lt;complexType&gt;
 *                                     &lt;complexContent&gt;
 *                                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                                         &lt;sequence&gt;
 *                                           &lt;element name="Parameter" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *                                           &lt;element name="Amount" minOccurs="0"&gt;
 *                                             &lt;simpleType&gt;
 *                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                 &lt;maxLength value="18"/&gt;
 *                                               &lt;/restriction&gt;
 *                                             &lt;/simpleType&gt;
 *                                           &lt;/element&gt;
 *                                           &lt;element name="Currency" minOccurs="0"&gt;
 *                                             &lt;simpleType&gt;
 *                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                 &lt;length value="3"/&gt;
 *                                               &lt;/restriction&gt;
 *                                             &lt;/simpleType&gt;
 *                                           &lt;/element&gt;
 *                                           &lt;element name="ReasonType" minOccurs="0"&gt;
 *                                             &lt;simpleType&gt;
 *                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                 &lt;maxLength value="128"/&gt;
 *                                               &lt;/restriction&gt;
 *                                             &lt;/simpleType&gt;
 *                                           &lt;/element&gt;
 *                                           &lt;element name="VoucherType" minOccurs="0"&gt;
 *                                             &lt;simpleType&gt;
 *                                               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                                 &lt;maxLength value="128"/&gt;
 *                                               &lt;/restriction&gt;
 *                                             &lt;/simpleType&gt;
 *                                           &lt;/element&gt;
 *                                         &lt;/sequence&gt;
 *                                       &lt;/restriction&gt;
 *                                     &lt;/complexContent&gt;
 *                                   &lt;/complexType&gt;
 *                                 &lt;/element&gt;
 *                               &lt;/sequence&gt;
 *                             &lt;/restriction&gt;
 *                           &lt;/complexContent&gt;
 *                         &lt;/complexType&gt;
 *                       &lt;/element&gt;
 *                       &lt;element name="CreateTopOrgRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateTopOrgRequest"/&gt;
 *                       &lt;element name="CreateChildOrgRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateChildOrgRequest"/&gt;
 *                       &lt;element name="CreateTillRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateTillRequest"/&gt;
 *                       &lt;element name="CreateOrgOperatorRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateOrgOperatorRequest"/&gt;
 *                       &lt;element name="ChangeCustomerMSISDNRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeCustomerMSISDNRequest"/&gt;
 *                       &lt;element name="ChangeTillMSISDNRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeTillMSISDNRequest"/&gt;
 *                       &lt;element name="ChangeTillLanguageRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeTillLanguageRequest"/&gt;
 *                       &lt;element name="ChangeAccountStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeAccountStatusRequest"/&gt;
 *                       &lt;element name="UpdateCustomerKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateCustomerKYCRequest"/&gt;
 *                       &lt;element name="UpdateOrganizationKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateOrganizationKYCRequest"/&gt;
 *                       &lt;element name="QueryCustomerKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustomerKYCRequest"/&gt;
 *                       &lt;element name="QueryCustomerInfoRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustomerInfoRequest"/&gt;
 *                       &lt;element name="QueryCustomerProductsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustomerProductsRequest"/&gt;
 *                       &lt;element name="QueryCustomerBalanceRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustomerBalanceRequest"/&gt;
 *                       &lt;element name="QueryOrganizationKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrganizationKYCRequest"/&gt;
 *                       &lt;element name="QueryOrganizationInfoRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrganizationInfoRequest"/&gt;
 *                       &lt;element name="QueryOrganizationProductsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrganizationProductsRequest"/&gt;
 *                       &lt;element name="QueryOrganizationBalanceRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrganizationBalanceRequest"/&gt;
 *                       &lt;element name="ListOrganizationTillsRequest" type="{http://cps.huawei.com/cpsinterface/request}ListOrganizationTillsRequest"/&gt;
 *                       &lt;element name="QueryOrgOperatorKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrgOperatorKYCRequest"/&gt;
 *                       &lt;element name="QueryOrgOperatorInfoRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrgOperatorInfoRequest"/&gt;
 *                       &lt;element name="QueryTillInfoRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryTillInfoRequest"/&gt;
 *                       &lt;element name="QueryTillProductsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryTillProductsRequest"/&gt;
 *                       &lt;element name="ChangeCustomerStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeCustomerStatusRequest"/&gt;
 *                       &lt;element name="ChangeOrganizationStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeOrganizationStatusRequest"/&gt;
 *                       &lt;element name="ChangeTillStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeTillStatusRequest"/&gt;
 *                       &lt;element name="ChangeSPOperatorStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeSPOperatorStatusRequest"/&gt;
 *                       &lt;element name="ChangeOrgOperatorStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeOrgOperatorStatusRequest"/&gt;
 *                       &lt;element name="UpdateSPOperatorKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateSPOperatorKYCRequest"/&gt;
 *                       &lt;element name="UpdateOrgOperatorKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateOrgOperatorKYCRequest"/&gt;
 *                       &lt;element name="UpdateCustomerProductsRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateCustomerProductsRequest"/&gt;
 *                       &lt;element name="UpdateOrganizationProductsRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateOrganizationProductsRequest"/&gt;
 *                       &lt;element name="UpdateTillProductsRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateTillProductsRequest"/&gt;
 *                       &lt;element name="RegisterCustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}RegisterCustomerRequest"/&gt;
 *                       &lt;element name="RecycleMSISDNRequest" type="{http://cps.huawei.com/cpsinterface/request}RecycleMSISDNRequest"/&gt;
 *                       &lt;element name="ListOrganizationChildStoresRequest" type="{http://cps.huawei.com/cpsinterface/request}ListOrganizationChildStoresRequest"/&gt;
 *                       &lt;element name="ListOrganizationOperatorsRequest" type="{http://cps.huawei.com/cpsinterface/request}ListOrganizationOperatorsRequest"/&gt;
 *                       &lt;element name="UpdateSPOperatorRoleRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateSPOperatorRoleRequest"/&gt;
 *                       &lt;element name="UpdateOrgOperatorRoleRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateOrgOperatorRoleRequest"/&gt;
 *                       &lt;element name="UpdateOrgTaxExemptionRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateOrgTaxExemptionRequest"/&gt;
 *                       &lt;element name="QueryO2CLinkRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryO2CLinkRequest"/&gt;
 *                       &lt;element name="AddO2CLinkRequest" type="{http://cps.huawei.com/cpsinterface/request}AddO2CLinkRequest"/&gt;
 *                       &lt;element name="DeleteO2CLinkRequest" type="{http://cps.huawei.com/cpsinterface/request}DeleteO2CLinkRequest"/&gt;
 *                       &lt;element name="VerifyCCCallerRequest" type="{http://cps.huawei.com/cpsinterface/request}VerifyCCCallerRequest"/&gt;
 *                       &lt;element name="UnlockCustomerPINRequest" type="{http://cps.huawei.com/cpsinterface/request}UnlockCustomerPINRequest"/&gt;
 *                       &lt;element name="UnlockOrgOperatorPINRequest" type="{http://cps.huawei.com/cpsinterface/request}UnlockOrgOperatorPINRequest"/&gt;
 *                       &lt;element name="UnlockOrgOperatorPasswordRequest" type="{http://cps.huawei.com/cpsinterface/request}UnlockOrgOperatorPasswordRequest"/&gt;
 *                       &lt;element name="ResetCustomerPINRequest" type="{http://cps.huawei.com/cpsinterface/request}ResetCustomerPINRequest"/&gt;
 *                       &lt;element name="ResetOrgOperatorPINRequest" type="{http://cps.huawei.com/cpsinterface/request}ResetOrgOperatorPINRequest"/&gt;
 *                       &lt;element name="ResetOrgOperatorPasswordRequest" type="{http://cps.huawei.com/cpsinterface/request}ResetOrgOperatorPasswordRequest"/&gt;
 *                       &lt;element name="ResetCustomerSecretWordRequest" type="{http://cps.huawei.com/cpsinterface/request}ResetCustomerSecretWordRequest"/&gt;
 *                       &lt;element name="ReleaseCustomerCCSuspendStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}ReleaseCustomerCCSuspendStatusRequest"/&gt;
 *                       &lt;element name="ReleaseOrgOperatorCCSuspendStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}ReleaseOrgOperatorCCSuspendStatusRequest"/&gt;
 *                       &lt;element name="SearchTransactionRequest" type="{http://cps.huawei.com/cpsinterface/request}SearchTransactionRequest"/&gt;
 *                       &lt;element name="ReverseTransactionRequest" type="{http://cps.huawei.com/cpsinterface/request}ReverseTransactionRequest"/&gt;
 *                       &lt;element name="ConfirmTransactionRequest" type="{http://cps.huawei.com/cpsinterface/request}ConfirmTransactionRequest"/&gt;
 *                       &lt;element name="QueryCustomerAccountStatementsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustomerAccountStatementsRequest"/&gt;
 *                       &lt;element name="QueryCustomerTransactionsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustomerTransactionsRequest"/&gt;
 *                       &lt;element name="QueryOrganizationAccountStatementsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrganizationAccountStatementsRequest"/&gt;
 *                       &lt;element name="QueryOrganizationTransactionsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrganizationTransactionsRequest"/&gt;
 *                       &lt;element name="QueryResultMessageRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryResultMessageRequest"/&gt;
 *                       &lt;element name="UpdateTransactionStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateTransactionStatusRequest"/&gt;
 *                       &lt;element name="ChangeCustomerPINRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeCustomerPINRequest"/&gt;
 *                       &lt;element name="ChangeOrgOperatorPINRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeOrgOperatorPINRequest"/&gt;
 *                       &lt;element name="ChangeCustomerSecretWordRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeCustomerSecretWordRequest"/&gt;
 *                       &lt;element name="ChangeOrgOperatorSecretWordRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeOrgOperatorSecretWordRequest"/&gt;
 *                       &lt;element name="ChangeCustomerLanguageRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeCustomerLanguageRequest"/&gt;
 *                       &lt;element name="ChangeOrgOperatorLanguageRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeOrgOperatorLanguageRequest"/&gt;
 *                       &lt;element name="ChangeSPOperatorLanguageRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeSPOperatorLanguageRequest"/&gt;
 *                       &lt;element name="ChangeOrgnNameRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeOrgnNameRequest"/&gt;
 *                       &lt;element name="ActivateCustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}ActivateCustomerRequest"/&gt;
 *                       &lt;element name="ActivateTillRequest" type="{http://cps.huawei.com/cpsinterface/request}ActivateTillRequest"/&gt;
 *                       &lt;element name="AddCustomerBeneficiaryRequest" type="{http://cps.huawei.com/cpsinterface/request}AddCustomerBeneficiaryRequest"/&gt;
 *                       &lt;element name="AddOrgBeneficiaryRequest" type="{http://cps.huawei.com/cpsinterface/request}AddOrgBeneficiaryRequest"/&gt;
 *                       &lt;element name="DeleteCustomerBeneficiaryRequest" type="{http://cps.huawei.com/cpsinterface/request}DeleteCustomerBeneficiaryRequest"/&gt;
 *                       &lt;element name="DeleteOrgBeneficiaryRequest" type="{http://cps.huawei.com/cpsinterface/request}DeleteOrgBeneficiaryRequest"/&gt;
 *                       &lt;element name="LookupCustomerBeneficiaryRequest" type="{http://cps.huawei.com/cpsinterface/request}LookupCustomerBeneficiaryRequest"/&gt;
 *                       &lt;element name="LookupOrgBeneficiaryRequest" type="{http://cps.huawei.com/cpsinterface/request}LookupOrgBeneficiaryRequest"/&gt;
 *                       &lt;element name="AddGroupBeneficiaryRequest" type="{http://cps.huawei.com/cpsinterface/request}AddGroupBeneficiaryRequest"/&gt;
 *                       &lt;element name="DeleteGroupBeneficiaryRequest" type="{http://cps.huawei.com/cpsinterface/request}DeleteGroupBeneficiaryRequest"/&gt;
 *                       &lt;element name="LookupGroupBeneficiaryRequest" type="{http://cps.huawei.com/cpsinterface/request}LookupGroupBeneficiaryRequest"/&gt;
 *                       &lt;element name="RecipientLookUpRequest" type="{http://cps.huawei.com/cpsinterface/request}RecipientLookUpRequest"/&gt;
 *                       &lt;element name="BulkTaskRequest" type="{http://cps.huawei.com/cpsinterface/request}BulkTaskRequest"/&gt;
 *                       &lt;element name="SMSVCSendRequest" type="{http://cps.huawei.com/cpsinterface/request}SMSVCSendRequest"/&gt;
 *                       &lt;element name="ChangeTillDefaultOperatorIDRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeTillDefaultOperatorIDRequest"/&gt;
 *                       &lt;element name="CustomerGetStartPINRequest" type="{http://cps.huawei.com/cpsinterface/request}CustomerGetStartPINRequest"/&gt;
 *                       &lt;element name="QueryGroupBalanceRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryGroupBalanceRequest"/&gt;
 *                       &lt;element name="QueryGroupAccountStatementsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryGroupAccountStatementsRequest"/&gt;
 *                       &lt;element name="QueryGroupTransactionsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryGroupTransactionsRequest"/&gt;
 *                       &lt;element name="QueryCustomerPointsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustomerPointsRequest"/&gt;
 *                       &lt;element name="QueryCustomerPointsLogRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustomerPointsLogRequest"/&gt;
 *                       &lt;element name="AdjustCustomerPointsRequest" type="{http://cps.huawei.com/cpsinterface/request}AdjustCustomerPointsRequest"/&gt;
 *                       &lt;element name="QueryOrganizationPointsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrganizationPointsRequest"/&gt;
 *                       &lt;element name="QueryOrganizationPointsLogRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrganizationPointsLogRequest"/&gt;
 *                       &lt;element name="AdjustOrganizationPointsRequest" type="{http://cps.huawei.com/cpsinterface/request}AdjustOrganizationPointsRequest"/&gt;
 *                       &lt;element name="CreateGroupRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateGroupRequest"/&gt;
 *                       &lt;element name="CreateGroupByCustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateGroupByCustomerRequest"/&gt;
 *                       &lt;element name="UpdateGroupKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateGroupKYCRequest"/&gt;
 *                       &lt;element name="ChangeGroupStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeGroupStatusRequest"/&gt;
 *                       &lt;element name="AddGroupMemberRequest" type="{http://cps.huawei.com/cpsinterface/request}AddGroupMemberRequest"/&gt;
 *                       &lt;element name="AddGroupMemberByGroupLeaderRequest" type="{http://cps.huawei.com/cpsinterface/request}AddGroupMemberByGroupLeaderRequest"/&gt;
 *                       &lt;element name="RemoveGroupMemberRequest" type="{http://cps.huawei.com/cpsinterface/request}RemoveGroupMemberRequest"/&gt;
 *                       &lt;element name="RemoveGroupMemberByGroupLeaderRequest" type="{http://cps.huawei.com/cpsinterface/request}RemoveGroupMemberByGroupLeaderRequest"/&gt;
 *                       &lt;element name="ChangeGroupMemberRolesRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeGroupMemberRolesRequest"/&gt;
 *                       &lt;element name="ChangeGroupMemberRolesByGroupLeaderRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeGroupMemberRolesByGroupLeaderRequest"/&gt;
 *                       &lt;element name="ConfirmGroupMembershipRequest" type="{http://cps.huawei.com/cpsinterface/request}ConfirmGroupMembershipRequest"/&gt;
 *                       &lt;element name="ApproveGroupActionOrTransactionRequest" type="{http://cps.huawei.com/cpsinterface/request}ApproveGroupActionOrTransactionRequest"/&gt;
 *                       &lt;element name="SearchMyGroupsRequest" type="{http://cps.huawei.com/cpsinterface/request}SearchMyGroupsRequest"/&gt;
 *                       &lt;element name="QueryGroupInfoRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryGroupInfoRequest"/&gt;
 *                       &lt;element name="QueryGroupKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryGroupKYCRequest"/&gt;
 *                       &lt;element name="QueryGroupProductsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryGroupProductsRequest"/&gt;
 *                       &lt;element name="ListGroupMembersRequest" type="{http://cps.huawei.com/cpsinterface/request}ListGroupMembersRequest"/&gt;
 *                       &lt;element name="ListGroupMembersByCustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}ListGroupMembersByCustomerRequest"/&gt;
 *                       &lt;element name="ChangeGroupRuleProfileRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeGroupRuleProfileRequest"/&gt;
 *                       &lt;element name="ChangeGroupChargeProfileRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeGroupChargeProfileRequest"/&gt;
 *                       &lt;element name="ChangeGroupAccountRuleProfileRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeGroupAccountRuleProfileRequest"/&gt;
 *                       &lt;element name="IdentifyCustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}IdentifyCustomerRequest"/&gt;
 *                       &lt;element name="RaiseDisputedTxnReversalRequest" type="{http://cps.huawei.com/cpsinterface/request}RaiseDisputedTxnReversalRequest"/&gt;
 *                       &lt;element name="CancelIssuedVoucherRequest" type="{http://cps.huawei.com/cpsinterface/request}CancelIssuedVoucherRequest"/&gt;
 *                       &lt;element name="CreateCustomerBundleRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateCustomerBundleRequest"/&gt;
 *                       &lt;element name="CreateOrganizationBundleRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateOrganizationBundleRequest"/&gt;
 *                       &lt;element name="CreateExternalProviderBundleRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateExternalProviderBundleRequest"/&gt;
 *                       &lt;element name="CreateGroupBundleRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateGroupBundleRequest"/&gt;
 *                       &lt;element name="CreateBankAccountRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateBankAccountRequest"/&gt;
 *                       &lt;element name="QueryIdentityBundleRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryIdentityBundleRequest"/&gt;
 *                       &lt;element name="DeleteBankAccountRequest" type="{http://cps.huawei.com/cpsinterface/request}DeleteBankAccountRequest"/&gt;
 *                       &lt;element name="SetDefaultBankAccountRequest" type="{http://cps.huawei.com/cpsinterface/request}SetDefaultBankAccountRequest"/&gt;
 *                       &lt;element name="CreateDirectDebitMandateByPayeeRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateDirectDebitMandateByPayeeRequest"/&gt;
 *                       &lt;element name="CreateDirectDebitMandateByPayerRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateDirectDebitMandateByPayerRequest"/&gt;
 *                       &lt;element name="ActivateDirectDebitMandateRequest" type="{http://cps.huawei.com/cpsinterface/request}ActivateDirectDebitMandateRequest"/&gt;
 *                       &lt;element name="CancelDirectDebitMandateByPayerRequest" type="{http://cps.huawei.com/cpsinterface/request}CancelDirectDebitMandateByPayerRequest"/&gt;
 *                       &lt;element name="CancelDirectDebitMandateByPayeeRequest" type="{http://cps.huawei.com/cpsinterface/request}CancelDirectDebitMandateByPayeeRequest"/&gt;
 *                       &lt;element name="ReactivateDirectDebitMandateByPayerRequest" type="{http://cps.huawei.com/cpsinterface/request}ReactivateDirectDebitMandateByPayerRequest"/&gt;
 *                       &lt;element name="ReactivateDirectDebitMandateByPayeeRequest" type="{http://cps.huawei.com/cpsinterface/request}ReactivateDirectDebitMandateByPayeeRequest"/&gt;
 *                       &lt;element name="EditDirectDebitMandateByPayerRequest" type="{http://cps.huawei.com/cpsinterface/request}EditDirectDebitMandateByPayerRequest"/&gt;
 *                       &lt;element name="EditDirectDebitMandateByPayeeRequest" type="{http://cps.huawei.com/cpsinterface/request}EditDirectDebitMandateByPayeeRequest"/&gt;
 *                       &lt;element name="QueryDirectDebitMandateByPayerRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryDirectDebitMandateByPayerRequest"/&gt;
 *                       &lt;element name="ViewDirectDebitMandateByPayerRequest" type="{http://cps.huawei.com/cpsinterface/request}ViewDirectDebitMandateByPayerRequest"/&gt;
 *                       &lt;element name="ViewDirectDebitMandateByPayeeRequest" type="{http://cps.huawei.com/cpsinterface/request}ViewDirectDebitMandateByPayeeRequest"/&gt;
 *                       &lt;element name="DeleteIndividualReminderScheduleRequest" type="{http://cps.huawei.com/cpsinterface/request}DeleteIndividualReminderScheduleRequest"/&gt;
 *                       &lt;element name="CreateReminderScheduleRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateReminderScheduleRequest"/&gt;
 *                       &lt;element name="QueryReminderScheduleRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryReminderScheduleRequest"/&gt;
 *                       &lt;element name="LinkingIdentitiesRequest" type="{http://cps.huawei.com/cpsinterface/request}LinkingIdentitiesRequest"/&gt;
 *                       &lt;element name="UnlinkIdentitiesRequest" type="{http://cps.huawei.com/cpsinterface/request}UnlinkIdentitiesRequest"/&gt;
 *                       &lt;element name="CCHChangeCustKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}CCHChangeCustKYCRequest"/&gt;
 *                       &lt;element name="CCHChangeOrgOperatorKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}CCHChangeOrgOperatorKYCRequest"/&gt;
 *                       &lt;element name="PreValidationRequest" type="{http://cps.huawei.com/cpsinterface/request}PreValidationRequest"/&gt;
 *                       &lt;element name="PreValidationConfirmationRequest" type="{http://cps.huawei.com/cpsinterface/request}PreValidationConfirmationRequest"/&gt;
 *                       &lt;element name="CreateOrgLoyaltyAccountRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateOrgLoyaltyAccountRequest"/&gt;
 *                       &lt;element name="CreateCustLoyaltyAccountRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateCustLoyaltyAccountRequest"/&gt;
 *                       &lt;element name="CreateGroupLoyaltyAccountRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateGroupLoyaltyAccountRequest"/&gt;
 *                       &lt;element name="CustomerRegisterCardRequest" type="{http://cps.huawei.com/cpsinterface/request}CustomerRegisterCardRequest"/&gt;
 *                       &lt;element name="OrgRegisterCardRequest" type="{http://cps.huawei.com/cpsinterface/request}OrgRegisterCardRequest"/&gt;
 *                       &lt;element name="GroupRegisterCardRequest" type="{http://cps.huawei.com/cpsinterface/request}GroupRegisterCardRequest"/&gt;
 *                       &lt;element name="RegisterCard4CustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}RegisterCard4CustomerRequest"/&gt;
 *                       &lt;element name="RegisterCard4OrgRequest" type="{http://cps.huawei.com/cpsinterface/request}RegisterCard4OrgRequest"/&gt;
 *                       &lt;element name="RegisterCard4GroupRequest" type="{http://cps.huawei.com/cpsinterface/request}RegisterCard4GroupRequest"/&gt;
 *                       &lt;element name="CustomerActivateCardRequest" type="{http://cps.huawei.com/cpsinterface/request}CustomerActivateCardRequest"/&gt;
 *                       &lt;element name="OrgActivateCardRequest" type="{http://cps.huawei.com/cpsinterface/request}OrgActivateCardRequest"/&gt;
 *                       &lt;element name="GroupActivateCardRequest" type="{http://cps.huawei.com/cpsinterface/request}GroupActivateCardRequest"/&gt;
 *                       &lt;element name="CustomerCancelCardRequest" type="{http://cps.huawei.com/cpsinterface/request}CustomerCancelCardRequest"/&gt;
 *                       &lt;element name="OrgCancelCardRequest" type="{http://cps.huawei.com/cpsinterface/request}OrgCancelCardRequest"/&gt;
 *                       &lt;element name="GroupCancelCardRequest" type="{http://cps.huawei.com/cpsinterface/request}GroupCancelCardRequest"/&gt;
 *                       &lt;element name="QueryCustLoyaltyPointRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustLoyaltyPointRequest"/&gt;
 *                       &lt;element name="QueryOrgLoyaltyPointRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrgLoyaltyPointRequest"/&gt;
 *                       &lt;element name="QueryGroupLoyaltyPointRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryGroupLoyaltyPointRequest"/&gt;
 *                       &lt;element name="QueryLoyaltyConsumerRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryLoyaltyConsumerRequest"/&gt;
 *                       &lt;element name="QueryCustLoyaltyPointStatementRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustLoyaltyPointStatementRequest"/&gt;
 *                       &lt;element name="QueryOrgLoyaltyPointStatementRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrgLoyaltyPointStatementRequest"/&gt;
 *                       &lt;element name="QueryGroupLoyaltyPointStatementRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryGroupLoyaltyPointStatementRequest"/&gt;
 *                       &lt;element name="QueryLoyaltyConsumerStatementRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryLoyaltyConsumerStatementRequest"/&gt;
 *                       &lt;element name="CCHIdentifyCustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}CCHIdentifyCustomerRequest"/&gt;
 *                       &lt;element name="CCHIdentifyOperatorRequest" type="{http://cps.huawei.com/cpsinterface/request}CCHIdentifyOperatorRequest"/&gt;
 *                       &lt;element name="UpdateOrgOperatorOwnKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateOrgOperatorOwnKYCRequest"/&gt;
 *                       &lt;element name="QuerySavingPlanForCustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}QuerySavingPlanForCustomerRequest"/&gt;
 *                       &lt;element name="QuerySavingPlanForGroupRequest" type="{http://cps.huawei.com/cpsinterface/request}QuerySavingPlanForGroupRequest"/&gt;
 *                       &lt;element name="QuerySavingPlanForOrganizationRequest" type="{http://cps.huawei.com/cpsinterface/request}QuerySavingPlanForOrganizationRequest"/&gt;
 *                       &lt;element name="QueryTransferPointsFeeRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryTransferPointsFeeRequest"/&gt;
 *                       &lt;element name="QueryRedeemBalanceRateRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryRedeemBalanceRateRequest"/&gt;
 *                       &lt;element name="TransferPointsRequest" type="{http://cps.huawei.com/cpsinterface/request}TransferPointsRequest"/&gt;
 *                       &lt;element name="RedeemPointsToGoodsRequest" type="{http://cps.huawei.com/cpsinterface/request}RedeemPointsToGoodsRequest"/&gt;
 *                       &lt;element name="RedeemPointsWithVoucherRequest" type="{http://cps.huawei.com/cpsinterface/request}RedeemPointsWithVoucherRequest"/&gt;
 *                       &lt;element name="RedeemPointsToBalanceRequest" type="{http://cps.huawei.com/cpsinterface/request}RedeemPointsToBalanceRequest"/&gt;
 *                       &lt;element name="SubscribeSavingPlanForCustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}SubscribeSavingPlanForCustomerRequest"/&gt;
 *                       &lt;element name="SubscribeSavingPlanForGroupRequest" type="{http://cps.huawei.com/cpsinterface/request}SubscribeSavingPlanForGroupRequest"/&gt;
 *                       &lt;element name="SubscribeSavingPlanForOrgRequest" type="{http://cps.huawei.com/cpsinterface/request}SubscribeSavingPlanForOrgRequest"/&gt;
 *                       &lt;element name="UnSubscribeSavingPlanForCustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}UnSubscribeSavingPlanForCustomerRequest"/&gt;
 *                       &lt;element name="UnSubscribeSavingPlanForGroupRequest" type="{http://cps.huawei.com/cpsinterface/request}UnSubscribeSavingPlanForGroupRequest"/&gt;
 *                       &lt;element name="UnSubscribeSavingPlanForOrgRequest" type="{http://cps.huawei.com/cpsinterface/request}UnSubscribeSavingPlanForOrgRequest"/&gt;
 *                       &lt;element name="ValidateTokenRequest" type="{http://cps.huawei.com/cpsinterface/request}ValidateTokenRequest"/&gt;
 *                       &lt;element name="ChangeOrgOperatorMSISDNRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeOrgOperatorMSISDNRequest"/&gt;
 *                     &lt;/choice&gt;
 *                   &lt;/choice&gt;
 *                   &lt;element name="ReferenceData" minOccurs="0"&gt;
 *                     &lt;complexType&gt;
 *                       &lt;complexContent&gt;
 *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                           &lt;sequence&gt;
 *                             &lt;element name="ReferenceItem" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
 *                           &lt;/sequence&gt;
 *                         &lt;/restriction&gt;
 *                       &lt;/complexContent&gt;
 *                     &lt;/complexType&gt;
 *                   &lt;/element&gt;
 *                   &lt;element name="Remark" minOccurs="0"&gt;
 *                     &lt;simpleType&gt;
 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                         &lt;maxLength value="255"/&gt;
 *                       &lt;/restriction&gt;
 *                     &lt;/simpleType&gt;
 *                   &lt;/element&gt;
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
    "header",
    "body"
})
public class Request {

    @XmlElement(name = "Header", required = true)
    protected Request.Header header;
    @XmlElement(name = "Body", required = true)
    protected Request.Body body;

    /**
     * Gets the value of the header property.
     * 
     * @return
     *     possible object is
     *     {@link Request.Header }
     *     
     */
    public Request.Header getHeader() {
        return header;
    }

    /**
     * Sets the value of the header property.
     * 
     * @param value
     *     allowed object is
     *     {@link Request.Header }
     *     
     */
    public void setHeader(Request.Header value) {
        this.header = value;
    }

    /**
     * Gets the value of the body property.
     * 
     * @return
     *     possible object is
     *     {@link Request.Body }
     *     
     */
    public Request.Body getBody() {
        return body;
    }

    /**
     * Sets the value of the body property.
     * 
     * @param value
     *     allowed object is
     *     {@link Request.Body }
     *     
     */
    public void setBody(Request.Body value) {
        this.body = value;
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
     *         &lt;element name="Identity"&gt;
     *           &lt;complexType&gt;
     *             &lt;complexContent&gt;
     *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                 &lt;sequence&gt;
     *                   &lt;element name="Initiator"&gt;
     *                     &lt;complexType&gt;
     *                       &lt;complexContent&gt;
     *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                           &lt;sequence&gt;
     *                             &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
     *                             &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
     *                             &lt;element name="SecurityCredential" type="{http://cps.huawei.com/cpsinterface/common}SecurityCredentialType"/&gt;
     *                             &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
     *                             &lt;element name="InitiatorKYC" minOccurs="0"&gt;
     *                               &lt;complexType&gt;
     *                                 &lt;complexContent&gt;
     *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                                     &lt;sequence&gt;
     *                                       &lt;element name="SimpleKYC" maxOccurs="unbounded" minOccurs="0"&gt;
     *                                         &lt;complexType&gt;
     *                                           &lt;complexContent&gt;
     *                                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                                               &lt;sequence&gt;
     *                                                 &lt;element name="KYCFieldName"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="256"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="KYCValue"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="512"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                               &lt;/sequence&gt;
     *                                             &lt;/restriction&gt;
     *                                           &lt;/complexContent&gt;
     *                                         &lt;/complexType&gt;
     *                                       &lt;/element&gt;
     *                                       &lt;element name="IDDetails" minOccurs="0"&gt;
     *                                         &lt;complexType&gt;
     *                                           &lt;complexContent&gt;
     *                                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                                               &lt;sequence&gt;
     *                                                 &lt;element name="IDType" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="32"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="IDNumber"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                               &lt;/sequence&gt;
     *                                             &lt;/restriction&gt;
     *                                           &lt;/complexContent&gt;
     *                                         &lt;/complexType&gt;
     *                                       &lt;/element&gt;
     *                                       &lt;element name="ContactDetails" minOccurs="0"&gt;
     *                                         &lt;complexType&gt;
     *                                           &lt;complexContent&gt;
     *                                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                                               &lt;sequence&gt;
     *                                                 &lt;element name="ContactType" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="32"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="FirstName" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="LastName" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="SurName" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="PhoneNumber" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="EMail" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="256"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="IDNumber" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                               &lt;/sequence&gt;
     *                                             &lt;/restriction&gt;
     *                                           &lt;/complexContent&gt;
     *                                         &lt;/complexType&gt;
     *                                       &lt;/element&gt;
     *                                       &lt;element name="CertificateDetails" minOccurs="0"&gt;
     *                                         &lt;complexType&gt;
     *                                           &lt;complexContent&gt;
     *                                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                                               &lt;sequence&gt;
     *                                                 &lt;element name="CertificateType" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="32"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="CertificateNumber"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                               &lt;/sequence&gt;
     *                                             &lt;/restriction&gt;
     *                                           &lt;/complexContent&gt;
     *                                         &lt;/complexType&gt;
     *                                       &lt;/element&gt;
     *                                     &lt;/sequence&gt;
     *                                   &lt;/restriction&gt;
     *                                 &lt;/complexContent&gt;
     *                               &lt;/complexType&gt;
     *                             &lt;/element&gt;
     *                             &lt;element name="GPSPosition" minOccurs="0"&gt;
     *                               &lt;simpleType&gt;
     *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                   &lt;maxLength value="32"/&gt;
     *                                 &lt;/restriction&gt;
     *                               &lt;/simpleType&gt;
     *                             &lt;/element&gt;
     *                           &lt;/sequence&gt;
     *                         &lt;/restriction&gt;
     *                       &lt;/complexContent&gt;
     *                     &lt;/complexType&gt;
     *                   &lt;/element&gt;
     *                   &lt;element name="PrimaryParty" minOccurs="0"&gt;
     *                     &lt;complexType&gt;
     *                       &lt;complexContent&gt;
     *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                           &lt;sequence&gt;
     *                             &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
     *                             &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
     *                             &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
     *                             &lt;element name="PrimaryPartyKYC" minOccurs="0"&gt;
     *                               &lt;complexType&gt;
     *                                 &lt;complexContent&gt;
     *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                                     &lt;sequence&gt;
     *                                       &lt;element name="SimpleKYC" maxOccurs="unbounded" minOccurs="0"&gt;
     *                                         &lt;complexType&gt;
     *                                           &lt;complexContent&gt;
     *                                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                                               &lt;sequence&gt;
     *                                                 &lt;element name="KYCFieldName"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="256"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="KYCValue"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="512"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                               &lt;/sequence&gt;
     *                                             &lt;/restriction&gt;
     *                                           &lt;/complexContent&gt;
     *                                         &lt;/complexType&gt;
     *                                       &lt;/element&gt;
     *                                       &lt;element name="IDDetails" minOccurs="0"&gt;
     *                                         &lt;complexType&gt;
     *                                           &lt;complexContent&gt;
     *                                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                                               &lt;sequence&gt;
     *                                                 &lt;element name="IDType" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="32"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="IDNumber"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                               &lt;/sequence&gt;
     *                                             &lt;/restriction&gt;
     *                                           &lt;/complexContent&gt;
     *                                         &lt;/complexType&gt;
     *                                       &lt;/element&gt;
     *                                       &lt;element name="ContactDetails" minOccurs="0"&gt;
     *                                         &lt;complexType&gt;
     *                                           &lt;complexContent&gt;
     *                                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                                               &lt;sequence&gt;
     *                                                 &lt;element name="ContactType" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="32"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="FirstName" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="LastName" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="SurName" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="PhoneNumber" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="EMail" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="256"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="IDNumber" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                               &lt;/sequence&gt;
     *                                             &lt;/restriction&gt;
     *                                           &lt;/complexContent&gt;
     *                                         &lt;/complexType&gt;
     *                                       &lt;/element&gt;
     *                                       &lt;element name="CertificateDetails" minOccurs="0"&gt;
     *                                         &lt;complexType&gt;
     *                                           &lt;complexContent&gt;
     *                                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                                               &lt;sequence&gt;
     *                                                 &lt;element name="CertificateType" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="32"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="CertificateNumber"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                               &lt;/sequence&gt;
     *                                             &lt;/restriction&gt;
     *                                           &lt;/complexContent&gt;
     *                                         &lt;/complexType&gt;
     *                                       &lt;/element&gt;
     *                                     &lt;/sequence&gt;
     *                                   &lt;/restriction&gt;
     *                                 &lt;/complexContent&gt;
     *                               &lt;/complexType&gt;
     *                             &lt;/element&gt;
     *                           &lt;/sequence&gt;
     *                         &lt;/restriction&gt;
     *                       &lt;/complexContent&gt;
     *                     &lt;/complexType&gt;
     *                   &lt;/element&gt;
     *                   &lt;element name="ReceiverParty" minOccurs="0"&gt;
     *                     &lt;complexType&gt;
     *                       &lt;complexContent&gt;
     *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                           &lt;sequence&gt;
     *                             &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
     *                             &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
     *                             &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
     *                             &lt;element name="ReceiverKYC" minOccurs="0"&gt;
     *                               &lt;complexType&gt;
     *                                 &lt;complexContent&gt;
     *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                                     &lt;sequence&gt;
     *                                       &lt;element name="SimpleKYC" maxOccurs="unbounded" minOccurs="0"&gt;
     *                                         &lt;complexType&gt;
     *                                           &lt;complexContent&gt;
     *                                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                                               &lt;sequence&gt;
     *                                                 &lt;element name="KYCFieldName"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="256"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="KYCValue"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="512"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                               &lt;/sequence&gt;
     *                                             &lt;/restriction&gt;
     *                                           &lt;/complexContent&gt;
     *                                         &lt;/complexType&gt;
     *                                       &lt;/element&gt;
     *                                       &lt;element name="IDDetails" minOccurs="0"&gt;
     *                                         &lt;complexType&gt;
     *                                           &lt;complexContent&gt;
     *                                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                                               &lt;sequence&gt;
     *                                                 &lt;element name="IDType" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="32"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="IDNumber"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                               &lt;/sequence&gt;
     *                                             &lt;/restriction&gt;
     *                                           &lt;/complexContent&gt;
     *                                         &lt;/complexType&gt;
     *                                       &lt;/element&gt;
     *                                       &lt;element name="ContactDetails" minOccurs="0"&gt;
     *                                         &lt;complexType&gt;
     *                                           &lt;complexContent&gt;
     *                                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                                               &lt;sequence&gt;
     *                                                 &lt;element name="ContactType" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="32"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="FirstName" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="LastName" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="SurName" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="PhoneNumber" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="EMail" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="256"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="IDNumber" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                               &lt;/sequence&gt;
     *                                             &lt;/restriction&gt;
     *                                           &lt;/complexContent&gt;
     *                                         &lt;/complexType&gt;
     *                                       &lt;/element&gt;
     *                                       &lt;element name="CertificateDetails" minOccurs="0"&gt;
     *                                         &lt;complexType&gt;
     *                                           &lt;complexContent&gt;
     *                                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                                               &lt;sequence&gt;
     *                                                 &lt;element name="CertificateType" minOccurs="0"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="32"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                                 &lt;element name="CertificateNumber"&gt;
     *                                                   &lt;simpleType&gt;
     *                                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                                       &lt;maxLength value="64"/&gt;
     *                                                     &lt;/restriction&gt;
     *                                                   &lt;/simpleType&gt;
     *                                                 &lt;/element&gt;
     *                                               &lt;/sequence&gt;
     *                                             &lt;/restriction&gt;
     *                                           &lt;/complexContent&gt;
     *                                         &lt;/complexType&gt;
     *                                       &lt;/element&gt;
     *                                     &lt;/sequence&gt;
     *                                   &lt;/restriction&gt;
     *                                 &lt;/complexContent&gt;
     *                               &lt;/complexType&gt;
     *                             &lt;/element&gt;
     *                           &lt;/sequence&gt;
     *                         &lt;/restriction&gt;
     *                       &lt;/complexContent&gt;
     *                     &lt;/complexType&gt;
     *                   &lt;/element&gt;
     *                   &lt;element name="Requester" minOccurs="0"&gt;
     *                     &lt;complexType&gt;
     *                       &lt;complexContent&gt;
     *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                           &lt;sequence&gt;
     *                             &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
     *                             &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
     *                             &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
     *                           &lt;/sequence&gt;
     *                         &lt;/restriction&gt;
     *                       &lt;/complexContent&gt;
     *                     &lt;/complexType&gt;
     *                   &lt;/element&gt;
     *                 &lt;/sequence&gt;
     *               &lt;/restriction&gt;
     *             &lt;/complexContent&gt;
     *           &lt;/complexType&gt;
     *         &lt;/element&gt;
     *         &lt;element name="Verification" minOccurs="0"&gt;
     *           &lt;complexType&gt;
     *             &lt;complexContent&gt;
     *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                 &lt;sequence&gt;
     *                   &lt;element name="ApplicationCode"&gt;
     *                     &lt;simpleType&gt;
     *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                         &lt;maxLength value="20"/&gt;
     *                       &lt;/restriction&gt;
     *                     &lt;/simpleType&gt;
     *                   &lt;/element&gt;
     *                   &lt;element name="FunctionCode"&gt;
     *                     &lt;simpleType&gt;
     *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                         &lt;maxLength value="20"/&gt;
     *                       &lt;/restriction&gt;
     *                     &lt;/simpleType&gt;
     *                   &lt;/element&gt;
     *                   &lt;element name="VerificationCode"&gt;
     *                     &lt;simpleType&gt;
     *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                         &lt;maxLength value="20"/&gt;
     *                       &lt;/restriction&gt;
     *                     &lt;/simpleType&gt;
     *                   &lt;/element&gt;
     *                   &lt;element name="CustomerAccount" minOccurs="0"&gt;
     *                     &lt;simpleType&gt;
     *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                         &lt;maxLength value="1024"/&gt;
     *                       &lt;/restriction&gt;
     *                     &lt;/simpleType&gt;
     *                   &lt;/element&gt;
     *                   &lt;element name="Destination" minOccurs="0"&gt;
     *                     &lt;simpleType&gt;
     *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                         &lt;maxLength value="1024"/&gt;
     *                       &lt;/restriction&gt;
     *                     &lt;/simpleType&gt;
     *                   &lt;/element&gt;
     *                   &lt;element name="DestinationType" minOccurs="0"&gt;
     *                     &lt;simpleType&gt;
     *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                         &lt;maxLength value="1024"/&gt;
     *                       &lt;/restriction&gt;
     *                     &lt;/simpleType&gt;
     *                   &lt;/element&gt;
     *                   &lt;element name="TransactionID" minOccurs="0"&gt;
     *                     &lt;simpleType&gt;
     *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                         &lt;maxLength value="1024"/&gt;
     *                       &lt;/restriction&gt;
     *                     &lt;/simpleType&gt;
     *                   &lt;/element&gt;
     *                 &lt;/sequence&gt;
     *               &lt;/restriction&gt;
     *             &lt;/complexContent&gt;
     *           &lt;/complexType&gt;
     *         &lt;/element&gt;
     *         &lt;choice&gt;
     *           &lt;element name="EncryptedParameters" type="{http://www.w3.org/2001/XMLSchema}base64Binary"/&gt;
     *           &lt;choice&gt;
     *             &lt;element name="TransactionRequest"&gt;
     *               &lt;complexType&gt;
     *                 &lt;complexContent&gt;
     *                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                     &lt;sequence&gt;
     *                       &lt;element name="Parameters" minOccurs="0"&gt;
     *                         &lt;complexType&gt;
     *                           &lt;complexContent&gt;
     *                             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                               &lt;sequence&gt;
     *                                 &lt;element name="Parameter" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded" minOccurs="0"/&gt;
     *                                 &lt;element name="Amount" minOccurs="0"&gt;
     *                                   &lt;simpleType&gt;
     *                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                       &lt;maxLength value="18"/&gt;
     *                                     &lt;/restriction&gt;
     *                                   &lt;/simpleType&gt;
     *                                 &lt;/element&gt;
     *                                 &lt;element name="Currency" minOccurs="0"&gt;
     *                                   &lt;simpleType&gt;
     *                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                       &lt;length value="3"/&gt;
     *                                     &lt;/restriction&gt;
     *                                   &lt;/simpleType&gt;
     *                                 &lt;/element&gt;
     *                                 &lt;element name="ReasonType" minOccurs="0"&gt;
     *                                   &lt;simpleType&gt;
     *                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                       &lt;maxLength value="128"/&gt;
     *                                     &lt;/restriction&gt;
     *                                   &lt;/simpleType&gt;
     *                                 &lt;/element&gt;
     *                                 &lt;element name="VoucherType" minOccurs="0"&gt;
     *                                   &lt;simpleType&gt;
     *                                     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                                       &lt;maxLength value="128"/&gt;
     *                                     &lt;/restriction&gt;
     *                                   &lt;/simpleType&gt;
     *                                 &lt;/element&gt;
     *                               &lt;/sequence&gt;
     *                             &lt;/restriction&gt;
     *                           &lt;/complexContent&gt;
     *                         &lt;/complexType&gt;
     *                       &lt;/element&gt;
     *                     &lt;/sequence&gt;
     *                   &lt;/restriction&gt;
     *                 &lt;/complexContent&gt;
     *               &lt;/complexType&gt;
     *             &lt;/element&gt;
     *             &lt;element name="CreateTopOrgRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateTopOrgRequest"/&gt;
     *             &lt;element name="CreateChildOrgRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateChildOrgRequest"/&gt;
     *             &lt;element name="CreateTillRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateTillRequest"/&gt;
     *             &lt;element name="CreateOrgOperatorRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateOrgOperatorRequest"/&gt;
     *             &lt;element name="ChangeCustomerMSISDNRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeCustomerMSISDNRequest"/&gt;
     *             &lt;element name="ChangeTillMSISDNRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeTillMSISDNRequest"/&gt;
     *             &lt;element name="ChangeTillLanguageRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeTillLanguageRequest"/&gt;
     *             &lt;element name="ChangeAccountStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeAccountStatusRequest"/&gt;
     *             &lt;element name="UpdateCustomerKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateCustomerKYCRequest"/&gt;
     *             &lt;element name="UpdateOrganizationKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateOrganizationKYCRequest"/&gt;
     *             &lt;element name="QueryCustomerKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustomerKYCRequest"/&gt;
     *             &lt;element name="QueryCustomerInfoRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustomerInfoRequest"/&gt;
     *             &lt;element name="QueryCustomerProductsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustomerProductsRequest"/&gt;
     *             &lt;element name="QueryCustomerBalanceRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustomerBalanceRequest"/&gt;
     *             &lt;element name="QueryOrganizationKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrganizationKYCRequest"/&gt;
     *             &lt;element name="QueryOrganizationInfoRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrganizationInfoRequest"/&gt;
     *             &lt;element name="QueryOrganizationProductsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrganizationProductsRequest"/&gt;
     *             &lt;element name="QueryOrganizationBalanceRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrganizationBalanceRequest"/&gt;
     *             &lt;element name="ListOrganizationTillsRequest" type="{http://cps.huawei.com/cpsinterface/request}ListOrganizationTillsRequest"/&gt;
     *             &lt;element name="QueryOrgOperatorKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrgOperatorKYCRequest"/&gt;
     *             &lt;element name="QueryOrgOperatorInfoRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrgOperatorInfoRequest"/&gt;
     *             &lt;element name="QueryTillInfoRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryTillInfoRequest"/&gt;
     *             &lt;element name="QueryTillProductsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryTillProductsRequest"/&gt;
     *             &lt;element name="ChangeCustomerStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeCustomerStatusRequest"/&gt;
     *             &lt;element name="ChangeOrganizationStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeOrganizationStatusRequest"/&gt;
     *             &lt;element name="ChangeTillStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeTillStatusRequest"/&gt;
     *             &lt;element name="ChangeSPOperatorStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeSPOperatorStatusRequest"/&gt;
     *             &lt;element name="ChangeOrgOperatorStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeOrgOperatorStatusRequest"/&gt;
     *             &lt;element name="UpdateSPOperatorKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateSPOperatorKYCRequest"/&gt;
     *             &lt;element name="UpdateOrgOperatorKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateOrgOperatorKYCRequest"/&gt;
     *             &lt;element name="UpdateCustomerProductsRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateCustomerProductsRequest"/&gt;
     *             &lt;element name="UpdateOrganizationProductsRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateOrganizationProductsRequest"/&gt;
     *             &lt;element name="UpdateTillProductsRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateTillProductsRequest"/&gt;
     *             &lt;element name="RegisterCustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}RegisterCustomerRequest"/&gt;
     *             &lt;element name="RecycleMSISDNRequest" type="{http://cps.huawei.com/cpsinterface/request}RecycleMSISDNRequest"/&gt;
     *             &lt;element name="ListOrganizationChildStoresRequest" type="{http://cps.huawei.com/cpsinterface/request}ListOrganizationChildStoresRequest"/&gt;
     *             &lt;element name="ListOrganizationOperatorsRequest" type="{http://cps.huawei.com/cpsinterface/request}ListOrganizationOperatorsRequest"/&gt;
     *             &lt;element name="UpdateSPOperatorRoleRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateSPOperatorRoleRequest"/&gt;
     *             &lt;element name="UpdateOrgOperatorRoleRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateOrgOperatorRoleRequest"/&gt;
     *             &lt;element name="UpdateOrgTaxExemptionRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateOrgTaxExemptionRequest"/&gt;
     *             &lt;element name="QueryO2CLinkRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryO2CLinkRequest"/&gt;
     *             &lt;element name="AddO2CLinkRequest" type="{http://cps.huawei.com/cpsinterface/request}AddO2CLinkRequest"/&gt;
     *             &lt;element name="DeleteO2CLinkRequest" type="{http://cps.huawei.com/cpsinterface/request}DeleteO2CLinkRequest"/&gt;
     *             &lt;element name="VerifyCCCallerRequest" type="{http://cps.huawei.com/cpsinterface/request}VerifyCCCallerRequest"/&gt;
     *             &lt;element name="UnlockCustomerPINRequest" type="{http://cps.huawei.com/cpsinterface/request}UnlockCustomerPINRequest"/&gt;
     *             &lt;element name="UnlockOrgOperatorPINRequest" type="{http://cps.huawei.com/cpsinterface/request}UnlockOrgOperatorPINRequest"/&gt;
     *             &lt;element name="UnlockOrgOperatorPasswordRequest" type="{http://cps.huawei.com/cpsinterface/request}UnlockOrgOperatorPasswordRequest"/&gt;
     *             &lt;element name="ResetCustomerPINRequest" type="{http://cps.huawei.com/cpsinterface/request}ResetCustomerPINRequest"/&gt;
     *             &lt;element name="ResetOrgOperatorPINRequest" type="{http://cps.huawei.com/cpsinterface/request}ResetOrgOperatorPINRequest"/&gt;
     *             &lt;element name="ResetOrgOperatorPasswordRequest" type="{http://cps.huawei.com/cpsinterface/request}ResetOrgOperatorPasswordRequest"/&gt;
     *             &lt;element name="ResetCustomerSecretWordRequest" type="{http://cps.huawei.com/cpsinterface/request}ResetCustomerSecretWordRequest"/&gt;
     *             &lt;element name="ReleaseCustomerCCSuspendStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}ReleaseCustomerCCSuspendStatusRequest"/&gt;
     *             &lt;element name="ReleaseOrgOperatorCCSuspendStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}ReleaseOrgOperatorCCSuspendStatusRequest"/&gt;
     *             &lt;element name="SearchTransactionRequest" type="{http://cps.huawei.com/cpsinterface/request}SearchTransactionRequest"/&gt;
     *             &lt;element name="ReverseTransactionRequest" type="{http://cps.huawei.com/cpsinterface/request}ReverseTransactionRequest"/&gt;
     *             &lt;element name="ConfirmTransactionRequest" type="{http://cps.huawei.com/cpsinterface/request}ConfirmTransactionRequest"/&gt;
     *             &lt;element name="QueryCustomerAccountStatementsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustomerAccountStatementsRequest"/&gt;
     *             &lt;element name="QueryCustomerTransactionsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustomerTransactionsRequest"/&gt;
     *             &lt;element name="QueryOrganizationAccountStatementsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrganizationAccountStatementsRequest"/&gt;
     *             &lt;element name="QueryOrganizationTransactionsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrganizationTransactionsRequest"/&gt;
     *             &lt;element name="QueryResultMessageRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryResultMessageRequest"/&gt;
     *             &lt;element name="UpdateTransactionStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateTransactionStatusRequest"/&gt;
     *             &lt;element name="ChangeCustomerPINRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeCustomerPINRequest"/&gt;
     *             &lt;element name="ChangeOrgOperatorPINRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeOrgOperatorPINRequest"/&gt;
     *             &lt;element name="ChangeCustomerSecretWordRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeCustomerSecretWordRequest"/&gt;
     *             &lt;element name="ChangeOrgOperatorSecretWordRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeOrgOperatorSecretWordRequest"/&gt;
     *             &lt;element name="ChangeCustomerLanguageRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeCustomerLanguageRequest"/&gt;
     *             &lt;element name="ChangeOrgOperatorLanguageRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeOrgOperatorLanguageRequest"/&gt;
     *             &lt;element name="ChangeSPOperatorLanguageRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeSPOperatorLanguageRequest"/&gt;
     *             &lt;element name="ChangeOrgnNameRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeOrgnNameRequest"/&gt;
     *             &lt;element name="ActivateCustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}ActivateCustomerRequest"/&gt;
     *             &lt;element name="ActivateTillRequest" type="{http://cps.huawei.com/cpsinterface/request}ActivateTillRequest"/&gt;
     *             &lt;element name="AddCustomerBeneficiaryRequest" type="{http://cps.huawei.com/cpsinterface/request}AddCustomerBeneficiaryRequest"/&gt;
     *             &lt;element name="AddOrgBeneficiaryRequest" type="{http://cps.huawei.com/cpsinterface/request}AddOrgBeneficiaryRequest"/&gt;
     *             &lt;element name="DeleteCustomerBeneficiaryRequest" type="{http://cps.huawei.com/cpsinterface/request}DeleteCustomerBeneficiaryRequest"/&gt;
     *             &lt;element name="DeleteOrgBeneficiaryRequest" type="{http://cps.huawei.com/cpsinterface/request}DeleteOrgBeneficiaryRequest"/&gt;
     *             &lt;element name="LookupCustomerBeneficiaryRequest" type="{http://cps.huawei.com/cpsinterface/request}LookupCustomerBeneficiaryRequest"/&gt;
     *             &lt;element name="LookupOrgBeneficiaryRequest" type="{http://cps.huawei.com/cpsinterface/request}LookupOrgBeneficiaryRequest"/&gt;
     *             &lt;element name="AddGroupBeneficiaryRequest" type="{http://cps.huawei.com/cpsinterface/request}AddGroupBeneficiaryRequest"/&gt;
     *             &lt;element name="DeleteGroupBeneficiaryRequest" type="{http://cps.huawei.com/cpsinterface/request}DeleteGroupBeneficiaryRequest"/&gt;
     *             &lt;element name="LookupGroupBeneficiaryRequest" type="{http://cps.huawei.com/cpsinterface/request}LookupGroupBeneficiaryRequest"/&gt;
     *             &lt;element name="RecipientLookUpRequest" type="{http://cps.huawei.com/cpsinterface/request}RecipientLookUpRequest"/&gt;
     *             &lt;element name="BulkTaskRequest" type="{http://cps.huawei.com/cpsinterface/request}BulkTaskRequest"/&gt;
     *             &lt;element name="SMSVCSendRequest" type="{http://cps.huawei.com/cpsinterface/request}SMSVCSendRequest"/&gt;
     *             &lt;element name="ChangeTillDefaultOperatorIDRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeTillDefaultOperatorIDRequest"/&gt;
     *             &lt;element name="CustomerGetStartPINRequest" type="{http://cps.huawei.com/cpsinterface/request}CustomerGetStartPINRequest"/&gt;
     *             &lt;element name="QueryGroupBalanceRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryGroupBalanceRequest"/&gt;
     *             &lt;element name="QueryGroupAccountStatementsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryGroupAccountStatementsRequest"/&gt;
     *             &lt;element name="QueryGroupTransactionsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryGroupTransactionsRequest"/&gt;
     *             &lt;element name="QueryCustomerPointsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustomerPointsRequest"/&gt;
     *             &lt;element name="QueryCustomerPointsLogRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustomerPointsLogRequest"/&gt;
     *             &lt;element name="AdjustCustomerPointsRequest" type="{http://cps.huawei.com/cpsinterface/request}AdjustCustomerPointsRequest"/&gt;
     *             &lt;element name="QueryOrganizationPointsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrganizationPointsRequest"/&gt;
     *             &lt;element name="QueryOrganizationPointsLogRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrganizationPointsLogRequest"/&gt;
     *             &lt;element name="AdjustOrganizationPointsRequest" type="{http://cps.huawei.com/cpsinterface/request}AdjustOrganizationPointsRequest"/&gt;
     *             &lt;element name="CreateGroupRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateGroupRequest"/&gt;
     *             &lt;element name="CreateGroupByCustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateGroupByCustomerRequest"/&gt;
     *             &lt;element name="UpdateGroupKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateGroupKYCRequest"/&gt;
     *             &lt;element name="ChangeGroupStatusRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeGroupStatusRequest"/&gt;
     *             &lt;element name="AddGroupMemberRequest" type="{http://cps.huawei.com/cpsinterface/request}AddGroupMemberRequest"/&gt;
     *             &lt;element name="AddGroupMemberByGroupLeaderRequest" type="{http://cps.huawei.com/cpsinterface/request}AddGroupMemberByGroupLeaderRequest"/&gt;
     *             &lt;element name="RemoveGroupMemberRequest" type="{http://cps.huawei.com/cpsinterface/request}RemoveGroupMemberRequest"/&gt;
     *             &lt;element name="RemoveGroupMemberByGroupLeaderRequest" type="{http://cps.huawei.com/cpsinterface/request}RemoveGroupMemberByGroupLeaderRequest"/&gt;
     *             &lt;element name="ChangeGroupMemberRolesRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeGroupMemberRolesRequest"/&gt;
     *             &lt;element name="ChangeGroupMemberRolesByGroupLeaderRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeGroupMemberRolesByGroupLeaderRequest"/&gt;
     *             &lt;element name="ConfirmGroupMembershipRequest" type="{http://cps.huawei.com/cpsinterface/request}ConfirmGroupMembershipRequest"/&gt;
     *             &lt;element name="ApproveGroupActionOrTransactionRequest" type="{http://cps.huawei.com/cpsinterface/request}ApproveGroupActionOrTransactionRequest"/&gt;
     *             &lt;element name="SearchMyGroupsRequest" type="{http://cps.huawei.com/cpsinterface/request}SearchMyGroupsRequest"/&gt;
     *             &lt;element name="QueryGroupInfoRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryGroupInfoRequest"/&gt;
     *             &lt;element name="QueryGroupKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryGroupKYCRequest"/&gt;
     *             &lt;element name="QueryGroupProductsRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryGroupProductsRequest"/&gt;
     *             &lt;element name="ListGroupMembersRequest" type="{http://cps.huawei.com/cpsinterface/request}ListGroupMembersRequest"/&gt;
     *             &lt;element name="ListGroupMembersByCustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}ListGroupMembersByCustomerRequest"/&gt;
     *             &lt;element name="ChangeGroupRuleProfileRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeGroupRuleProfileRequest"/&gt;
     *             &lt;element name="ChangeGroupChargeProfileRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeGroupChargeProfileRequest"/&gt;
     *             &lt;element name="ChangeGroupAccountRuleProfileRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeGroupAccountRuleProfileRequest"/&gt;
     *             &lt;element name="IdentifyCustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}IdentifyCustomerRequest"/&gt;
     *             &lt;element name="RaiseDisputedTxnReversalRequest" type="{http://cps.huawei.com/cpsinterface/request}RaiseDisputedTxnReversalRequest"/&gt;
     *             &lt;element name="CancelIssuedVoucherRequest" type="{http://cps.huawei.com/cpsinterface/request}CancelIssuedVoucherRequest"/&gt;
     *             &lt;element name="CreateCustomerBundleRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateCustomerBundleRequest"/&gt;
     *             &lt;element name="CreateOrganizationBundleRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateOrganizationBundleRequest"/&gt;
     *             &lt;element name="CreateExternalProviderBundleRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateExternalProviderBundleRequest"/&gt;
     *             &lt;element name="CreateGroupBundleRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateGroupBundleRequest"/&gt;
     *             &lt;element name="CreateBankAccountRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateBankAccountRequest"/&gt;
     *             &lt;element name="QueryIdentityBundleRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryIdentityBundleRequest"/&gt;
     *             &lt;element name="DeleteBankAccountRequest" type="{http://cps.huawei.com/cpsinterface/request}DeleteBankAccountRequest"/&gt;
     *             &lt;element name="SetDefaultBankAccountRequest" type="{http://cps.huawei.com/cpsinterface/request}SetDefaultBankAccountRequest"/&gt;
     *             &lt;element name="CreateDirectDebitMandateByPayeeRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateDirectDebitMandateByPayeeRequest"/&gt;
     *             &lt;element name="CreateDirectDebitMandateByPayerRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateDirectDebitMandateByPayerRequest"/&gt;
     *             &lt;element name="ActivateDirectDebitMandateRequest" type="{http://cps.huawei.com/cpsinterface/request}ActivateDirectDebitMandateRequest"/&gt;
     *             &lt;element name="CancelDirectDebitMandateByPayerRequest" type="{http://cps.huawei.com/cpsinterface/request}CancelDirectDebitMandateByPayerRequest"/&gt;
     *             &lt;element name="CancelDirectDebitMandateByPayeeRequest" type="{http://cps.huawei.com/cpsinterface/request}CancelDirectDebitMandateByPayeeRequest"/&gt;
     *             &lt;element name="ReactivateDirectDebitMandateByPayerRequest" type="{http://cps.huawei.com/cpsinterface/request}ReactivateDirectDebitMandateByPayerRequest"/&gt;
     *             &lt;element name="ReactivateDirectDebitMandateByPayeeRequest" type="{http://cps.huawei.com/cpsinterface/request}ReactivateDirectDebitMandateByPayeeRequest"/&gt;
     *             &lt;element name="EditDirectDebitMandateByPayerRequest" type="{http://cps.huawei.com/cpsinterface/request}EditDirectDebitMandateByPayerRequest"/&gt;
     *             &lt;element name="EditDirectDebitMandateByPayeeRequest" type="{http://cps.huawei.com/cpsinterface/request}EditDirectDebitMandateByPayeeRequest"/&gt;
     *             &lt;element name="QueryDirectDebitMandateByPayerRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryDirectDebitMandateByPayerRequest"/&gt;
     *             &lt;element name="ViewDirectDebitMandateByPayerRequest" type="{http://cps.huawei.com/cpsinterface/request}ViewDirectDebitMandateByPayerRequest"/&gt;
     *             &lt;element name="ViewDirectDebitMandateByPayeeRequest" type="{http://cps.huawei.com/cpsinterface/request}ViewDirectDebitMandateByPayeeRequest"/&gt;
     *             &lt;element name="DeleteIndividualReminderScheduleRequest" type="{http://cps.huawei.com/cpsinterface/request}DeleteIndividualReminderScheduleRequest"/&gt;
     *             &lt;element name="CreateReminderScheduleRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateReminderScheduleRequest"/&gt;
     *             &lt;element name="QueryReminderScheduleRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryReminderScheduleRequest"/&gt;
     *             &lt;element name="LinkingIdentitiesRequest" type="{http://cps.huawei.com/cpsinterface/request}LinkingIdentitiesRequest"/&gt;
     *             &lt;element name="UnlinkIdentitiesRequest" type="{http://cps.huawei.com/cpsinterface/request}UnlinkIdentitiesRequest"/&gt;
     *             &lt;element name="CCHChangeCustKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}CCHChangeCustKYCRequest"/&gt;
     *             &lt;element name="CCHChangeOrgOperatorKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}CCHChangeOrgOperatorKYCRequest"/&gt;
     *             &lt;element name="PreValidationRequest" type="{http://cps.huawei.com/cpsinterface/request}PreValidationRequest"/&gt;
     *             &lt;element name="PreValidationConfirmationRequest" type="{http://cps.huawei.com/cpsinterface/request}PreValidationConfirmationRequest"/&gt;
     *             &lt;element name="CreateOrgLoyaltyAccountRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateOrgLoyaltyAccountRequest"/&gt;
     *             &lt;element name="CreateCustLoyaltyAccountRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateCustLoyaltyAccountRequest"/&gt;
     *             &lt;element name="CreateGroupLoyaltyAccountRequest" type="{http://cps.huawei.com/cpsinterface/request}CreateGroupLoyaltyAccountRequest"/&gt;
     *             &lt;element name="CustomerRegisterCardRequest" type="{http://cps.huawei.com/cpsinterface/request}CustomerRegisterCardRequest"/&gt;
     *             &lt;element name="OrgRegisterCardRequest" type="{http://cps.huawei.com/cpsinterface/request}OrgRegisterCardRequest"/&gt;
     *             &lt;element name="GroupRegisterCardRequest" type="{http://cps.huawei.com/cpsinterface/request}GroupRegisterCardRequest"/&gt;
     *             &lt;element name="RegisterCard4CustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}RegisterCard4CustomerRequest"/&gt;
     *             &lt;element name="RegisterCard4OrgRequest" type="{http://cps.huawei.com/cpsinterface/request}RegisterCard4OrgRequest"/&gt;
     *             &lt;element name="RegisterCard4GroupRequest" type="{http://cps.huawei.com/cpsinterface/request}RegisterCard4GroupRequest"/&gt;
     *             &lt;element name="CustomerActivateCardRequest" type="{http://cps.huawei.com/cpsinterface/request}CustomerActivateCardRequest"/&gt;
     *             &lt;element name="OrgActivateCardRequest" type="{http://cps.huawei.com/cpsinterface/request}OrgActivateCardRequest"/&gt;
     *             &lt;element name="GroupActivateCardRequest" type="{http://cps.huawei.com/cpsinterface/request}GroupActivateCardRequest"/&gt;
     *             &lt;element name="CustomerCancelCardRequest" type="{http://cps.huawei.com/cpsinterface/request}CustomerCancelCardRequest"/&gt;
     *             &lt;element name="OrgCancelCardRequest" type="{http://cps.huawei.com/cpsinterface/request}OrgCancelCardRequest"/&gt;
     *             &lt;element name="GroupCancelCardRequest" type="{http://cps.huawei.com/cpsinterface/request}GroupCancelCardRequest"/&gt;
     *             &lt;element name="QueryCustLoyaltyPointRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustLoyaltyPointRequest"/&gt;
     *             &lt;element name="QueryOrgLoyaltyPointRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrgLoyaltyPointRequest"/&gt;
     *             &lt;element name="QueryGroupLoyaltyPointRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryGroupLoyaltyPointRequest"/&gt;
     *             &lt;element name="QueryLoyaltyConsumerRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryLoyaltyConsumerRequest"/&gt;
     *             &lt;element name="QueryCustLoyaltyPointStatementRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryCustLoyaltyPointStatementRequest"/&gt;
     *             &lt;element name="QueryOrgLoyaltyPointStatementRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryOrgLoyaltyPointStatementRequest"/&gt;
     *             &lt;element name="QueryGroupLoyaltyPointStatementRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryGroupLoyaltyPointStatementRequest"/&gt;
     *             &lt;element name="QueryLoyaltyConsumerStatementRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryLoyaltyConsumerStatementRequest"/&gt;
     *             &lt;element name="CCHIdentifyCustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}CCHIdentifyCustomerRequest"/&gt;
     *             &lt;element name="CCHIdentifyOperatorRequest" type="{http://cps.huawei.com/cpsinterface/request}CCHIdentifyOperatorRequest"/&gt;
     *             &lt;element name="UpdateOrgOperatorOwnKYCRequest" type="{http://cps.huawei.com/cpsinterface/request}UpdateOrgOperatorOwnKYCRequest"/&gt;
     *             &lt;element name="QuerySavingPlanForCustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}QuerySavingPlanForCustomerRequest"/&gt;
     *             &lt;element name="QuerySavingPlanForGroupRequest" type="{http://cps.huawei.com/cpsinterface/request}QuerySavingPlanForGroupRequest"/&gt;
     *             &lt;element name="QuerySavingPlanForOrganizationRequest" type="{http://cps.huawei.com/cpsinterface/request}QuerySavingPlanForOrganizationRequest"/&gt;
     *             &lt;element name="QueryTransferPointsFeeRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryTransferPointsFeeRequest"/&gt;
     *             &lt;element name="QueryRedeemBalanceRateRequest" type="{http://cps.huawei.com/cpsinterface/request}QueryRedeemBalanceRateRequest"/&gt;
     *             &lt;element name="TransferPointsRequest" type="{http://cps.huawei.com/cpsinterface/request}TransferPointsRequest"/&gt;
     *             &lt;element name="RedeemPointsToGoodsRequest" type="{http://cps.huawei.com/cpsinterface/request}RedeemPointsToGoodsRequest"/&gt;
     *             &lt;element name="RedeemPointsWithVoucherRequest" type="{http://cps.huawei.com/cpsinterface/request}RedeemPointsWithVoucherRequest"/&gt;
     *             &lt;element name="RedeemPointsToBalanceRequest" type="{http://cps.huawei.com/cpsinterface/request}RedeemPointsToBalanceRequest"/&gt;
     *             &lt;element name="SubscribeSavingPlanForCustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}SubscribeSavingPlanForCustomerRequest"/&gt;
     *             &lt;element name="SubscribeSavingPlanForGroupRequest" type="{http://cps.huawei.com/cpsinterface/request}SubscribeSavingPlanForGroupRequest"/&gt;
     *             &lt;element name="SubscribeSavingPlanForOrgRequest" type="{http://cps.huawei.com/cpsinterface/request}SubscribeSavingPlanForOrgRequest"/&gt;
     *             &lt;element name="UnSubscribeSavingPlanForCustomerRequest" type="{http://cps.huawei.com/cpsinterface/request}UnSubscribeSavingPlanForCustomerRequest"/&gt;
     *             &lt;element name="UnSubscribeSavingPlanForGroupRequest" type="{http://cps.huawei.com/cpsinterface/request}UnSubscribeSavingPlanForGroupRequest"/&gt;
     *             &lt;element name="UnSubscribeSavingPlanForOrgRequest" type="{http://cps.huawei.com/cpsinterface/request}UnSubscribeSavingPlanForOrgRequest"/&gt;
     *             &lt;element name="ValidateTokenRequest" type="{http://cps.huawei.com/cpsinterface/request}ValidateTokenRequest"/&gt;
     *             &lt;element name="ChangeOrgOperatorMSISDNRequest" type="{http://cps.huawei.com/cpsinterface/request}ChangeOrgOperatorMSISDNRequest"/&gt;
     *           &lt;/choice&gt;
     *         &lt;/choice&gt;
     *         &lt;element name="ReferenceData" minOccurs="0"&gt;
     *           &lt;complexType&gt;
     *             &lt;complexContent&gt;
     *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                 &lt;sequence&gt;
     *                   &lt;element name="ReferenceItem" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
     *                 &lt;/sequence&gt;
     *               &lt;/restriction&gt;
     *             &lt;/complexContent&gt;
     *           &lt;/complexType&gt;
     *         &lt;/element&gt;
     *         &lt;element name="Remark" minOccurs="0"&gt;
     *           &lt;simpleType&gt;
     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *               &lt;maxLength value="255"/&gt;
     *             &lt;/restriction&gt;
     *           &lt;/simpleType&gt;
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
    @XmlType(name = "", propOrder = {
        "identity",
        "verification",
        "encryptedParameters",
        "transactionRequest",
        "createTopOrgRequest",
        "createChildOrgRequest",
        "createTillRequest",
        "createOrgOperatorRequest",
        "changeCustomerMSISDNRequest",
        "changeTillMSISDNRequest",
        "changeTillLanguageRequest",
        "changeAccountStatusRequest",
        "updateCustomerKYCRequest",
        "updateOrganizationKYCRequest",
        "queryCustomerKYCRequest",
        "queryCustomerInfoRequest",
        "queryCustomerProductsRequest",
        "queryCustomerBalanceRequest",
        "queryOrganizationKYCRequest",
        "queryOrganizationInfoRequest",
        "queryOrganizationProductsRequest",
        "queryOrganizationBalanceRequest",
        "listOrganizationTillsRequest",
        "queryOrgOperatorKYCRequest",
        "queryOrgOperatorInfoRequest",
        "queryTillInfoRequest",
        "queryTillProductsRequest",
        "changeCustomerStatusRequest",
        "changeOrganizationStatusRequest",
        "changeTillStatusRequest",
        "changeSPOperatorStatusRequest",
        "changeOrgOperatorStatusRequest",
        "updateSPOperatorKYCRequest",
        "updateOrgOperatorKYCRequest",
        "updateCustomerProductsRequest",
        "updateOrganizationProductsRequest",
        "updateTillProductsRequest",
        "registerCustomerRequest",
        "recycleMSISDNRequest",
        "listOrganizationChildStoresRequest",
        "listOrganizationOperatorsRequest",
        "updateSPOperatorRoleRequest",
        "updateOrgOperatorRoleRequest",
        "updateOrgTaxExemptionRequest",
        "queryO2CLinkRequest",
        "addO2CLinkRequest",
        "deleteO2CLinkRequest",
        "verifyCCCallerRequest",
        "unlockCustomerPINRequest",
        "unlockOrgOperatorPINRequest",
        "unlockOrgOperatorPasswordRequest",
        "resetCustomerPINRequest",
        "resetOrgOperatorPINRequest",
        "resetOrgOperatorPasswordRequest",
        "resetCustomerSecretWordRequest",
        "releaseCustomerCCSuspendStatusRequest",
        "releaseOrgOperatorCCSuspendStatusRequest",
        "searchTransactionRequest",
        "reverseTransactionRequest",
        "confirmTransactionRequest",
        "queryCustomerAccountStatementsRequest",
        "queryCustomerTransactionsRequest",
        "queryOrganizationAccountStatementsRequest",
        "queryOrganizationTransactionsRequest",
        "queryResultMessageRequest",
        "updateTransactionStatusRequest",
        "changeCustomerPINRequest",
        "changeOrgOperatorPINRequest",
        "changeCustomerSecretWordRequest",
        "changeOrgOperatorSecretWordRequest",
        "changeCustomerLanguageRequest",
        "changeOrgOperatorLanguageRequest",
        "changeSPOperatorLanguageRequest",
        "changeOrgnNameRequest",
        "activateCustomerRequest",
        "activateTillRequest",
        "addCustomerBeneficiaryRequest",
        "addOrgBeneficiaryRequest",
        "deleteCustomerBeneficiaryRequest",
        "deleteOrgBeneficiaryRequest",
        "lookupCustomerBeneficiaryRequest",
        "lookupOrgBeneficiaryRequest",
        "addGroupBeneficiaryRequest",
        "deleteGroupBeneficiaryRequest",
        "lookupGroupBeneficiaryRequest",
        "recipientLookUpRequest",
        "bulkTaskRequest",
        "smsvcSendRequest",
        "changeTillDefaultOperatorIDRequest",
        "customerGetStartPINRequest",
        "queryGroupBalanceRequest",
        "queryGroupAccountStatementsRequest",
        "queryGroupTransactionsRequest",
        "queryCustomerPointsRequest",
        "queryCustomerPointsLogRequest",
        "adjustCustomerPointsRequest",
        "queryOrganizationPointsRequest",
        "queryOrganizationPointsLogRequest",
        "adjustOrganizationPointsRequest",
        "createGroupRequest",
        "createGroupByCustomerRequest",
        "updateGroupKYCRequest",
        "changeGroupStatusRequest",
        "addGroupMemberRequest",
        "addGroupMemberByGroupLeaderRequest",
        "removeGroupMemberRequest",
        "removeGroupMemberByGroupLeaderRequest",
        "changeGroupMemberRolesRequest",
        "changeGroupMemberRolesByGroupLeaderRequest",
        "confirmGroupMembershipRequest",
        "approveGroupActionOrTransactionRequest",
        "searchMyGroupsRequest",
        "queryGroupInfoRequest",
        "queryGroupKYCRequest",
        "queryGroupProductsRequest",
        "listGroupMembersRequest",
        "listGroupMembersByCustomerRequest",
        "changeGroupRuleProfileRequest",
        "changeGroupChargeProfileRequest",
        "changeGroupAccountRuleProfileRequest",
        "identifyCustomerRequest",
        "raiseDisputedTxnReversalRequest",
        "cancelIssuedVoucherRequest",
        "createCustomerBundleRequest",
        "createOrganizationBundleRequest",
        "createExternalProviderBundleRequest",
        "createGroupBundleRequest",
        "createBankAccountRequest",
        "queryIdentityBundleRequest",
        "deleteBankAccountRequest",
        "setDefaultBankAccountRequest",
        "createDirectDebitMandateByPayeeRequest",
        "createDirectDebitMandateByPayerRequest",
        "activateDirectDebitMandateRequest",
        "cancelDirectDebitMandateByPayerRequest",
        "cancelDirectDebitMandateByPayeeRequest",
        "reactivateDirectDebitMandateByPayerRequest",
        "reactivateDirectDebitMandateByPayeeRequest",
        "editDirectDebitMandateByPayerRequest",
        "editDirectDebitMandateByPayeeRequest",
        "queryDirectDebitMandateByPayerRequest",
        "viewDirectDebitMandateByPayerRequest",
        "viewDirectDebitMandateByPayeeRequest",
        "deleteIndividualReminderScheduleRequest",
        "createReminderScheduleRequest",
        "queryReminderScheduleRequest",
        "linkingIdentitiesRequest",
        "unlinkIdentitiesRequest",
        "cchChangeCustKYCRequest",
        "cchChangeOrgOperatorKYCRequest",
        "preValidationRequest",
        "preValidationConfirmationRequest",
        "createOrgLoyaltyAccountRequest",
        "createCustLoyaltyAccountRequest",
        "createGroupLoyaltyAccountRequest",
        "customerRegisterCardRequest",
        "orgRegisterCardRequest",
        "groupRegisterCardRequest",
        "registerCard4CustomerRequest",
        "registerCard4OrgRequest",
        "registerCard4GroupRequest",
        "customerActivateCardRequest",
        "orgActivateCardRequest",
        "groupActivateCardRequest",
        "customerCancelCardRequest",
        "orgCancelCardRequest",
        "groupCancelCardRequest",
        "queryCustLoyaltyPointRequest",
        "queryOrgLoyaltyPointRequest",
        "queryGroupLoyaltyPointRequest",
        "queryLoyaltyConsumerRequest",
        "queryCustLoyaltyPointStatementRequest",
        "queryOrgLoyaltyPointStatementRequest",
        "queryGroupLoyaltyPointStatementRequest",
        "queryLoyaltyConsumerStatementRequest",
        "cchIdentifyCustomerRequest",
        "cchIdentifyOperatorRequest",
        "updateOrgOperatorOwnKYCRequest",
        "querySavingPlanForCustomerRequest",
        "querySavingPlanForGroupRequest",
        "querySavingPlanForOrganizationRequest",
        "queryTransferPointsFeeRequest",
        "queryRedeemBalanceRateRequest",
        "transferPointsRequest",
        "redeemPointsToGoodsRequest",
        "redeemPointsWithVoucherRequest",
        "redeemPointsToBalanceRequest",
        "subscribeSavingPlanForCustomerRequest",
        "subscribeSavingPlanForGroupRequest",
        "subscribeSavingPlanForOrgRequest",
        "unSubscribeSavingPlanForCustomerRequest",
        "unSubscribeSavingPlanForGroupRequest",
        "unSubscribeSavingPlanForOrgRequest",
        "validateTokenRequest",
        "changeOrgOperatorMSISDNRequest",
        "referenceData",
        "remark"
    })
    public static class Body {

        @XmlElement(name = "Identity", required = true)
        protected Request.Body.Identity identity;
        @XmlElement(name = "Verification")
        protected Request.Body.Verification verification;
        @XmlElement(name = "EncryptedParameters")
        protected byte[] encryptedParameters;
        @XmlElement(name = "TransactionRequest")
        protected Request.Body.TransactionRequest transactionRequest;
        @XmlElement(name = "CreateTopOrgRequest")
        protected CreateTopOrgRequest createTopOrgRequest;
        @XmlElement(name = "CreateChildOrgRequest")
        protected CreateChildOrgRequest createChildOrgRequest;
        @XmlElement(name = "CreateTillRequest")
        protected CreateTillRequest createTillRequest;
        @XmlElement(name = "CreateOrgOperatorRequest")
        protected CreateOrgOperatorRequest createOrgOperatorRequest;
        @XmlElement(name = "ChangeCustomerMSISDNRequest")
        protected ChangeCustomerMSISDNRequest changeCustomerMSISDNRequest;
        @XmlElement(name = "ChangeTillMSISDNRequest")
        protected ChangeTillMSISDNRequest changeTillMSISDNRequest;
        @XmlElement(name = "ChangeTillLanguageRequest")
        protected ChangeTillLanguageRequest changeTillLanguageRequest;
        @XmlElement(name = "ChangeAccountStatusRequest")
        protected ChangeAccountStatusRequest changeAccountStatusRequest;
        @XmlElement(name = "UpdateCustomerKYCRequest")
        protected UpdateCustomerKYCRequest updateCustomerKYCRequest;
        @XmlElement(name = "UpdateOrganizationKYCRequest")
        protected UpdateOrganizationKYCRequest updateOrganizationKYCRequest;
        @XmlElement(name = "QueryCustomerKYCRequest")
        protected QueryCustomerKYCRequest queryCustomerKYCRequest;
        @XmlElement(name = "QueryCustomerInfoRequest")
        protected QueryCustomerInfoRequest queryCustomerInfoRequest;
        @XmlElement(name = "QueryCustomerProductsRequest")
        protected QueryCustomerProductsRequest queryCustomerProductsRequest;
        @XmlElement(name = "QueryCustomerBalanceRequest")
        protected QueryCustomerBalanceRequest queryCustomerBalanceRequest;
        @XmlElement(name = "QueryOrganizationKYCRequest")
        protected QueryOrganizationKYCRequest queryOrganizationKYCRequest;
        @XmlElement(name = "QueryOrganizationInfoRequest")
        protected QueryOrganizationInfoRequest queryOrganizationInfoRequest;
        @XmlElement(name = "QueryOrganizationProductsRequest")
        protected QueryOrganizationProductsRequest queryOrganizationProductsRequest;
        @XmlElement(name = "QueryOrganizationBalanceRequest")
        protected QueryOrganizationBalanceRequest queryOrganizationBalanceRequest;
        @XmlElement(name = "ListOrganizationTillsRequest")
        protected ListOrganizationTillsRequest listOrganizationTillsRequest;
        @XmlElement(name = "QueryOrgOperatorKYCRequest")
        protected QueryOrgOperatorKYCRequest queryOrgOperatorKYCRequest;
        @XmlElement(name = "QueryOrgOperatorInfoRequest")
        protected QueryOrgOperatorInfoRequest queryOrgOperatorInfoRequest;
        @XmlElement(name = "QueryTillInfoRequest")
        protected QueryTillInfoRequest queryTillInfoRequest;
        @XmlElement(name = "QueryTillProductsRequest")
        protected QueryTillProductsRequest queryTillProductsRequest;
        @XmlElement(name = "ChangeCustomerStatusRequest")
        protected ChangeCustomerStatusRequest changeCustomerStatusRequest;
        @XmlElement(name = "ChangeOrganizationStatusRequest")
        protected ChangeOrganizationStatusRequest changeOrganizationStatusRequest;
        @XmlElement(name = "ChangeTillStatusRequest")
        protected ChangeTillStatusRequest changeTillStatusRequest;
        @XmlElement(name = "ChangeSPOperatorStatusRequest")
        protected ChangeSPOperatorStatusRequest changeSPOperatorStatusRequest;
        @XmlElement(name = "ChangeOrgOperatorStatusRequest")
        protected ChangeOrgOperatorStatusRequest changeOrgOperatorStatusRequest;
        @XmlElement(name = "UpdateSPOperatorKYCRequest")
        protected UpdateSPOperatorKYCRequest updateSPOperatorKYCRequest;
        @XmlElement(name = "UpdateOrgOperatorKYCRequest")
        protected UpdateOrgOperatorKYCRequest updateOrgOperatorKYCRequest;
        @XmlElement(name = "UpdateCustomerProductsRequest")
        protected UpdateCustomerProductsRequest updateCustomerProductsRequest;
        @XmlElement(name = "UpdateOrganizationProductsRequest")
        protected UpdateOrganizationProductsRequest updateOrganizationProductsRequest;
        @XmlElement(name = "UpdateTillProductsRequest")
        protected UpdateTillProductsRequest updateTillProductsRequest;
        @XmlElement(name = "RegisterCustomerRequest")
        protected RegisterCustomerRequest registerCustomerRequest;
        @XmlElement(name = "RecycleMSISDNRequest")
        protected RecycleMSISDNRequest recycleMSISDNRequest;
        @XmlElement(name = "ListOrganizationChildStoresRequest")
        protected ListOrganizationChildStoresRequest listOrganizationChildStoresRequest;
        @XmlElement(name = "ListOrganizationOperatorsRequest")
        protected ListOrganizationOperatorsRequest listOrganizationOperatorsRequest;
        @XmlElement(name = "UpdateSPOperatorRoleRequest")
        protected UpdateSPOperatorRoleRequest updateSPOperatorRoleRequest;
        @XmlElement(name = "UpdateOrgOperatorRoleRequest")
        protected UpdateOrgOperatorRoleRequest updateOrgOperatorRoleRequest;
        @XmlElement(name = "UpdateOrgTaxExemptionRequest")
        protected UpdateOrgTaxExemptionRequest updateOrgTaxExemptionRequest;
        @XmlElement(name = "QueryO2CLinkRequest")
        protected QueryO2CLinkRequest queryO2CLinkRequest;
        @XmlElement(name = "AddO2CLinkRequest")
        protected AddO2CLinkRequest addO2CLinkRequest;
        @XmlElement(name = "DeleteO2CLinkRequest")
        protected DeleteO2CLinkRequest deleteO2CLinkRequest;
        @XmlElement(name = "VerifyCCCallerRequest")
        protected VerifyCCCallerRequest verifyCCCallerRequest;
        @XmlElement(name = "UnlockCustomerPINRequest")
        protected UnlockCustomerPINRequest unlockCustomerPINRequest;
        @XmlElement(name = "UnlockOrgOperatorPINRequest")
        protected UnlockOrgOperatorPINRequest unlockOrgOperatorPINRequest;
        @XmlElement(name = "UnlockOrgOperatorPasswordRequest")
        protected UnlockOrgOperatorPasswordRequest unlockOrgOperatorPasswordRequest;
        @XmlElement(name = "ResetCustomerPINRequest")
        protected ResetCustomerPINRequest resetCustomerPINRequest;
        @XmlElement(name = "ResetOrgOperatorPINRequest")
        protected ResetOrgOperatorPINRequest resetOrgOperatorPINRequest;
        @XmlElement(name = "ResetOrgOperatorPasswordRequest")
        protected ResetOrgOperatorPasswordRequest resetOrgOperatorPasswordRequest;
        @XmlElement(name = "ResetCustomerSecretWordRequest")
        protected ResetCustomerSecretWordRequest resetCustomerSecretWordRequest;
        @XmlElement(name = "ReleaseCustomerCCSuspendStatusRequest")
        protected ReleaseCustomerCCSuspendStatusRequest releaseCustomerCCSuspendStatusRequest;
        @XmlElement(name = "ReleaseOrgOperatorCCSuspendStatusRequest")
        protected ReleaseOrgOperatorCCSuspendStatusRequest releaseOrgOperatorCCSuspendStatusRequest;
        @XmlElement(name = "SearchTransactionRequest")
        protected SearchTransactionRequest searchTransactionRequest;
        @XmlElement(name = "ReverseTransactionRequest")
        protected ReverseTransactionRequest reverseTransactionRequest;
        @XmlElement(name = "ConfirmTransactionRequest")
        protected ConfirmTransactionRequest confirmTransactionRequest;
        @XmlElement(name = "QueryCustomerAccountStatementsRequest")
        protected QueryCustomerAccountStatementsRequest queryCustomerAccountStatementsRequest;
        @XmlElement(name = "QueryCustomerTransactionsRequest")
        protected QueryCustomerTransactionsRequest queryCustomerTransactionsRequest;
        @XmlElement(name = "QueryOrganizationAccountStatementsRequest")
        protected QueryOrganizationAccountStatementsRequest queryOrganizationAccountStatementsRequest;
        @XmlElement(name = "QueryOrganizationTransactionsRequest")
        protected QueryOrganizationTransactionsRequest queryOrganizationTransactionsRequest;
        @XmlElement(name = "QueryResultMessageRequest")
        protected QueryResultMessageRequest queryResultMessageRequest;
        @XmlElement(name = "UpdateTransactionStatusRequest")
        protected UpdateTransactionStatusRequest updateTransactionStatusRequest;
        @XmlElement(name = "ChangeCustomerPINRequest")
        protected ChangeCustomerPINRequest changeCustomerPINRequest;
        @XmlElement(name = "ChangeOrgOperatorPINRequest")
        protected ChangeOrgOperatorPINRequest changeOrgOperatorPINRequest;
        @XmlElement(name = "ChangeCustomerSecretWordRequest")
        protected ChangeCustomerSecretWordRequest changeCustomerSecretWordRequest;
        @XmlElement(name = "ChangeOrgOperatorSecretWordRequest")
        protected ChangeOrgOperatorSecretWordRequest changeOrgOperatorSecretWordRequest;
        @XmlElement(name = "ChangeCustomerLanguageRequest")
        protected ChangeCustomerLanguageRequest changeCustomerLanguageRequest;
        @XmlElement(name = "ChangeOrgOperatorLanguageRequest")
        protected ChangeOrgOperatorLanguageRequest changeOrgOperatorLanguageRequest;
        @XmlElement(name = "ChangeSPOperatorLanguageRequest")
        protected ChangeSPOperatorLanguageRequest changeSPOperatorLanguageRequest;
        @XmlElement(name = "ChangeOrgnNameRequest")
        protected ChangeOrgnNameRequest changeOrgnNameRequest;
        @XmlElement(name = "ActivateCustomerRequest")
        protected ActivateCustomerRequest activateCustomerRequest;
        @XmlElement(name = "ActivateTillRequest")
        protected ActivateTillRequest activateTillRequest;
        @XmlElement(name = "AddCustomerBeneficiaryRequest")
        protected AddCustomerBeneficiaryRequest addCustomerBeneficiaryRequest;
        @XmlElement(name = "AddOrgBeneficiaryRequest")
        protected AddOrgBeneficiaryRequest addOrgBeneficiaryRequest;
        @XmlElement(name = "DeleteCustomerBeneficiaryRequest")
        protected DeleteCustomerBeneficiaryRequest deleteCustomerBeneficiaryRequest;
        @XmlElement(name = "DeleteOrgBeneficiaryRequest")
        protected DeleteOrgBeneficiaryRequest deleteOrgBeneficiaryRequest;
        @XmlElement(name = "LookupCustomerBeneficiaryRequest")
        protected LookupCustomerBeneficiaryRequest lookupCustomerBeneficiaryRequest;
        @XmlElement(name = "LookupOrgBeneficiaryRequest")
        protected LookupOrgBeneficiaryRequest lookupOrgBeneficiaryRequest;
        @XmlElement(name = "AddGroupBeneficiaryRequest")
        protected AddGroupBeneficiaryRequest addGroupBeneficiaryRequest;
        @XmlElement(name = "DeleteGroupBeneficiaryRequest")
        protected DeleteGroupBeneficiaryRequest deleteGroupBeneficiaryRequest;
        @XmlElement(name = "LookupGroupBeneficiaryRequest")
        protected LookupGroupBeneficiaryRequest lookupGroupBeneficiaryRequest;
        @XmlElement(name = "RecipientLookUpRequest")
        protected RecipientLookUpRequest recipientLookUpRequest;
        @XmlElement(name = "BulkTaskRequest")
        protected BulkTaskRequest bulkTaskRequest;
        @XmlElement(name = "SMSVCSendRequest")
        protected SMSVCSendRequest smsvcSendRequest;
        @XmlElement(name = "ChangeTillDefaultOperatorIDRequest")
        protected ChangeTillDefaultOperatorIDRequest changeTillDefaultOperatorIDRequest;
        @XmlElement(name = "CustomerGetStartPINRequest")
        protected CustomerGetStartPINRequest customerGetStartPINRequest;
        @XmlElement(name = "QueryGroupBalanceRequest")
        protected QueryGroupBalanceRequest queryGroupBalanceRequest;
        @XmlElement(name = "QueryGroupAccountStatementsRequest")
        protected QueryGroupAccountStatementsRequest queryGroupAccountStatementsRequest;
        @XmlElement(name = "QueryGroupTransactionsRequest")
        protected QueryGroupTransactionsRequest queryGroupTransactionsRequest;
        @XmlElement(name = "QueryCustomerPointsRequest")
        protected QueryCustomerPointsRequest queryCustomerPointsRequest;
        @XmlElement(name = "QueryCustomerPointsLogRequest")
        protected QueryCustomerPointsLogRequest queryCustomerPointsLogRequest;
        @XmlElement(name = "AdjustCustomerPointsRequest")
        protected AdjustCustomerPointsRequest adjustCustomerPointsRequest;
        @XmlElement(name = "QueryOrganizationPointsRequest")
        protected QueryOrganizationPointsRequest queryOrganizationPointsRequest;
        @XmlElement(name = "QueryOrganizationPointsLogRequest")
        protected QueryOrganizationPointsLogRequest queryOrganizationPointsLogRequest;
        @XmlElement(name = "AdjustOrganizationPointsRequest")
        protected AdjustOrganizationPointsRequest adjustOrganizationPointsRequest;
        @XmlElement(name = "CreateGroupRequest")
        protected CreateGroupRequest createGroupRequest;
        @XmlElement(name = "CreateGroupByCustomerRequest")
        protected CreateGroupByCustomerRequest createGroupByCustomerRequest;
        @XmlElement(name = "UpdateGroupKYCRequest")
        protected UpdateGroupKYCRequest updateGroupKYCRequest;
        @XmlElement(name = "ChangeGroupStatusRequest")
        protected ChangeGroupStatusRequest changeGroupStatusRequest;
        @XmlElement(name = "AddGroupMemberRequest")
        protected AddGroupMemberRequest addGroupMemberRequest;
        @XmlElement(name = "AddGroupMemberByGroupLeaderRequest")
        protected AddGroupMemberByGroupLeaderRequest addGroupMemberByGroupLeaderRequest;
        @XmlElement(name = "RemoveGroupMemberRequest")
        protected RemoveGroupMemberRequest removeGroupMemberRequest;
        @XmlElement(name = "RemoveGroupMemberByGroupLeaderRequest")
        protected RemoveGroupMemberByGroupLeaderRequest removeGroupMemberByGroupLeaderRequest;
        @XmlElement(name = "ChangeGroupMemberRolesRequest")
        protected ChangeGroupMemberRolesRequest changeGroupMemberRolesRequest;
        @XmlElement(name = "ChangeGroupMemberRolesByGroupLeaderRequest")
        protected ChangeGroupMemberRolesByGroupLeaderRequest changeGroupMemberRolesByGroupLeaderRequest;
        @XmlElement(name = "ConfirmGroupMembershipRequest")
        protected ConfirmGroupMembershipRequest confirmGroupMembershipRequest;
        @XmlElement(name = "ApproveGroupActionOrTransactionRequest")
        protected ApproveGroupActionOrTransactionRequest approveGroupActionOrTransactionRequest;
        @XmlElement(name = "SearchMyGroupsRequest")
        protected SearchMyGroupsRequest searchMyGroupsRequest;
        @XmlElement(name = "QueryGroupInfoRequest")
        protected QueryGroupInfoRequest queryGroupInfoRequest;
        @XmlElement(name = "QueryGroupKYCRequest")
        protected QueryGroupKYCRequest queryGroupKYCRequest;
        @XmlElement(name = "QueryGroupProductsRequest")
        protected QueryGroupProductsRequest queryGroupProductsRequest;
        @XmlElement(name = "ListGroupMembersRequest")
        protected ListGroupMembersRequest listGroupMembersRequest;
        @XmlElement(name = "ListGroupMembersByCustomerRequest")
        protected ListGroupMembersByCustomerRequest listGroupMembersByCustomerRequest;
        @XmlElement(name = "ChangeGroupRuleProfileRequest")
        protected ChangeGroupRuleProfileRequest changeGroupRuleProfileRequest;
        @XmlElement(name = "ChangeGroupChargeProfileRequest")
        protected ChangeGroupChargeProfileRequest changeGroupChargeProfileRequest;
        @XmlElement(name = "ChangeGroupAccountRuleProfileRequest")
        protected ChangeGroupAccountRuleProfileRequest changeGroupAccountRuleProfileRequest;
        @XmlElement(name = "IdentifyCustomerRequest")
        protected IdentifyCustomerRequest identifyCustomerRequest;
        @XmlElement(name = "RaiseDisputedTxnReversalRequest")
        protected RaiseDisputedTxnReversalRequest raiseDisputedTxnReversalRequest;
        @XmlElement(name = "CancelIssuedVoucherRequest")
        protected CancelIssuedVoucherRequest cancelIssuedVoucherRequest;
        @XmlElement(name = "CreateCustomerBundleRequest")
        protected CreateCustomerBundleRequest createCustomerBundleRequest;
        @XmlElement(name = "CreateOrganizationBundleRequest")
        protected CreateOrganizationBundleRequest createOrganizationBundleRequest;
        @XmlElement(name = "CreateExternalProviderBundleRequest")
        protected CreateExternalProviderBundleRequest createExternalProviderBundleRequest;
        @XmlElement(name = "CreateGroupBundleRequest")
        protected CreateGroupBundleRequest createGroupBundleRequest;
        @XmlElement(name = "CreateBankAccountRequest")
        protected CreateBankAccountRequest createBankAccountRequest;
        @XmlElement(name = "QueryIdentityBundleRequest")
        protected QueryIdentityBundleRequest queryIdentityBundleRequest;
        @XmlElement(name = "DeleteBankAccountRequest")
        protected DeleteBankAccountRequest deleteBankAccountRequest;
        @XmlElement(name = "SetDefaultBankAccountRequest")
        protected SetDefaultBankAccountRequest setDefaultBankAccountRequest;
        @XmlElement(name = "CreateDirectDebitMandateByPayeeRequest")
        protected CreateDirectDebitMandateByPayeeRequest createDirectDebitMandateByPayeeRequest;
        @XmlElement(name = "CreateDirectDebitMandateByPayerRequest")
        protected CreateDirectDebitMandateByPayerRequest createDirectDebitMandateByPayerRequest;
        @XmlElement(name = "ActivateDirectDebitMandateRequest")
        protected ActivateDirectDebitMandateRequest activateDirectDebitMandateRequest;
        @XmlElement(name = "CancelDirectDebitMandateByPayerRequest")
        protected CancelDirectDebitMandateByPayerRequest cancelDirectDebitMandateByPayerRequest;
        @XmlElement(name = "CancelDirectDebitMandateByPayeeRequest")
        protected CancelDirectDebitMandateByPayeeRequest cancelDirectDebitMandateByPayeeRequest;
        @XmlElement(name = "ReactivateDirectDebitMandateByPayerRequest")
        protected ReactivateDirectDebitMandateByPayerRequest reactivateDirectDebitMandateByPayerRequest;
        @XmlElement(name = "ReactivateDirectDebitMandateByPayeeRequest")
        protected ReactivateDirectDebitMandateByPayeeRequest reactivateDirectDebitMandateByPayeeRequest;
        @XmlElement(name = "EditDirectDebitMandateByPayerRequest")
        protected EditDirectDebitMandateByPayerRequest editDirectDebitMandateByPayerRequest;
        @XmlElement(name = "EditDirectDebitMandateByPayeeRequest")
        protected EditDirectDebitMandateByPayeeRequest editDirectDebitMandateByPayeeRequest;
        @XmlElement(name = "QueryDirectDebitMandateByPayerRequest")
        protected QueryDirectDebitMandateByPayerRequest queryDirectDebitMandateByPayerRequest;
        @XmlElement(name = "ViewDirectDebitMandateByPayerRequest")
        protected ViewDirectDebitMandateByPayerRequest viewDirectDebitMandateByPayerRequest;
        @XmlElement(name = "ViewDirectDebitMandateByPayeeRequest")
        protected ViewDirectDebitMandateByPayeeRequest viewDirectDebitMandateByPayeeRequest;
        @XmlElement(name = "DeleteIndividualReminderScheduleRequest")
        protected DeleteIndividualReminderScheduleRequest deleteIndividualReminderScheduleRequest;
        @XmlElement(name = "CreateReminderScheduleRequest")
        protected CreateReminderScheduleRequest createReminderScheduleRequest;
        @XmlElement(name = "QueryReminderScheduleRequest")
        protected QueryReminderScheduleRequest queryReminderScheduleRequest;
        @XmlElement(name = "LinkingIdentitiesRequest")
        protected LinkingIdentitiesRequest linkingIdentitiesRequest;
        @XmlElement(name = "UnlinkIdentitiesRequest")
        protected UnlinkIdentitiesRequest unlinkIdentitiesRequest;
        @XmlElement(name = "CCHChangeCustKYCRequest")
        protected CCHChangeCustKYCRequest cchChangeCustKYCRequest;
        @XmlElement(name = "CCHChangeOrgOperatorKYCRequest")
        protected CCHChangeOrgOperatorKYCRequest cchChangeOrgOperatorKYCRequest;
        @XmlElement(name = "PreValidationRequest")
        protected PreValidationRequest preValidationRequest;
        @XmlElement(name = "PreValidationConfirmationRequest")
        protected PreValidationConfirmationRequest preValidationConfirmationRequest;
        @XmlElement(name = "CreateOrgLoyaltyAccountRequest")
        protected CreateOrgLoyaltyAccountRequest createOrgLoyaltyAccountRequest;
        @XmlElement(name = "CreateCustLoyaltyAccountRequest")
        protected CreateCustLoyaltyAccountRequest createCustLoyaltyAccountRequest;
        @XmlElement(name = "CreateGroupLoyaltyAccountRequest")
        protected CreateGroupLoyaltyAccountRequest createGroupLoyaltyAccountRequest;
        @XmlElement(name = "CustomerRegisterCardRequest")
        protected CustomerRegisterCardRequest customerRegisterCardRequest;
        @XmlElement(name = "OrgRegisterCardRequest")
        protected OrgRegisterCardRequest orgRegisterCardRequest;
        @XmlElement(name = "GroupRegisterCardRequest")
        protected GroupRegisterCardRequest groupRegisterCardRequest;
        @XmlElement(name = "RegisterCard4CustomerRequest")
        protected RegisterCard4CustomerRequest registerCard4CustomerRequest;
        @XmlElement(name = "RegisterCard4OrgRequest")
        protected RegisterCard4OrgRequest registerCard4OrgRequest;
        @XmlElement(name = "RegisterCard4GroupRequest")
        protected RegisterCard4GroupRequest registerCard4GroupRequest;
        @XmlElement(name = "CustomerActivateCardRequest")
        protected CustomerActivateCardRequest customerActivateCardRequest;
        @XmlElement(name = "OrgActivateCardRequest")
        protected OrgActivateCardRequest orgActivateCardRequest;
        @XmlElement(name = "GroupActivateCardRequest")
        protected GroupActivateCardRequest groupActivateCardRequest;
        @XmlElement(name = "CustomerCancelCardRequest")
        protected CustomerCancelCardRequest customerCancelCardRequest;
        @XmlElement(name = "OrgCancelCardRequest")
        protected OrgCancelCardRequest orgCancelCardRequest;
        @XmlElement(name = "GroupCancelCardRequest")
        protected GroupCancelCardRequest groupCancelCardRequest;
        @XmlElement(name = "QueryCustLoyaltyPointRequest")
        protected QueryCustLoyaltyPointRequest queryCustLoyaltyPointRequest;
        @XmlElement(name = "QueryOrgLoyaltyPointRequest")
        protected QueryOrgLoyaltyPointRequest queryOrgLoyaltyPointRequest;
        @XmlElement(name = "QueryGroupLoyaltyPointRequest")
        protected QueryGroupLoyaltyPointRequest queryGroupLoyaltyPointRequest;
        @XmlElement(name = "QueryLoyaltyConsumerRequest")
        protected QueryLoyaltyConsumerRequest queryLoyaltyConsumerRequest;
        @XmlElement(name = "QueryCustLoyaltyPointStatementRequest")
        protected QueryCustLoyaltyPointStatementRequest queryCustLoyaltyPointStatementRequest;
        @XmlElement(name = "QueryOrgLoyaltyPointStatementRequest")
        protected QueryOrgLoyaltyPointStatementRequest queryOrgLoyaltyPointStatementRequest;
        @XmlElement(name = "QueryGroupLoyaltyPointStatementRequest")
        protected QueryGroupLoyaltyPointStatementRequest queryGroupLoyaltyPointStatementRequest;
        @XmlElement(name = "QueryLoyaltyConsumerStatementRequest")
        protected QueryLoyaltyConsumerStatementRequest queryLoyaltyConsumerStatementRequest;
        @XmlElement(name = "CCHIdentifyCustomerRequest")
        protected CCHIdentifyCustomerRequest cchIdentifyCustomerRequest;
        @XmlElement(name = "CCHIdentifyOperatorRequest")
        protected CCHIdentifyOperatorRequest cchIdentifyOperatorRequest;
        @XmlElement(name = "UpdateOrgOperatorOwnKYCRequest")
        protected UpdateOrgOperatorOwnKYCRequest updateOrgOperatorOwnKYCRequest;
        @XmlElement(name = "QuerySavingPlanForCustomerRequest")
        protected QuerySavingPlanForCustomerRequest querySavingPlanForCustomerRequest;
        @XmlElement(name = "QuerySavingPlanForGroupRequest")
        protected QuerySavingPlanForGroupRequest querySavingPlanForGroupRequest;
        @XmlElement(name = "QuerySavingPlanForOrganizationRequest")
        protected QuerySavingPlanForOrganizationRequest querySavingPlanForOrganizationRequest;
        @XmlElement(name = "QueryTransferPointsFeeRequest")
        protected QueryTransferPointsFeeRequest queryTransferPointsFeeRequest;
        @XmlElement(name = "QueryRedeemBalanceRateRequest")
        protected QueryRedeemBalanceRateRequest queryRedeemBalanceRateRequest;
        @XmlElement(name = "TransferPointsRequest")
        protected TransferPointsRequest transferPointsRequest;
        @XmlElement(name = "RedeemPointsToGoodsRequest")
        protected RedeemPointsToGoodsRequest redeemPointsToGoodsRequest;
        @XmlElement(name = "RedeemPointsWithVoucherRequest")
        protected RedeemPointsWithVoucherRequest redeemPointsWithVoucherRequest;
        @XmlElement(name = "RedeemPointsToBalanceRequest")
        protected RedeemPointsToBalanceRequest redeemPointsToBalanceRequest;
        @XmlElement(name = "SubscribeSavingPlanForCustomerRequest")
        protected SubscribeSavingPlanForCustomerRequest subscribeSavingPlanForCustomerRequest;
        @XmlElement(name = "SubscribeSavingPlanForGroupRequest")
        protected SubscribeSavingPlanForGroupRequest subscribeSavingPlanForGroupRequest;
        @XmlElement(name = "SubscribeSavingPlanForOrgRequest")
        protected SubscribeSavingPlanForOrgRequest subscribeSavingPlanForOrgRequest;
        @XmlElement(name = "UnSubscribeSavingPlanForCustomerRequest")
        protected UnSubscribeSavingPlanForCustomerRequest unSubscribeSavingPlanForCustomerRequest;
        @XmlElement(name = "UnSubscribeSavingPlanForGroupRequest")
        protected UnSubscribeSavingPlanForGroupRequest unSubscribeSavingPlanForGroupRequest;
        @XmlElement(name = "UnSubscribeSavingPlanForOrgRequest")
        protected UnSubscribeSavingPlanForOrgRequest unSubscribeSavingPlanForOrgRequest;
        @XmlElement(name = "ValidateTokenRequest")
        protected ValidateTokenRequest validateTokenRequest;
        @XmlElement(name = "ChangeOrgOperatorMSISDNRequest")
        protected ChangeOrgOperatorMSISDNRequest changeOrgOperatorMSISDNRequest;
        @XmlElement(name = "ReferenceData")
        protected Request.Body.ReferenceData referenceData;
        @XmlElement(name = "Remark")
        protected String remark;

        /**
         * Gets the value of the identity property.
         * 
         * @return
         *     possible object is
         *     {@link Request.Body.Identity }
         *     
         */
        public Request.Body.Identity getIdentity() {
            return identity;
        }

        /**
         * Sets the value of the identity property.
         * 
         * @param value
         *     allowed object is
         *     {@link Request.Body.Identity }
         *     
         */
        public void setIdentity(Request.Body.Identity value) {
            this.identity = value;
        }

        /**
         * Gets the value of the verification property.
         * 
         * @return
         *     possible object is
         *     {@link Request.Body.Verification }
         *     
         */
        public Request.Body.Verification getVerification() {
            return verification;
        }

        /**
         * Sets the value of the verification property.
         * 
         * @param value
         *     allowed object is
         *     {@link Request.Body.Verification }
         *     
         */
        public void setVerification(Request.Body.Verification value) {
            this.verification = value;
        }

        /**
         * Gets the value of the encryptedParameters property.
         * 
         * @return
         *     possible object is
         *     byte[]
         */
        public byte[] getEncryptedParameters() {
            return encryptedParameters;
        }

        /**
         * Sets the value of the encryptedParameters property.
         * 
         * @param value
         *     allowed object is
         *     byte[]
         */
        public void setEncryptedParameters(byte[] value) {
            this.encryptedParameters = value;
        }

        /**
         * Gets the value of the transactionRequest property.
         * 
         * @return
         *     possible object is
         *     {@link Request.Body.TransactionRequest }
         *     
         */
        public Request.Body.TransactionRequest getTransactionRequest() {
            return transactionRequest;
        }

        /**
         * Sets the value of the transactionRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link Request.Body.TransactionRequest }
         *     
         */
        public void setTransactionRequest(Request.Body.TransactionRequest value) {
            this.transactionRequest = value;
        }

        /**
         * Gets the value of the createTopOrgRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CreateTopOrgRequest }
         *     
         */
        public CreateTopOrgRequest getCreateTopOrgRequest() {
            return createTopOrgRequest;
        }

        /**
         * Sets the value of the createTopOrgRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateTopOrgRequest }
         *     
         */
        public void setCreateTopOrgRequest(CreateTopOrgRequest value) {
            this.createTopOrgRequest = value;
        }

        /**
         * Gets the value of the createChildOrgRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CreateChildOrgRequest }
         *     
         */
        public CreateChildOrgRequest getCreateChildOrgRequest() {
            return createChildOrgRequest;
        }

        /**
         * Sets the value of the createChildOrgRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateChildOrgRequest }
         *     
         */
        public void setCreateChildOrgRequest(CreateChildOrgRequest value) {
            this.createChildOrgRequest = value;
        }

        /**
         * Gets the value of the createTillRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CreateTillRequest }
         *     
         */
        public CreateTillRequest getCreateTillRequest() {
            return createTillRequest;
        }

        /**
         * Sets the value of the createTillRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateTillRequest }
         *     
         */
        public void setCreateTillRequest(CreateTillRequest value) {
            this.createTillRequest = value;
        }

        /**
         * Gets the value of the createOrgOperatorRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CreateOrgOperatorRequest }
         *     
         */
        public CreateOrgOperatorRequest getCreateOrgOperatorRequest() {
            return createOrgOperatorRequest;
        }

        /**
         * Sets the value of the createOrgOperatorRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateOrgOperatorRequest }
         *     
         */
        public void setCreateOrgOperatorRequest(CreateOrgOperatorRequest value) {
            this.createOrgOperatorRequest = value;
        }

        /**
         * Gets the value of the changeCustomerMSISDNRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeCustomerMSISDNRequest }
         *     
         */
        public ChangeCustomerMSISDNRequest getChangeCustomerMSISDNRequest() {
            return changeCustomerMSISDNRequest;
        }

        /**
         * Sets the value of the changeCustomerMSISDNRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeCustomerMSISDNRequest }
         *     
         */
        public void setChangeCustomerMSISDNRequest(ChangeCustomerMSISDNRequest value) {
            this.changeCustomerMSISDNRequest = value;
        }

        /**
         * Gets the value of the changeTillMSISDNRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeTillMSISDNRequest }
         *     
         */
        public ChangeTillMSISDNRequest getChangeTillMSISDNRequest() {
            return changeTillMSISDNRequest;
        }

        /**
         * Sets the value of the changeTillMSISDNRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeTillMSISDNRequest }
         *     
         */
        public void setChangeTillMSISDNRequest(ChangeTillMSISDNRequest value) {
            this.changeTillMSISDNRequest = value;
        }

        /**
         * Gets the value of the changeTillLanguageRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeTillLanguageRequest }
         *     
         */
        public ChangeTillLanguageRequest getChangeTillLanguageRequest() {
            return changeTillLanguageRequest;
        }

        /**
         * Sets the value of the changeTillLanguageRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeTillLanguageRequest }
         *     
         */
        public void setChangeTillLanguageRequest(ChangeTillLanguageRequest value) {
            this.changeTillLanguageRequest = value;
        }

        /**
         * Gets the value of the changeAccountStatusRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeAccountStatusRequest }
         *     
         */
        public ChangeAccountStatusRequest getChangeAccountStatusRequest() {
            return changeAccountStatusRequest;
        }

        /**
         * Sets the value of the changeAccountStatusRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeAccountStatusRequest }
         *     
         */
        public void setChangeAccountStatusRequest(ChangeAccountStatusRequest value) {
            this.changeAccountStatusRequest = value;
        }

        /**
         * Gets the value of the updateCustomerKYCRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateCustomerKYCRequest }
         *     
         */
        public UpdateCustomerKYCRequest getUpdateCustomerKYCRequest() {
            return updateCustomerKYCRequest;
        }

        /**
         * Sets the value of the updateCustomerKYCRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateCustomerKYCRequest }
         *     
         */
        public void setUpdateCustomerKYCRequest(UpdateCustomerKYCRequest value) {
            this.updateCustomerKYCRequest = value;
        }

        /**
         * Gets the value of the updateOrganizationKYCRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateOrganizationKYCRequest }
         *     
         */
        public UpdateOrganizationKYCRequest getUpdateOrganizationKYCRequest() {
            return updateOrganizationKYCRequest;
        }

        /**
         * Sets the value of the updateOrganizationKYCRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateOrganizationKYCRequest }
         *     
         */
        public void setUpdateOrganizationKYCRequest(UpdateOrganizationKYCRequest value) {
            this.updateOrganizationKYCRequest = value;
        }

        /**
         * Gets the value of the queryCustomerKYCRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustomerKYCRequest }
         *     
         */
        public QueryCustomerKYCRequest getQueryCustomerKYCRequest() {
            return queryCustomerKYCRequest;
        }

        /**
         * Sets the value of the queryCustomerKYCRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustomerKYCRequest }
         *     
         */
        public void setQueryCustomerKYCRequest(QueryCustomerKYCRequest value) {
            this.queryCustomerKYCRequest = value;
        }

        /**
         * Gets the value of the queryCustomerInfoRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustomerInfoRequest }
         *     
         */
        public QueryCustomerInfoRequest getQueryCustomerInfoRequest() {
            return queryCustomerInfoRequest;
        }

        /**
         * Sets the value of the queryCustomerInfoRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustomerInfoRequest }
         *     
         */
        public void setQueryCustomerInfoRequest(QueryCustomerInfoRequest value) {
            this.queryCustomerInfoRequest = value;
        }

        /**
         * Gets the value of the queryCustomerProductsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustomerProductsRequest }
         *     
         */
        public QueryCustomerProductsRequest getQueryCustomerProductsRequest() {
            return queryCustomerProductsRequest;
        }

        /**
         * Sets the value of the queryCustomerProductsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustomerProductsRequest }
         *     
         */
        public void setQueryCustomerProductsRequest(QueryCustomerProductsRequest value) {
            this.queryCustomerProductsRequest = value;
        }

        /**
         * Gets the value of the queryCustomerBalanceRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustomerBalanceRequest }
         *     
         */
        public QueryCustomerBalanceRequest getQueryCustomerBalanceRequest() {
            return queryCustomerBalanceRequest;
        }

        /**
         * Sets the value of the queryCustomerBalanceRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustomerBalanceRequest }
         *     
         */
        public void setQueryCustomerBalanceRequest(QueryCustomerBalanceRequest value) {
            this.queryCustomerBalanceRequest = value;
        }

        /**
         * Gets the value of the queryOrganizationKYCRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrganizationKYCRequest }
         *     
         */
        public QueryOrganizationKYCRequest getQueryOrganizationKYCRequest() {
            return queryOrganizationKYCRequest;
        }

        /**
         * Sets the value of the queryOrganizationKYCRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrganizationKYCRequest }
         *     
         */
        public void setQueryOrganizationKYCRequest(QueryOrganizationKYCRequest value) {
            this.queryOrganizationKYCRequest = value;
        }

        /**
         * Gets the value of the queryOrganizationInfoRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrganizationInfoRequest }
         *     
         */
        public QueryOrganizationInfoRequest getQueryOrganizationInfoRequest() {
            return queryOrganizationInfoRequest;
        }

        /**
         * Sets the value of the queryOrganizationInfoRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrganizationInfoRequest }
         *     
         */
        public void setQueryOrganizationInfoRequest(QueryOrganizationInfoRequest value) {
            this.queryOrganizationInfoRequest = value;
        }

        /**
         * Gets the value of the queryOrganizationProductsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrganizationProductsRequest }
         *     
         */
        public QueryOrganizationProductsRequest getQueryOrganizationProductsRequest() {
            return queryOrganizationProductsRequest;
        }

        /**
         * Sets the value of the queryOrganizationProductsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrganizationProductsRequest }
         *     
         */
        public void setQueryOrganizationProductsRequest(QueryOrganizationProductsRequest value) {
            this.queryOrganizationProductsRequest = value;
        }

        /**
         * Gets the value of the queryOrganizationBalanceRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrganizationBalanceRequest }
         *     
         */
        public QueryOrganizationBalanceRequest getQueryOrganizationBalanceRequest() {
            return queryOrganizationBalanceRequest;
        }

        /**
         * Sets the value of the queryOrganizationBalanceRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrganizationBalanceRequest }
         *     
         */
        public void setQueryOrganizationBalanceRequest(QueryOrganizationBalanceRequest value) {
            this.queryOrganizationBalanceRequest = value;
        }

        /**
         * Gets the value of the listOrganizationTillsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ListOrganizationTillsRequest }
         *     
         */
        public ListOrganizationTillsRequest getListOrganizationTillsRequest() {
            return listOrganizationTillsRequest;
        }

        /**
         * Sets the value of the listOrganizationTillsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ListOrganizationTillsRequest }
         *     
         */
        public void setListOrganizationTillsRequest(ListOrganizationTillsRequest value) {
            this.listOrganizationTillsRequest = value;
        }

        /**
         * Gets the value of the queryOrgOperatorKYCRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrgOperatorKYCRequest }
         *     
         */
        public QueryOrgOperatorKYCRequest getQueryOrgOperatorKYCRequest() {
            return queryOrgOperatorKYCRequest;
        }

        /**
         * Sets the value of the queryOrgOperatorKYCRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrgOperatorKYCRequest }
         *     
         */
        public void setQueryOrgOperatorKYCRequest(QueryOrgOperatorKYCRequest value) {
            this.queryOrgOperatorKYCRequest = value;
        }

        /**
         * Gets the value of the queryOrgOperatorInfoRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrgOperatorInfoRequest }
         *     
         */
        public QueryOrgOperatorInfoRequest getQueryOrgOperatorInfoRequest() {
            return queryOrgOperatorInfoRequest;
        }

        /**
         * Sets the value of the queryOrgOperatorInfoRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrgOperatorInfoRequest }
         *     
         */
        public void setQueryOrgOperatorInfoRequest(QueryOrgOperatorInfoRequest value) {
            this.queryOrgOperatorInfoRequest = value;
        }

        /**
         * Gets the value of the queryTillInfoRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryTillInfoRequest }
         *     
         */
        public QueryTillInfoRequest getQueryTillInfoRequest() {
            return queryTillInfoRequest;
        }

        /**
         * Sets the value of the queryTillInfoRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryTillInfoRequest }
         *     
         */
        public void setQueryTillInfoRequest(QueryTillInfoRequest value) {
            this.queryTillInfoRequest = value;
        }

        /**
         * Gets the value of the queryTillProductsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryTillProductsRequest }
         *     
         */
        public QueryTillProductsRequest getQueryTillProductsRequest() {
            return queryTillProductsRequest;
        }

        /**
         * Sets the value of the queryTillProductsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryTillProductsRequest }
         *     
         */
        public void setQueryTillProductsRequest(QueryTillProductsRequest value) {
            this.queryTillProductsRequest = value;
        }

        /**
         * Gets the value of the changeCustomerStatusRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeCustomerStatusRequest }
         *     
         */
        public ChangeCustomerStatusRequest getChangeCustomerStatusRequest() {
            return changeCustomerStatusRequest;
        }

        /**
         * Sets the value of the changeCustomerStatusRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeCustomerStatusRequest }
         *     
         */
        public void setChangeCustomerStatusRequest(ChangeCustomerStatusRequest value) {
            this.changeCustomerStatusRequest = value;
        }

        /**
         * Gets the value of the changeOrganizationStatusRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeOrganizationStatusRequest }
         *     
         */
        public ChangeOrganizationStatusRequest getChangeOrganizationStatusRequest() {
            return changeOrganizationStatusRequest;
        }

        /**
         * Sets the value of the changeOrganizationStatusRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeOrganizationStatusRequest }
         *     
         */
        public void setChangeOrganizationStatusRequest(ChangeOrganizationStatusRequest value) {
            this.changeOrganizationStatusRequest = value;
        }

        /**
         * Gets the value of the changeTillStatusRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeTillStatusRequest }
         *     
         */
        public ChangeTillStatusRequest getChangeTillStatusRequest() {
            return changeTillStatusRequest;
        }

        /**
         * Sets the value of the changeTillStatusRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeTillStatusRequest }
         *     
         */
        public void setChangeTillStatusRequest(ChangeTillStatusRequest value) {
            this.changeTillStatusRequest = value;
        }

        /**
         * Gets the value of the changeSPOperatorStatusRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeSPOperatorStatusRequest }
         *     
         */
        public ChangeSPOperatorStatusRequest getChangeSPOperatorStatusRequest() {
            return changeSPOperatorStatusRequest;
        }

        /**
         * Sets the value of the changeSPOperatorStatusRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeSPOperatorStatusRequest }
         *     
         */
        public void setChangeSPOperatorStatusRequest(ChangeSPOperatorStatusRequest value) {
            this.changeSPOperatorStatusRequest = value;
        }

        /**
         * Gets the value of the changeOrgOperatorStatusRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeOrgOperatorStatusRequest }
         *     
         */
        public ChangeOrgOperatorStatusRequest getChangeOrgOperatorStatusRequest() {
            return changeOrgOperatorStatusRequest;
        }

        /**
         * Sets the value of the changeOrgOperatorStatusRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeOrgOperatorStatusRequest }
         *     
         */
        public void setChangeOrgOperatorStatusRequest(ChangeOrgOperatorStatusRequest value) {
            this.changeOrgOperatorStatusRequest = value;
        }

        /**
         * Gets the value of the updateSPOperatorKYCRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateSPOperatorKYCRequest }
         *     
         */
        public UpdateSPOperatorKYCRequest getUpdateSPOperatorKYCRequest() {
            return updateSPOperatorKYCRequest;
        }

        /**
         * Sets the value of the updateSPOperatorKYCRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateSPOperatorKYCRequest }
         *     
         */
        public void setUpdateSPOperatorKYCRequest(UpdateSPOperatorKYCRequest value) {
            this.updateSPOperatorKYCRequest = value;
        }

        /**
         * Gets the value of the updateOrgOperatorKYCRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateOrgOperatorKYCRequest }
         *     
         */
        public UpdateOrgOperatorKYCRequest getUpdateOrgOperatorKYCRequest() {
            return updateOrgOperatorKYCRequest;
        }

        /**
         * Sets the value of the updateOrgOperatorKYCRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateOrgOperatorKYCRequest }
         *     
         */
        public void setUpdateOrgOperatorKYCRequest(UpdateOrgOperatorKYCRequest value) {
            this.updateOrgOperatorKYCRequest = value;
        }

        /**
         * Gets the value of the updateCustomerProductsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateCustomerProductsRequest }
         *     
         */
        public UpdateCustomerProductsRequest getUpdateCustomerProductsRequest() {
            return updateCustomerProductsRequest;
        }

        /**
         * Sets the value of the updateCustomerProductsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateCustomerProductsRequest }
         *     
         */
        public void setUpdateCustomerProductsRequest(UpdateCustomerProductsRequest value) {
            this.updateCustomerProductsRequest = value;
        }

        /**
         * Gets the value of the updateOrganizationProductsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateOrganizationProductsRequest }
         *     
         */
        public UpdateOrganizationProductsRequest getUpdateOrganizationProductsRequest() {
            return updateOrganizationProductsRequest;
        }

        /**
         * Sets the value of the updateOrganizationProductsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateOrganizationProductsRequest }
         *     
         */
        public void setUpdateOrganizationProductsRequest(UpdateOrganizationProductsRequest value) {
            this.updateOrganizationProductsRequest = value;
        }

        /**
         * Gets the value of the updateTillProductsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateTillProductsRequest }
         *     
         */
        public UpdateTillProductsRequest getUpdateTillProductsRequest() {
            return updateTillProductsRequest;
        }

        /**
         * Sets the value of the updateTillProductsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateTillProductsRequest }
         *     
         */
        public void setUpdateTillProductsRequest(UpdateTillProductsRequest value) {
            this.updateTillProductsRequest = value;
        }

        /**
         * Gets the value of the registerCustomerRequest property.
         * 
         * @return
         *     possible object is
         *     {@link RegisterCustomerRequest }
         *     
         */
        public RegisterCustomerRequest getRegisterCustomerRequest() {
            return registerCustomerRequest;
        }

        /**
         * Sets the value of the registerCustomerRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link RegisterCustomerRequest }
         *     
         */
        public void setRegisterCustomerRequest(RegisterCustomerRequest value) {
            this.registerCustomerRequest = value;
        }

        /**
         * Gets the value of the recycleMSISDNRequest property.
         * 
         * @return
         *     possible object is
         *     {@link RecycleMSISDNRequest }
         *     
         */
        public RecycleMSISDNRequest getRecycleMSISDNRequest() {
            return recycleMSISDNRequest;
        }

        /**
         * Sets the value of the recycleMSISDNRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link RecycleMSISDNRequest }
         *     
         */
        public void setRecycleMSISDNRequest(RecycleMSISDNRequest value) {
            this.recycleMSISDNRequest = value;
        }

        /**
         * Gets the value of the listOrganizationChildStoresRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ListOrganizationChildStoresRequest }
         *     
         */
        public ListOrganizationChildStoresRequest getListOrganizationChildStoresRequest() {
            return listOrganizationChildStoresRequest;
        }

        /**
         * Sets the value of the listOrganizationChildStoresRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ListOrganizationChildStoresRequest }
         *     
         */
        public void setListOrganizationChildStoresRequest(ListOrganizationChildStoresRequest value) {
            this.listOrganizationChildStoresRequest = value;
        }

        /**
         * Gets the value of the listOrganizationOperatorsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ListOrganizationOperatorsRequest }
         *     
         */
        public ListOrganizationOperatorsRequest getListOrganizationOperatorsRequest() {
            return listOrganizationOperatorsRequest;
        }

        /**
         * Sets the value of the listOrganizationOperatorsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ListOrganizationOperatorsRequest }
         *     
         */
        public void setListOrganizationOperatorsRequest(ListOrganizationOperatorsRequest value) {
            this.listOrganizationOperatorsRequest = value;
        }

        /**
         * Gets the value of the updateSPOperatorRoleRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateSPOperatorRoleRequest }
         *     
         */
        public UpdateSPOperatorRoleRequest getUpdateSPOperatorRoleRequest() {
            return updateSPOperatorRoleRequest;
        }

        /**
         * Sets the value of the updateSPOperatorRoleRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateSPOperatorRoleRequest }
         *     
         */
        public void setUpdateSPOperatorRoleRequest(UpdateSPOperatorRoleRequest value) {
            this.updateSPOperatorRoleRequest = value;
        }

        /**
         * Gets the value of the updateOrgOperatorRoleRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateOrgOperatorRoleRequest }
         *     
         */
        public UpdateOrgOperatorRoleRequest getUpdateOrgOperatorRoleRequest() {
            return updateOrgOperatorRoleRequest;
        }

        /**
         * Sets the value of the updateOrgOperatorRoleRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateOrgOperatorRoleRequest }
         *     
         */
        public void setUpdateOrgOperatorRoleRequest(UpdateOrgOperatorRoleRequest value) {
            this.updateOrgOperatorRoleRequest = value;
        }

        /**
         * Gets the value of the updateOrgTaxExemptionRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateOrgTaxExemptionRequest }
         *     
         */
        public UpdateOrgTaxExemptionRequest getUpdateOrgTaxExemptionRequest() {
            return updateOrgTaxExemptionRequest;
        }

        /**
         * Sets the value of the updateOrgTaxExemptionRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateOrgTaxExemptionRequest }
         *     
         */
        public void setUpdateOrgTaxExemptionRequest(UpdateOrgTaxExemptionRequest value) {
            this.updateOrgTaxExemptionRequest = value;
        }

        /**
         * Gets the value of the queryO2CLinkRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryO2CLinkRequest }
         *     
         */
        public QueryO2CLinkRequest getQueryO2CLinkRequest() {
            return queryO2CLinkRequest;
        }

        /**
         * Sets the value of the queryO2CLinkRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryO2CLinkRequest }
         *     
         */
        public void setQueryO2CLinkRequest(QueryO2CLinkRequest value) {
            this.queryO2CLinkRequest = value;
        }

        /**
         * Gets the value of the addO2CLinkRequest property.
         * 
         * @return
         *     possible object is
         *     {@link AddO2CLinkRequest }
         *     
         */
        public AddO2CLinkRequest getAddO2CLinkRequest() {
            return addO2CLinkRequest;
        }

        /**
         * Sets the value of the addO2CLinkRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link AddO2CLinkRequest }
         *     
         */
        public void setAddO2CLinkRequest(AddO2CLinkRequest value) {
            this.addO2CLinkRequest = value;
        }

        /**
         * Gets the value of the deleteO2CLinkRequest property.
         * 
         * @return
         *     possible object is
         *     {@link DeleteO2CLinkRequest }
         *     
         */
        public DeleteO2CLinkRequest getDeleteO2CLinkRequest() {
            return deleteO2CLinkRequest;
        }

        /**
         * Sets the value of the deleteO2CLinkRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link DeleteO2CLinkRequest }
         *     
         */
        public void setDeleteO2CLinkRequest(DeleteO2CLinkRequest value) {
            this.deleteO2CLinkRequest = value;
        }

        /**
         * Gets the value of the verifyCCCallerRequest property.
         * 
         * @return
         *     possible object is
         *     {@link VerifyCCCallerRequest }
         *     
         */
        public VerifyCCCallerRequest getVerifyCCCallerRequest() {
            return verifyCCCallerRequest;
        }

        /**
         * Sets the value of the verifyCCCallerRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link VerifyCCCallerRequest }
         *     
         */
        public void setVerifyCCCallerRequest(VerifyCCCallerRequest value) {
            this.verifyCCCallerRequest = value;
        }

        /**
         * Gets the value of the unlockCustomerPINRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UnlockCustomerPINRequest }
         *     
         */
        public UnlockCustomerPINRequest getUnlockCustomerPINRequest() {
            return unlockCustomerPINRequest;
        }

        /**
         * Sets the value of the unlockCustomerPINRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UnlockCustomerPINRequest }
         *     
         */
        public void setUnlockCustomerPINRequest(UnlockCustomerPINRequest value) {
            this.unlockCustomerPINRequest = value;
        }

        /**
         * Gets the value of the unlockOrgOperatorPINRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UnlockOrgOperatorPINRequest }
         *     
         */
        public UnlockOrgOperatorPINRequest getUnlockOrgOperatorPINRequest() {
            return unlockOrgOperatorPINRequest;
        }

        /**
         * Sets the value of the unlockOrgOperatorPINRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UnlockOrgOperatorPINRequest }
         *     
         */
        public void setUnlockOrgOperatorPINRequest(UnlockOrgOperatorPINRequest value) {
            this.unlockOrgOperatorPINRequest = value;
        }

        /**
         * Gets the value of the unlockOrgOperatorPasswordRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UnlockOrgOperatorPasswordRequest }
         *     
         */
        public UnlockOrgOperatorPasswordRequest getUnlockOrgOperatorPasswordRequest() {
            return unlockOrgOperatorPasswordRequest;
        }

        /**
         * Sets the value of the unlockOrgOperatorPasswordRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UnlockOrgOperatorPasswordRequest }
         *     
         */
        public void setUnlockOrgOperatorPasswordRequest(UnlockOrgOperatorPasswordRequest value) {
            this.unlockOrgOperatorPasswordRequest = value;
        }

        /**
         * Gets the value of the resetCustomerPINRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ResetCustomerPINRequest }
         *     
         */
        public ResetCustomerPINRequest getResetCustomerPINRequest() {
            return resetCustomerPINRequest;
        }

        /**
         * Sets the value of the resetCustomerPINRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ResetCustomerPINRequest }
         *     
         */
        public void setResetCustomerPINRequest(ResetCustomerPINRequest value) {
            this.resetCustomerPINRequest = value;
        }

        /**
         * Gets the value of the resetOrgOperatorPINRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ResetOrgOperatorPINRequest }
         *     
         */
        public ResetOrgOperatorPINRequest getResetOrgOperatorPINRequest() {
            return resetOrgOperatorPINRequest;
        }

        /**
         * Sets the value of the resetOrgOperatorPINRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ResetOrgOperatorPINRequest }
         *     
         */
        public void setResetOrgOperatorPINRequest(ResetOrgOperatorPINRequest value) {
            this.resetOrgOperatorPINRequest = value;
        }

        /**
         * Gets the value of the resetOrgOperatorPasswordRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ResetOrgOperatorPasswordRequest }
         *     
         */
        public ResetOrgOperatorPasswordRequest getResetOrgOperatorPasswordRequest() {
            return resetOrgOperatorPasswordRequest;
        }

        /**
         * Sets the value of the resetOrgOperatorPasswordRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ResetOrgOperatorPasswordRequest }
         *     
         */
        public void setResetOrgOperatorPasswordRequest(ResetOrgOperatorPasswordRequest value) {
            this.resetOrgOperatorPasswordRequest = value;
        }

        /**
         * Gets the value of the resetCustomerSecretWordRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ResetCustomerSecretWordRequest }
         *     
         */
        public ResetCustomerSecretWordRequest getResetCustomerSecretWordRequest() {
            return resetCustomerSecretWordRequest;
        }

        /**
         * Sets the value of the resetCustomerSecretWordRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ResetCustomerSecretWordRequest }
         *     
         */
        public void setResetCustomerSecretWordRequest(ResetCustomerSecretWordRequest value) {
            this.resetCustomerSecretWordRequest = value;
        }

        /**
         * Gets the value of the releaseCustomerCCSuspendStatusRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ReleaseCustomerCCSuspendStatusRequest }
         *     
         */
        public ReleaseCustomerCCSuspendStatusRequest getReleaseCustomerCCSuspendStatusRequest() {
            return releaseCustomerCCSuspendStatusRequest;
        }

        /**
         * Sets the value of the releaseCustomerCCSuspendStatusRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ReleaseCustomerCCSuspendStatusRequest }
         *     
         */
        public void setReleaseCustomerCCSuspendStatusRequest(ReleaseCustomerCCSuspendStatusRequest value) {
            this.releaseCustomerCCSuspendStatusRequest = value;
        }

        /**
         * Gets the value of the releaseOrgOperatorCCSuspendStatusRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ReleaseOrgOperatorCCSuspendStatusRequest }
         *     
         */
        public ReleaseOrgOperatorCCSuspendStatusRequest getReleaseOrgOperatorCCSuspendStatusRequest() {
            return releaseOrgOperatorCCSuspendStatusRequest;
        }

        /**
         * Sets the value of the releaseOrgOperatorCCSuspendStatusRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ReleaseOrgOperatorCCSuspendStatusRequest }
         *     
         */
        public void setReleaseOrgOperatorCCSuspendStatusRequest(ReleaseOrgOperatorCCSuspendStatusRequest value) {
            this.releaseOrgOperatorCCSuspendStatusRequest = value;
        }

        /**
         * Gets the value of the searchTransactionRequest property.
         * 
         * @return
         *     possible object is
         *     {@link SearchTransactionRequest }
         *     
         */
        public SearchTransactionRequest getSearchTransactionRequest() {
            return searchTransactionRequest;
        }

        /**
         * Sets the value of the searchTransactionRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link SearchTransactionRequest }
         *     
         */
        public void setSearchTransactionRequest(SearchTransactionRequest value) {
            this.searchTransactionRequest = value;
        }

        /**
         * Gets the value of the reverseTransactionRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ReverseTransactionRequest }
         *     
         */
        public ReverseTransactionRequest getReverseTransactionRequest() {
            return reverseTransactionRequest;
        }

        /**
         * Sets the value of the reverseTransactionRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ReverseTransactionRequest }
         *     
         */
        public void setReverseTransactionRequest(ReverseTransactionRequest value) {
            this.reverseTransactionRequest = value;
        }

        /**
         * Gets the value of the confirmTransactionRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ConfirmTransactionRequest }
         *     
         */
        public ConfirmTransactionRequest getConfirmTransactionRequest() {
            return confirmTransactionRequest;
        }

        /**
         * Sets the value of the confirmTransactionRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ConfirmTransactionRequest }
         *     
         */
        public void setConfirmTransactionRequest(ConfirmTransactionRequest value) {
            this.confirmTransactionRequest = value;
        }

        /**
         * Gets the value of the queryCustomerAccountStatementsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustomerAccountStatementsRequest }
         *     
         */
        public QueryCustomerAccountStatementsRequest getQueryCustomerAccountStatementsRequest() {
            return queryCustomerAccountStatementsRequest;
        }

        /**
         * Sets the value of the queryCustomerAccountStatementsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustomerAccountStatementsRequest }
         *     
         */
        public void setQueryCustomerAccountStatementsRequest(QueryCustomerAccountStatementsRequest value) {
            this.queryCustomerAccountStatementsRequest = value;
        }

        /**
         * Gets the value of the queryCustomerTransactionsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustomerTransactionsRequest }
         *     
         */
        public QueryCustomerTransactionsRequest getQueryCustomerTransactionsRequest() {
            return queryCustomerTransactionsRequest;
        }

        /**
         * Sets the value of the queryCustomerTransactionsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustomerTransactionsRequest }
         *     
         */
        public void setQueryCustomerTransactionsRequest(QueryCustomerTransactionsRequest value) {
            this.queryCustomerTransactionsRequest = value;
        }

        /**
         * Gets the value of the queryOrganizationAccountStatementsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrganizationAccountStatementsRequest }
         *     
         */
        public QueryOrganizationAccountStatementsRequest getQueryOrganizationAccountStatementsRequest() {
            return queryOrganizationAccountStatementsRequest;
        }

        /**
         * Sets the value of the queryOrganizationAccountStatementsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrganizationAccountStatementsRequest }
         *     
         */
        public void setQueryOrganizationAccountStatementsRequest(QueryOrganizationAccountStatementsRequest value) {
            this.queryOrganizationAccountStatementsRequest = value;
        }

        /**
         * Gets the value of the queryOrganizationTransactionsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrganizationTransactionsRequest }
         *     
         */
        public QueryOrganizationTransactionsRequest getQueryOrganizationTransactionsRequest() {
            return queryOrganizationTransactionsRequest;
        }

        /**
         * Sets the value of the queryOrganizationTransactionsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrganizationTransactionsRequest }
         *     
         */
        public void setQueryOrganizationTransactionsRequest(QueryOrganizationTransactionsRequest value) {
            this.queryOrganizationTransactionsRequest = value;
        }

        /**
         * Gets the value of the queryResultMessageRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryResultMessageRequest }
         *     
         */
        public QueryResultMessageRequest getQueryResultMessageRequest() {
            return queryResultMessageRequest;
        }

        /**
         * Sets the value of the queryResultMessageRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryResultMessageRequest }
         *     
         */
        public void setQueryResultMessageRequest(QueryResultMessageRequest value) {
            this.queryResultMessageRequest = value;
        }

        /**
         * Gets the value of the updateTransactionStatusRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateTransactionStatusRequest }
         *     
         */
        public UpdateTransactionStatusRequest getUpdateTransactionStatusRequest() {
            return updateTransactionStatusRequest;
        }

        /**
         * Sets the value of the updateTransactionStatusRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateTransactionStatusRequest }
         *     
         */
        public void setUpdateTransactionStatusRequest(UpdateTransactionStatusRequest value) {
            this.updateTransactionStatusRequest = value;
        }

        /**
         * Gets the value of the changeCustomerPINRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeCustomerPINRequest }
         *     
         */
        public ChangeCustomerPINRequest getChangeCustomerPINRequest() {
            return changeCustomerPINRequest;
        }

        /**
         * Sets the value of the changeCustomerPINRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeCustomerPINRequest }
         *     
         */
        public void setChangeCustomerPINRequest(ChangeCustomerPINRequest value) {
            this.changeCustomerPINRequest = value;
        }

        /**
         * Gets the value of the changeOrgOperatorPINRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeOrgOperatorPINRequest }
         *     
         */
        public ChangeOrgOperatorPINRequest getChangeOrgOperatorPINRequest() {
            return changeOrgOperatorPINRequest;
        }

        /**
         * Sets the value of the changeOrgOperatorPINRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeOrgOperatorPINRequest }
         *     
         */
        public void setChangeOrgOperatorPINRequest(ChangeOrgOperatorPINRequest value) {
            this.changeOrgOperatorPINRequest = value;
        }

        /**
         * Gets the value of the changeCustomerSecretWordRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeCustomerSecretWordRequest }
         *     
         */
        public ChangeCustomerSecretWordRequest getChangeCustomerSecretWordRequest() {
            return changeCustomerSecretWordRequest;
        }

        /**
         * Sets the value of the changeCustomerSecretWordRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeCustomerSecretWordRequest }
         *     
         */
        public void setChangeCustomerSecretWordRequest(ChangeCustomerSecretWordRequest value) {
            this.changeCustomerSecretWordRequest = value;
        }

        /**
         * Gets the value of the changeOrgOperatorSecretWordRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeOrgOperatorSecretWordRequest }
         *     
         */
        public ChangeOrgOperatorSecretWordRequest getChangeOrgOperatorSecretWordRequest() {
            return changeOrgOperatorSecretWordRequest;
        }

        /**
         * Sets the value of the changeOrgOperatorSecretWordRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeOrgOperatorSecretWordRequest }
         *     
         */
        public void setChangeOrgOperatorSecretWordRequest(ChangeOrgOperatorSecretWordRequest value) {
            this.changeOrgOperatorSecretWordRequest = value;
        }

        /**
         * Gets the value of the changeCustomerLanguageRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeCustomerLanguageRequest }
         *     
         */
        public ChangeCustomerLanguageRequest getChangeCustomerLanguageRequest() {
            return changeCustomerLanguageRequest;
        }

        /**
         * Sets the value of the changeCustomerLanguageRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeCustomerLanguageRequest }
         *     
         */
        public void setChangeCustomerLanguageRequest(ChangeCustomerLanguageRequest value) {
            this.changeCustomerLanguageRequest = value;
        }

        /**
         * Gets the value of the changeOrgOperatorLanguageRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeOrgOperatorLanguageRequest }
         *     
         */
        public ChangeOrgOperatorLanguageRequest getChangeOrgOperatorLanguageRequest() {
            return changeOrgOperatorLanguageRequest;
        }

        /**
         * Sets the value of the changeOrgOperatorLanguageRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeOrgOperatorLanguageRequest }
         *     
         */
        public void setChangeOrgOperatorLanguageRequest(ChangeOrgOperatorLanguageRequest value) {
            this.changeOrgOperatorLanguageRequest = value;
        }

        /**
         * Gets the value of the changeSPOperatorLanguageRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeSPOperatorLanguageRequest }
         *     
         */
        public ChangeSPOperatorLanguageRequest getChangeSPOperatorLanguageRequest() {
            return changeSPOperatorLanguageRequest;
        }

        /**
         * Sets the value of the changeSPOperatorLanguageRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeSPOperatorLanguageRequest }
         *     
         */
        public void setChangeSPOperatorLanguageRequest(ChangeSPOperatorLanguageRequest value) {
            this.changeSPOperatorLanguageRequest = value;
        }

        /**
         * Gets the value of the changeOrgnNameRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeOrgnNameRequest }
         *     
         */
        public ChangeOrgnNameRequest getChangeOrgnNameRequest() {
            return changeOrgnNameRequest;
        }

        /**
         * Sets the value of the changeOrgnNameRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeOrgnNameRequest }
         *     
         */
        public void setChangeOrgnNameRequest(ChangeOrgnNameRequest value) {
            this.changeOrgnNameRequest = value;
        }

        /**
         * Gets the value of the activateCustomerRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ActivateCustomerRequest }
         *     
         */
        public ActivateCustomerRequest getActivateCustomerRequest() {
            return activateCustomerRequest;
        }

        /**
         * Sets the value of the activateCustomerRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ActivateCustomerRequest }
         *     
         */
        public void setActivateCustomerRequest(ActivateCustomerRequest value) {
            this.activateCustomerRequest = value;
        }

        /**
         * Gets the value of the activateTillRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ActivateTillRequest }
         *     
         */
        public ActivateTillRequest getActivateTillRequest() {
            return activateTillRequest;
        }

        /**
         * Sets the value of the activateTillRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ActivateTillRequest }
         *     
         */
        public void setActivateTillRequest(ActivateTillRequest value) {
            this.activateTillRequest = value;
        }

        /**
         * Gets the value of the addCustomerBeneficiaryRequest property.
         * 
         * @return
         *     possible object is
         *     {@link AddCustomerBeneficiaryRequest }
         *     
         */
        public AddCustomerBeneficiaryRequest getAddCustomerBeneficiaryRequest() {
            return addCustomerBeneficiaryRequest;
        }

        /**
         * Sets the value of the addCustomerBeneficiaryRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link AddCustomerBeneficiaryRequest }
         *     
         */
        public void setAddCustomerBeneficiaryRequest(AddCustomerBeneficiaryRequest value) {
            this.addCustomerBeneficiaryRequest = value;
        }

        /**
         * Gets the value of the addOrgBeneficiaryRequest property.
         * 
         * @return
         *     possible object is
         *     {@link AddOrgBeneficiaryRequest }
         *     
         */
        public AddOrgBeneficiaryRequest getAddOrgBeneficiaryRequest() {
            return addOrgBeneficiaryRequest;
        }

        /**
         * Sets the value of the addOrgBeneficiaryRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link AddOrgBeneficiaryRequest }
         *     
         */
        public void setAddOrgBeneficiaryRequest(AddOrgBeneficiaryRequest value) {
            this.addOrgBeneficiaryRequest = value;
        }

        /**
         * Gets the value of the deleteCustomerBeneficiaryRequest property.
         * 
         * @return
         *     possible object is
         *     {@link DeleteCustomerBeneficiaryRequest }
         *     
         */
        public DeleteCustomerBeneficiaryRequest getDeleteCustomerBeneficiaryRequest() {
            return deleteCustomerBeneficiaryRequest;
        }

        /**
         * Sets the value of the deleteCustomerBeneficiaryRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link DeleteCustomerBeneficiaryRequest }
         *     
         */
        public void setDeleteCustomerBeneficiaryRequest(DeleteCustomerBeneficiaryRequest value) {
            this.deleteCustomerBeneficiaryRequest = value;
        }

        /**
         * Gets the value of the deleteOrgBeneficiaryRequest property.
         * 
         * @return
         *     possible object is
         *     {@link DeleteOrgBeneficiaryRequest }
         *     
         */
        public DeleteOrgBeneficiaryRequest getDeleteOrgBeneficiaryRequest() {
            return deleteOrgBeneficiaryRequest;
        }

        /**
         * Sets the value of the deleteOrgBeneficiaryRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link DeleteOrgBeneficiaryRequest }
         *     
         */
        public void setDeleteOrgBeneficiaryRequest(DeleteOrgBeneficiaryRequest value) {
            this.deleteOrgBeneficiaryRequest = value;
        }

        /**
         * Gets the value of the lookupCustomerBeneficiaryRequest property.
         * 
         * @return
         *     possible object is
         *     {@link LookupCustomerBeneficiaryRequest }
         *     
         */
        public LookupCustomerBeneficiaryRequest getLookupCustomerBeneficiaryRequest() {
            return lookupCustomerBeneficiaryRequest;
        }

        /**
         * Sets the value of the lookupCustomerBeneficiaryRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link LookupCustomerBeneficiaryRequest }
         *     
         */
        public void setLookupCustomerBeneficiaryRequest(LookupCustomerBeneficiaryRequest value) {
            this.lookupCustomerBeneficiaryRequest = value;
        }

        /**
         * Gets the value of the lookupOrgBeneficiaryRequest property.
         * 
         * @return
         *     possible object is
         *     {@link LookupOrgBeneficiaryRequest }
         *     
         */
        public LookupOrgBeneficiaryRequest getLookupOrgBeneficiaryRequest() {
            return lookupOrgBeneficiaryRequest;
        }

        /**
         * Sets the value of the lookupOrgBeneficiaryRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link LookupOrgBeneficiaryRequest }
         *     
         */
        public void setLookupOrgBeneficiaryRequest(LookupOrgBeneficiaryRequest value) {
            this.lookupOrgBeneficiaryRequest = value;
        }

        /**
         * Gets the value of the addGroupBeneficiaryRequest property.
         * 
         * @return
         *     possible object is
         *     {@link AddGroupBeneficiaryRequest }
         *     
         */
        public AddGroupBeneficiaryRequest getAddGroupBeneficiaryRequest() {
            return addGroupBeneficiaryRequest;
        }

        /**
         * Sets the value of the addGroupBeneficiaryRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link AddGroupBeneficiaryRequest }
         *     
         */
        public void setAddGroupBeneficiaryRequest(AddGroupBeneficiaryRequest value) {
            this.addGroupBeneficiaryRequest = value;
        }

        /**
         * Gets the value of the deleteGroupBeneficiaryRequest property.
         * 
         * @return
         *     possible object is
         *     {@link DeleteGroupBeneficiaryRequest }
         *     
         */
        public DeleteGroupBeneficiaryRequest getDeleteGroupBeneficiaryRequest() {
            return deleteGroupBeneficiaryRequest;
        }

        /**
         * Sets the value of the deleteGroupBeneficiaryRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link DeleteGroupBeneficiaryRequest }
         *     
         */
        public void setDeleteGroupBeneficiaryRequest(DeleteGroupBeneficiaryRequest value) {
            this.deleteGroupBeneficiaryRequest = value;
        }

        /**
         * Gets the value of the lookupGroupBeneficiaryRequest property.
         * 
         * @return
         *     possible object is
         *     {@link LookupGroupBeneficiaryRequest }
         *     
         */
        public LookupGroupBeneficiaryRequest getLookupGroupBeneficiaryRequest() {
            return lookupGroupBeneficiaryRequest;
        }

        /**
         * Sets the value of the lookupGroupBeneficiaryRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link LookupGroupBeneficiaryRequest }
         *     
         */
        public void setLookupGroupBeneficiaryRequest(LookupGroupBeneficiaryRequest value) {
            this.lookupGroupBeneficiaryRequest = value;
        }

        /**
         * Gets the value of the recipientLookUpRequest property.
         * 
         * @return
         *     possible object is
         *     {@link RecipientLookUpRequest }
         *     
         */
        public RecipientLookUpRequest getRecipientLookUpRequest() {
            return recipientLookUpRequest;
        }

        /**
         * Sets the value of the recipientLookUpRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link RecipientLookUpRequest }
         *     
         */
        public void setRecipientLookUpRequest(RecipientLookUpRequest value) {
            this.recipientLookUpRequest = value;
        }

        /**
         * Gets the value of the bulkTaskRequest property.
         * 
         * @return
         *     possible object is
         *     {@link BulkTaskRequest }
         *     
         */
        public BulkTaskRequest getBulkTaskRequest() {
            return bulkTaskRequest;
        }

        /**
         * Sets the value of the bulkTaskRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link BulkTaskRequest }
         *     
         */
        public void setBulkTaskRequest(BulkTaskRequest value) {
            this.bulkTaskRequest = value;
        }

        /**
         * Gets the value of the smsvcSendRequest property.
         * 
         * @return
         *     possible object is
         *     {@link SMSVCSendRequest }
         *     
         */
        public SMSVCSendRequest getSMSVCSendRequest() {
            return smsvcSendRequest;
        }

        /**
         * Sets the value of the smsvcSendRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link SMSVCSendRequest }
         *     
         */
        public void setSMSVCSendRequest(SMSVCSendRequest value) {
            this.smsvcSendRequest = value;
        }

        /**
         * Gets the value of the changeTillDefaultOperatorIDRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeTillDefaultOperatorIDRequest }
         *     
         */
        public ChangeTillDefaultOperatorIDRequest getChangeTillDefaultOperatorIDRequest() {
            return changeTillDefaultOperatorIDRequest;
        }

        /**
         * Sets the value of the changeTillDefaultOperatorIDRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeTillDefaultOperatorIDRequest }
         *     
         */
        public void setChangeTillDefaultOperatorIDRequest(ChangeTillDefaultOperatorIDRequest value) {
            this.changeTillDefaultOperatorIDRequest = value;
        }

        /**
         * Gets the value of the customerGetStartPINRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CustomerGetStartPINRequest }
         *     
         */
        public CustomerGetStartPINRequest getCustomerGetStartPINRequest() {
            return customerGetStartPINRequest;
        }

        /**
         * Sets the value of the customerGetStartPINRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CustomerGetStartPINRequest }
         *     
         */
        public void setCustomerGetStartPINRequest(CustomerGetStartPINRequest value) {
            this.customerGetStartPINRequest = value;
        }

        /**
         * Gets the value of the queryGroupBalanceRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryGroupBalanceRequest }
         *     
         */
        public QueryGroupBalanceRequest getQueryGroupBalanceRequest() {
            return queryGroupBalanceRequest;
        }

        /**
         * Sets the value of the queryGroupBalanceRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryGroupBalanceRequest }
         *     
         */
        public void setQueryGroupBalanceRequest(QueryGroupBalanceRequest value) {
            this.queryGroupBalanceRequest = value;
        }

        /**
         * Gets the value of the queryGroupAccountStatementsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryGroupAccountStatementsRequest }
         *     
         */
        public QueryGroupAccountStatementsRequest getQueryGroupAccountStatementsRequest() {
            return queryGroupAccountStatementsRequest;
        }

        /**
         * Sets the value of the queryGroupAccountStatementsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryGroupAccountStatementsRequest }
         *     
         */
        public void setQueryGroupAccountStatementsRequest(QueryGroupAccountStatementsRequest value) {
            this.queryGroupAccountStatementsRequest = value;
        }

        /**
         * Gets the value of the queryGroupTransactionsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryGroupTransactionsRequest }
         *     
         */
        public QueryGroupTransactionsRequest getQueryGroupTransactionsRequest() {
            return queryGroupTransactionsRequest;
        }

        /**
         * Sets the value of the queryGroupTransactionsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryGroupTransactionsRequest }
         *     
         */
        public void setQueryGroupTransactionsRequest(QueryGroupTransactionsRequest value) {
            this.queryGroupTransactionsRequest = value;
        }

        /**
         * Gets the value of the queryCustomerPointsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustomerPointsRequest }
         *     
         */
        public QueryCustomerPointsRequest getQueryCustomerPointsRequest() {
            return queryCustomerPointsRequest;
        }

        /**
         * Sets the value of the queryCustomerPointsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustomerPointsRequest }
         *     
         */
        public void setQueryCustomerPointsRequest(QueryCustomerPointsRequest value) {
            this.queryCustomerPointsRequest = value;
        }

        /**
         * Gets the value of the queryCustomerPointsLogRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustomerPointsLogRequest }
         *     
         */
        public QueryCustomerPointsLogRequest getQueryCustomerPointsLogRequest() {
            return queryCustomerPointsLogRequest;
        }

        /**
         * Sets the value of the queryCustomerPointsLogRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustomerPointsLogRequest }
         *     
         */
        public void setQueryCustomerPointsLogRequest(QueryCustomerPointsLogRequest value) {
            this.queryCustomerPointsLogRequest = value;
        }

        /**
         * Gets the value of the adjustCustomerPointsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link AdjustCustomerPointsRequest }
         *     
         */
        public AdjustCustomerPointsRequest getAdjustCustomerPointsRequest() {
            return adjustCustomerPointsRequest;
        }

        /**
         * Sets the value of the adjustCustomerPointsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link AdjustCustomerPointsRequest }
         *     
         */
        public void setAdjustCustomerPointsRequest(AdjustCustomerPointsRequest value) {
            this.adjustCustomerPointsRequest = value;
        }

        /**
         * Gets the value of the queryOrganizationPointsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrganizationPointsRequest }
         *     
         */
        public QueryOrganizationPointsRequest getQueryOrganizationPointsRequest() {
            return queryOrganizationPointsRequest;
        }

        /**
         * Sets the value of the queryOrganizationPointsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrganizationPointsRequest }
         *     
         */
        public void setQueryOrganizationPointsRequest(QueryOrganizationPointsRequest value) {
            this.queryOrganizationPointsRequest = value;
        }

        /**
         * Gets the value of the queryOrganizationPointsLogRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrganizationPointsLogRequest }
         *     
         */
        public QueryOrganizationPointsLogRequest getQueryOrganizationPointsLogRequest() {
            return queryOrganizationPointsLogRequest;
        }

        /**
         * Sets the value of the queryOrganizationPointsLogRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrganizationPointsLogRequest }
         *     
         */
        public void setQueryOrganizationPointsLogRequest(QueryOrganizationPointsLogRequest value) {
            this.queryOrganizationPointsLogRequest = value;
        }

        /**
         * Gets the value of the adjustOrganizationPointsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link AdjustOrganizationPointsRequest }
         *     
         */
        public AdjustOrganizationPointsRequest getAdjustOrganizationPointsRequest() {
            return adjustOrganizationPointsRequest;
        }

        /**
         * Sets the value of the adjustOrganizationPointsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link AdjustOrganizationPointsRequest }
         *     
         */
        public void setAdjustOrganizationPointsRequest(AdjustOrganizationPointsRequest value) {
            this.adjustOrganizationPointsRequest = value;
        }

        /**
         * Gets the value of the createGroupRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CreateGroupRequest }
         *     
         */
        public CreateGroupRequest getCreateGroupRequest() {
            return createGroupRequest;
        }

        /**
         * Sets the value of the createGroupRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateGroupRequest }
         *     
         */
        public void setCreateGroupRequest(CreateGroupRequest value) {
            this.createGroupRequest = value;
        }

        /**
         * Gets the value of the createGroupByCustomerRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CreateGroupByCustomerRequest }
         *     
         */
        public CreateGroupByCustomerRequest getCreateGroupByCustomerRequest() {
            return createGroupByCustomerRequest;
        }

        /**
         * Sets the value of the createGroupByCustomerRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateGroupByCustomerRequest }
         *     
         */
        public void setCreateGroupByCustomerRequest(CreateGroupByCustomerRequest value) {
            this.createGroupByCustomerRequest = value;
        }

        /**
         * Gets the value of the updateGroupKYCRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateGroupKYCRequest }
         *     
         */
        public UpdateGroupKYCRequest getUpdateGroupKYCRequest() {
            return updateGroupKYCRequest;
        }

        /**
         * Sets the value of the updateGroupKYCRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateGroupKYCRequest }
         *     
         */
        public void setUpdateGroupKYCRequest(UpdateGroupKYCRequest value) {
            this.updateGroupKYCRequest = value;
        }

        /**
         * Gets the value of the changeGroupStatusRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeGroupStatusRequest }
         *     
         */
        public ChangeGroupStatusRequest getChangeGroupStatusRequest() {
            return changeGroupStatusRequest;
        }

        /**
         * Sets the value of the changeGroupStatusRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeGroupStatusRequest }
         *     
         */
        public void setChangeGroupStatusRequest(ChangeGroupStatusRequest value) {
            this.changeGroupStatusRequest = value;
        }

        /**
         * Gets the value of the addGroupMemberRequest property.
         * 
         * @return
         *     possible object is
         *     {@link AddGroupMemberRequest }
         *     
         */
        public AddGroupMemberRequest getAddGroupMemberRequest() {
            return addGroupMemberRequest;
        }

        /**
         * Sets the value of the addGroupMemberRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link AddGroupMemberRequest }
         *     
         */
        public void setAddGroupMemberRequest(AddGroupMemberRequest value) {
            this.addGroupMemberRequest = value;
        }

        /**
         * Gets the value of the addGroupMemberByGroupLeaderRequest property.
         * 
         * @return
         *     possible object is
         *     {@link AddGroupMemberByGroupLeaderRequest }
         *     
         */
        public AddGroupMemberByGroupLeaderRequest getAddGroupMemberByGroupLeaderRequest() {
            return addGroupMemberByGroupLeaderRequest;
        }

        /**
         * Sets the value of the addGroupMemberByGroupLeaderRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link AddGroupMemberByGroupLeaderRequest }
         *     
         */
        public void setAddGroupMemberByGroupLeaderRequest(AddGroupMemberByGroupLeaderRequest value) {
            this.addGroupMemberByGroupLeaderRequest = value;
        }

        /**
         * Gets the value of the removeGroupMemberRequest property.
         * 
         * @return
         *     possible object is
         *     {@link RemoveGroupMemberRequest }
         *     
         */
        public RemoveGroupMemberRequest getRemoveGroupMemberRequest() {
            return removeGroupMemberRequest;
        }

        /**
         * Sets the value of the removeGroupMemberRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link RemoveGroupMemberRequest }
         *     
         */
        public void setRemoveGroupMemberRequest(RemoveGroupMemberRequest value) {
            this.removeGroupMemberRequest = value;
        }

        /**
         * Gets the value of the removeGroupMemberByGroupLeaderRequest property.
         * 
         * @return
         *     possible object is
         *     {@link RemoveGroupMemberByGroupLeaderRequest }
         *     
         */
        public RemoveGroupMemberByGroupLeaderRequest getRemoveGroupMemberByGroupLeaderRequest() {
            return removeGroupMemberByGroupLeaderRequest;
        }

        /**
         * Sets the value of the removeGroupMemberByGroupLeaderRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link RemoveGroupMemberByGroupLeaderRequest }
         *     
         */
        public void setRemoveGroupMemberByGroupLeaderRequest(RemoveGroupMemberByGroupLeaderRequest value) {
            this.removeGroupMemberByGroupLeaderRequest = value;
        }

        /**
         * Gets the value of the changeGroupMemberRolesRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeGroupMemberRolesRequest }
         *     
         */
        public ChangeGroupMemberRolesRequest getChangeGroupMemberRolesRequest() {
            return changeGroupMemberRolesRequest;
        }

        /**
         * Sets the value of the changeGroupMemberRolesRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeGroupMemberRolesRequest }
         *     
         */
        public void setChangeGroupMemberRolesRequest(ChangeGroupMemberRolesRequest value) {
            this.changeGroupMemberRolesRequest = value;
        }

        /**
         * Gets the value of the changeGroupMemberRolesByGroupLeaderRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeGroupMemberRolesByGroupLeaderRequest }
         *     
         */
        public ChangeGroupMemberRolesByGroupLeaderRequest getChangeGroupMemberRolesByGroupLeaderRequest() {
            return changeGroupMemberRolesByGroupLeaderRequest;
        }

        /**
         * Sets the value of the changeGroupMemberRolesByGroupLeaderRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeGroupMemberRolesByGroupLeaderRequest }
         *     
         */
        public void setChangeGroupMemberRolesByGroupLeaderRequest(ChangeGroupMemberRolesByGroupLeaderRequest value) {
            this.changeGroupMemberRolesByGroupLeaderRequest = value;
        }

        /**
         * Gets the value of the confirmGroupMembershipRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ConfirmGroupMembershipRequest }
         *     
         */
        public ConfirmGroupMembershipRequest getConfirmGroupMembershipRequest() {
            return confirmGroupMembershipRequest;
        }

        /**
         * Sets the value of the confirmGroupMembershipRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ConfirmGroupMembershipRequest }
         *     
         */
        public void setConfirmGroupMembershipRequest(ConfirmGroupMembershipRequest value) {
            this.confirmGroupMembershipRequest = value;
        }

        /**
         * Gets the value of the approveGroupActionOrTransactionRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ApproveGroupActionOrTransactionRequest }
         *     
         */
        public ApproveGroupActionOrTransactionRequest getApproveGroupActionOrTransactionRequest() {
            return approveGroupActionOrTransactionRequest;
        }

        /**
         * Sets the value of the approveGroupActionOrTransactionRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ApproveGroupActionOrTransactionRequest }
         *     
         */
        public void setApproveGroupActionOrTransactionRequest(ApproveGroupActionOrTransactionRequest value) {
            this.approveGroupActionOrTransactionRequest = value;
        }

        /**
         * Gets the value of the searchMyGroupsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link SearchMyGroupsRequest }
         *     
         */
        public SearchMyGroupsRequest getSearchMyGroupsRequest() {
            return searchMyGroupsRequest;
        }

        /**
         * Sets the value of the searchMyGroupsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link SearchMyGroupsRequest }
         *     
         */
        public void setSearchMyGroupsRequest(SearchMyGroupsRequest value) {
            this.searchMyGroupsRequest = value;
        }

        /**
         * Gets the value of the queryGroupInfoRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryGroupInfoRequest }
         *     
         */
        public QueryGroupInfoRequest getQueryGroupInfoRequest() {
            return queryGroupInfoRequest;
        }

        /**
         * Sets the value of the queryGroupInfoRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryGroupInfoRequest }
         *     
         */
        public void setQueryGroupInfoRequest(QueryGroupInfoRequest value) {
            this.queryGroupInfoRequest = value;
        }

        /**
         * Gets the value of the queryGroupKYCRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryGroupKYCRequest }
         *     
         */
        public QueryGroupKYCRequest getQueryGroupKYCRequest() {
            return queryGroupKYCRequest;
        }

        /**
         * Sets the value of the queryGroupKYCRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryGroupKYCRequest }
         *     
         */
        public void setQueryGroupKYCRequest(QueryGroupKYCRequest value) {
            this.queryGroupKYCRequest = value;
        }

        /**
         * Gets the value of the queryGroupProductsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryGroupProductsRequest }
         *     
         */
        public QueryGroupProductsRequest getQueryGroupProductsRequest() {
            return queryGroupProductsRequest;
        }

        /**
         * Sets the value of the queryGroupProductsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryGroupProductsRequest }
         *     
         */
        public void setQueryGroupProductsRequest(QueryGroupProductsRequest value) {
            this.queryGroupProductsRequest = value;
        }

        /**
         * Gets the value of the listGroupMembersRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ListGroupMembersRequest }
         *     
         */
        public ListGroupMembersRequest getListGroupMembersRequest() {
            return listGroupMembersRequest;
        }

        /**
         * Sets the value of the listGroupMembersRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ListGroupMembersRequest }
         *     
         */
        public void setListGroupMembersRequest(ListGroupMembersRequest value) {
            this.listGroupMembersRequest = value;
        }

        /**
         * Gets the value of the listGroupMembersByCustomerRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ListGroupMembersByCustomerRequest }
         *     
         */
        public ListGroupMembersByCustomerRequest getListGroupMembersByCustomerRequest() {
            return listGroupMembersByCustomerRequest;
        }

        /**
         * Sets the value of the listGroupMembersByCustomerRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ListGroupMembersByCustomerRequest }
         *     
         */
        public void setListGroupMembersByCustomerRequest(ListGroupMembersByCustomerRequest value) {
            this.listGroupMembersByCustomerRequest = value;
        }

        /**
         * Gets the value of the changeGroupRuleProfileRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeGroupRuleProfileRequest }
         *     
         */
        public ChangeGroupRuleProfileRequest getChangeGroupRuleProfileRequest() {
            return changeGroupRuleProfileRequest;
        }

        /**
         * Sets the value of the changeGroupRuleProfileRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeGroupRuleProfileRequest }
         *     
         */
        public void setChangeGroupRuleProfileRequest(ChangeGroupRuleProfileRequest value) {
            this.changeGroupRuleProfileRequest = value;
        }

        /**
         * Gets the value of the changeGroupChargeProfileRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeGroupChargeProfileRequest }
         *     
         */
        public ChangeGroupChargeProfileRequest getChangeGroupChargeProfileRequest() {
            return changeGroupChargeProfileRequest;
        }

        /**
         * Sets the value of the changeGroupChargeProfileRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeGroupChargeProfileRequest }
         *     
         */
        public void setChangeGroupChargeProfileRequest(ChangeGroupChargeProfileRequest value) {
            this.changeGroupChargeProfileRequest = value;
        }

        /**
         * Gets the value of the changeGroupAccountRuleProfileRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeGroupAccountRuleProfileRequest }
         *     
         */
        public ChangeGroupAccountRuleProfileRequest getChangeGroupAccountRuleProfileRequest() {
            return changeGroupAccountRuleProfileRequest;
        }

        /**
         * Sets the value of the changeGroupAccountRuleProfileRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeGroupAccountRuleProfileRequest }
         *     
         */
        public void setChangeGroupAccountRuleProfileRequest(ChangeGroupAccountRuleProfileRequest value) {
            this.changeGroupAccountRuleProfileRequest = value;
        }

        /**
         * Gets the value of the identifyCustomerRequest property.
         * 
         * @return
         *     possible object is
         *     {@link IdentifyCustomerRequest }
         *     
         */
        public IdentifyCustomerRequest getIdentifyCustomerRequest() {
            return identifyCustomerRequest;
        }

        /**
         * Sets the value of the identifyCustomerRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link IdentifyCustomerRequest }
         *     
         */
        public void setIdentifyCustomerRequest(IdentifyCustomerRequest value) {
            this.identifyCustomerRequest = value;
        }

        /**
         * Gets the value of the raiseDisputedTxnReversalRequest property.
         * 
         * @return
         *     possible object is
         *     {@link RaiseDisputedTxnReversalRequest }
         *     
         */
        public RaiseDisputedTxnReversalRequest getRaiseDisputedTxnReversalRequest() {
            return raiseDisputedTxnReversalRequest;
        }

        /**
         * Sets the value of the raiseDisputedTxnReversalRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link RaiseDisputedTxnReversalRequest }
         *     
         */
        public void setRaiseDisputedTxnReversalRequest(RaiseDisputedTxnReversalRequest value) {
            this.raiseDisputedTxnReversalRequest = value;
        }

        /**
         * Gets the value of the cancelIssuedVoucherRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CancelIssuedVoucherRequest }
         *     
         */
        public CancelIssuedVoucherRequest getCancelIssuedVoucherRequest() {
            return cancelIssuedVoucherRequest;
        }

        /**
         * Sets the value of the cancelIssuedVoucherRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CancelIssuedVoucherRequest }
         *     
         */
        public void setCancelIssuedVoucherRequest(CancelIssuedVoucherRequest value) {
            this.cancelIssuedVoucherRequest = value;
        }

        /**
         * Gets the value of the createCustomerBundleRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CreateCustomerBundleRequest }
         *     
         */
        public CreateCustomerBundleRequest getCreateCustomerBundleRequest() {
            return createCustomerBundleRequest;
        }

        /**
         * Sets the value of the createCustomerBundleRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateCustomerBundleRequest }
         *     
         */
        public void setCreateCustomerBundleRequest(CreateCustomerBundleRequest value) {
            this.createCustomerBundleRequest = value;
        }

        /**
         * Gets the value of the createOrganizationBundleRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CreateOrganizationBundleRequest }
         *     
         */
        public CreateOrganizationBundleRequest getCreateOrganizationBundleRequest() {
            return createOrganizationBundleRequest;
        }

        /**
         * Sets the value of the createOrganizationBundleRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateOrganizationBundleRequest }
         *     
         */
        public void setCreateOrganizationBundleRequest(CreateOrganizationBundleRequest value) {
            this.createOrganizationBundleRequest = value;
        }

        /**
         * Gets the value of the createExternalProviderBundleRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CreateExternalProviderBundleRequest }
         *     
         */
        public CreateExternalProviderBundleRequest getCreateExternalProviderBundleRequest() {
            return createExternalProviderBundleRequest;
        }

        /**
         * Sets the value of the createExternalProviderBundleRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateExternalProviderBundleRequest }
         *     
         */
        public void setCreateExternalProviderBundleRequest(CreateExternalProviderBundleRequest value) {
            this.createExternalProviderBundleRequest = value;
        }

        /**
         * Gets the value of the createGroupBundleRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CreateGroupBundleRequest }
         *     
         */
        public CreateGroupBundleRequest getCreateGroupBundleRequest() {
            return createGroupBundleRequest;
        }

        /**
         * Sets the value of the createGroupBundleRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateGroupBundleRequest }
         *     
         */
        public void setCreateGroupBundleRequest(CreateGroupBundleRequest value) {
            this.createGroupBundleRequest = value;
        }

        /**
         * Gets the value of the createBankAccountRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CreateBankAccountRequest }
         *     
         */
        public CreateBankAccountRequest getCreateBankAccountRequest() {
            return createBankAccountRequest;
        }

        /**
         * Sets the value of the createBankAccountRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateBankAccountRequest }
         *     
         */
        public void setCreateBankAccountRequest(CreateBankAccountRequest value) {
            this.createBankAccountRequest = value;
        }

        /**
         * Gets the value of the queryIdentityBundleRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryIdentityBundleRequest }
         *     
         */
        public QueryIdentityBundleRequest getQueryIdentityBundleRequest() {
            return queryIdentityBundleRequest;
        }

        /**
         * Sets the value of the queryIdentityBundleRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryIdentityBundleRequest }
         *     
         */
        public void setQueryIdentityBundleRequest(QueryIdentityBundleRequest value) {
            this.queryIdentityBundleRequest = value;
        }

        /**
         * Gets the value of the deleteBankAccountRequest property.
         * 
         * @return
         *     possible object is
         *     {@link DeleteBankAccountRequest }
         *     
         */
        public DeleteBankAccountRequest getDeleteBankAccountRequest() {
            return deleteBankAccountRequest;
        }

        /**
         * Sets the value of the deleteBankAccountRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link DeleteBankAccountRequest }
         *     
         */
        public void setDeleteBankAccountRequest(DeleteBankAccountRequest value) {
            this.deleteBankAccountRequest = value;
        }

        /**
         * Gets the value of the setDefaultBankAccountRequest property.
         * 
         * @return
         *     possible object is
         *     {@link SetDefaultBankAccountRequest }
         *     
         */
        public SetDefaultBankAccountRequest getSetDefaultBankAccountRequest() {
            return setDefaultBankAccountRequest;
        }

        /**
         * Sets the value of the setDefaultBankAccountRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link SetDefaultBankAccountRequest }
         *     
         */
        public void setSetDefaultBankAccountRequest(SetDefaultBankAccountRequest value) {
            this.setDefaultBankAccountRequest = value;
        }

        /**
         * Gets the value of the createDirectDebitMandateByPayeeRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CreateDirectDebitMandateByPayeeRequest }
         *     
         */
        public CreateDirectDebitMandateByPayeeRequest getCreateDirectDebitMandateByPayeeRequest() {
            return createDirectDebitMandateByPayeeRequest;
        }

        /**
         * Sets the value of the createDirectDebitMandateByPayeeRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateDirectDebitMandateByPayeeRequest }
         *     
         */
        public void setCreateDirectDebitMandateByPayeeRequest(CreateDirectDebitMandateByPayeeRequest value) {
            this.createDirectDebitMandateByPayeeRequest = value;
        }

        /**
         * Gets the value of the createDirectDebitMandateByPayerRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CreateDirectDebitMandateByPayerRequest }
         *     
         */
        public CreateDirectDebitMandateByPayerRequest getCreateDirectDebitMandateByPayerRequest() {
            return createDirectDebitMandateByPayerRequest;
        }

        /**
         * Sets the value of the createDirectDebitMandateByPayerRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateDirectDebitMandateByPayerRequest }
         *     
         */
        public void setCreateDirectDebitMandateByPayerRequest(CreateDirectDebitMandateByPayerRequest value) {
            this.createDirectDebitMandateByPayerRequest = value;
        }

        /**
         * Gets the value of the activateDirectDebitMandateRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ActivateDirectDebitMandateRequest }
         *     
         */
        public ActivateDirectDebitMandateRequest getActivateDirectDebitMandateRequest() {
            return activateDirectDebitMandateRequest;
        }

        /**
         * Sets the value of the activateDirectDebitMandateRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ActivateDirectDebitMandateRequest }
         *     
         */
        public void setActivateDirectDebitMandateRequest(ActivateDirectDebitMandateRequest value) {
            this.activateDirectDebitMandateRequest = value;
        }

        /**
         * Gets the value of the cancelDirectDebitMandateByPayerRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CancelDirectDebitMandateByPayerRequest }
         *     
         */
        public CancelDirectDebitMandateByPayerRequest getCancelDirectDebitMandateByPayerRequest() {
            return cancelDirectDebitMandateByPayerRequest;
        }

        /**
         * Sets the value of the cancelDirectDebitMandateByPayerRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CancelDirectDebitMandateByPayerRequest }
         *     
         */
        public void setCancelDirectDebitMandateByPayerRequest(CancelDirectDebitMandateByPayerRequest value) {
            this.cancelDirectDebitMandateByPayerRequest = value;
        }

        /**
         * Gets the value of the cancelDirectDebitMandateByPayeeRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CancelDirectDebitMandateByPayeeRequest }
         *     
         */
        public CancelDirectDebitMandateByPayeeRequest getCancelDirectDebitMandateByPayeeRequest() {
            return cancelDirectDebitMandateByPayeeRequest;
        }

        /**
         * Sets the value of the cancelDirectDebitMandateByPayeeRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CancelDirectDebitMandateByPayeeRequest }
         *     
         */
        public void setCancelDirectDebitMandateByPayeeRequest(CancelDirectDebitMandateByPayeeRequest value) {
            this.cancelDirectDebitMandateByPayeeRequest = value;
        }

        /**
         * Gets the value of the reactivateDirectDebitMandateByPayerRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ReactivateDirectDebitMandateByPayerRequest }
         *     
         */
        public ReactivateDirectDebitMandateByPayerRequest getReactivateDirectDebitMandateByPayerRequest() {
            return reactivateDirectDebitMandateByPayerRequest;
        }

        /**
         * Sets the value of the reactivateDirectDebitMandateByPayerRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ReactivateDirectDebitMandateByPayerRequest }
         *     
         */
        public void setReactivateDirectDebitMandateByPayerRequest(ReactivateDirectDebitMandateByPayerRequest value) {
            this.reactivateDirectDebitMandateByPayerRequest = value;
        }

        /**
         * Gets the value of the reactivateDirectDebitMandateByPayeeRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ReactivateDirectDebitMandateByPayeeRequest }
         *     
         */
        public ReactivateDirectDebitMandateByPayeeRequest getReactivateDirectDebitMandateByPayeeRequest() {
            return reactivateDirectDebitMandateByPayeeRequest;
        }

        /**
         * Sets the value of the reactivateDirectDebitMandateByPayeeRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ReactivateDirectDebitMandateByPayeeRequest }
         *     
         */
        public void setReactivateDirectDebitMandateByPayeeRequest(ReactivateDirectDebitMandateByPayeeRequest value) {
            this.reactivateDirectDebitMandateByPayeeRequest = value;
        }

        /**
         * Gets the value of the editDirectDebitMandateByPayerRequest property.
         * 
         * @return
         *     possible object is
         *     {@link EditDirectDebitMandateByPayerRequest }
         *     
         */
        public EditDirectDebitMandateByPayerRequest getEditDirectDebitMandateByPayerRequest() {
            return editDirectDebitMandateByPayerRequest;
        }

        /**
         * Sets the value of the editDirectDebitMandateByPayerRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link EditDirectDebitMandateByPayerRequest }
         *     
         */
        public void setEditDirectDebitMandateByPayerRequest(EditDirectDebitMandateByPayerRequest value) {
            this.editDirectDebitMandateByPayerRequest = value;
        }

        /**
         * Gets the value of the editDirectDebitMandateByPayeeRequest property.
         * 
         * @return
         *     possible object is
         *     {@link EditDirectDebitMandateByPayeeRequest }
         *     
         */
        public EditDirectDebitMandateByPayeeRequest getEditDirectDebitMandateByPayeeRequest() {
            return editDirectDebitMandateByPayeeRequest;
        }

        /**
         * Sets the value of the editDirectDebitMandateByPayeeRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link EditDirectDebitMandateByPayeeRequest }
         *     
         */
        public void setEditDirectDebitMandateByPayeeRequest(EditDirectDebitMandateByPayeeRequest value) {
            this.editDirectDebitMandateByPayeeRequest = value;
        }

        /**
         * Gets the value of the queryDirectDebitMandateByPayerRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryDirectDebitMandateByPayerRequest }
         *     
         */
        public QueryDirectDebitMandateByPayerRequest getQueryDirectDebitMandateByPayerRequest() {
            return queryDirectDebitMandateByPayerRequest;
        }

        /**
         * Sets the value of the queryDirectDebitMandateByPayerRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryDirectDebitMandateByPayerRequest }
         *     
         */
        public void setQueryDirectDebitMandateByPayerRequest(QueryDirectDebitMandateByPayerRequest value) {
            this.queryDirectDebitMandateByPayerRequest = value;
        }

        /**
         * Gets the value of the viewDirectDebitMandateByPayerRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ViewDirectDebitMandateByPayerRequest }
         *     
         */
        public ViewDirectDebitMandateByPayerRequest getViewDirectDebitMandateByPayerRequest() {
            return viewDirectDebitMandateByPayerRequest;
        }

        /**
         * Sets the value of the viewDirectDebitMandateByPayerRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ViewDirectDebitMandateByPayerRequest }
         *     
         */
        public void setViewDirectDebitMandateByPayerRequest(ViewDirectDebitMandateByPayerRequest value) {
            this.viewDirectDebitMandateByPayerRequest = value;
        }

        /**
         * Gets the value of the viewDirectDebitMandateByPayeeRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ViewDirectDebitMandateByPayeeRequest }
         *     
         */
        public ViewDirectDebitMandateByPayeeRequest getViewDirectDebitMandateByPayeeRequest() {
            return viewDirectDebitMandateByPayeeRequest;
        }

        /**
         * Sets the value of the viewDirectDebitMandateByPayeeRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ViewDirectDebitMandateByPayeeRequest }
         *     
         */
        public void setViewDirectDebitMandateByPayeeRequest(ViewDirectDebitMandateByPayeeRequest value) {
            this.viewDirectDebitMandateByPayeeRequest = value;
        }

        /**
         * Gets the value of the deleteIndividualReminderScheduleRequest property.
         * 
         * @return
         *     possible object is
         *     {@link DeleteIndividualReminderScheduleRequest }
         *     
         */
        public DeleteIndividualReminderScheduleRequest getDeleteIndividualReminderScheduleRequest() {
            return deleteIndividualReminderScheduleRequest;
        }

        /**
         * Sets the value of the deleteIndividualReminderScheduleRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link DeleteIndividualReminderScheduleRequest }
         *     
         */
        public void setDeleteIndividualReminderScheduleRequest(DeleteIndividualReminderScheduleRequest value) {
            this.deleteIndividualReminderScheduleRequest = value;
        }

        /**
         * Gets the value of the createReminderScheduleRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CreateReminderScheduleRequest }
         *     
         */
        public CreateReminderScheduleRequest getCreateReminderScheduleRequest() {
            return createReminderScheduleRequest;
        }

        /**
         * Sets the value of the createReminderScheduleRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateReminderScheduleRequest }
         *     
         */
        public void setCreateReminderScheduleRequest(CreateReminderScheduleRequest value) {
            this.createReminderScheduleRequest = value;
        }

        /**
         * Gets the value of the queryReminderScheduleRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryReminderScheduleRequest }
         *     
         */
        public QueryReminderScheduleRequest getQueryReminderScheduleRequest() {
            return queryReminderScheduleRequest;
        }

        /**
         * Sets the value of the queryReminderScheduleRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryReminderScheduleRequest }
         *     
         */
        public void setQueryReminderScheduleRequest(QueryReminderScheduleRequest value) {
            this.queryReminderScheduleRequest = value;
        }

        /**
         * Gets the value of the linkingIdentitiesRequest property.
         * 
         * @return
         *     possible object is
         *     {@link LinkingIdentitiesRequest }
         *     
         */
        public LinkingIdentitiesRequest getLinkingIdentitiesRequest() {
            return linkingIdentitiesRequest;
        }

        /**
         * Sets the value of the linkingIdentitiesRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link LinkingIdentitiesRequest }
         *     
         */
        public void setLinkingIdentitiesRequest(LinkingIdentitiesRequest value) {
            this.linkingIdentitiesRequest = value;
        }

        /**
         * Gets the value of the unlinkIdentitiesRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UnlinkIdentitiesRequest }
         *     
         */
        public UnlinkIdentitiesRequest getUnlinkIdentitiesRequest() {
            return unlinkIdentitiesRequest;
        }

        /**
         * Sets the value of the unlinkIdentitiesRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UnlinkIdentitiesRequest }
         *     
         */
        public void setUnlinkIdentitiesRequest(UnlinkIdentitiesRequest value) {
            this.unlinkIdentitiesRequest = value;
        }

        /**
         * Gets the value of the cchChangeCustKYCRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CCHChangeCustKYCRequest }
         *     
         */
        public CCHChangeCustKYCRequest getCCHChangeCustKYCRequest() {
            return cchChangeCustKYCRequest;
        }

        /**
         * Sets the value of the cchChangeCustKYCRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CCHChangeCustKYCRequest }
         *     
         */
        public void setCCHChangeCustKYCRequest(CCHChangeCustKYCRequest value) {
            this.cchChangeCustKYCRequest = value;
        }

        /**
         * Gets the value of the cchChangeOrgOperatorKYCRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CCHChangeOrgOperatorKYCRequest }
         *     
         */
        public CCHChangeOrgOperatorKYCRequest getCCHChangeOrgOperatorKYCRequest() {
            return cchChangeOrgOperatorKYCRequest;
        }

        /**
         * Sets the value of the cchChangeOrgOperatorKYCRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CCHChangeOrgOperatorKYCRequest }
         *     
         */
        public void setCCHChangeOrgOperatorKYCRequest(CCHChangeOrgOperatorKYCRequest value) {
            this.cchChangeOrgOperatorKYCRequest = value;
        }

        /**
         * Gets the value of the preValidationRequest property.
         * 
         * @return
         *     possible object is
         *     {@link PreValidationRequest }
         *     
         */
        public PreValidationRequest getPreValidationRequest() {
            return preValidationRequest;
        }

        /**
         * Sets the value of the preValidationRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link PreValidationRequest }
         *     
         */
        public void setPreValidationRequest(PreValidationRequest value) {
            this.preValidationRequest = value;
        }

        /**
         * Gets the value of the preValidationConfirmationRequest property.
         * 
         * @return
         *     possible object is
         *     {@link PreValidationConfirmationRequest }
         *     
         */
        public PreValidationConfirmationRequest getPreValidationConfirmationRequest() {
            return preValidationConfirmationRequest;
        }

        /**
         * Sets the value of the preValidationConfirmationRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link PreValidationConfirmationRequest }
         *     
         */
        public void setPreValidationConfirmationRequest(PreValidationConfirmationRequest value) {
            this.preValidationConfirmationRequest = value;
        }

        /**
         * Gets the value of the createOrgLoyaltyAccountRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CreateOrgLoyaltyAccountRequest }
         *     
         */
        public CreateOrgLoyaltyAccountRequest getCreateOrgLoyaltyAccountRequest() {
            return createOrgLoyaltyAccountRequest;
        }

        /**
         * Sets the value of the createOrgLoyaltyAccountRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateOrgLoyaltyAccountRequest }
         *     
         */
        public void setCreateOrgLoyaltyAccountRequest(CreateOrgLoyaltyAccountRequest value) {
            this.createOrgLoyaltyAccountRequest = value;
        }

        /**
         * Gets the value of the createCustLoyaltyAccountRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CreateCustLoyaltyAccountRequest }
         *     
         */
        public CreateCustLoyaltyAccountRequest getCreateCustLoyaltyAccountRequest() {
            return createCustLoyaltyAccountRequest;
        }

        /**
         * Sets the value of the createCustLoyaltyAccountRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateCustLoyaltyAccountRequest }
         *     
         */
        public void setCreateCustLoyaltyAccountRequest(CreateCustLoyaltyAccountRequest value) {
            this.createCustLoyaltyAccountRequest = value;
        }

        /**
         * Gets the value of the createGroupLoyaltyAccountRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CreateGroupLoyaltyAccountRequest }
         *     
         */
        public CreateGroupLoyaltyAccountRequest getCreateGroupLoyaltyAccountRequest() {
            return createGroupLoyaltyAccountRequest;
        }

        /**
         * Sets the value of the createGroupLoyaltyAccountRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CreateGroupLoyaltyAccountRequest }
         *     
         */
        public void setCreateGroupLoyaltyAccountRequest(CreateGroupLoyaltyAccountRequest value) {
            this.createGroupLoyaltyAccountRequest = value;
        }

        /**
         * Gets the value of the customerRegisterCardRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CustomerRegisterCardRequest }
         *     
         */
        public CustomerRegisterCardRequest getCustomerRegisterCardRequest() {
            return customerRegisterCardRequest;
        }

        /**
         * Sets the value of the customerRegisterCardRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CustomerRegisterCardRequest }
         *     
         */
        public void setCustomerRegisterCardRequest(CustomerRegisterCardRequest value) {
            this.customerRegisterCardRequest = value;
        }

        /**
         * Gets the value of the orgRegisterCardRequest property.
         * 
         * @return
         *     possible object is
         *     {@link OrgRegisterCardRequest }
         *     
         */
        public OrgRegisterCardRequest getOrgRegisterCardRequest() {
            return orgRegisterCardRequest;
        }

        /**
         * Sets the value of the orgRegisterCardRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link OrgRegisterCardRequest }
         *     
         */
        public void setOrgRegisterCardRequest(OrgRegisterCardRequest value) {
            this.orgRegisterCardRequest = value;
        }

        /**
         * Gets the value of the groupRegisterCardRequest property.
         * 
         * @return
         *     possible object is
         *     {@link GroupRegisterCardRequest }
         *     
         */
        public GroupRegisterCardRequest getGroupRegisterCardRequest() {
            return groupRegisterCardRequest;
        }

        /**
         * Sets the value of the groupRegisterCardRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link GroupRegisterCardRequest }
         *     
         */
        public void setGroupRegisterCardRequest(GroupRegisterCardRequest value) {
            this.groupRegisterCardRequest = value;
        }

        /**
         * Gets the value of the registerCard4CustomerRequest property.
         * 
         * @return
         *     possible object is
         *     {@link RegisterCard4CustomerRequest }
         *     
         */
        public RegisterCard4CustomerRequest getRegisterCard4CustomerRequest() {
            return registerCard4CustomerRequest;
        }

        /**
         * Sets the value of the registerCard4CustomerRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link RegisterCard4CustomerRequest }
         *     
         */
        public void setRegisterCard4CustomerRequest(RegisterCard4CustomerRequest value) {
            this.registerCard4CustomerRequest = value;
        }

        /**
         * Gets the value of the registerCard4OrgRequest property.
         * 
         * @return
         *     possible object is
         *     {@link RegisterCard4OrgRequest }
         *     
         */
        public RegisterCard4OrgRequest getRegisterCard4OrgRequest() {
            return registerCard4OrgRequest;
        }

        /**
         * Sets the value of the registerCard4OrgRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link RegisterCard4OrgRequest }
         *     
         */
        public void setRegisterCard4OrgRequest(RegisterCard4OrgRequest value) {
            this.registerCard4OrgRequest = value;
        }

        /**
         * Gets the value of the registerCard4GroupRequest property.
         * 
         * @return
         *     possible object is
         *     {@link RegisterCard4GroupRequest }
         *     
         */
        public RegisterCard4GroupRequest getRegisterCard4GroupRequest() {
            return registerCard4GroupRequest;
        }

        /**
         * Sets the value of the registerCard4GroupRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link RegisterCard4GroupRequest }
         *     
         */
        public void setRegisterCard4GroupRequest(RegisterCard4GroupRequest value) {
            this.registerCard4GroupRequest = value;
        }

        /**
         * Gets the value of the customerActivateCardRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CustomerActivateCardRequest }
         *     
         */
        public CustomerActivateCardRequest getCustomerActivateCardRequest() {
            return customerActivateCardRequest;
        }

        /**
         * Sets the value of the customerActivateCardRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CustomerActivateCardRequest }
         *     
         */
        public void setCustomerActivateCardRequest(CustomerActivateCardRequest value) {
            this.customerActivateCardRequest = value;
        }

        /**
         * Gets the value of the orgActivateCardRequest property.
         * 
         * @return
         *     possible object is
         *     {@link OrgActivateCardRequest }
         *     
         */
        public OrgActivateCardRequest getOrgActivateCardRequest() {
            return orgActivateCardRequest;
        }

        /**
         * Sets the value of the orgActivateCardRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link OrgActivateCardRequest }
         *     
         */
        public void setOrgActivateCardRequest(OrgActivateCardRequest value) {
            this.orgActivateCardRequest = value;
        }

        /**
         * Gets the value of the groupActivateCardRequest property.
         * 
         * @return
         *     possible object is
         *     {@link GroupActivateCardRequest }
         *     
         */
        public GroupActivateCardRequest getGroupActivateCardRequest() {
            return groupActivateCardRequest;
        }

        /**
         * Sets the value of the groupActivateCardRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link GroupActivateCardRequest }
         *     
         */
        public void setGroupActivateCardRequest(GroupActivateCardRequest value) {
            this.groupActivateCardRequest = value;
        }

        /**
         * Gets the value of the customerCancelCardRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CustomerCancelCardRequest }
         *     
         */
        public CustomerCancelCardRequest getCustomerCancelCardRequest() {
            return customerCancelCardRequest;
        }

        /**
         * Sets the value of the customerCancelCardRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CustomerCancelCardRequest }
         *     
         */
        public void setCustomerCancelCardRequest(CustomerCancelCardRequest value) {
            this.customerCancelCardRequest = value;
        }

        /**
         * Gets the value of the orgCancelCardRequest property.
         * 
         * @return
         *     possible object is
         *     {@link OrgCancelCardRequest }
         *     
         */
        public OrgCancelCardRequest getOrgCancelCardRequest() {
            return orgCancelCardRequest;
        }

        /**
         * Sets the value of the orgCancelCardRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link OrgCancelCardRequest }
         *     
         */
        public void setOrgCancelCardRequest(OrgCancelCardRequest value) {
            this.orgCancelCardRequest = value;
        }

        /**
         * Gets the value of the groupCancelCardRequest property.
         * 
         * @return
         *     possible object is
         *     {@link GroupCancelCardRequest }
         *     
         */
        public GroupCancelCardRequest getGroupCancelCardRequest() {
            return groupCancelCardRequest;
        }

        /**
         * Sets the value of the groupCancelCardRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link GroupCancelCardRequest }
         *     
         */
        public void setGroupCancelCardRequest(GroupCancelCardRequest value) {
            this.groupCancelCardRequest = value;
        }

        /**
         * Gets the value of the queryCustLoyaltyPointRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustLoyaltyPointRequest }
         *     
         */
        public QueryCustLoyaltyPointRequest getQueryCustLoyaltyPointRequest() {
            return queryCustLoyaltyPointRequest;
        }

        /**
         * Sets the value of the queryCustLoyaltyPointRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustLoyaltyPointRequest }
         *     
         */
        public void setQueryCustLoyaltyPointRequest(QueryCustLoyaltyPointRequest value) {
            this.queryCustLoyaltyPointRequest = value;
        }

        /**
         * Gets the value of the queryOrgLoyaltyPointRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrgLoyaltyPointRequest }
         *     
         */
        public QueryOrgLoyaltyPointRequest getQueryOrgLoyaltyPointRequest() {
            return queryOrgLoyaltyPointRequest;
        }

        /**
         * Sets the value of the queryOrgLoyaltyPointRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrgLoyaltyPointRequest }
         *     
         */
        public void setQueryOrgLoyaltyPointRequest(QueryOrgLoyaltyPointRequest value) {
            this.queryOrgLoyaltyPointRequest = value;
        }

        /**
         * Gets the value of the queryGroupLoyaltyPointRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryGroupLoyaltyPointRequest }
         *     
         */
        public QueryGroupLoyaltyPointRequest getQueryGroupLoyaltyPointRequest() {
            return queryGroupLoyaltyPointRequest;
        }

        /**
         * Sets the value of the queryGroupLoyaltyPointRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryGroupLoyaltyPointRequest }
         *     
         */
        public void setQueryGroupLoyaltyPointRequest(QueryGroupLoyaltyPointRequest value) {
            this.queryGroupLoyaltyPointRequest = value;
        }

        /**
         * Gets the value of the queryLoyaltyConsumerRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryLoyaltyConsumerRequest }
         *     
         */
        public QueryLoyaltyConsumerRequest getQueryLoyaltyConsumerRequest() {
            return queryLoyaltyConsumerRequest;
        }

        /**
         * Sets the value of the queryLoyaltyConsumerRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryLoyaltyConsumerRequest }
         *     
         */
        public void setQueryLoyaltyConsumerRequest(QueryLoyaltyConsumerRequest value) {
            this.queryLoyaltyConsumerRequest = value;
        }

        /**
         * Gets the value of the queryCustLoyaltyPointStatementRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryCustLoyaltyPointStatementRequest }
         *     
         */
        public QueryCustLoyaltyPointStatementRequest getQueryCustLoyaltyPointStatementRequest() {
            return queryCustLoyaltyPointStatementRequest;
        }

        /**
         * Sets the value of the queryCustLoyaltyPointStatementRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryCustLoyaltyPointStatementRequest }
         *     
         */
        public void setQueryCustLoyaltyPointStatementRequest(QueryCustLoyaltyPointStatementRequest value) {
            this.queryCustLoyaltyPointStatementRequest = value;
        }

        /**
         * Gets the value of the queryOrgLoyaltyPointStatementRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryOrgLoyaltyPointStatementRequest }
         *     
         */
        public QueryOrgLoyaltyPointStatementRequest getQueryOrgLoyaltyPointStatementRequest() {
            return queryOrgLoyaltyPointStatementRequest;
        }

        /**
         * Sets the value of the queryOrgLoyaltyPointStatementRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryOrgLoyaltyPointStatementRequest }
         *     
         */
        public void setQueryOrgLoyaltyPointStatementRequest(QueryOrgLoyaltyPointStatementRequest value) {
            this.queryOrgLoyaltyPointStatementRequest = value;
        }

        /**
         * Gets the value of the queryGroupLoyaltyPointStatementRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryGroupLoyaltyPointStatementRequest }
         *     
         */
        public QueryGroupLoyaltyPointStatementRequest getQueryGroupLoyaltyPointStatementRequest() {
            return queryGroupLoyaltyPointStatementRequest;
        }

        /**
         * Sets the value of the queryGroupLoyaltyPointStatementRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryGroupLoyaltyPointStatementRequest }
         *     
         */
        public void setQueryGroupLoyaltyPointStatementRequest(QueryGroupLoyaltyPointStatementRequest value) {
            this.queryGroupLoyaltyPointStatementRequest = value;
        }

        /**
         * Gets the value of the queryLoyaltyConsumerStatementRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryLoyaltyConsumerStatementRequest }
         *     
         */
        public QueryLoyaltyConsumerStatementRequest getQueryLoyaltyConsumerStatementRequest() {
            return queryLoyaltyConsumerStatementRequest;
        }

        /**
         * Sets the value of the queryLoyaltyConsumerStatementRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryLoyaltyConsumerStatementRequest }
         *     
         */
        public void setQueryLoyaltyConsumerStatementRequest(QueryLoyaltyConsumerStatementRequest value) {
            this.queryLoyaltyConsumerStatementRequest = value;
        }

        /**
         * Gets the value of the cchIdentifyCustomerRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CCHIdentifyCustomerRequest }
         *     
         */
        public CCHIdentifyCustomerRequest getCCHIdentifyCustomerRequest() {
            return cchIdentifyCustomerRequest;
        }

        /**
         * Sets the value of the cchIdentifyCustomerRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CCHIdentifyCustomerRequest }
         *     
         */
        public void setCCHIdentifyCustomerRequest(CCHIdentifyCustomerRequest value) {
            this.cchIdentifyCustomerRequest = value;
        }

        /**
         * Gets the value of the cchIdentifyOperatorRequest property.
         * 
         * @return
         *     possible object is
         *     {@link CCHIdentifyOperatorRequest }
         *     
         */
        public CCHIdentifyOperatorRequest getCCHIdentifyOperatorRequest() {
            return cchIdentifyOperatorRequest;
        }

        /**
         * Sets the value of the cchIdentifyOperatorRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link CCHIdentifyOperatorRequest }
         *     
         */
        public void setCCHIdentifyOperatorRequest(CCHIdentifyOperatorRequest value) {
            this.cchIdentifyOperatorRequest = value;
        }

        /**
         * Gets the value of the updateOrgOperatorOwnKYCRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UpdateOrgOperatorOwnKYCRequest }
         *     
         */
        public UpdateOrgOperatorOwnKYCRequest getUpdateOrgOperatorOwnKYCRequest() {
            return updateOrgOperatorOwnKYCRequest;
        }

        /**
         * Sets the value of the updateOrgOperatorOwnKYCRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UpdateOrgOperatorOwnKYCRequest }
         *     
         */
        public void setUpdateOrgOperatorOwnKYCRequest(UpdateOrgOperatorOwnKYCRequest value) {
            this.updateOrgOperatorOwnKYCRequest = value;
        }

        /**
         * Gets the value of the querySavingPlanForCustomerRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QuerySavingPlanForCustomerRequest }
         *     
         */
        public QuerySavingPlanForCustomerRequest getQuerySavingPlanForCustomerRequest() {
            return querySavingPlanForCustomerRequest;
        }

        /**
         * Sets the value of the querySavingPlanForCustomerRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QuerySavingPlanForCustomerRequest }
         *     
         */
        public void setQuerySavingPlanForCustomerRequest(QuerySavingPlanForCustomerRequest value) {
            this.querySavingPlanForCustomerRequest = value;
        }

        /**
         * Gets the value of the querySavingPlanForGroupRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QuerySavingPlanForGroupRequest }
         *     
         */
        public QuerySavingPlanForGroupRequest getQuerySavingPlanForGroupRequest() {
            return querySavingPlanForGroupRequest;
        }

        /**
         * Sets the value of the querySavingPlanForGroupRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QuerySavingPlanForGroupRequest }
         *     
         */
        public void setQuerySavingPlanForGroupRequest(QuerySavingPlanForGroupRequest value) {
            this.querySavingPlanForGroupRequest = value;
        }

        /**
         * Gets the value of the querySavingPlanForOrganizationRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QuerySavingPlanForOrganizationRequest }
         *     
         */
        public QuerySavingPlanForOrganizationRequest getQuerySavingPlanForOrganizationRequest() {
            return querySavingPlanForOrganizationRequest;
        }

        /**
         * Sets the value of the querySavingPlanForOrganizationRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QuerySavingPlanForOrganizationRequest }
         *     
         */
        public void setQuerySavingPlanForOrganizationRequest(QuerySavingPlanForOrganizationRequest value) {
            this.querySavingPlanForOrganizationRequest = value;
        }

        /**
         * Gets the value of the queryTransferPointsFeeRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryTransferPointsFeeRequest }
         *     
         */
        public QueryTransferPointsFeeRequest getQueryTransferPointsFeeRequest() {
            return queryTransferPointsFeeRequest;
        }

        /**
         * Sets the value of the queryTransferPointsFeeRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryTransferPointsFeeRequest }
         *     
         */
        public void setQueryTransferPointsFeeRequest(QueryTransferPointsFeeRequest value) {
            this.queryTransferPointsFeeRequest = value;
        }

        /**
         * Gets the value of the queryRedeemBalanceRateRequest property.
         * 
         * @return
         *     possible object is
         *     {@link QueryRedeemBalanceRateRequest }
         *     
         */
        public QueryRedeemBalanceRateRequest getQueryRedeemBalanceRateRequest() {
            return queryRedeemBalanceRateRequest;
        }

        /**
         * Sets the value of the queryRedeemBalanceRateRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link QueryRedeemBalanceRateRequest }
         *     
         */
        public void setQueryRedeemBalanceRateRequest(QueryRedeemBalanceRateRequest value) {
            this.queryRedeemBalanceRateRequest = value;
        }

        /**
         * Gets the value of the transferPointsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link TransferPointsRequest }
         *     
         */
        public TransferPointsRequest getTransferPointsRequest() {
            return transferPointsRequest;
        }

        /**
         * Sets the value of the transferPointsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link TransferPointsRequest }
         *     
         */
        public void setTransferPointsRequest(TransferPointsRequest value) {
            this.transferPointsRequest = value;
        }

        /**
         * Gets the value of the redeemPointsToGoodsRequest property.
         * 
         * @return
         *     possible object is
         *     {@link RedeemPointsToGoodsRequest }
         *     
         */
        public RedeemPointsToGoodsRequest getRedeemPointsToGoodsRequest() {
            return redeemPointsToGoodsRequest;
        }

        /**
         * Sets the value of the redeemPointsToGoodsRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link RedeemPointsToGoodsRequest }
         *     
         */
        public void setRedeemPointsToGoodsRequest(RedeemPointsToGoodsRequest value) {
            this.redeemPointsToGoodsRequest = value;
        }

        /**
         * Gets the value of the redeemPointsWithVoucherRequest property.
         * 
         * @return
         *     possible object is
         *     {@link RedeemPointsWithVoucherRequest }
         *     
         */
        public RedeemPointsWithVoucherRequest getRedeemPointsWithVoucherRequest() {
            return redeemPointsWithVoucherRequest;
        }

        /**
         * Sets the value of the redeemPointsWithVoucherRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link RedeemPointsWithVoucherRequest }
         *     
         */
        public void setRedeemPointsWithVoucherRequest(RedeemPointsWithVoucherRequest value) {
            this.redeemPointsWithVoucherRequest = value;
        }

        /**
         * Gets the value of the redeemPointsToBalanceRequest property.
         * 
         * @return
         *     possible object is
         *     {@link RedeemPointsToBalanceRequest }
         *     
         */
        public RedeemPointsToBalanceRequest getRedeemPointsToBalanceRequest() {
            return redeemPointsToBalanceRequest;
        }

        /**
         * Sets the value of the redeemPointsToBalanceRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link RedeemPointsToBalanceRequest }
         *     
         */
        public void setRedeemPointsToBalanceRequest(RedeemPointsToBalanceRequest value) {
            this.redeemPointsToBalanceRequest = value;
        }

        /**
         * Gets the value of the subscribeSavingPlanForCustomerRequest property.
         * 
         * @return
         *     possible object is
         *     {@link SubscribeSavingPlanForCustomerRequest }
         *     
         */
        public SubscribeSavingPlanForCustomerRequest getSubscribeSavingPlanForCustomerRequest() {
            return subscribeSavingPlanForCustomerRequest;
        }

        /**
         * Sets the value of the subscribeSavingPlanForCustomerRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link SubscribeSavingPlanForCustomerRequest }
         *     
         */
        public void setSubscribeSavingPlanForCustomerRequest(SubscribeSavingPlanForCustomerRequest value) {
            this.subscribeSavingPlanForCustomerRequest = value;
        }

        /**
         * Gets the value of the subscribeSavingPlanForGroupRequest property.
         * 
         * @return
         *     possible object is
         *     {@link SubscribeSavingPlanForGroupRequest }
         *     
         */
        public SubscribeSavingPlanForGroupRequest getSubscribeSavingPlanForGroupRequest() {
            return subscribeSavingPlanForGroupRequest;
        }

        /**
         * Sets the value of the subscribeSavingPlanForGroupRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link SubscribeSavingPlanForGroupRequest }
         *     
         */
        public void setSubscribeSavingPlanForGroupRequest(SubscribeSavingPlanForGroupRequest value) {
            this.subscribeSavingPlanForGroupRequest = value;
        }

        /**
         * Gets the value of the subscribeSavingPlanForOrgRequest property.
         * 
         * @return
         *     possible object is
         *     {@link SubscribeSavingPlanForOrgRequest }
         *     
         */
        public SubscribeSavingPlanForOrgRequest getSubscribeSavingPlanForOrgRequest() {
            return subscribeSavingPlanForOrgRequest;
        }

        /**
         * Sets the value of the subscribeSavingPlanForOrgRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link SubscribeSavingPlanForOrgRequest }
         *     
         */
        public void setSubscribeSavingPlanForOrgRequest(SubscribeSavingPlanForOrgRequest value) {
            this.subscribeSavingPlanForOrgRequest = value;
        }

        /**
         * Gets the value of the unSubscribeSavingPlanForCustomerRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UnSubscribeSavingPlanForCustomerRequest }
         *     
         */
        public UnSubscribeSavingPlanForCustomerRequest getUnSubscribeSavingPlanForCustomerRequest() {
            return unSubscribeSavingPlanForCustomerRequest;
        }

        /**
         * Sets the value of the unSubscribeSavingPlanForCustomerRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UnSubscribeSavingPlanForCustomerRequest }
         *     
         */
        public void setUnSubscribeSavingPlanForCustomerRequest(UnSubscribeSavingPlanForCustomerRequest value) {
            this.unSubscribeSavingPlanForCustomerRequest = value;
        }

        /**
         * Gets the value of the unSubscribeSavingPlanForGroupRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UnSubscribeSavingPlanForGroupRequest }
         *     
         */
        public UnSubscribeSavingPlanForGroupRequest getUnSubscribeSavingPlanForGroupRequest() {
            return unSubscribeSavingPlanForGroupRequest;
        }

        /**
         * Sets the value of the unSubscribeSavingPlanForGroupRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UnSubscribeSavingPlanForGroupRequest }
         *     
         */
        public void setUnSubscribeSavingPlanForGroupRequest(UnSubscribeSavingPlanForGroupRequest value) {
            this.unSubscribeSavingPlanForGroupRequest = value;
        }

        /**
         * Gets the value of the unSubscribeSavingPlanForOrgRequest property.
         * 
         * @return
         *     possible object is
         *     {@link UnSubscribeSavingPlanForOrgRequest }
         *     
         */
        public UnSubscribeSavingPlanForOrgRequest getUnSubscribeSavingPlanForOrgRequest() {
            return unSubscribeSavingPlanForOrgRequest;
        }

        /**
         * Sets the value of the unSubscribeSavingPlanForOrgRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link UnSubscribeSavingPlanForOrgRequest }
         *     
         */
        public void setUnSubscribeSavingPlanForOrgRequest(UnSubscribeSavingPlanForOrgRequest value) {
            this.unSubscribeSavingPlanForOrgRequest = value;
        }

        /**
         * Gets the value of the validateTokenRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ValidateTokenRequest }
         *     
         */
        public ValidateTokenRequest getValidateTokenRequest() {
            return validateTokenRequest;
        }

        /**
         * Sets the value of the validateTokenRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ValidateTokenRequest }
         *     
         */
        public void setValidateTokenRequest(ValidateTokenRequest value) {
            this.validateTokenRequest = value;
        }

        /**
         * Gets the value of the changeOrgOperatorMSISDNRequest property.
         * 
         * @return
         *     possible object is
         *     {@link ChangeOrgOperatorMSISDNRequest }
         *     
         */
        public ChangeOrgOperatorMSISDNRequest getChangeOrgOperatorMSISDNRequest() {
            return changeOrgOperatorMSISDNRequest;
        }

        /**
         * Sets the value of the changeOrgOperatorMSISDNRequest property.
         * 
         * @param value
         *     allowed object is
         *     {@link ChangeOrgOperatorMSISDNRequest }
         *     
         */
        public void setChangeOrgOperatorMSISDNRequest(ChangeOrgOperatorMSISDNRequest value) {
            this.changeOrgOperatorMSISDNRequest = value;
        }

        /**
         * Gets the value of the referenceData property.
         * 
         * @return
         *     possible object is
         *     {@link Request.Body.ReferenceData }
         *     
         */
        public Request.Body.ReferenceData getReferenceData() {
            return referenceData;
        }

        /**
         * Sets the value of the referenceData property.
         * 
         * @param value
         *     allowed object is
         *     {@link Request.Body.ReferenceData }
         *     
         */
        public void setReferenceData(Request.Body.ReferenceData value) {
            this.referenceData = value;
        }

        /**
         * Gets the value of the remark property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getRemark() {
            return remark;
        }

        /**
         * Sets the value of the remark property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setRemark(String value) {
            this.remark = value;
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
         *         &lt;element name="Initiator"&gt;
         *           &lt;complexType&gt;
         *             &lt;complexContent&gt;
         *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                 &lt;sequence&gt;
         *                   &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
         *                   &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
         *                   &lt;element name="SecurityCredential" type="{http://cps.huawei.com/cpsinterface/common}SecurityCredentialType"/&gt;
         *                   &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
         *                   &lt;element name="InitiatorKYC" minOccurs="0"&gt;
         *                     &lt;complexType&gt;
         *                       &lt;complexContent&gt;
         *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                           &lt;sequence&gt;
         *                             &lt;element name="SimpleKYC" maxOccurs="unbounded" minOccurs="0"&gt;
         *                               &lt;complexType&gt;
         *                                 &lt;complexContent&gt;
         *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                                     &lt;sequence&gt;
         *                                       &lt;element name="KYCFieldName"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="256"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="KYCValue"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="512"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                     &lt;/sequence&gt;
         *                                   &lt;/restriction&gt;
         *                                 &lt;/complexContent&gt;
         *                               &lt;/complexType&gt;
         *                             &lt;/element&gt;
         *                             &lt;element name="IDDetails" minOccurs="0"&gt;
         *                               &lt;complexType&gt;
         *                                 &lt;complexContent&gt;
         *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                                     &lt;sequence&gt;
         *                                       &lt;element name="IDType" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="32"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="IDNumber"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                     &lt;/sequence&gt;
         *                                   &lt;/restriction&gt;
         *                                 &lt;/complexContent&gt;
         *                               &lt;/complexType&gt;
         *                             &lt;/element&gt;
         *                             &lt;element name="ContactDetails" minOccurs="0"&gt;
         *                               &lt;complexType&gt;
         *                                 &lt;complexContent&gt;
         *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                                     &lt;sequence&gt;
         *                                       &lt;element name="ContactType" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="32"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="FirstName" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="LastName" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="SurName" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="PhoneNumber" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="EMail" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="256"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="IDNumber" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                     &lt;/sequence&gt;
         *                                   &lt;/restriction&gt;
         *                                 &lt;/complexContent&gt;
         *                               &lt;/complexType&gt;
         *                             &lt;/element&gt;
         *                             &lt;element name="CertificateDetails" minOccurs="0"&gt;
         *                               &lt;complexType&gt;
         *                                 &lt;complexContent&gt;
         *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                                     &lt;sequence&gt;
         *                                       &lt;element name="CertificateType" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="32"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="CertificateNumber"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                     &lt;/sequence&gt;
         *                                   &lt;/restriction&gt;
         *                                 &lt;/complexContent&gt;
         *                               &lt;/complexType&gt;
         *                             &lt;/element&gt;
         *                           &lt;/sequence&gt;
         *                         &lt;/restriction&gt;
         *                       &lt;/complexContent&gt;
         *                     &lt;/complexType&gt;
         *                   &lt;/element&gt;
         *                   &lt;element name="GPSPosition" minOccurs="0"&gt;
         *                     &lt;simpleType&gt;
         *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                         &lt;maxLength value="32"/&gt;
         *                       &lt;/restriction&gt;
         *                     &lt;/simpleType&gt;
         *                   &lt;/element&gt;
         *                 &lt;/sequence&gt;
         *               &lt;/restriction&gt;
         *             &lt;/complexContent&gt;
         *           &lt;/complexType&gt;
         *         &lt;/element&gt;
         *         &lt;element name="PrimaryParty" minOccurs="0"&gt;
         *           &lt;complexType&gt;
         *             &lt;complexContent&gt;
         *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                 &lt;sequence&gt;
         *                   &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
         *                   &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
         *                   &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
         *                   &lt;element name="PrimaryPartyKYC" minOccurs="0"&gt;
         *                     &lt;complexType&gt;
         *                       &lt;complexContent&gt;
         *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                           &lt;sequence&gt;
         *                             &lt;element name="SimpleKYC" maxOccurs="unbounded" minOccurs="0"&gt;
         *                               &lt;complexType&gt;
         *                                 &lt;complexContent&gt;
         *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                                     &lt;sequence&gt;
         *                                       &lt;element name="KYCFieldName"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="256"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="KYCValue"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="512"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                     &lt;/sequence&gt;
         *                                   &lt;/restriction&gt;
         *                                 &lt;/complexContent&gt;
         *                               &lt;/complexType&gt;
         *                             &lt;/element&gt;
         *                             &lt;element name="IDDetails" minOccurs="0"&gt;
         *                               &lt;complexType&gt;
         *                                 &lt;complexContent&gt;
         *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                                     &lt;sequence&gt;
         *                                       &lt;element name="IDType" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="32"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="IDNumber"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                     &lt;/sequence&gt;
         *                                   &lt;/restriction&gt;
         *                                 &lt;/complexContent&gt;
         *                               &lt;/complexType&gt;
         *                             &lt;/element&gt;
         *                             &lt;element name="ContactDetails" minOccurs="0"&gt;
         *                               &lt;complexType&gt;
         *                                 &lt;complexContent&gt;
         *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                                     &lt;sequence&gt;
         *                                       &lt;element name="ContactType" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="32"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="FirstName" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="LastName" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="SurName" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="PhoneNumber" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="EMail" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="256"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="IDNumber" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                     &lt;/sequence&gt;
         *                                   &lt;/restriction&gt;
         *                                 &lt;/complexContent&gt;
         *                               &lt;/complexType&gt;
         *                             &lt;/element&gt;
         *                             &lt;element name="CertificateDetails" minOccurs="0"&gt;
         *                               &lt;complexType&gt;
         *                                 &lt;complexContent&gt;
         *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                                     &lt;sequence&gt;
         *                                       &lt;element name="CertificateType" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="32"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="CertificateNumber"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                     &lt;/sequence&gt;
         *                                   &lt;/restriction&gt;
         *                                 &lt;/complexContent&gt;
         *                               &lt;/complexType&gt;
         *                             &lt;/element&gt;
         *                           &lt;/sequence&gt;
         *                         &lt;/restriction&gt;
         *                       &lt;/complexContent&gt;
         *                     &lt;/complexType&gt;
         *                   &lt;/element&gt;
         *                 &lt;/sequence&gt;
         *               &lt;/restriction&gt;
         *             &lt;/complexContent&gt;
         *           &lt;/complexType&gt;
         *         &lt;/element&gt;
         *         &lt;element name="ReceiverParty" minOccurs="0"&gt;
         *           &lt;complexType&gt;
         *             &lt;complexContent&gt;
         *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                 &lt;sequence&gt;
         *                   &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
         *                   &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
         *                   &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
         *                   &lt;element name="ReceiverKYC" minOccurs="0"&gt;
         *                     &lt;complexType&gt;
         *                       &lt;complexContent&gt;
         *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                           &lt;sequence&gt;
         *                             &lt;element name="SimpleKYC" maxOccurs="unbounded" minOccurs="0"&gt;
         *                               &lt;complexType&gt;
         *                                 &lt;complexContent&gt;
         *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                                     &lt;sequence&gt;
         *                                       &lt;element name="KYCFieldName"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="256"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="KYCValue"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="512"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                     &lt;/sequence&gt;
         *                                   &lt;/restriction&gt;
         *                                 &lt;/complexContent&gt;
         *                               &lt;/complexType&gt;
         *                             &lt;/element&gt;
         *                             &lt;element name="IDDetails" minOccurs="0"&gt;
         *                               &lt;complexType&gt;
         *                                 &lt;complexContent&gt;
         *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                                     &lt;sequence&gt;
         *                                       &lt;element name="IDType" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="32"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="IDNumber"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                     &lt;/sequence&gt;
         *                                   &lt;/restriction&gt;
         *                                 &lt;/complexContent&gt;
         *                               &lt;/complexType&gt;
         *                             &lt;/element&gt;
         *                             &lt;element name="ContactDetails" minOccurs="0"&gt;
         *                               &lt;complexType&gt;
         *                                 &lt;complexContent&gt;
         *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                                     &lt;sequence&gt;
         *                                       &lt;element name="ContactType" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="32"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="FirstName" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="LastName" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="SurName" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="PhoneNumber" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="EMail" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="256"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="IDNumber" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                     &lt;/sequence&gt;
         *                                   &lt;/restriction&gt;
         *                                 &lt;/complexContent&gt;
         *                               &lt;/complexType&gt;
         *                             &lt;/element&gt;
         *                             &lt;element name="CertificateDetails" minOccurs="0"&gt;
         *                               &lt;complexType&gt;
         *                                 &lt;complexContent&gt;
         *                                   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                                     &lt;sequence&gt;
         *                                       &lt;element name="CertificateType" minOccurs="0"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="32"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                       &lt;element name="CertificateNumber"&gt;
         *                                         &lt;simpleType&gt;
         *                                           &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                                             &lt;maxLength value="64"/&gt;
         *                                           &lt;/restriction&gt;
         *                                         &lt;/simpleType&gt;
         *                                       &lt;/element&gt;
         *                                     &lt;/sequence&gt;
         *                                   &lt;/restriction&gt;
         *                                 &lt;/complexContent&gt;
         *                               &lt;/complexType&gt;
         *                             &lt;/element&gt;
         *                           &lt;/sequence&gt;
         *                         &lt;/restriction&gt;
         *                       &lt;/complexContent&gt;
         *                     &lt;/complexType&gt;
         *                   &lt;/element&gt;
         *                 &lt;/sequence&gt;
         *               &lt;/restriction&gt;
         *             &lt;/complexContent&gt;
         *           &lt;/complexType&gt;
         *         &lt;/element&gt;
         *         &lt;element name="Requester" minOccurs="0"&gt;
         *           &lt;complexType&gt;
         *             &lt;complexContent&gt;
         *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                 &lt;sequence&gt;
         *                   &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
         *                   &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
         *                   &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
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
        @XmlType(name = "", propOrder = {
            "initiator",
            "primaryParty",
            "receiverParty",
            "requester"
        })
        public static class Identity {

            @XmlElement(name = "Initiator", required = true)
            protected Request.Body.Identity.Initiator initiator;
            @XmlElement(name = "PrimaryParty")
            protected Request.Body.Identity.PrimaryParty primaryParty;
            @XmlElement(name = "ReceiverParty")
            protected Request.Body.Identity.ReceiverParty receiverParty;
            @XmlElement(name = "Requester")
            protected Request.Body.Identity.Requester requester;

            /**
             * Gets the value of the initiator property.
             * 
             * @return
             *     possible object is
             *     {@link Request.Body.Identity.Initiator }
             *     
             */
            public Request.Body.Identity.Initiator getInitiator() {
                return initiator;
            }

            /**
             * Sets the value of the initiator property.
             * 
             * @param value
             *     allowed object is
             *     {@link Request.Body.Identity.Initiator }
             *     
             */
            public void setInitiator(Request.Body.Identity.Initiator value) {
                this.initiator = value;
            }

            /**
             * Gets the value of the primaryParty property.
             * 
             * @return
             *     possible object is
             *     {@link Request.Body.Identity.PrimaryParty }
             *     
             */
            public Request.Body.Identity.PrimaryParty getPrimaryParty() {
                return primaryParty;
            }

            /**
             * Sets the value of the primaryParty property.
             * 
             * @param value
             *     allowed object is
             *     {@link Request.Body.Identity.PrimaryParty }
             *     
             */
            public void setPrimaryParty(Request.Body.Identity.PrimaryParty value) {
                this.primaryParty = value;
            }

            /**
             * Gets the value of the receiverParty property.
             * 
             * @return
             *     possible object is
             *     {@link Request.Body.Identity.ReceiverParty }
             *     
             */
            public Request.Body.Identity.ReceiverParty getReceiverParty() {
                return receiverParty;
            }

            /**
             * Sets the value of the receiverParty property.
             * 
             * @param value
             *     allowed object is
             *     {@link Request.Body.Identity.ReceiverParty }
             *     
             */
            public void setReceiverParty(Request.Body.Identity.ReceiverParty value) {
                this.receiverParty = value;
            }

            /**
             * Gets the value of the requester property.
             * 
             * @return
             *     possible object is
             *     {@link Request.Body.Identity.Requester }
             *     
             */
            public Request.Body.Identity.Requester getRequester() {
                return requester;
            }

            /**
             * Sets the value of the requester property.
             * 
             * @param value
             *     allowed object is
             *     {@link Request.Body.Identity.Requester }
             *     
             */
            public void setRequester(Request.Body.Identity.Requester value) {
                this.requester = value;
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
             *         &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
             *         &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
             *         &lt;element name="SecurityCredential" type="{http://cps.huawei.com/cpsinterface/common}SecurityCredentialType"/&gt;
             *         &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
             *         &lt;element name="InitiatorKYC" minOccurs="0"&gt;
             *           &lt;complexType&gt;
             *             &lt;complexContent&gt;
             *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
             *                 &lt;sequence&gt;
             *                   &lt;element name="SimpleKYC" maxOccurs="unbounded" minOccurs="0"&gt;
             *                     &lt;complexType&gt;
             *                       &lt;complexContent&gt;
             *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
             *                           &lt;sequence&gt;
             *                             &lt;element name="KYCFieldName"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="256"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="KYCValue"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="512"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                           &lt;/sequence&gt;
             *                         &lt;/restriction&gt;
             *                       &lt;/complexContent&gt;
             *                     &lt;/complexType&gt;
             *                   &lt;/element&gt;
             *                   &lt;element name="IDDetails" minOccurs="0"&gt;
             *                     &lt;complexType&gt;
             *                       &lt;complexContent&gt;
             *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
             *                           &lt;sequence&gt;
             *                             &lt;element name="IDType" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="32"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="IDNumber"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                           &lt;/sequence&gt;
             *                         &lt;/restriction&gt;
             *                       &lt;/complexContent&gt;
             *                     &lt;/complexType&gt;
             *                   &lt;/element&gt;
             *                   &lt;element name="ContactDetails" minOccurs="0"&gt;
             *                     &lt;complexType&gt;
             *                       &lt;complexContent&gt;
             *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
             *                           &lt;sequence&gt;
             *                             &lt;element name="ContactType" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="32"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="FirstName" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="LastName" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="SurName" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="PhoneNumber" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="EMail" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="256"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="IDNumber" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                           &lt;/sequence&gt;
             *                         &lt;/restriction&gt;
             *                       &lt;/complexContent&gt;
             *                     &lt;/complexType&gt;
             *                   &lt;/element&gt;
             *                   &lt;element name="CertificateDetails" minOccurs="0"&gt;
             *                     &lt;complexType&gt;
             *                       &lt;complexContent&gt;
             *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
             *                           &lt;sequence&gt;
             *                             &lt;element name="CertificateType" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="32"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="CertificateNumber"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                           &lt;/sequence&gt;
             *                         &lt;/restriction&gt;
             *                       &lt;/complexContent&gt;
             *                     &lt;/complexType&gt;
             *                   &lt;/element&gt;
             *                 &lt;/sequence&gt;
             *               &lt;/restriction&gt;
             *             &lt;/complexContent&gt;
             *           &lt;/complexType&gt;
             *         &lt;/element&gt;
             *         &lt;element name="GPSPosition" minOccurs="0"&gt;
             *           &lt;simpleType&gt;
             *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *               &lt;maxLength value="32"/&gt;
             *             &lt;/restriction&gt;
             *           &lt;/simpleType&gt;
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
            @XmlType(name = "", propOrder = {
                "identifierType",
                "identifier",
                "securityCredential",
                "shortCode",
                "initiatorKYC",
                "gpsPosition"
            })
            public static class Initiator {

                @XmlElement(name = "IdentifierType", required = true)
                protected String identifierType;
                @XmlElement(name = "Identifier", required = true)
                protected String identifier;
                @XmlElement(name = "SecurityCredential", required = true)
                protected String securityCredential;
                @XmlElement(name = "ShortCode")
                protected String shortCode;
                @XmlElement(name = "InitiatorKYC")
                protected Request.Body.Identity.Initiator.InitiatorKYC initiatorKYC;
                @XmlElement(name = "GPSPosition")
                protected String gpsPosition;

                /**
                 * Gets the value of the identifierType property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link String }
                 *     
                 */
                public String getIdentifierType() {
                    return identifierType;
                }

                /**
                 * Sets the value of the identifierType property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link String }
                 *     
                 */
                public void setIdentifierType(String value) {
                    this.identifierType = value;
                }

                /**
                 * Gets the value of the identifier property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link String }
                 *     
                 */
                public String getIdentifier() {
                    return identifier;
                }

                /**
                 * Sets the value of the identifier property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link String }
                 *     
                 */
                public void setIdentifier(String value) {
                    this.identifier = value;
                }

                /**
                 * Gets the value of the securityCredential property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link String }
                 *     
                 */
                public String getSecurityCredential() {
                    return securityCredential;
                }

                /**
                 * Sets the value of the securityCredential property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link String }
                 *     
                 */
                public void setSecurityCredential(String value) {
                    this.securityCredential = value;
                }

                /**
                 * Gets the value of the shortCode property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link String }
                 *     
                 */
                public String getShortCode() {
                    return shortCode;
                }

                /**
                 * Sets the value of the shortCode property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link String }
                 *     
                 */
                public void setShortCode(String value) {
                    this.shortCode = value;
                }

                /**
                 * Gets the value of the initiatorKYC property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link Request.Body.Identity.Initiator.InitiatorKYC }
                 *     
                 */
                public Request.Body.Identity.Initiator.InitiatorKYC getInitiatorKYC() {
                    return initiatorKYC;
                }

                /**
                 * Sets the value of the initiatorKYC property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link Request.Body.Identity.Initiator.InitiatorKYC }
                 *     
                 */
                public void setInitiatorKYC(Request.Body.Identity.Initiator.InitiatorKYC value) {
                    this.initiatorKYC = value;
                }

                /**
                 * Gets the value of the gpsPosition property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link String }
                 *     
                 */
                public String getGPSPosition() {
                    return gpsPosition;
                }

                /**
                 * Sets the value of the gpsPosition property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link String }
                 *     
                 */
                public void setGPSPosition(String value) {
                    this.gpsPosition = value;
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
                 *         &lt;element name="SimpleKYC" maxOccurs="unbounded" minOccurs="0"&gt;
                 *           &lt;complexType&gt;
                 *             &lt;complexContent&gt;
                 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
                 *                 &lt;sequence&gt;
                 *                   &lt;element name="KYCFieldName"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="256"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="KYCValue"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="512"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                 &lt;/sequence&gt;
                 *               &lt;/restriction&gt;
                 *             &lt;/complexContent&gt;
                 *           &lt;/complexType&gt;
                 *         &lt;/element&gt;
                 *         &lt;element name="IDDetails" minOccurs="0"&gt;
                 *           &lt;complexType&gt;
                 *             &lt;complexContent&gt;
                 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
                 *                 &lt;sequence&gt;
                 *                   &lt;element name="IDType" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="32"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="IDNumber"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                 &lt;/sequence&gt;
                 *               &lt;/restriction&gt;
                 *             &lt;/complexContent&gt;
                 *           &lt;/complexType&gt;
                 *         &lt;/element&gt;
                 *         &lt;element name="ContactDetails" minOccurs="0"&gt;
                 *           &lt;complexType&gt;
                 *             &lt;complexContent&gt;
                 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
                 *                 &lt;sequence&gt;
                 *                   &lt;element name="ContactType" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="32"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="FirstName" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="LastName" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="SurName" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="PhoneNumber" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="EMail" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="256"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="IDNumber" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                 &lt;/sequence&gt;
                 *               &lt;/restriction&gt;
                 *             &lt;/complexContent&gt;
                 *           &lt;/complexType&gt;
                 *         &lt;/element&gt;
                 *         &lt;element name="CertificateDetails" minOccurs="0"&gt;
                 *           &lt;complexType&gt;
                 *             &lt;complexContent&gt;
                 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
                 *                 &lt;sequence&gt;
                 *                   &lt;element name="CertificateType" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="32"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="CertificateNumber"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
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
                @XmlType(name = "", propOrder = {
                    "simpleKYC",
                    "idDetails",
                    "contactDetails",
                    "certificateDetails"
                })
                public static class InitiatorKYC {

                    @XmlElement(name = "SimpleKYC")
                    protected List<Request.Body.Identity.Initiator.InitiatorKYC.SimpleKYC> simpleKYC;
                    @XmlElement(name = "IDDetails")
                    protected Request.Body.Identity.Initiator.InitiatorKYC.IDDetails idDetails;
                    @XmlElement(name = "ContactDetails")
                    protected Request.Body.Identity.Initiator.InitiatorKYC.ContactDetails contactDetails;
                    @XmlElement(name = "CertificateDetails")
                    protected Request.Body.Identity.Initiator.InitiatorKYC.CertificateDetails certificateDetails;

                    /**
                     * Gets the value of the simpleKYC property.
                     * 
                     * <p>
                     * This accessor method returns a reference to the live list,
                     * not a snapshot. Therefore any modification you make to the
                     * returned list will be present inside the Jakarta XML Binding object.
                     * This is why there is not a <CODE>set</CODE> method for the simpleKYC property.
                     * 
                     * <p>
                     * For example, to add a new item, do as follows:
                     * <pre>
                     *    getSimpleKYC().add(newItem);
                     * </pre>
                     * 
                     * 
                     * <p>
                     * Objects of the following type(s) are allowed in the list
                     * {@link Request.Body.Identity.Initiator.InitiatorKYC.SimpleKYC }
                     * 
                     * 
                     */
                    public List<Request.Body.Identity.Initiator.InitiatorKYC.SimpleKYC> getSimpleKYC() {
                        if (simpleKYC == null) {
                            simpleKYC = new ArrayList<Request.Body.Identity.Initiator.InitiatorKYC.SimpleKYC>();
                        }
                        return this.simpleKYC;
                    }

                    /**
                     * Gets the value of the idDetails property.
                     * 
                     * @return
                     *     possible object is
                     *     {@link Request.Body.Identity.Initiator.InitiatorKYC.IDDetails }
                     *     
                     */
                    public Request.Body.Identity.Initiator.InitiatorKYC.IDDetails getIDDetails() {
                        return idDetails;
                    }

                    /**
                     * Sets the value of the idDetails property.
                     * 
                     * @param value
                     *     allowed object is
                     *     {@link Request.Body.Identity.Initiator.InitiatorKYC.IDDetails }
                     *     
                     */
                    public void setIDDetails(Request.Body.Identity.Initiator.InitiatorKYC.IDDetails value) {
                        this.idDetails = value;
                    }

                    /**
                     * Gets the value of the contactDetails property.
                     * 
                     * @return
                     *     possible object is
                     *     {@link Request.Body.Identity.Initiator.InitiatorKYC.ContactDetails }
                     *     
                     */
                    public Request.Body.Identity.Initiator.InitiatorKYC.ContactDetails getContactDetails() {
                        return contactDetails;
                    }

                    /**
                     * Sets the value of the contactDetails property.
                     * 
                     * @param value
                     *     allowed object is
                     *     {@link Request.Body.Identity.Initiator.InitiatorKYC.ContactDetails }
                     *     
                     */
                    public void setContactDetails(Request.Body.Identity.Initiator.InitiatorKYC.ContactDetails value) {
                        this.contactDetails = value;
                    }

                    /**
                     * Gets the value of the certificateDetails property.
                     * 
                     * @return
                     *     possible object is
                     *     {@link Request.Body.Identity.Initiator.InitiatorKYC.CertificateDetails }
                     *     
                     */
                    public Request.Body.Identity.Initiator.InitiatorKYC.CertificateDetails getCertificateDetails() {
                        return certificateDetails;
                    }

                    /**
                     * Sets the value of the certificateDetails property.
                     * 
                     * @param value
                     *     allowed object is
                     *     {@link Request.Body.Identity.Initiator.InitiatorKYC.CertificateDetails }
                     *     
                     */
                    public void setCertificateDetails(Request.Body.Identity.Initiator.InitiatorKYC.CertificateDetails value) {
                        this.certificateDetails = value;
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
                     *         &lt;element name="CertificateType" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="32"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="CertificateNumber"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
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
                    @XmlType(name = "", propOrder = {
                        "certificateType",
                        "certificateNumber"
                    })
                    public static class CertificateDetails {

                        @XmlElement(name = "CertificateType")
                        protected String certificateType;
                        @XmlElement(name = "CertificateNumber", required = true)
                        protected String certificateNumber;

                        /**
                         * Gets the value of the certificateType property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getCertificateType() {
                            return certificateType;
                        }

                        /**
                         * Sets the value of the certificateType property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setCertificateType(String value) {
                            this.certificateType = value;
                        }

                        /**
                         * Gets the value of the certificateNumber property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getCertificateNumber() {
                            return certificateNumber;
                        }

                        /**
                         * Sets the value of the certificateNumber property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setCertificateNumber(String value) {
                            this.certificateNumber = value;
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
                     *         &lt;element name="ContactType" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="32"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="FirstName" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="LastName" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="SurName" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="PhoneNumber" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="EMail" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="256"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="IDNumber" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
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
                    @XmlType(name = "", propOrder = {
                        "contactType",
                        "firstName",
                        "lastName",
                        "surName",
                        "phoneNumber",
                        "eMail",
                        "idNumber"
                    })
                    public static class ContactDetails {

                        @XmlElement(name = "ContactType")
                        protected String contactType;
                        @XmlElement(name = "FirstName")
                        protected String firstName;
                        @XmlElement(name = "LastName")
                        protected String lastName;
                        @XmlElement(name = "SurName")
                        protected String surName;
                        @XmlElement(name = "PhoneNumber")
                        protected String phoneNumber;
                        @XmlElement(name = "EMail")
                        protected String eMail;
                        @XmlElement(name = "IDNumber")
                        protected String idNumber;

                        /**
                         * Gets the value of the contactType property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getContactType() {
                            return contactType;
                        }

                        /**
                         * Sets the value of the contactType property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setContactType(String value) {
                            this.contactType = value;
                        }

                        /**
                         * Gets the value of the firstName property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getFirstName() {
                            return firstName;
                        }

                        /**
                         * Sets the value of the firstName property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setFirstName(String value) {
                            this.firstName = value;
                        }

                        /**
                         * Gets the value of the lastName property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getLastName() {
                            return lastName;
                        }

                        /**
                         * Sets the value of the lastName property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setLastName(String value) {
                            this.lastName = value;
                        }

                        /**
                         * Gets the value of the surName property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getSurName() {
                            return surName;
                        }

                        /**
                         * Sets the value of the surName property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setSurName(String value) {
                            this.surName = value;
                        }

                        /**
                         * Gets the value of the phoneNumber property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getPhoneNumber() {
                            return phoneNumber;
                        }

                        /**
                         * Sets the value of the phoneNumber property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setPhoneNumber(String value) {
                            this.phoneNumber = value;
                        }

                        /**
                         * Gets the value of the eMail property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getEMail() {
                            return eMail;
                        }

                        /**
                         * Sets the value of the eMail property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setEMail(String value) {
                            this.eMail = value;
                        }

                        /**
                         * Gets the value of the idNumber property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getIDNumber() {
                            return idNumber;
                        }

                        /**
                         * Sets the value of the idNumber property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setIDNumber(String value) {
                            this.idNumber = value;
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
                     *         &lt;element name="IDType" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="32"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="IDNumber"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
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
                    @XmlType(name = "", propOrder = {
                        "idType",
                        "idNumber"
                    })
                    public static class IDDetails {

                        @XmlElement(name = "IDType")
                        protected String idType;
                        @XmlElement(name = "IDNumber", required = true)
                        protected String idNumber;

                        /**
                         * Gets the value of the idType property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getIDType() {
                            return idType;
                        }

                        /**
                         * Sets the value of the idType property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setIDType(String value) {
                            this.idType = value;
                        }

                        /**
                         * Gets the value of the idNumber property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getIDNumber() {
                            return idNumber;
                        }

                        /**
                         * Sets the value of the idNumber property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setIDNumber(String value) {
                            this.idNumber = value;
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
                     *         &lt;element name="KYCFieldName"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="256"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="KYCValue"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="512"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
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
                    @XmlType(name = "", propOrder = {
                        "kycFieldName",
                        "kycValue"
                    })
                    public static class SimpleKYC {

                        @XmlElement(name = "KYCFieldName", required = true)
                        protected String kycFieldName;
                        @XmlElement(name = "KYCValue", required = true)
                        protected String kycValue;

                        /**
                         * Gets the value of the kycFieldName property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getKYCFieldName() {
                            return kycFieldName;
                        }

                        /**
                         * Sets the value of the kycFieldName property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setKYCFieldName(String value) {
                            this.kycFieldName = value;
                        }

                        /**
                         * Gets the value of the kycValue property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getKYCValue() {
                            return kycValue;
                        }

                        /**
                         * Sets the value of the kycValue property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setKYCValue(String value) {
                            this.kycValue = value;
                        }

                    }

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
             *         &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
             *         &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
             *         &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
             *         &lt;element name="PrimaryPartyKYC" minOccurs="0"&gt;
             *           &lt;complexType&gt;
             *             &lt;complexContent&gt;
             *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
             *                 &lt;sequence&gt;
             *                   &lt;element name="SimpleKYC" maxOccurs="unbounded" minOccurs="0"&gt;
             *                     &lt;complexType&gt;
             *                       &lt;complexContent&gt;
             *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
             *                           &lt;sequence&gt;
             *                             &lt;element name="KYCFieldName"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="256"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="KYCValue"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="512"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                           &lt;/sequence&gt;
             *                         &lt;/restriction&gt;
             *                       &lt;/complexContent&gt;
             *                     &lt;/complexType&gt;
             *                   &lt;/element&gt;
             *                   &lt;element name="IDDetails" minOccurs="0"&gt;
             *                     &lt;complexType&gt;
             *                       &lt;complexContent&gt;
             *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
             *                           &lt;sequence&gt;
             *                             &lt;element name="IDType" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="32"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="IDNumber"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                           &lt;/sequence&gt;
             *                         &lt;/restriction&gt;
             *                       &lt;/complexContent&gt;
             *                     &lt;/complexType&gt;
             *                   &lt;/element&gt;
             *                   &lt;element name="ContactDetails" minOccurs="0"&gt;
             *                     &lt;complexType&gt;
             *                       &lt;complexContent&gt;
             *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
             *                           &lt;sequence&gt;
             *                             &lt;element name="ContactType" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="32"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="FirstName" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="LastName" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="SurName" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="PhoneNumber" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="EMail" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="256"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="IDNumber" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                           &lt;/sequence&gt;
             *                         &lt;/restriction&gt;
             *                       &lt;/complexContent&gt;
             *                     &lt;/complexType&gt;
             *                   &lt;/element&gt;
             *                   &lt;element name="CertificateDetails" minOccurs="0"&gt;
             *                     &lt;complexType&gt;
             *                       &lt;complexContent&gt;
             *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
             *                           &lt;sequence&gt;
             *                             &lt;element name="CertificateType" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="32"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="CertificateNumber"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                           &lt;/sequence&gt;
             *                         &lt;/restriction&gt;
             *                       &lt;/complexContent&gt;
             *                     &lt;/complexType&gt;
             *                   &lt;/element&gt;
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
            @XmlType(name = "", propOrder = {
                "identifierType",
                "identifier",
                "shortCode",
                "primaryPartyKYC"
            })
            public static class PrimaryParty {

                @XmlElement(name = "IdentifierType", required = true)
                protected String identifierType;
                @XmlElement(name = "Identifier", required = true)
                protected String identifier;
                @XmlElement(name = "ShortCode")
                protected String shortCode;
                @XmlElement(name = "PrimaryPartyKYC")
                protected Request.Body.Identity.PrimaryParty.PrimaryPartyKYC primaryPartyKYC;

                /**
                 * Gets the value of the identifierType property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link String }
                 *     
                 */
                public String getIdentifierType() {
                    return identifierType;
                }

                /**
                 * Sets the value of the identifierType property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link String }
                 *     
                 */
                public void setIdentifierType(String value) {
                    this.identifierType = value;
                }

                /**
                 * Gets the value of the identifier property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link String }
                 *     
                 */
                public String getIdentifier() {
                    return identifier;
                }

                /**
                 * Sets the value of the identifier property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link String }
                 *     
                 */
                public void setIdentifier(String value) {
                    this.identifier = value;
                }

                /**
                 * Gets the value of the shortCode property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link String }
                 *     
                 */
                public String getShortCode() {
                    return shortCode;
                }

                /**
                 * Sets the value of the shortCode property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link String }
                 *     
                 */
                public void setShortCode(String value) {
                    this.shortCode = value;
                }

                /**
                 * Gets the value of the primaryPartyKYC property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link Request.Body.Identity.PrimaryParty.PrimaryPartyKYC }
                 *     
                 */
                public Request.Body.Identity.PrimaryParty.PrimaryPartyKYC getPrimaryPartyKYC() {
                    return primaryPartyKYC;
                }

                /**
                 * Sets the value of the primaryPartyKYC property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link Request.Body.Identity.PrimaryParty.PrimaryPartyKYC }
                 *     
                 */
                public void setPrimaryPartyKYC(Request.Body.Identity.PrimaryParty.PrimaryPartyKYC value) {
                    this.primaryPartyKYC = value;
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
                 *         &lt;element name="SimpleKYC" maxOccurs="unbounded" minOccurs="0"&gt;
                 *           &lt;complexType&gt;
                 *             &lt;complexContent&gt;
                 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
                 *                 &lt;sequence&gt;
                 *                   &lt;element name="KYCFieldName"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="256"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="KYCValue"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="512"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                 &lt;/sequence&gt;
                 *               &lt;/restriction&gt;
                 *             &lt;/complexContent&gt;
                 *           &lt;/complexType&gt;
                 *         &lt;/element&gt;
                 *         &lt;element name="IDDetails" minOccurs="0"&gt;
                 *           &lt;complexType&gt;
                 *             &lt;complexContent&gt;
                 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
                 *                 &lt;sequence&gt;
                 *                   &lt;element name="IDType" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="32"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="IDNumber"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                 &lt;/sequence&gt;
                 *               &lt;/restriction&gt;
                 *             &lt;/complexContent&gt;
                 *           &lt;/complexType&gt;
                 *         &lt;/element&gt;
                 *         &lt;element name="ContactDetails" minOccurs="0"&gt;
                 *           &lt;complexType&gt;
                 *             &lt;complexContent&gt;
                 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
                 *                 &lt;sequence&gt;
                 *                   &lt;element name="ContactType" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="32"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="FirstName" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="LastName" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="SurName" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="PhoneNumber" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="EMail" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="256"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="IDNumber" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                 &lt;/sequence&gt;
                 *               &lt;/restriction&gt;
                 *             &lt;/complexContent&gt;
                 *           &lt;/complexType&gt;
                 *         &lt;/element&gt;
                 *         &lt;element name="CertificateDetails" minOccurs="0"&gt;
                 *           &lt;complexType&gt;
                 *             &lt;complexContent&gt;
                 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
                 *                 &lt;sequence&gt;
                 *                   &lt;element name="CertificateType" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="32"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="CertificateNumber"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
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
                @XmlType(name = "", propOrder = {
                    "simpleKYC",
                    "idDetails",
                    "contactDetails",
                    "certificateDetails"
                })
                public static class PrimaryPartyKYC {

                    @XmlElement(name = "SimpleKYC")
                    protected List<Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.SimpleKYC> simpleKYC;
                    @XmlElement(name = "IDDetails")
                    protected Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.IDDetails idDetails;
                    @XmlElement(name = "ContactDetails")
                    protected Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.ContactDetails contactDetails;
                    @XmlElement(name = "CertificateDetails")
                    protected Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.CertificateDetails certificateDetails;

                    /**
                     * Gets the value of the simpleKYC property.
                     * 
                     * <p>
                     * This accessor method returns a reference to the live list,
                     * not a snapshot. Therefore any modification you make to the
                     * returned list will be present inside the Jakarta XML Binding object.
                     * This is why there is not a <CODE>set</CODE> method for the simpleKYC property.
                     * 
                     * <p>
                     * For example, to add a new item, do as follows:
                     * <pre>
                     *    getSimpleKYC().add(newItem);
                     * </pre>
                     * 
                     * 
                     * <p>
                     * Objects of the following type(s) are allowed in the list
                     * {@link Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.SimpleKYC }
                     * 
                     * 
                     */
                    public List<Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.SimpleKYC> getSimpleKYC() {
                        if (simpleKYC == null) {
                            simpleKYC = new ArrayList<Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.SimpleKYC>();
                        }
                        return this.simpleKYC;
                    }

                    /**
                     * Gets the value of the idDetails property.
                     * 
                     * @return
                     *     possible object is
                     *     {@link Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.IDDetails }
                     *     
                     */
                    public Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.IDDetails getIDDetails() {
                        return idDetails;
                    }

                    /**
                     * Sets the value of the idDetails property.
                     * 
                     * @param value
                     *     allowed object is
                     *     {@link Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.IDDetails }
                     *     
                     */
                    public void setIDDetails(Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.IDDetails value) {
                        this.idDetails = value;
                    }

                    /**
                     * Gets the value of the contactDetails property.
                     * 
                     * @return
                     *     possible object is
                     *     {@link Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.ContactDetails }
                     *     
                     */
                    public Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.ContactDetails getContactDetails() {
                        return contactDetails;
                    }

                    /**
                     * Sets the value of the contactDetails property.
                     * 
                     * @param value
                     *     allowed object is
                     *     {@link Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.ContactDetails }
                     *     
                     */
                    public void setContactDetails(Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.ContactDetails value) {
                        this.contactDetails = value;
                    }

                    /**
                     * Gets the value of the certificateDetails property.
                     * 
                     * @return
                     *     possible object is
                     *     {@link Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.CertificateDetails }
                     *     
                     */
                    public Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.CertificateDetails getCertificateDetails() {
                        return certificateDetails;
                    }

                    /**
                     * Sets the value of the certificateDetails property.
                     * 
                     * @param value
                     *     allowed object is
                     *     {@link Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.CertificateDetails }
                     *     
                     */
                    public void setCertificateDetails(Request.Body.Identity.PrimaryParty.PrimaryPartyKYC.CertificateDetails value) {
                        this.certificateDetails = value;
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
                     *         &lt;element name="CertificateType" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="32"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="CertificateNumber"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
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
                    @XmlType(name = "", propOrder = {
                        "certificateType",
                        "certificateNumber"
                    })
                    public static class CertificateDetails {

                        @XmlElement(name = "CertificateType")
                        protected String certificateType;
                        @XmlElement(name = "CertificateNumber", required = true)
                        protected String certificateNumber;

                        /**
                         * Gets the value of the certificateType property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getCertificateType() {
                            return certificateType;
                        }

                        /**
                         * Sets the value of the certificateType property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setCertificateType(String value) {
                            this.certificateType = value;
                        }

                        /**
                         * Gets the value of the certificateNumber property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getCertificateNumber() {
                            return certificateNumber;
                        }

                        /**
                         * Sets the value of the certificateNumber property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setCertificateNumber(String value) {
                            this.certificateNumber = value;
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
                     *         &lt;element name="ContactType" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="32"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="FirstName" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="LastName" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="SurName" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="PhoneNumber" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="EMail" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="256"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="IDNumber" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
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
                    @XmlType(name = "", propOrder = {
                        "contactType",
                        "firstName",
                        "lastName",
                        "surName",
                        "phoneNumber",
                        "eMail",
                        "idNumber"
                    })
                    public static class ContactDetails {

                        @XmlElement(name = "ContactType")
                        protected String contactType;
                        @XmlElement(name = "FirstName")
                        protected String firstName;
                        @XmlElement(name = "LastName")
                        protected String lastName;
                        @XmlElement(name = "SurName")
                        protected String surName;
                        @XmlElement(name = "PhoneNumber")
                        protected String phoneNumber;
                        @XmlElement(name = "EMail")
                        protected String eMail;
                        @XmlElement(name = "IDNumber")
                        protected String idNumber;

                        /**
                         * Gets the value of the contactType property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getContactType() {
                            return contactType;
                        }

                        /**
                         * Sets the value of the contactType property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setContactType(String value) {
                            this.contactType = value;
                        }

                        /**
                         * Gets the value of the firstName property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getFirstName() {
                            return firstName;
                        }

                        /**
                         * Sets the value of the firstName property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setFirstName(String value) {
                            this.firstName = value;
                        }

                        /**
                         * Gets the value of the lastName property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getLastName() {
                            return lastName;
                        }

                        /**
                         * Sets the value of the lastName property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setLastName(String value) {
                            this.lastName = value;
                        }

                        /**
                         * Gets the value of the surName property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getSurName() {
                            return surName;
                        }

                        /**
                         * Sets the value of the surName property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setSurName(String value) {
                            this.surName = value;
                        }

                        /**
                         * Gets the value of the phoneNumber property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getPhoneNumber() {
                            return phoneNumber;
                        }

                        /**
                         * Sets the value of the phoneNumber property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setPhoneNumber(String value) {
                            this.phoneNumber = value;
                        }

                        /**
                         * Gets the value of the eMail property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getEMail() {
                            return eMail;
                        }

                        /**
                         * Sets the value of the eMail property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setEMail(String value) {
                            this.eMail = value;
                        }

                        /**
                         * Gets the value of the idNumber property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getIDNumber() {
                            return idNumber;
                        }

                        /**
                         * Sets the value of the idNumber property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setIDNumber(String value) {
                            this.idNumber = value;
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
                     *         &lt;element name="IDType" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="32"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="IDNumber"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
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
                    @XmlType(name = "", propOrder = {
                        "idType",
                        "idNumber"
                    })
                    public static class IDDetails {

                        @XmlElement(name = "IDType")
                        protected String idType;
                        @XmlElement(name = "IDNumber", required = true)
                        protected String idNumber;

                        /**
                         * Gets the value of the idType property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getIDType() {
                            return idType;
                        }

                        /**
                         * Sets the value of the idType property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setIDType(String value) {
                            this.idType = value;
                        }

                        /**
                         * Gets the value of the idNumber property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getIDNumber() {
                            return idNumber;
                        }

                        /**
                         * Sets the value of the idNumber property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setIDNumber(String value) {
                            this.idNumber = value;
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
                     *         &lt;element name="KYCFieldName"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="256"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="KYCValue"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="512"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
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
                    @XmlType(name = "", propOrder = {
                        "kycFieldName",
                        "kycValue"
                    })
                    public static class SimpleKYC {

                        @XmlElement(name = "KYCFieldName", required = true)
                        protected String kycFieldName;
                        @XmlElement(name = "KYCValue", required = true)
                        protected String kycValue;

                        /**
                         * Gets the value of the kycFieldName property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getKYCFieldName() {
                            return kycFieldName;
                        }

                        /**
                         * Sets the value of the kycFieldName property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setKYCFieldName(String value) {
                            this.kycFieldName = value;
                        }

                        /**
                         * Gets the value of the kycValue property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getKYCValue() {
                            return kycValue;
                        }

                        /**
                         * Sets the value of the kycValue property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setKYCValue(String value) {
                            this.kycValue = value;
                        }

                    }

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
             *         &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
             *         &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
             *         &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
             *         &lt;element name="ReceiverKYC" minOccurs="0"&gt;
             *           &lt;complexType&gt;
             *             &lt;complexContent&gt;
             *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
             *                 &lt;sequence&gt;
             *                   &lt;element name="SimpleKYC" maxOccurs="unbounded" minOccurs="0"&gt;
             *                     &lt;complexType&gt;
             *                       &lt;complexContent&gt;
             *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
             *                           &lt;sequence&gt;
             *                             &lt;element name="KYCFieldName"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="256"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="KYCValue"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="512"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                           &lt;/sequence&gt;
             *                         &lt;/restriction&gt;
             *                       &lt;/complexContent&gt;
             *                     &lt;/complexType&gt;
             *                   &lt;/element&gt;
             *                   &lt;element name="IDDetails" minOccurs="0"&gt;
             *                     &lt;complexType&gt;
             *                       &lt;complexContent&gt;
             *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
             *                           &lt;sequence&gt;
             *                             &lt;element name="IDType" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="32"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="IDNumber"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                           &lt;/sequence&gt;
             *                         &lt;/restriction&gt;
             *                       &lt;/complexContent&gt;
             *                     &lt;/complexType&gt;
             *                   &lt;/element&gt;
             *                   &lt;element name="ContactDetails" minOccurs="0"&gt;
             *                     &lt;complexType&gt;
             *                       &lt;complexContent&gt;
             *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
             *                           &lt;sequence&gt;
             *                             &lt;element name="ContactType" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="32"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="FirstName" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="LastName" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="SurName" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="PhoneNumber" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="EMail" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="256"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="IDNumber" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                           &lt;/sequence&gt;
             *                         &lt;/restriction&gt;
             *                       &lt;/complexContent&gt;
             *                     &lt;/complexType&gt;
             *                   &lt;/element&gt;
             *                   &lt;element name="CertificateDetails" minOccurs="0"&gt;
             *                     &lt;complexType&gt;
             *                       &lt;complexContent&gt;
             *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
             *                           &lt;sequence&gt;
             *                             &lt;element name="CertificateType" minOccurs="0"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="32"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                             &lt;element name="CertificateNumber"&gt;
             *                               &lt;simpleType&gt;
             *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *                                   &lt;maxLength value="64"/&gt;
             *                                 &lt;/restriction&gt;
             *                               &lt;/simpleType&gt;
             *                             &lt;/element&gt;
             *                           &lt;/sequence&gt;
             *                         &lt;/restriction&gt;
             *                       &lt;/complexContent&gt;
             *                     &lt;/complexType&gt;
             *                   &lt;/element&gt;
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
            @XmlType(name = "", propOrder = {
                "identifierType",
                "identifier",
                "shortCode",
                "receiverKYC"
            })
            public static class ReceiverParty {

                @XmlElement(name = "IdentifierType", required = true)
                protected String identifierType;
                @XmlElement(name = "Identifier", required = true)
                protected String identifier;
                @XmlElement(name = "ShortCode")
                protected String shortCode;
                @XmlElement(name = "ReceiverKYC")
                protected Request.Body.Identity.ReceiverParty.ReceiverKYC receiverKYC;

                /**
                 * Gets the value of the identifierType property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link String }
                 *     
                 */
                public String getIdentifierType() {
                    return identifierType;
                }

                /**
                 * Sets the value of the identifierType property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link String }
                 *     
                 */
                public void setIdentifierType(String value) {
                    this.identifierType = value;
                }

                /**
                 * Gets the value of the identifier property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link String }
                 *     
                 */
                public String getIdentifier() {
                    return identifier;
                }

                /**
                 * Sets the value of the identifier property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link String }
                 *     
                 */
                public void setIdentifier(String value) {
                    this.identifier = value;
                }

                /**
                 * Gets the value of the shortCode property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link String }
                 *     
                 */
                public String getShortCode() {
                    return shortCode;
                }

                /**
                 * Sets the value of the shortCode property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link String }
                 *     
                 */
                public void setShortCode(String value) {
                    this.shortCode = value;
                }

                /**
                 * Gets the value of the receiverKYC property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link Request.Body.Identity.ReceiverParty.ReceiverKYC }
                 *     
                 */
                public Request.Body.Identity.ReceiverParty.ReceiverKYC getReceiverKYC() {
                    return receiverKYC;
                }

                /**
                 * Sets the value of the receiverKYC property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link Request.Body.Identity.ReceiverParty.ReceiverKYC }
                 *     
                 */
                public void setReceiverKYC(Request.Body.Identity.ReceiverParty.ReceiverKYC value) {
                    this.receiverKYC = value;
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
                 *         &lt;element name="SimpleKYC" maxOccurs="unbounded" minOccurs="0"&gt;
                 *           &lt;complexType&gt;
                 *             &lt;complexContent&gt;
                 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
                 *                 &lt;sequence&gt;
                 *                   &lt;element name="KYCFieldName"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="256"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="KYCValue"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="512"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                 &lt;/sequence&gt;
                 *               &lt;/restriction&gt;
                 *             &lt;/complexContent&gt;
                 *           &lt;/complexType&gt;
                 *         &lt;/element&gt;
                 *         &lt;element name="IDDetails" minOccurs="0"&gt;
                 *           &lt;complexType&gt;
                 *             &lt;complexContent&gt;
                 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
                 *                 &lt;sequence&gt;
                 *                   &lt;element name="IDType" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="32"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="IDNumber"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                 &lt;/sequence&gt;
                 *               &lt;/restriction&gt;
                 *             &lt;/complexContent&gt;
                 *           &lt;/complexType&gt;
                 *         &lt;/element&gt;
                 *         &lt;element name="ContactDetails" minOccurs="0"&gt;
                 *           &lt;complexType&gt;
                 *             &lt;complexContent&gt;
                 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
                 *                 &lt;sequence&gt;
                 *                   &lt;element name="ContactType" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="32"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="FirstName" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="LastName" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="SurName" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="PhoneNumber" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="EMail" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="256"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="IDNumber" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                 &lt;/sequence&gt;
                 *               &lt;/restriction&gt;
                 *             &lt;/complexContent&gt;
                 *           &lt;/complexType&gt;
                 *         &lt;/element&gt;
                 *         &lt;element name="CertificateDetails" minOccurs="0"&gt;
                 *           &lt;complexType&gt;
                 *             &lt;complexContent&gt;
                 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
                 *                 &lt;sequence&gt;
                 *                   &lt;element name="CertificateType" minOccurs="0"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="32"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
                 *                   &lt;element name="CertificateNumber"&gt;
                 *                     &lt;simpleType&gt;
                 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                 *                         &lt;maxLength value="64"/&gt;
                 *                       &lt;/restriction&gt;
                 *                     &lt;/simpleType&gt;
                 *                   &lt;/element&gt;
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
                @XmlType(name = "", propOrder = {
                    "simpleKYC",
                    "idDetails",
                    "contactDetails",
                    "certificateDetails"
                })
                public static class ReceiverKYC {

                    @XmlElement(name = "SimpleKYC")
                    protected List<Request.Body.Identity.ReceiverParty.ReceiverKYC.SimpleKYC> simpleKYC;
                    @XmlElement(name = "IDDetails")
                    protected Request.Body.Identity.ReceiverParty.ReceiverKYC.IDDetails idDetails;
                    @XmlElement(name = "ContactDetails")
                    protected Request.Body.Identity.ReceiverParty.ReceiverKYC.ContactDetails contactDetails;
                    @XmlElement(name = "CertificateDetails")
                    protected Request.Body.Identity.ReceiverParty.ReceiverKYC.CertificateDetails certificateDetails;

                    /**
                     * Gets the value of the simpleKYC property.
                     * 
                     * <p>
                     * This accessor method returns a reference to the live list,
                     * not a snapshot. Therefore any modification you make to the
                     * returned list will be present inside the Jakarta XML Binding object.
                     * This is why there is not a <CODE>set</CODE> method for the simpleKYC property.
                     * 
                     * <p>
                     * For example, to add a new item, do as follows:
                     * <pre>
                     *    getSimpleKYC().add(newItem);
                     * </pre>
                     * 
                     * 
                     * <p>
                     * Objects of the following type(s) are allowed in the list
                     * {@link Request.Body.Identity.ReceiverParty.ReceiverKYC.SimpleKYC }
                     * 
                     * 
                     */
                    public List<Request.Body.Identity.ReceiverParty.ReceiverKYC.SimpleKYC> getSimpleKYC() {
                        if (simpleKYC == null) {
                            simpleKYC = new ArrayList<Request.Body.Identity.ReceiverParty.ReceiverKYC.SimpleKYC>();
                        }
                        return this.simpleKYC;
                    }

                    /**
                     * Gets the value of the idDetails property.
                     * 
                     * @return
                     *     possible object is
                     *     {@link Request.Body.Identity.ReceiverParty.ReceiverKYC.IDDetails }
                     *     
                     */
                    public Request.Body.Identity.ReceiverParty.ReceiverKYC.IDDetails getIDDetails() {
                        return idDetails;
                    }

                    /**
                     * Sets the value of the idDetails property.
                     * 
                     * @param value
                     *     allowed object is
                     *     {@link Request.Body.Identity.ReceiverParty.ReceiverKYC.IDDetails }
                     *     
                     */
                    public void setIDDetails(Request.Body.Identity.ReceiverParty.ReceiverKYC.IDDetails value) {
                        this.idDetails = value;
                    }

                    /**
                     * Gets the value of the contactDetails property.
                     * 
                     * @return
                     *     possible object is
                     *     {@link Request.Body.Identity.ReceiverParty.ReceiverKYC.ContactDetails }
                     *     
                     */
                    public Request.Body.Identity.ReceiverParty.ReceiverKYC.ContactDetails getContactDetails() {
                        return contactDetails;
                    }

                    /**
                     * Sets the value of the contactDetails property.
                     * 
                     * @param value
                     *     allowed object is
                     *     {@link Request.Body.Identity.ReceiverParty.ReceiverKYC.ContactDetails }
                     *     
                     */
                    public void setContactDetails(Request.Body.Identity.ReceiverParty.ReceiverKYC.ContactDetails value) {
                        this.contactDetails = value;
                    }

                    /**
                     * Gets the value of the certificateDetails property.
                     * 
                     * @return
                     *     possible object is
                     *     {@link Request.Body.Identity.ReceiverParty.ReceiverKYC.CertificateDetails }
                     *     
                     */
                    public Request.Body.Identity.ReceiverParty.ReceiverKYC.CertificateDetails getCertificateDetails() {
                        return certificateDetails;
                    }

                    /**
                     * Sets the value of the certificateDetails property.
                     * 
                     * @param value
                     *     allowed object is
                     *     {@link Request.Body.Identity.ReceiverParty.ReceiverKYC.CertificateDetails }
                     *     
                     */
                    public void setCertificateDetails(Request.Body.Identity.ReceiverParty.ReceiverKYC.CertificateDetails value) {
                        this.certificateDetails = value;
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
                     *         &lt;element name="CertificateType" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="32"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="CertificateNumber"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
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
                    @XmlType(name = "", propOrder = {
                        "certificateType",
                        "certificateNumber"
                    })
                    public static class CertificateDetails {

                        @XmlElement(name = "CertificateType")
                        protected String certificateType;
                        @XmlElement(name = "CertificateNumber", required = true)
                        protected String certificateNumber;

                        /**
                         * Gets the value of the certificateType property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getCertificateType() {
                            return certificateType;
                        }

                        /**
                         * Sets the value of the certificateType property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setCertificateType(String value) {
                            this.certificateType = value;
                        }

                        /**
                         * Gets the value of the certificateNumber property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getCertificateNumber() {
                            return certificateNumber;
                        }

                        /**
                         * Sets the value of the certificateNumber property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setCertificateNumber(String value) {
                            this.certificateNumber = value;
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
                     *         &lt;element name="ContactType" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="32"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="FirstName" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="LastName" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="SurName" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="PhoneNumber" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="EMail" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="256"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="IDNumber" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
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
                    @XmlType(name = "", propOrder = {
                        "contactType",
                        "firstName",
                        "lastName",
                        "surName",
                        "phoneNumber",
                        "eMail",
                        "idNumber"
                    })
                    public static class ContactDetails {

                        @XmlElement(name = "ContactType")
                        protected String contactType;
                        @XmlElement(name = "FirstName")
                        protected String firstName;
                        @XmlElement(name = "LastName")
                        protected String lastName;
                        @XmlElement(name = "SurName")
                        protected String surName;
                        @XmlElement(name = "PhoneNumber")
                        protected String phoneNumber;
                        @XmlElement(name = "EMail")
                        protected String eMail;
                        @XmlElement(name = "IDNumber")
                        protected String idNumber;

                        /**
                         * Gets the value of the contactType property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getContactType() {
                            return contactType;
                        }

                        /**
                         * Sets the value of the contactType property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setContactType(String value) {
                            this.contactType = value;
                        }

                        /**
                         * Gets the value of the firstName property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getFirstName() {
                            return firstName;
                        }

                        /**
                         * Sets the value of the firstName property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setFirstName(String value) {
                            this.firstName = value;
                        }

                        /**
                         * Gets the value of the lastName property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getLastName() {
                            return lastName;
                        }

                        /**
                         * Sets the value of the lastName property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setLastName(String value) {
                            this.lastName = value;
                        }

                        /**
                         * Gets the value of the surName property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getSurName() {
                            return surName;
                        }

                        /**
                         * Sets the value of the surName property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setSurName(String value) {
                            this.surName = value;
                        }

                        /**
                         * Gets the value of the phoneNumber property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getPhoneNumber() {
                            return phoneNumber;
                        }

                        /**
                         * Sets the value of the phoneNumber property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setPhoneNumber(String value) {
                            this.phoneNumber = value;
                        }

                        /**
                         * Gets the value of the eMail property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getEMail() {
                            return eMail;
                        }

                        /**
                         * Sets the value of the eMail property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setEMail(String value) {
                            this.eMail = value;
                        }

                        /**
                         * Gets the value of the idNumber property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getIDNumber() {
                            return idNumber;
                        }

                        /**
                         * Sets the value of the idNumber property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setIDNumber(String value) {
                            this.idNumber = value;
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
                     *         &lt;element name="IDType" minOccurs="0"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="32"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="IDNumber"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="64"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
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
                    @XmlType(name = "", propOrder = {
                        "idType",
                        "idNumber"
                    })
                    public static class IDDetails {

                        @XmlElement(name = "IDType")
                        protected String idType;
                        @XmlElement(name = "IDNumber", required = true)
                        protected String idNumber;

                        /**
                         * Gets the value of the idType property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getIDType() {
                            return idType;
                        }

                        /**
                         * Sets the value of the idType property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setIDType(String value) {
                            this.idType = value;
                        }

                        /**
                         * Gets the value of the idNumber property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getIDNumber() {
                            return idNumber;
                        }

                        /**
                         * Sets the value of the idNumber property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setIDNumber(String value) {
                            this.idNumber = value;
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
                     *         &lt;element name="KYCFieldName"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="256"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
                     *         &lt;/element&gt;
                     *         &lt;element name="KYCValue"&gt;
                     *           &lt;simpleType&gt;
                     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
                     *               &lt;maxLength value="512"/&gt;
                     *             &lt;/restriction&gt;
                     *           &lt;/simpleType&gt;
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
                    @XmlType(name = "", propOrder = {
                        "kycFieldName",
                        "kycValue"
                    })
                    public static class SimpleKYC {

                        @XmlElement(name = "KYCFieldName", required = true)
                        protected String kycFieldName;
                        @XmlElement(name = "KYCValue", required = true)
                        protected String kycValue;

                        /**
                         * Gets the value of the kycFieldName property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getKYCFieldName() {
                            return kycFieldName;
                        }

                        /**
                         * Sets the value of the kycFieldName property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setKYCFieldName(String value) {
                            this.kycFieldName = value;
                        }

                        /**
                         * Gets the value of the kycValue property.
                         * 
                         * @return
                         *     possible object is
                         *     {@link String }
                         *     
                         */
                        public String getKYCValue() {
                            return kycValue;
                        }

                        /**
                         * Sets the value of the kycValue property.
                         * 
                         * @param value
                         *     allowed object is
                         *     {@link String }
                         *     
                         */
                        public void setKYCValue(String value) {
                            this.kycValue = value;
                        }

                    }

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
             *         &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
             *         &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
             *         &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
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
                "identifierType",
                "identifier",
                "shortCode"
            })
            public static class Requester {

                @XmlElement(name = "IdentifierType", required = true)
                protected String identifierType;
                @XmlElement(name = "Identifier", required = true)
                protected String identifier;
                @XmlElement(name = "ShortCode")
                protected String shortCode;

                /**
                 * Gets the value of the identifierType property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link String }
                 *     
                 */
                public String getIdentifierType() {
                    return identifierType;
                }

                /**
                 * Sets the value of the identifierType property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link String }
                 *     
                 */
                public void setIdentifierType(String value) {
                    this.identifierType = value;
                }

                /**
                 * Gets the value of the identifier property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link String }
                 *     
                 */
                public String getIdentifier() {
                    return identifier;
                }

                /**
                 * Sets the value of the identifier property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link String }
                 *     
                 */
                public void setIdentifier(String value) {
                    this.identifier = value;
                }

                /**
                 * Gets the value of the shortCode property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link String }
                 *     
                 */
                public String getShortCode() {
                    return shortCode;
                }

                /**
                 * Sets the value of the shortCode property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link String }
                 *     
                 */
                public void setShortCode(String value) {
                    this.shortCode = value;
                }

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
         *         &lt;element name="ReferenceItem" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
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
            "referenceItem"
        })
        public static class ReferenceData {

            @XmlElement(name = "ReferenceItem", required = true)
            protected List<ParameterType> referenceItem;

            /**
             * Gets the value of the referenceItem property.
             * 
             * <p>
             * This accessor method returns a reference to the live list,
             * not a snapshot. Therefore any modification you make to the
             * returned list will be present inside the Jakarta XML Binding object.
             * This is why there is not a <CODE>set</CODE> method for the referenceItem property.
             * 
             * <p>
             * For example, to add a new item, do as follows:
             * <pre>
             *    getReferenceItem().add(newItem);
             * </pre>
             * 
             * 
             * <p>
             * Objects of the following type(s) are allowed in the list
             * {@link ParameterType }
             * 
             * 
             */
            public List<ParameterType> getReferenceItem() {
                if (referenceItem == null) {
                    referenceItem = new ArrayList<ParameterType>();
                }
                return this.referenceItem;
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
         *         &lt;element name="Parameters" minOccurs="0"&gt;
         *           &lt;complexType&gt;
         *             &lt;complexContent&gt;
         *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *                 &lt;sequence&gt;
         *                   &lt;element name="Parameter" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded" minOccurs="0"/&gt;
         *                   &lt;element name="Amount" minOccurs="0"&gt;
         *                     &lt;simpleType&gt;
         *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                         &lt;maxLength value="18"/&gt;
         *                       &lt;/restriction&gt;
         *                     &lt;/simpleType&gt;
         *                   &lt;/element&gt;
         *                   &lt;element name="Currency" minOccurs="0"&gt;
         *                     &lt;simpleType&gt;
         *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                         &lt;length value="3"/&gt;
         *                       &lt;/restriction&gt;
         *                     &lt;/simpleType&gt;
         *                   &lt;/element&gt;
         *                   &lt;element name="ReasonType" minOccurs="0"&gt;
         *                     &lt;simpleType&gt;
         *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                         &lt;maxLength value="128"/&gt;
         *                       &lt;/restriction&gt;
         *                     &lt;/simpleType&gt;
         *                   &lt;/element&gt;
         *                   &lt;element name="VoucherType" minOccurs="0"&gt;
         *                     &lt;simpleType&gt;
         *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *                         &lt;maxLength value="128"/&gt;
         *                       &lt;/restriction&gt;
         *                     &lt;/simpleType&gt;
         *                   &lt;/element&gt;
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
        @XmlType(name = "", propOrder = {
            "parameters"
        })
        public static class TransactionRequest {

            @XmlElement(name = "Parameters")
            protected Request.Body.TransactionRequest.Parameters parameters;

            /**
             * Gets the value of the parameters property.
             * 
             * @return
             *     possible object is
             *     {@link Request.Body.TransactionRequest.Parameters }
             *     
             */
            public Request.Body.TransactionRequest.Parameters getParameters() {
                return parameters;
            }

            /**
             * Sets the value of the parameters property.
             * 
             * @param value
             *     allowed object is
             *     {@link Request.Body.TransactionRequest.Parameters }
             *     
             */
            public void setParameters(Request.Body.TransactionRequest.Parameters value) {
                this.parameters = value;
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
             *         &lt;element name="Parameter" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded" minOccurs="0"/&gt;
             *         &lt;element name="Amount" minOccurs="0"&gt;
             *           &lt;simpleType&gt;
             *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *               &lt;maxLength value="18"/&gt;
             *             &lt;/restriction&gt;
             *           &lt;/simpleType&gt;
             *         &lt;/element&gt;
             *         &lt;element name="Currency" minOccurs="0"&gt;
             *           &lt;simpleType&gt;
             *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *               &lt;length value="3"/&gt;
             *             &lt;/restriction&gt;
             *           &lt;/simpleType&gt;
             *         &lt;/element&gt;
             *         &lt;element name="ReasonType" minOccurs="0"&gt;
             *           &lt;simpleType&gt;
             *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *               &lt;maxLength value="128"/&gt;
             *             &lt;/restriction&gt;
             *           &lt;/simpleType&gt;
             *         &lt;/element&gt;
             *         &lt;element name="VoucherType" minOccurs="0"&gt;
             *           &lt;simpleType&gt;
             *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
             *               &lt;maxLength value="128"/&gt;
             *             &lt;/restriction&gt;
             *           &lt;/simpleType&gt;
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
            @XmlType(name = "", propOrder = {
                "parameter",
                "amount",
                "currency",
                "reasonType",
                "voucherType"
            })
            public static class Parameters {

                @XmlElement(name = "Parameter")
                protected List<ParameterType> parameter;
                @XmlElement(name = "Amount")
                protected String amount;
                @XmlElement(name = "Currency")
                protected String currency;
                @XmlElement(name = "ReasonType")
                protected String reasonType;
                @XmlElement(name = "VoucherType")
                protected String voucherType;

                /**
                 * Gets the value of the parameter property.
                 * 
                 * <p>
                 * This accessor method returns a reference to the live list,
                 * not a snapshot. Therefore any modification you make to the
                 * returned list will be present inside the Jakarta XML Binding object.
                 * This is why there is not a <CODE>set</CODE> method for the parameter property.
                 * 
                 * <p>
                 * For example, to add a new item, do as follows:
                 * <pre>
                 *    getParameter().add(newItem);
                 * </pre>
                 * 
                 * 
                 * <p>
                 * Objects of the following type(s) are allowed in the list
                 * {@link ParameterType }
                 * 
                 * 
                 */
                public List<ParameterType> getParameter() {
                    if (parameter == null) {
                        parameter = new ArrayList<ParameterType>();
                    }
                    return this.parameter;
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
                 * Gets the value of the reasonType property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link String }
                 *     
                 */
                public String getReasonType() {
                    return reasonType;
                }

                /**
                 * Sets the value of the reasonType property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link String }
                 *     
                 */
                public void setReasonType(String value) {
                    this.reasonType = value;
                }

                /**
                 * Gets the value of the voucherType property.
                 * 
                 * @return
                 *     possible object is
                 *     {@link String }
                 *     
                 */
                public String getVoucherType() {
                    return voucherType;
                }

                /**
                 * Sets the value of the voucherType property.
                 * 
                 * @param value
                 *     allowed object is
                 *     {@link String }
                 *     
                 */
                public void setVoucherType(String value) {
                    this.voucherType = value;
                }

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
         *         &lt;element name="ApplicationCode"&gt;
         *           &lt;simpleType&gt;
         *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *               &lt;maxLength value="20"/&gt;
         *             &lt;/restriction&gt;
         *           &lt;/simpleType&gt;
         *         &lt;/element&gt;
         *         &lt;element name="FunctionCode"&gt;
         *           &lt;simpleType&gt;
         *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *               &lt;maxLength value="20"/&gt;
         *             &lt;/restriction&gt;
         *           &lt;/simpleType&gt;
         *         &lt;/element&gt;
         *         &lt;element name="VerificationCode"&gt;
         *           &lt;simpleType&gt;
         *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *               &lt;maxLength value="20"/&gt;
         *             &lt;/restriction&gt;
         *           &lt;/simpleType&gt;
         *         &lt;/element&gt;
         *         &lt;element name="CustomerAccount" minOccurs="0"&gt;
         *           &lt;simpleType&gt;
         *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *               &lt;maxLength value="1024"/&gt;
         *             &lt;/restriction&gt;
         *           &lt;/simpleType&gt;
         *         &lt;/element&gt;
         *         &lt;element name="Destination" minOccurs="0"&gt;
         *           &lt;simpleType&gt;
         *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *               &lt;maxLength value="1024"/&gt;
         *             &lt;/restriction&gt;
         *           &lt;/simpleType&gt;
         *         &lt;/element&gt;
         *         &lt;element name="DestinationType" minOccurs="0"&gt;
         *           &lt;simpleType&gt;
         *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *               &lt;maxLength value="1024"/&gt;
         *             &lt;/restriction&gt;
         *           &lt;/simpleType&gt;
         *         &lt;/element&gt;
         *         &lt;element name="TransactionID" minOccurs="0"&gt;
         *           &lt;simpleType&gt;
         *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *               &lt;maxLength value="1024"/&gt;
         *             &lt;/restriction&gt;
         *           &lt;/simpleType&gt;
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
        @XmlType(name = "", propOrder = {
            "applicationCode",
            "functionCode",
            "verificationCode",
            "customerAccount",
            "destination",
            "destinationType",
            "transactionID"
        })
        public static class Verification {

            @XmlElement(name = "ApplicationCode", required = true)
            protected String applicationCode;
            @XmlElement(name = "FunctionCode", required = true)
            protected String functionCode;
            @XmlElement(name = "VerificationCode", required = true)
            protected String verificationCode;
            @XmlElement(name = "CustomerAccount")
            protected String customerAccount;
            @XmlElement(name = "Destination")
            protected String destination;
            @XmlElement(name = "DestinationType")
            protected String destinationType;
            @XmlElement(name = "TransactionID")
            protected String transactionID;

            /**
             * Gets the value of the applicationCode property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getApplicationCode() {
                return applicationCode;
            }

            /**
             * Sets the value of the applicationCode property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setApplicationCode(String value) {
                this.applicationCode = value;
            }

            /**
             * Gets the value of the functionCode property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getFunctionCode() {
                return functionCode;
            }

            /**
             * Sets the value of the functionCode property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setFunctionCode(String value) {
                this.functionCode = value;
            }

            /**
             * Gets the value of the verificationCode property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getVerificationCode() {
                return verificationCode;
            }

            /**
             * Sets the value of the verificationCode property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setVerificationCode(String value) {
                this.verificationCode = value;
            }

            /**
             * Gets the value of the customerAccount property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getCustomerAccount() {
                return customerAccount;
            }

            /**
             * Sets the value of the customerAccount property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setCustomerAccount(String value) {
                this.customerAccount = value;
            }

            /**
             * Gets the value of the destination property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getDestination() {
                return destination;
            }

            /**
             * Sets the value of the destination property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setDestination(String value) {
                this.destination = value;
            }

            /**
             * Gets the value of the destinationType property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getDestinationType() {
                return destinationType;
            }

            /**
             * Sets the value of the destinationType property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setDestinationType(String value) {
                this.destinationType = value;
            }

            /**
             * Gets the value of the transactionID property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getTransactionID() {
                return transactionID;
            }

            /**
             * Sets the value of the transactionID property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setTransactionID(String value) {
                this.transactionID = value;
            }

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
     *         &lt;element name="Version"&gt;
     *           &lt;simpleType&gt;
     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *               &lt;maxLength value="32"/&gt;
     *             &lt;/restriction&gt;
     *           &lt;/simpleType&gt;
     *         &lt;/element&gt;
     *         &lt;element name="CommandID"&gt;
     *           &lt;simpleType&gt;
     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *               &lt;maxLength value="64"/&gt;
     *             &lt;/restriction&gt;
     *           &lt;/simpleType&gt;
     *         &lt;/element&gt;
     *         &lt;element name="LanguageCode" minOccurs="0"&gt;
     *           &lt;simpleType&gt;
     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *               &lt;maxLength value="10"/&gt;
     *             &lt;/restriction&gt;
     *           &lt;/simpleType&gt;
     *         &lt;/element&gt;
     *         &lt;element name="OriginatorConversationID" minOccurs="0"&gt;
     *           &lt;simpleType&gt;
     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *               &lt;maxLength value="128"/&gt;
     *             &lt;/restriction&gt;
     *           &lt;/simpleType&gt;
     *         &lt;/element&gt;
     *         &lt;element name="ConversationID" minOccurs="0"&gt;
     *           &lt;simpleType&gt;
     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *               &lt;maxLength value="36"/&gt;
     *             &lt;/restriction&gt;
     *           &lt;/simpleType&gt;
     *         &lt;/element&gt;
     *         &lt;element name="Caller"&gt;
     *           &lt;complexType&gt;
     *             &lt;complexContent&gt;
     *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                 &lt;sequence&gt;
     *                   &lt;element name="CallerType" type="{http://www.w3.org/2001/XMLSchema}integer"/&gt;
     *                   &lt;element name="ThirdPartyID"&gt;
     *                     &lt;simpleType&gt;
     *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                         &lt;maxLength value="20"/&gt;
     *                       &lt;/restriction&gt;
     *                     &lt;/simpleType&gt;
     *                   &lt;/element&gt;
     *                   &lt;element name="Password" type="{http://cps.huawei.com/cpsinterface/common}SecurityCredentialType"/&gt;
     *                   &lt;element name="CheckSum" minOccurs="0"&gt;
     *                     &lt;simpleType&gt;
     *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                         &lt;maxLength value="1024"/&gt;
     *                       &lt;/restriction&gt;
     *                     &lt;/simpleType&gt;
     *                   &lt;/element&gt;
     *                   &lt;element name="ResultURL" minOccurs="0"&gt;
     *                     &lt;simpleType&gt;
     *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                         &lt;maxLength value="1024"/&gt;
     *                       &lt;/restriction&gt;
     *                     &lt;/simpleType&gt;
     *                   &lt;/element&gt;
     *                 &lt;/sequence&gt;
     *               &lt;/restriction&gt;
     *             &lt;/complexContent&gt;
     *           &lt;/complexType&gt;
     *         &lt;/element&gt;
     *         &lt;element name="KeyOwner" type="{http://www.w3.org/2001/XMLSchema}integer"/&gt;
     *         &lt;element name="AccessDevice" minOccurs="0"&gt;
     *           &lt;complexType&gt;
     *             &lt;complexContent&gt;
     *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                 &lt;sequence&gt;
     *                   &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
     *                   &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
     *                 &lt;/sequence&gt;
     *               &lt;/restriction&gt;
     *             &lt;/complexContent&gt;
     *           &lt;/complexType&gt;
     *         &lt;/element&gt;
     *         &lt;element name="Timestamp"&gt;
     *           &lt;simpleType&gt;
     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *               &lt;maxLength value="25"/&gt;
     *             &lt;/restriction&gt;
     *           &lt;/simpleType&gt;
     *         &lt;/element&gt;
     *         &lt;element name="ChannelCode" minOccurs="0"&gt;
     *           &lt;simpleType&gt;
     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *               &lt;minLength value="1"/&gt;
     *               &lt;maxLength value="64"/&gt;
     *             &lt;/restriction&gt;
     *           &lt;/simpleType&gt;
     *         &lt;/element&gt;
     *         &lt;element name="ChannelSessionId" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
     *         &lt;element name="HeaderExtension" minOccurs="0"&gt;
     *           &lt;complexType&gt;
     *             &lt;complexContent&gt;
     *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                 &lt;sequence&gt;
     *                   &lt;element name="Extension" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
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
    @XmlType(name = "", propOrder = {
        "version",
        "commandID",
        "languageCode",
        "originatorConversationID",
        "conversationID",
        "caller",
        "keyOwner",
        "accessDevice",
        "timestamp",
        "channelCode",
        "channelSessionId",
        "headerExtension"
    })
    public static class Header {

        @XmlElement(name = "Version", required = true)
        protected String version;
        @XmlElement(name = "CommandID", required = true)
        protected String commandID;
        @XmlElement(name = "LanguageCode")
        protected String languageCode;
        @XmlElement(name = "OriginatorConversationID")
        protected String originatorConversationID;
        @XmlElement(name = "ConversationID")
        protected String conversationID;
        @XmlElement(name = "Caller", required = true)
        protected Request.Header.Caller caller;
        @XmlElement(name = "KeyOwner", required = true)
        protected BigInteger keyOwner;
        @XmlElement(name = "AccessDevice")
        protected Request.Header.AccessDevice accessDevice;
        @XmlElement(name = "Timestamp", required = true)
        protected String timestamp;
        @XmlElement(name = "ChannelCode")
        protected String channelCode;
        @XmlElement(name = "ChannelSessionId")
        protected String channelSessionId;
        @XmlElement(name = "HeaderExtension")
        protected Request.Header.HeaderExtension headerExtension;

        /**
         * Gets the value of the version property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getVersion() {
            return version;
        }

        /**
         * Sets the value of the version property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setVersion(String value) {
            this.version = value;
        }

        /**
         * Gets the value of the commandID property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getCommandID() {
            return commandID;
        }

        /**
         * Sets the value of the commandID property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setCommandID(String value) {
            this.commandID = value;
        }

        /**
         * Gets the value of the languageCode property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getLanguageCode() {
            return languageCode;
        }

        /**
         * Sets the value of the languageCode property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setLanguageCode(String value) {
            this.languageCode = value;
        }

        /**
         * Gets the value of the originatorConversationID property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getOriginatorConversationID() {
            return originatorConversationID;
        }

        /**
         * Sets the value of the originatorConversationID property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setOriginatorConversationID(String value) {
            this.originatorConversationID = value;
        }

        /**
         * Gets the value of the conversationID property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getConversationID() {
            return conversationID;
        }

        /**
         * Sets the value of the conversationID property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setConversationID(String value) {
            this.conversationID = value;
        }

        /**
         * Gets the value of the caller property.
         * 
         * @return
         *     possible object is
         *     {@link Request.Header.Caller }
         *     
         */
        public Request.Header.Caller getCaller() {
            return caller;
        }

        /**
         * Sets the value of the caller property.
         * 
         * @param value
         *     allowed object is
         *     {@link Request.Header.Caller }
         *     
         */
        public void setCaller(Request.Header.Caller value) {
            this.caller = value;
        }

        /**
         * Gets the value of the keyOwner property.
         * 
         * @return
         *     possible object is
         *     {@link BigInteger }
         *     
         */
        public BigInteger getKeyOwner() {
            return keyOwner;
        }

        /**
         * Sets the value of the keyOwner property.
         * 
         * @param value
         *     allowed object is
         *     {@link BigInteger }
         *     
         */
        public void setKeyOwner(BigInteger value) {
            this.keyOwner = value;
        }

        /**
         * Gets the value of the accessDevice property.
         * 
         * @return
         *     possible object is
         *     {@link Request.Header.AccessDevice }
         *     
         */
        public Request.Header.AccessDevice getAccessDevice() {
            return accessDevice;
        }

        /**
         * Sets the value of the accessDevice property.
         * 
         * @param value
         *     allowed object is
         *     {@link Request.Header.AccessDevice }
         *     
         */
        public void setAccessDevice(Request.Header.AccessDevice value) {
            this.accessDevice = value;
        }

        /**
         * Gets the value of the timestamp property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getTimestamp() {
            return timestamp;
        }

        /**
         * Sets the value of the timestamp property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setTimestamp(String value) {
            this.timestamp = value;
        }

        /**
         * Gets the value of the channelCode property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getChannelCode() {
            return channelCode;
        }

        /**
         * Sets the value of the channelCode property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setChannelCode(String value) {
            this.channelCode = value;
        }

        /**
         * Gets the value of the channelSessionId property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getChannelSessionId() {
            return channelSessionId;
        }

        /**
         * Sets the value of the channelSessionId property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setChannelSessionId(String value) {
            this.channelSessionId = value;
        }

        /**
         * Gets the value of the headerExtension property.
         * 
         * @return
         *     possible object is
         *     {@link Request.Header.HeaderExtension }
         *     
         */
        public Request.Header.HeaderExtension getHeaderExtension() {
            return headerExtension;
        }

        /**
         * Sets the value of the headerExtension property.
         * 
         * @param value
         *     allowed object is
         *     {@link Request.Header.HeaderExtension }
         *     
         */
        public void setHeaderExtension(Request.Header.HeaderExtension value) {
            this.headerExtension = value;
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
         *         &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
         *         &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
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
            "identifierType",
            "identifier"
        })
        public static class AccessDevice {

            @XmlElement(name = "IdentifierType", required = true)
            protected String identifierType;
            @XmlElement(name = "Identifier", required = true)
            protected String identifier;

            /**
             * Gets the value of the identifierType property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getIdentifierType() {
                return identifierType;
            }

            /**
             * Sets the value of the identifierType property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setIdentifierType(String value) {
                this.identifierType = value;
            }

            /**
             * Gets the value of the identifier property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getIdentifier() {
                return identifier;
            }

            /**
             * Sets the value of the identifier property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setIdentifier(String value) {
                this.identifier = value;
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
         *         &lt;element name="CallerType" type="{http://www.w3.org/2001/XMLSchema}integer"/&gt;
         *         &lt;element name="ThirdPartyID"&gt;
         *           &lt;simpleType&gt;
         *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *               &lt;maxLength value="20"/&gt;
         *             &lt;/restriction&gt;
         *           &lt;/simpleType&gt;
         *         &lt;/element&gt;
         *         &lt;element name="Password" type="{http://cps.huawei.com/cpsinterface/common}SecurityCredentialType"/&gt;
         *         &lt;element name="CheckSum" minOccurs="0"&gt;
         *           &lt;simpleType&gt;
         *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *               &lt;maxLength value="1024"/&gt;
         *             &lt;/restriction&gt;
         *           &lt;/simpleType&gt;
         *         &lt;/element&gt;
         *         &lt;element name="ResultURL" minOccurs="0"&gt;
         *           &lt;simpleType&gt;
         *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *               &lt;maxLength value="1024"/&gt;
         *             &lt;/restriction&gt;
         *           &lt;/simpleType&gt;
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
        @XmlType(name = "", propOrder = {
            "callerType",
            "thirdPartyID",
            "password",
            "checkSum",
            "resultURL"
        })
        public static class Caller {

            @XmlElement(name = "CallerType", required = true)
            protected BigInteger callerType;
            @XmlElement(name = "ThirdPartyID", required = true)
            protected String thirdPartyID;
            @XmlElement(name = "Password", required = true)
            protected String password;
            @XmlElement(name = "CheckSum")
            protected String checkSum;
            @XmlElement(name = "ResultURL")
            protected String resultURL;

            /**
             * Gets the value of the callerType property.
             * 
             * @return
             *     possible object is
             *     {@link BigInteger }
             *     
             */
            public BigInteger getCallerType() {
                return callerType;
            }

            /**
             * Sets the value of the callerType property.
             * 
             * @param value
             *     allowed object is
             *     {@link BigInteger }
             *     
             */
            public void setCallerType(BigInteger value) {
                this.callerType = value;
            }

            /**
             * Gets the value of the thirdPartyID property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getThirdPartyID() {
                return thirdPartyID;
            }

            /**
             * Sets the value of the thirdPartyID property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setThirdPartyID(String value) {
                this.thirdPartyID = value;
            }

            /**
             * Gets the value of the password property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getPassword() {
                return password;
            }

            /**
             * Sets the value of the password property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setPassword(String value) {
                this.password = value;
            }

            /**
             * Gets the value of the checkSum property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getCheckSum() {
                return checkSum;
            }

            /**
             * Sets the value of the checkSum property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setCheckSum(String value) {
                this.checkSum = value;
            }

            /**
             * Gets the value of the resultURL property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getResultURL() {
                return resultURL;
            }

            /**
             * Sets the value of the resultURL property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setResultURL(String value) {
                this.resultURL = value;
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
         *         &lt;element name="Extension" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
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
            "extension"
        })
        public static class HeaderExtension {

            @XmlElement(name = "Extension", required = true)
            protected List<ParameterType> extension;

            /**
             * Gets the value of the extension property.
             * 
             * <p>
             * This accessor method returns a reference to the live list,
             * not a snapshot. Therefore any modification you make to the
             * returned list will be present inside the Jakarta XML Binding object.
             * This is why there is not a <CODE>set</CODE> method for the extension property.
             * 
             * <p>
             * For example, to add a new item, do as follows:
             * <pre>
             *    getExtension().add(newItem);
             * </pre>
             * 
             * 
             * <p>
             * Objects of the following type(s) are allowed in the list
             * {@link ParameterType }
             * 
             * 
             */
            public List<ParameterType> getExtension() {
                if (extension == null) {
                    extension = new ArrayList<ParameterType>();
                }
                return this.extension;
            }

        }

    }

}
