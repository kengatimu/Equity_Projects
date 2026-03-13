package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.dto.thunes.creditParties.creditPartyInfo.CreditPartyInformation;
import com.equitybank.gag.telco_b2c.dto.thunes.creditParties.creditPartyVerify.CreditPartyVerify;
import com.equitybank.gag.telco_b2c.dto.thunes.transfer.quotation.CreateQuoteDto;
import com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction.TransactionRequestDto;
import com.equitybank.gag.telco_b2c.dto.wendi.namecheck.NamecheckRequest;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.enums.TransactionStatus;
import com.equitybank.gag.telco_b2c.exception.CustomException;

import java.util.Map;

public interface PayloadService {
    String transactionErrorResponseXml(String rrn, String errorCode, String errorDescription);

    String composeStatusCheckResponse(TransactionDetails transactionDetails, String rrn);

    String statusCheckErrorResponseXml(String rrn, String errorCode, String errorDescription);

    String airtimeTopUpErrorResponseXml(String version, String errorCode, String errorDescription);

    String composeFloatPurchaseErrorResponse(String rrn, String errorCode, String errorDescription, Map<String, String> finFloatXmlTagsMap, String channel);

    String imtDefaultErrorResponseXml(String rrn, String errorCode, String errorDescription, TransactionStatus status);

    String imtPendingResponseXml(String rrn, String errorCode, String errorDescription, TransactionStatus status);

    String imtFinalSuccessResponseXml(String rrn, Map<String, String> responseDetailsMap);

    String technicalServiceCallBackResponse(String rrn);

    String defaultTechnicalServiceErrorResponse(String errorCode, String errorDescription);

    String composeNameCheckErrorResponse(String rrn, String telcom, String channel, String mobileNumber, String type, Map<String, String> finXmlTagsMap, String errorDescription);

    String composeFinacleGetRateXmlRequest();

    String composeDefaultErrorResponse(String errorCode, String errorDescription);

    String getErrorResponse(request channelRequest, String responseCode, String responseDesc);

    String composeChannelCallbackSuccessResponse(Map<String, String> xmlTagsMap, String rrn);

    String composeChannelCallbackFailureResponse(Map<String, String> xmlTagsMap, String rrn);

    Object composeCallbackResponse(Map<String, String> xmlTagsMap);

    String finReqToFloatPurchaseNamecheckReq(Map<String, String> xmlTagsMap) throws CustomException;

    request finReqToFloatPurchaseTranReq(Map<String, String> xmlTagsMap) throws CustomException;

    String generateFinNamecheckResponse(String responseXml, Map<String, String> finXmlTagsMap) throws CustomException;

    String generateFinFloatPurchaseResponse(String responseXml, Map<String, String> finFloatXmlTagsMap) throws CustomException;

    String thunesErrorResponseXml(String rrn, String errorCode, String errorDescription);

    String wendiErrorResponseXml(String rrn, String errorCode, String errorDescription);

    String generateThunesCreditPartyInfoRequest(CreditPartyInformation creditPartyInformation) throws CustomException;

    String generateThunesCreditPartyVerifyRequest(CreditPartyVerify creditPartyVerify) throws CustomException;

    String generateThunesCreateQuoteRequest(CreateQuoteDto createQuoteDto) throws CustomException;

    String generateThunesC2CRequest(TransactionRequestDto req) throws CustomException;

    String generateThunesC2BRequest(TransactionRequestDto req) throws CustomException;

    String generateThunesB2BRequest(TransactionRequestDto req) throws CustomException;

    String generateWendiB2CNamecheckRequest(NamecheckRequest namecheckRequest);
}
