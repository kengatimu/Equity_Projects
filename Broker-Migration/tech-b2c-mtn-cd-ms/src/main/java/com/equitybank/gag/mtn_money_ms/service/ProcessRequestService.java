package com.equitybank.gag.mtn_money_ms.service;

import com.equitybank.gag.mtn_money_ms.exception.CustomException;

import java.util.Map;

public interface ProcessRequestService {
    String processNamecheckRequest(String nameCheckXmlRequest, Map<String, String> xmlMapValues, String type) throws CustomException;

    String processFloatPurchaseRequest(String channelXmlRequest, Map<String, String> xmlMapValues, String rrn, String type) throws CustomException;

    String processFloatPurchaseStatusRequest(String channelXmlRequest, Map<String, String> xmlMapValues, String rrn, String type) throws CustomException;

}
