package com.equitybank.payments.imt.b2c.drcbroker.web.rest;

import com.equitybank.payments.imt.b2c.drcbroker.service.AtmCodeService;
import com.equitybank.payments.imt.b2c.drcbroker.service.SendToWalletService;
import com.equitybank.payments.imt.b2c.drcbroker.service.DataPersistenceService;
import com.equitybank.payments.imt.b2c.drcbroker.service.dto.BrokerServiceAtmCodeDTO;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.request.BusinessServiceRequestModel;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.BusinessServiceResponseModel;
import com.equitybank.payments.imt.b2c.drcbroker.service.util.JAXBMarshaller;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Executor;

@RestController
@RequestMapping(path = "/api/gag")
public class AtmCodeSyncResource {
    private static final Logger log = LoggerFactory.getLogger(AtmCodeSyncResource.class);

    private final SendToWalletService sendToWalletService;
    private final DataPersistenceService dataPersistenceService;
    private final AtmCodeService atmCodeService;
    private final JAXBMarshaller jaxbMarshaller;
    private final Executor taskExecutor;
    private final Gson gson;

    @Autowired
    public AtmCodeSyncResource(SendToWalletService sendToWalletService, DataPersistenceService dataPersistenceService, AtmCodeService atmCodeService, JAXBMarshaller jaxbMarshaller, Executor taskExecutor, Gson gson) {
        this.sendToWalletService = sendToWalletService;
        this.dataPersistenceService = dataPersistenceService;
        this.atmCodeService = atmCodeService;
        this.jaxbMarshaller = jaxbMarshaller;
        this.taskExecutor = taskExecutor;
        this.gson = gson;
    }

    @PostMapping(path = "/getatmcode",
            consumes = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE},
            produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<?> sendToWalletPost(@RequestBody String request) {
        log.info("Received XML String From Business Service: " + request);
        String type;
        String xmlResponse;
        BusinessServiceResponseModel responseModel;
        ErrorStatus errorStatus = new ErrorStatus();
        BrokerServiceAtmCodeDTO response = atmCodeService.processRequest(request, errorStatus);
        if (response == null) {
            Map<String, String> responseMap = new HashMap<>();
            responseMap.put("status", "NOK");
            responseModel = sendToWalletService.updateResponseModel(responseMap, new BusinessServiceRequestModel(), errorStatus);
            xmlResponse = jaxbMarshaller.marshallXML(responseModel, errorStatus);
            log.info("Error Occurred: " + gson.toJson(errorStatus));

            //update db with failure response
            type = "GetAtmCodeFailure";
            updateTransactionDetailsTable(xmlResponse, responseModel, type, errorStatus);
            return ResponseEntity.status(HttpStatus.NOT_ACCEPTABLE).body(xmlResponse);
        }
        xmlResponse = response.getBusinessServiceInitialResponse();

        //update db with Success response
        type = "GetAtmCodeSuccess";
        updateTransactionDetailsTable(xmlResponse, response, type, errorStatus);
        return ResponseEntity.status(HttpStatus.OK).body(xmlResponse);
    }

    private void updateTransactionDetailsTable(Object res, Object response, String type, ErrorStatus errorStatus) {
        taskExecutor.execute(() ->
                dataPersistenceService.persistData(res, response, type, errorStatus));
    }
}
