package com.equitybank.gag.papss.its.service;

import com.equitybank.gag.papss.its.exception.CustomException;

import java.util.Map;

public interface PayloadXmlComposerService {
    String composeAcmt024SuccessResponse(String rrn, Map<String, String> requestMap) throws CustomException;

    String composeAcmt024NamecheckFailureResponse(String rrn, Map<String, String> requestMap, String errorCode) throws CustomException;

    String composePacs002SuccessResponse(Map<String, String> requestMap) throws CustomException;

    String composePacs002FailureResponse(Map<String, String> requestMap, String errorCode) throws CustomException;

    String composePacs004Reversal(Map<String, String> requestMap, String errorCode);
}
