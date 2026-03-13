package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import java.security.SignatureException;
import java.util.Map;

import org.springframework.validation.BindingResult;

public interface DtoProcessingService {
    String processChannelRequest(boolean isInternal, request req, Envelope airtimeRequest, BindingResult result, String type) throws CustomException, SignatureException;

    String processCallbackRequest(Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException;
}
