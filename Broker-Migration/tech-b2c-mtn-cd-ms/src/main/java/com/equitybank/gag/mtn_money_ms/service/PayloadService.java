package com.equitybank.gag.mtn_money_ms.service;

import java.util.Map;

public interface PayloadService {
    String composeTelcoFloatNamecheckTelcoRequest(Map<String, String> xmlMapValues);

    String composeFloatPurchaseNameCheckSuccessResponse(Map<String, String> xmlMapValues, Map<String, String> extractedTelcoResponseMap);

    String composeNameCheckErrorResponse(Map<String, String> xmlMapValues);

    String composeTelcoFloatPurchaseTelcoRequest(Map<String, String> xmlMapValues);

    String composeFloatPurchaseSuccessResponse(Map<String, String> xmlMapValues, Map<String, String> extractedTelcoResponseMap);

    String composeFloatPurchaseErrorResponse(String rrn, String errorCode, String errorDescription);

    String composeFloatStatusCheckTelcoRequest(Map<String, String> xmlMapValues);

    String composeStatusCheckResponse(Map<String, String> xmlMapValues, Map<String, String> extractedTelcoResponseMap);

    String composeFloatStatusCheckDefaultErrorResponse(String rrn, String errorCode, String errorDescription);
}
