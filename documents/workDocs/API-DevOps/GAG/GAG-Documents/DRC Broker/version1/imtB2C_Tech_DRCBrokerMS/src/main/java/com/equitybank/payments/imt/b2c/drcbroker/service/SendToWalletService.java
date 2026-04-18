package com.equitybank.payments.imt.b2c.drcbroker.service;

import com.equitybank.payments.imt.b2c.drcbroker.service.dto.BrokerServiceSendToWalletDTO;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.request.BusinessServiceRequestModel;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.BusinessServiceResponseModel;

import java.util.Map;

public interface SendToWalletService {
    BrokerServiceSendToWalletDTO processRequest(String request, ErrorStatus errorStatus);
    BusinessServiceResponseModel updateResponseModel(Map<String, String> responseMap, BusinessServiceRequestModel requestModel, ErrorStatus errorStatus);
}
