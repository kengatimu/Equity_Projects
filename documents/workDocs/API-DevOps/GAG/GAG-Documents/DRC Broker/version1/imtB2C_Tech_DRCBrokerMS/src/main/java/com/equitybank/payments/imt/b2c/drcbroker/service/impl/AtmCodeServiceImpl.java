package com.equitybank.payments.imt.b2c.drcbroker.service.impl;

import com.equitybank.payments.imt.b2c.drcbroker.domain.AtmCodeDetails;
import com.equitybank.payments.imt.b2c.drcbroker.service.*;
import com.equitybank.payments.imt.b2c.drcbroker.service.dto.BrokerServiceAtmCodeDTO;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.request.AtmCodeRequest;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.request.BusinessServiceRequestModel;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.BusinessServiceResponseModel;
import com.equitybank.payments.imt.b2c.drcbroker.service.util.HttpUtil;
import com.equitybank.payments.imt.b2c.drcbroker.service.util.JAXBMarshaller;
import com.equitybank.payments.imt.b2c.drcbroker.service.util.XMLToJsonConverter;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class AtmCodeServiceImpl implements AtmCodeService {
    private static final Logger log = LoggerFactory.getLogger(AtmCodeServiceImpl.class);

    private final SendToWalletService sendToWalletService;
    private final ValidationService validationService;
    private final DataPersistenceService dataPersistenceService;
    private final ManualMapperService manualMapperService;
    private final XMLToJsonConverter xmlToJsonConverter;
    private final ModelMapperService modelMapperService;
    private final JAXBMarshaller jaxbMarshaller;
    private final HttpUtil httpUtil;
    private final Gson gson;

    @Autowired
    public AtmCodeServiceImpl(SendToWalletService sendToWalletService, ValidationService validationService, DataPersistenceService dataPersistenceService, ManualMapperService manualMapperService, XMLToJsonConverter xmlToJsonConverter, ModelMapperService modelMapperService, JAXBMarshaller jaxbMarshaller, HttpUtil httpUtil, Gson gson) {
        this.sendToWalletService = sendToWalletService;
        this.validationService = validationService;
        this.dataPersistenceService = dataPersistenceService;
        this.manualMapperService = manualMapperService;
        this.xmlToJsonConverter = xmlToJsonConverter;
        this.modelMapperService = modelMapperService;
        this.jaxbMarshaller = jaxbMarshaller;
        this.httpUtil = httpUtil;
        this.gson = gson;
    }

    @Override
    public BrokerServiceAtmCodeDTO processRequest(String request, ErrorStatus errorStatus) {
        Map<String, String> resMap;
        Map<String, String> responseMap = new HashMap<>();

        //convert the xml request to an json
        String jsonRequest = xmlToJsonConverter.convertXMLToJson(request, errorStatus);
        if (jsonRequest == null) return null;

        //convert the jsonRequest to BusinessServiceRequestModel Object
        BusinessServiceRequestModel requestModel = getRequestObject(jsonRequest);

        //validate inputs
        String type = "AtmCode";
        BusinessServiceRequestModel validatedRequestModel = validationService.validateInputs(requestModel, type, errorStatus);
        if (validatedRequestModel == null) return null;

        //map validatedRequestModel to BrokerServiceAtmCodeDTO
        String rrn = requestModel.getEazzycash().getRrn();
        type = "brokerServiceAtmCodeDTO";
        BrokerServiceAtmCodeDTO brokerServiceAtmCodeDTO = (BrokerServiceAtmCodeDTO) manualMapperService.mapValuesManually(validatedRequestModel, type, rrn, errorStatus);
        if (brokerServiceAtmCodeDTO == null) return null;

        //prepare broker request
        type = "brokerServiceAtmCodeRequest";
        AtmCodeRequest brokerRequest = (AtmCodeRequest) manualMapperService.mapValuesManually(brokerServiceAtmCodeDTO, type, rrn, errorStatus);
        if (brokerRequest == null) return null;

        //convert BrokerServiceAtmCodeRequest to json
        String jsonBrokerRequest = getRequestString(brokerRequest);

        //map brokerServiceAtmCodeRequest to entity
        type = "entity";
        String beneficiary = validatedRequestModel.getEazzycash().getNumber();
        AtmCodeDetails entity = (AtmCodeDetails) modelMapperService.mapObjects(brokerServiceAtmCodeDTO, type, beneficiary, rrn, errorStatus);
        if (entity == null) return null;

        //persist initial records to db
        type = "AtmCodeDetailsInitial";
        entity.setTelcoRequest(jsonBrokerRequest);
        entity.setBusinessServiceRequest(request);
        String status = dataPersistenceService.persistData(entity, null, type, errorStatus);
        if (status == null) return null;

        //send request to broker
        type = "generateAtmCode";
        resMap = httpUtil.postRequest(jsonBrokerRequest, type, rrn, errorStatus);
        resMap.put("rrn", brokerRequest.getTransactionID());
        if (resMap.get("statusCode").equals("0")) return null;

        //reading the sync response
        String jsonResponse = resMap.get("jsonResponse");
        String httpStatus = resMap.get("httpStatusCode");
        if (!httpStatus.equals("200")) return null;

        //if success
        responseMap.put("status", "OK");
        responseMap.put("statusCode", resMap.get("statusCode"));
        responseMap.put("statusReason", resMap.get("statusReason"));
        responseMap.put("jsonResponse", jsonResponse);
        responseMap.put("rrn", rrn);

        //convert json to xml string
        BusinessServiceResponseModel responseModel = sendToWalletService.updateResponseModel(responseMap, requestModel, errorStatus);
        String xmlResponse = jaxbMarshaller.marshallXML(responseModel, errorStatus);
        if (xmlResponse == null) return null;

        //update Dto
        String tranId = resMap.get("tranId");
        brokerServiceAtmCodeDTO.setBusinessServiceInitialResponse(xmlResponse);
        brokerServiceAtmCodeDTO.setTransactionId(tranId);
        return brokerServiceAtmCodeDTO;
    }

    private BusinessServiceRequestModel getRequestObject(String jsonRequest) {
        return gson.fromJson(jsonRequest, BusinessServiceRequestModel.class);
    }

    private String getRequestString(AtmCodeRequest brokerRequest) {
        return gson.toJson(brokerRequest);
    }
}
