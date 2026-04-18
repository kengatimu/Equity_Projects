package com.equitybank.payments.imt.b2c.drcbroker.service.impl;

import com.equitybank.payments.imt.b2c.drcbroker.domain.SendToWalletDetails;
import com.equitybank.payments.imt.b2c.drcbroker.service.*;
import com.equitybank.payments.imt.b2c.drcbroker.service.dto.BrokerServiceSendToWalletDTO;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.request.SendToWalletRequest;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.request.BusinessServiceRequestModel;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.SyncResponse;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.BusinessServiceResponseModel;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.Eazzycashres;
import com.equitybank.payments.imt.b2c.drcbroker.service.util.HttpUtil;
import com.equitybank.payments.imt.b2c.drcbroker.service.util.JAXBMarshaller;
import com.equitybank.payments.imt.b2c.drcbroker.service.util.XMLToJsonConverter;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Executor;

@Service
public class SendToWalletServiceImpl implements SendToWalletService {
    private static final Logger log = LoggerFactory.getLogger(SendToWalletServiceImpl.class);

    private final String DEFAULT_CURRENCY = "USD";
    private final ValidationService validationService;
    private final DataPersistenceService dataPersistenceService;
    private final ErrorCodes errorCodes;
    private final XMLToJsonConverter xmlToJsonConverter;
    private final ModelMapperService modelMapperService;
    private final JAXBMarshaller jaxbMarshaller;
    private final Executor taskExecutor;
    private final HttpUtil httpUtil;
    private final Gson gson;

    @Autowired
    public SendToWalletServiceImpl(ValidationService validationService, DataPersistenceService dataPersistenceService, ErrorCodes errorCodes, XMLToJsonConverter xmlToJsonConverter, ModelMapperService modelMapperService, JAXBMarshaller jaxbMarshaller, Executor taskExecutor, HttpUtil httpUtil, Gson gson) {
        this.validationService = validationService;
        this.dataPersistenceService = dataPersistenceService;
        this.errorCodes = errorCodes;
        this.xmlToJsonConverter = xmlToJsonConverter;
        this.modelMapperService = modelMapperService;
        this.jaxbMarshaller = jaxbMarshaller;
        this.taskExecutor = taskExecutor;
        this.httpUtil = httpUtil;
        this.gson = gson;
    }

    @Override
    public BrokerServiceSendToWalletDTO processRequest(String request, ErrorStatus errorStatus) {
        Map<String, String> resMap;
        Map<String, String> responseMap = new HashMap<>();
        BrokerServiceSendToWalletDTO brokerServiceSendToWalletDTO;

        String xmlResponse;
        String returnType;
        String beneficiary;
        String rrn;

        //convert the xml request to an json
        String jsonRequest = xmlToJsonConverter.convertXMLToJson(request, errorStatus);
        if (jsonRequest == null) return null;

        BusinessServiceRequestModel requestModel = gson.fromJson(jsonRequest, BusinessServiceRequestModel.class);

        //validate inputs
        String type = "SendToWallet";
        BusinessServiceRequestModel validatedRequestModel = validationService.validateInputs(requestModel, type, errorStatus);
        if (validatedRequestModel == null) return null;

        //map validatedRequestModel to BrokerServiceDTO
        beneficiary = validatedRequestModel.getEazzycash().getNumber();
        rrn = validatedRequestModel.getEazzycash().getRrn();
        returnType = "BrokerServiceSendToWalletDTO";
        brokerServiceSendToWalletDTO = (BrokerServiceSendToWalletDTO) modelMapperService.mapObjects(validatedRequestModel, returnType, beneficiary, rrn, errorStatus);
        if (brokerServiceSendToWalletDTO == null) return null;

        //adding currency to the dto
        brokerServiceSendToWalletDTO.getEazzycash().setCurrency(DEFAULT_CURRENCY);

        //prepare broker request
        SendToWalletRequest brokerRequest = prepareBrokerRequest(brokerServiceSendToWalletDTO);
        String jsonBrokerRequest = gson.toJson(brokerRequest);

        //manually map dto to entity
        SendToWalletDetails entity = mapDtoToEntity(brokerServiceSendToWalletDTO, jsonRequest, jsonBrokerRequest, request);

        //persist entity to db
        returnType = "BrokerServiceDetails";
        entity.setTelcoRequest(jsonBrokerRequest);
        String status = dataPersistenceService.persistData(entity, null, returnType, errorStatus);
        if (status == null) return null;

        //send request to broker
        type = "sendToWallet";
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
        BusinessServiceResponseModel responseModel = updateResponseModel(responseMap, requestModel, errorStatus);
        xmlResponse = jaxbMarshaller.marshallXML(responseModel, errorStatus);

        //update Dto
        String tranId = resMap.get("tranId");
        brokerServiceSendToWalletDTO.getEazzycash().setBusinessServiceInitialResponse(xmlResponse);
        brokerServiceSendToWalletDTO.getEazzycash().setTransactionId(tranId);
        return brokerServiceSendToWalletDTO;
    }

    public BusinessServiceResponseModel updateResponseModel(Map<String, String> responseMap, BusinessServiceRequestModel requestModel, ErrorStatus errorStatus) {
        BusinessServiceResponseModel res = new BusinessServiceResponseModel();
        Eazzycashres eazzycashres = new Eazzycashres();
        SyncResponse syncResponse = getSyncRes(responseMap.get("jsonResponse"));
        String status = responseMap.get("status");
        if (status.equalsIgnoreCase("OK")) {
            res.setMsgId(responseMap.get("rrn"));
            eazzycashres.setStatus("OK");
            eazzycashres.setTranID(syncResponse.getTransactionID() == null ? "" : syncResponse.getTransactionID());
            res.setEazzycashres(eazzycashres);
            return res;
        }
        String errorDesc = errorCodes.getErrorMsg(errorStatus.getStatusCode());
        res.setMsgId(errorStatus.getStatusMessage());
        eazzycashres.setStatus("ERROR|" + errorStatus.getStatusCode() + "|" + errorDesc + errorStatus.getStatusDesc());
        eazzycashres.setTranID("");
        res.setEazzycashres(eazzycashres);
        return res;
    }

    private SyncResponse getSyncRes(String jsonResponse) {
        return gson.fromJson(jsonResponse, SyncResponse.class);
    }

    private SendToWalletRequest prepareBrokerRequest(BrokerServiceSendToWalletDTO brokerServiceSendToWalletDTO) {
        SendToWalletRequest request = new SendToWalletRequest();
        request.setTransactionID(brokerServiceSendToWalletDTO.getEazzycash().getRrn());
        request.setBeneficiaryPhoneNumber(brokerServiceSendToWalletDTO.getEazzycash().getNumber());
//        request.setPhoneNumber(brokerServiceSendToWalletDTO.getEazzycash().getSender());
        request.setProviderName(brokerServiceSendToWalletDTO.getEazzycash().getTelco());
        request.setAmount(new BigDecimal(brokerServiceSendToWalletDTO.getEazzycash().getAmount()));
        request.setCurrency(brokerServiceSendToWalletDTO.getEazzycash().getCurrency());

        log.info("Broker Request::: " + gson.toJson(request));
        return request;
    }

    private SendToWalletDetails mapDtoToEntity(BrokerServiceSendToWalletDTO brokerServiceSendToWalletDTO, String jsonRequest, String jsonBrokerRequest, String request) {
        SendToWalletDetails entity = new SendToWalletDetails();
        entity.setAmount(brokerServiceSendToWalletDTO.getEazzycash().getAmount());
        entity.setCurrency(brokerServiceSendToWalletDTO.getEazzycash().getCurrency());
        entity.setRrn(brokerServiceSendToWalletDTO.getEazzycash().getRrn());
        entity.setSenderPhone(brokerServiceSendToWalletDTO.getEazzycash().getSender());
        entity.setSenderName(brokerServiceSendToWalletDTO.getEazzycash().getName());
        entity.setReceiverNumber(brokerServiceSendToWalletDTO.getEazzycash().getNumber());
        entity.setTelcoName(brokerServiceSendToWalletDTO.getEazzycash().getTelco());
        entity.setTelcoRequest(jsonBrokerRequest);
        entity.setBusinessServiceRequest(request);

        log.info("Database Entity Details::: " + entity);
        return entity;
    }
}
