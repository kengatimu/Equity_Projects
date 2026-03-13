/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.service.business.safaricom;

import com.equitybankgroup.payments.b2c.service.util.MiscUtil;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import lombok.Builder;
import lombok.Data;

/**
 *
 * @author ronaldcheruiyot
 */
@Builder
@Data
public class B2BRequest {
    
    private String spId;
    private String spPassword;
    private String serviceId;
    private String timestamp;
    
    private String originatorConversationID;
    private String conversationID;
    private String amount;
    private String shortCode;
    private String queueTimeoutURL;
    private String thirdPartyID;
    private String password;
    private String checkSum;
    private String resultURL;
    private String username;
    private String securityCredential;
    
    private String debitPartyShortCode;
    private String receiverPartyShortCode;
    
    public String getSoapRequest() throws NoSuchAlgorithmException {
        this.timestamp = MiscUtil.getCurrentTimestamp("yyyymmddhhmmss");
        return "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:req=\"http://api- v1.gen.mm.vodafone.com/mminterface/request\">\n" +
"    <soapenv:Header>\n" +
"        <tns:RequestSOAPHeader xmlns:tns=\"http://www.huawei.com.cn/schema/common/v2_1\">\n" +
"            <tns:spId>" + this.spId + "</tns:spId>\n" +
"            <tns:spPassword>" + this.getPasswordHash() + "</tns:spPassword>\n" +
"            <tns:serviceId>" + this.serviceId + "</tns:serviceId>\n" +
"            <tns:timeStamp>" + this.timestamp  + "</tns:timeStamp>\n" +
"        </tns:RequestSOAPHeader>\n" +
"    </soapenv:Header>\n" +
"    <soapenv:Body>\n" +
"        <req:RequestMsg>\n" +
"            <![CDATA[" + this.getB2BRequest() + "]]>\n" +
"</req:RequestMsg>\n" +
"</soapenv:Body>\n" +
"</soapenv:Envelope>";
    
    }
    
    private String getPasswordHash() throws NoSuchAlgorithmException {
        //Encrypted using Base64(sha256(SPid+Password+Timestamp))
        String input = this.spId + this.spPassword + this.timestamp;

        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] hashBytes = digest.digest(input.getBytes(StandardCharsets.UTF_8));

        return Base64.getEncoder().encodeToString(hashBytes);
    }
    
    private  String getB2BRequest()
    {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
"<request xmlns=\"http://api-v1.gen.mm.vodafone.com/mminterface/request\">\n" +
"    <Transaction>\n" +
"        <CommandID>BusinessDeposit</CommandID>\n" +
"        <LanguageCode/>\n" +
"        <OriginatorConversationID>" + this.originatorConversationID + "</OriginatorConversationID>\n" +
"        <ConversationID>" + this.conversationID + "</ConversationID>\n" +
"        <Remark> </Remark>\n" +
"        <Parameters>\n" +
"            <Parameter>\n" +
"                <Key>Amount</Key>\n" +
"                <Value>" + this.amount + "</Value>\n" +
"            </Parameter>\n" +
"            <Parameter>\n" +
"                <Key>ShortCode</Key>\n" +
"                <Value>" + this.shortCode + "</Value>\n" +
"            </Parameter>\n" +
"        </Parameters>\n" +
"        <ReferenceData>\n" +
"            <ReferenceItem>\n" +
"                <Key>QueueTimeoutURL</Key>\n" +
"                <Value>" + this.queueTimeoutURL + "</Value>\n" +
"            </ReferenceItem>\n" +
"            <ReferenceItem>\n" +
"                <Key>Occasion</Key>\n" +
"                <Value>Jamuhuri</Value>\n" +
"            </ReferenceItem>\n" +
"        </ReferenceData>\n" +
"        <Timestamp>" + MiscUtil.getCurrentTimestamp("yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'") + "</Timestamp>\n" +
"    </Transaction>\n" +
"    <Identity>\n" +
"        <Caller>\n" +
"            <CallerType>2</CallerType>\n" +
"            <ThirdPartyID>" + this.thirdPartyID + "</ThirdPartyID>\n" +
"            <Password>" + this.password + "</Password>\n" +
"            <CheckSum>" + this.checkSum + "</CheckSum>\n" +
"            <ResultURL>" + this.resultURL + "</ResultURL>\n" +
"        </Caller>\n" +
"        <Initiator>\n" +
"            <IdentifierType>11</IdentifierType>\n" +
"            <Identifier>" + this.username + "</Identifier>\n" +
"            <SecurityCredential>" + this.securityCredential + "</SecurityCredential>\n" +
"            <ShortCode>" + this.shortCode + "</ShortCode>\n" +
"        </Initiator>\n" +
"        <PrimaryParty>\n" +
"            <IdentifierType>4</IdentifierType>\n" +
"            <Identifier>" + this.debitPartyShortCode + "</Identifier>\n" +
"            <ShortCode></ShortCode>\n" +
"        </PrimaryParty>\n" +
"        <ReceiverParty>\n" +
"            <IdentifierType>2</IdentifierType>\n" +
"            <Identifier>" + this.receiverPartyShortCode + "</Identifier>\n" +
"            <ShortCode></ShortCode>\n" +
"        </ReceiverParty>\n" +
"        <AccessDevice>\n" +
"            <IdentifierType>1</IdentifierType>\n" +
"            <Identifier>Identifier3</Identifier>\n" +
"        </AccessDevice>\n" +
"    </Identity>\n" +
"    <KeyOwner>1</KeyOwner>\n" +
"</request>";
    }
    
}
