/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.dto.vodacom.constants;

/**
 *
 * @author ronaldcheruiyot
 */
public class VodacomConstants {
    public static final String LOGIN_RESPONSE_EVENTID = "S:Envelope/S:Header/ns3:eventid";
    public static final String LOGIN_RESPONSE_TRANSACTIONID = "S:Envelope/S:Body/ns2:getGenericResultResponse/SOAPAPIResult/eventInfo/transactionID";
    public static final String LOGIN_RESPONSE_USERNAME = "Username";
    public static final String LOGIN_RESPONSE_PASSWORD = "Password";
    public static final String LOGIN_RESPONSE_SESSIONID = "SessionID";
    public static final String LOGIN_RESPONSE_EVENTCODE = "S:Envelope/S:Body/ns2:getGenericResultResponse/SOAPAPIResult/eventInfo/code";
    
    public static final String DISBURSEMENT_REQUEST_TP_REFERENCE = "ThirdPartyReference";
    public static final String DISBURSEMENT_REQUEST_CALLBACK_DEST = "CallBackDestination";
    
    public static final String DISBURSEMENT_RESPONSE_EVENTCODE = "S:Envelope/S:Body/ns2:getGenericResultResponse/SOAPAPIResult/eventInfo/code";
    public static final String DISBURSEMENT_RESPONSE_DESCRIPTION = "S:Envelope/S:Body/ns2:getGenericResultResponse/SOAPAPIResult/eventInfo/description";
    public static final String DISBURSEMENT_RESPONSE_INSIGHT_TXN_ID = "Insight_txid";
    
    public static final String CALLBACK_RESULT_CODE = "ResultCode";
    public static final String CALLBACK_RESULT_DESC = "ResultDesc";
    
    public static final String AIRTIME_RESPONSE_DESC = "soapenv:Envelope/soapenv:Body/api:Response/res:Body/res:ResponseDesc";
    public static final String AIRTIME_RESPONSE_SERVICE_STATUS = "soapenv:Envelope/soapenv:Body/api:Response/res:Body/res:ServiceStatus";
    public static final String AIRTIME_RESPONSE_ORIGINATOR_CONVERSATION_ID = "soapenv:Envelope/soapenv:Body/api:Response/res:Header/res:OriginatorConversationID";
    public static final String AIRTIME_RESPONSE_RESPONSE_CODE = "soapenv:Envelope/soapenv:Body/api:Response/res:Body/res:ResponseCode";
    public static final String AIRTIME_RESPONSE_CONVERSATION_ID = "soapenv:Envelope/soapenv:Body/api:Response/res:Header/res:ConversationID";
    public static final String AIRTIME_REQUEST_CALLBACK_DEST = "soapenv:Envelope/soapenv:Body/api:Request/req:Header/req:Caller/req:ResultURL";
    public static final String AIRTIME_REQUEST_ORIGINATOR_CONVERSATION_ID = "soapenv:Envelope/soapenv:Body/api:Request/req:Header/req:OriginatorConversationID";
    
    public static final String AIRTIME_CALLBACK_RESULT_TYPE = "soapenv:Envelope/soapenv:Body/api:Result/res:Body/res:ResultType";
    public static final String AIRTIME_CALLBACK_RESULT_CODE = "soapenv:Envelope/soapenv:Body/api:Result/res:Body/res:ResultCode";
    public static final String AIRTIME_CALLBACK_RESULT_DESC = "soapenv:Envelope/soapenv:Body/api:Result/res:Body/res:ResultDesc";
    public static final String AIRTIME_CALLBACK_CONVERSATION_ID = "soapenv:Envelope/soapenv:Body/api:Result/res:Header/res:ConversationID";
    public static final String AIRTIME_CALLBACK_ORIGINATOR_CONVERSATION_ID = "soapenv:Envelope/soapenv:Body/api:Result/res:Header/res:OriginatorConversationID";
    public static final String AIRTIME_CALLBACK_TRANSACTION_ID = "soapenv:Envelope/soapenv:Body/api:Result/res:Body/res:TransactionResult/res:TransactionID";
    
    public static final String B2B_LOGIN_RESPONSE_SESSION_ID = "Response/SessionID";
    public static final String B2B_LOGIN_RESPONSE_RESULT_DESC = "Response/ResultDesc";
    public static final String B2B_LOGIN_RESPONSE_RESULT_CODE = "Response/ResultCode";
    
    public static final String B2B_DISBURSEMENT_REQUEST_THIRD_PARTY_REFERENCE = "Request/ThirdPartyReference";
    public static final String B2B_DISBURSEMENT_REQUEST_CALLBACK_DESTINATION = "Request/CallBackDestination";
    public static final String B2B_DISBURSEMENT_REQUEST_TRANSACTION_ID = "Request/TransactionID";
    public static final String B2B_DISBURSEMENT_REQUEST_AMOUNT = "Request/Amount";
    
    public static final String B2B_DISBURSEMENT_RESPONSE_DESC = "Response/ResponseDesc";
    public static final String B2B_DISBURSEMENT_THIRD_PARTY_REFERENCE = "Response/ThirdPartyReference";
    public static final String B2B_DISBURSEMENT_RESPONSE_CODE = "Response/ResponseCode";
    public static final String B2B_DISBURSEMENT_RESPONSE_INSIGHT_TXN_ID = "Response/InsightTxID";
    public static final String B2B_DISBURSEMENT_RESPONSE_TRANSACTION_DATETIME = "Response/TransactionDateTime";
    
    public static final String B2B_CALLBACK_RESULT_CODE = "Result/ResultCode";
    public static final String B2B_CALLBACK_RESULT_DESC = "Result/ResultDesc";
    public static final String B2B_CALLBACK_RESULT_TRAN_ID = "Result/TransactionID";
    public static final String B2B_CALLBACK_RESULT_THIRD_PARTY_REFERENCE = "Result/ThirdPartyReference";
    public static final String B2B_CALLBACK_RESULT_AMOUNT = "Result/Amount";
    public static final String B2B_CALLBACK_RESULT_TRANSACTION_TIME = "Result/TransactionTime";
    
    

}
/**
 *Key: Result/InsightReference, Value: 12sdxq3634dadsas242
Key: Result/ResultCode, Value: 0
Key: Result/TransactionID, Value: X-BS281
Key: Result/ThirdPartyReference, Value: TestBank123456
Key: Result/ResultDesc, Value: Process service request successfully.
Key: Result/Amount, Value: 200
Key: Result/TransactionTime, Value: 20170301T22:59:01
Key: Result, Value: 
* 
* 
* 20250306220132
Key: soapenv:Envelope/soapenv:Body/api:Result/res:Body/res:ResultType, Value: 0
Key: soapenv:Envelope/soapenv:Body/api:Result/res:Header/res:Version, Value: 1.0
Key: soapenv:Envelope/soapenv:Body/api:Result/res:Header/res:ConversationID, Value: AG_20250305_10103e5633ad3668a656
Key: soapenv:Envelope/soapenv:Body/api:Result/res:Header/res:OriginatorConversationID, Value: 9941873
Key: soapenv:Envelope/soapenv:Body/api:Result/res:Body/res:ResultCode, Value: 0
Key: soapenv:Envelope/soapenv:Body/api:Result/res:Body/res:ResultDesc, Value: Process service request successfully.
Key: soapenv:Envelope/soapenv:Body/api:Result/res:Body/res:TransactionResult/res:TransactionID, Value: 0000009213659753
 */