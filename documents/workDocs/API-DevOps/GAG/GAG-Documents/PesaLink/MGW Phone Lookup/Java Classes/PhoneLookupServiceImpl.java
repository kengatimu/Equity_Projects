package com.equitybank.payments.interbank.outbound.service.impl;

import com.equitybank.payments.interbank.outbound.service.ModelMapperService;
import com.equitybank.payments.interbank.outbound.service.PhoneLookupService;
import com.equitybank.payments.interbank.outbound.service.PhoneLookupXmlReaderService;
import com.equitybank.payments.interbank.outbound.service.dto.PhoneLookupDTO;
import com.equitybank.payments.interbank.outbound.service.model.error.ErrorStatus;
import com.equitybank.payments.interbank.outbound.service.model.request.business.service.PhoneLookupRequestModel;
import com.equitybank.payments.interbank.outbound.service.model.response.business.service.PhoneLookupResponseModel;
import com.equitybank.payments.interbank.outbound.service.utils.DummyResponse;
import com.equitybank.payments.interbank.outbound.service.utils.HttpUtil;
import com.google.gson.Gson;
import com.microsoft.applicationinsights.TelemetryClient;
import com.microsoft.applicationinsights.telemetry.SeverityLevel;
import org.modelmapper.ModelMapper;
import org.modelmapper.convention.MatchingStrategies;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class PhoneLookupServiceImpl implements PhoneLookupService {
    private static final Logger log = LoggerFactory.getLogger(PhoneLookupServiceImpl.class);

    private final PhoneLookupXmlReaderService phoneLookupXmlReaderService;
    private final ModelMapperService modelMapperService;
    private final HashMap<String, String> getConfigs;
    private final TelemetryClient telemetryClient;
    private final ModelMapper modelMapper;
    private final HttpUtil httpUtil;
    private final Gson gson;

    private final DummyResponse dummyResponse;

    @Autowired
    public PhoneLookupServiceImpl(PhoneLookupXmlReaderService phoneLookupXmlReaderService, ModelMapperService modelMapperService, HashMap<String, String> getConfigs, TelemetryClient telemetryClient, ModelMapper modelMapper, HttpUtil httpUtil, Gson gson, DummyResponse dummyResponse) {
        this.phoneLookupXmlReaderService = phoneLookupXmlReaderService;
        this.modelMapperService = modelMapperService;
        this.getConfigs = getConfigs;
        this.telemetryClient = telemetryClient;
        this.modelMapper = modelMapper;
        this.httpUtil = httpUtil;
        this.gson = gson;
        this.dummyResponse = dummyResponse;
    }

    @Override
    public PhoneLookupResponseModel lookupPhoneNumber(PhoneLookupRequestModel phoneLookupRequestModel, ErrorStatus errorStatus) {
        String phoneNumber = phoneLookupRequestModel.getReceiverPhone();
        PhoneLookupResponseModel responseModel;
        PhoneLookupDTO updatedPhoneLookupDTO;
        PhoneLookupDTO phoneLookupDTO;
        Map<String, String> resMap = new HashMap<>();
        try {
            //prepare dto
            phoneLookupDTO = prepareDto(phoneLookupRequestModel);

            //update dto with username and password
            updatedPhoneLookupDTO = updateDto(phoneLookupDTO);

            //prepare ipsl mgw lookup request xml string
            String ipslXmlRequest = modelMapperService.mapPhoneLookupRequestToXmlObject(updatedPhoneLookupDTO, errorStatus);
            if (ipslXmlRequest == null) return null;

            //send xml req to ipsl
            String type = "phoneLookup";
//            resMap = httpUtil.postRequest(ipslXmlRequest, phoneNumber, type, errorStatus);
//            if (resMap == null) return null;

            //TODO delete after testing
            // ****************************************************
            type = "multiple"; //single, multiple, userNotFound, none
            String xmlResDummy = dummyResponse.getXmlResponse(type);

            resMap.put("statusCode", "200");
            resMap.put("statusReason", "Success");
            resMap.put("xmlResponse", xmlResDummy);

            // ****************************************************

            //process the status
            log.info("IPSL Response: " + resMap.get("xmlResponse"));
            responseModel = phoneLookupXmlReaderService.readXmlResponse(resMap, updatedPhoneLookupDTO, phoneNumber, errorStatus);
            if (responseModel == null) return null;

        } catch (Exception ex) {
            errorStatus.setStatus("Failed");
            errorStatus.setStatusCode("01");
            errorStatus.setStatusDesc("Request Failed. Exception Occurred: " + ex.getMessage());
            log.error("Exception Occurred. PhoneLookupServiceImpl.lookupPhoneNumber Method: " + ex.getMessage());
            telemetryClient.trackTrace(phoneNumber + " Exception Occurred. PhoneLookupServiceImpl.lookupPhoneNumber Method: " + ex.getMessage(), SeverityLevel.Critical);
            return null;
        }
        return responseModel;
    }

    private PhoneLookupDTO updateDto(PhoneLookupDTO phoneLookupDTO) {
        String login = getConfigs.get("kba.inquire.username");
        String password = getConfigs.get("kba.inquire.password");

        phoneLookupDTO.setLogin(login);
        phoneLookupDTO.setPassword(password);
        return phoneLookupDTO;
    }

    private PhoneLookupDTO prepareDto(PhoneLookupRequestModel phoneLookupRequestModel) {
        modelMapper.getConfiguration().setMatchingStrategy(MatchingStrategies.STRICT);
        return modelMapper.map(phoneLookupRequestModel, PhoneLookupDTO.class);
    }
}
