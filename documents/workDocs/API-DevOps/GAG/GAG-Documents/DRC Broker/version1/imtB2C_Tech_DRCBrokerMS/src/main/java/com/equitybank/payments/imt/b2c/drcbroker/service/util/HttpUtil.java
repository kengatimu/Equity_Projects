package com.equitybank.payments.imt.b2c.drcbroker.service.util;

import com.equitybank.payments.imt.b2c.drcbroker.domain.ParamConfigs;
import com.equitybank.payments.imt.b2c.drcbroker.repository.ParamConfigsRepository;
import com.equitybank.payments.imt.b2c.drcbroker.service.impl.ErrorCodes;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.ErrorModel;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.SyncResponse;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.BusinessServiceResponseModel;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.Eazzycashres;
import com.google.gson.Gson;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Service
public class HttpUtil {
    private static final Logger log = LoggerFactory.getLogger(HttpUtil.class);

    private final ParamConfigsRepository paramConfigsRepository;
    private final ErrorCodes errorCodes;
    private final CloseableHttpClient closeableHttpClient;
    private final Gson gson;

    @Autowired
    public HttpUtil(ParamConfigsRepository paramConfigsRepository, ErrorCodes errorCodes, CloseableHttpClient closeableHttpClient, Gson gson) {
        this.paramConfigsRepository = paramConfigsRepository;
        this.errorCodes = errorCodes;
        this.closeableHttpClient = closeableHttpClient;
        this.gson = gson;
    }

    public Map<String, String> postRequest(String data, String type, String rrn, ErrorStatus errorStatus) {
        Map<String, String> res = new HashMap<>();
        String brokerEndpoint;
        String localEndpoint;
        String url;
        String tokenValue = "jwt-token";
        Optional<ParamConfigs> optionalTokenValue = paramConfigsRepository.findByConfigId(tokenValue);
        String token = optionalTokenValue.get().getConfigValue();
        log.info("JSON WEB TOKEN::: " + token);

        if (type.equalsIgnoreCase("sendToWallet")) {
            localEndpoint = "broker-send-to-wallet-endpoint";
            brokerEndpoint = "uat-broker-send-to-wallet-endpoint";
            Optional<ParamConfigs> optionalSendToWalletUrl = paramConfigsRepository.findByConfigId(brokerEndpoint);
//            Optional<BrokerParamConfigs> optionalSendToWalletUrl = paramConfigsRepository.findByConfigId(localEndpoint);
            String sendToWalletUrl = optionalSendToWalletUrl.get().getConfigValue();
            url = sendToWalletUrl;
        } else {
            localEndpoint = "local-broker-generate-atm-code-endpoint";
            brokerEndpoint = "uat-broker-generate-atm-code-endpoint";
            Optional<ParamConfigs> optionalGenerateAtmCodeUrl = paramConfigsRepository.findByConfigId(brokerEndpoint);
//            Optional<BrokerParamConfigs> optionalGenerateAtmCodeUrl = paramConfigsRepository.findByConfigId(localEndpoint);
            String generateAtmCodeUrl = optionalGenerateAtmCodeUrl.get().getConfigValue();
            url = generateAtmCodeUrl;
        }
        String statusReason;
        String jsonResponse;
        int httpStatusCode = 0;

        CloseableHttpResponse response = null;
        BusinessServiceResponseModel responseModel;
        log.info("Sending " + type + " Request To: " + url);
        try {
            HttpPost httpPost = new HttpPost(url);
            StringEntity entity = new StringEntity(data);
            httpPost.setEntity(entity);
            httpPost.setHeader("Accept", "application/json");
            httpPost.setHeader("Content-Type", "application/json");
            httpPost.setHeader("Authorization", "Bearer " + token);

            RequestConfig.Builder reqConfig = RequestConfig.custom();
            reqConfig.setConnectTimeout(40000);
            reqConfig.setConnectionRequestTimeout(40000);
            reqConfig.setSocketTimeout(40000);
            httpPost.setConfig(reqConfig.build());

            response = closeableHttpClient.execute(httpPost);
            httpStatusCode = response.getStatusLine().getStatusCode();
            statusReason = response.getStatusLine().getReasonPhrase();
            jsonResponse = EntityUtils.toString(response.getEntity());
            log.info("Request URl: " + url);
            log.info("StatusCode::: " + httpStatusCode);
            log.info("Status Reason::: " + statusReason);
            log.info("jsonResponse::: " + jsonResponse);

            if (httpStatusCode != 200) {
                if ((jsonResponse == null || jsonResponse.isEmpty())) {
                    errorStatus.setStatus("Failed");
                    errorStatus.setStatusCode("700");
                    errorStatus.setStatusDesc(" Time Out Occurred While Posting Request To PCES Broker. PCES Broker URL: " + url);
                    errorStatus.setStatusMessage(rrn);
                    errorStatus.setHttpStatusCode(httpStatusCode);
                    responseModel = getBusinessServiceResponse(rrn, errorStatus.getStatusCode(), errorStatus);
                    res.put("errorMessage", errorStatus.getStatusMessage() + errorStatus.getStatusDesc());
                    res.put("statusCode", String.valueOf(httpStatusCode));
                    res.put("bsResponse", gson.toJson(responseModel));
                    log.error("Time Out Occurred While Posting Request To PCES Broker. PCES Broker URL: " + url);
                    log.error(gson.toJson(responseModel));
                    return res;
                }
                ErrorModel errorModel = getBrokerError(jsonResponse);
                Integer code = errorModel.getCode();
                String message = errorModel.getMessage();

                errorStatus.setStatus("Failed");
                errorStatus.setStatusCode(String.valueOf(code));
                errorStatus.setStatusDesc(message);
                errorStatus.setStatusMessage(rrn);
                errorStatus.setHttpStatusCode(httpStatusCode);
                responseModel = getBusinessServiceResponse(rrn, errorStatus.getStatusCode(), errorStatus);
                res.put("errorMessage", errorStatus.getStatusMessage() + errorStatus.getHttpStatusDesc());
                res.put("statusCode", String.valueOf(code));
                res.put("bsResponse", gson.toJson(responseModel));
                res.put("httpStatusCode", String.valueOf(httpStatusCode));
                res.put("jsonResponse", jsonResponse);
                log.error("responseModel: " + gson.toJson(responseModel));
                return res;
            }
        } catch (Exception e) {
            String error = e.getMessage();
            String exceptionStatus;
            if (error.contains("timed out")) exceptionStatus = "Timeout Occurred.";
            else exceptionStatus = error;
            errorStatus.setStatus("Failed");
            errorStatus.setStatusCode("700");
            errorStatus.setHttpStatusCode(httpStatusCode);
            errorStatus.setStatusDesc(" Request To PCES Broker Failed. Connection To URL: " + url + " Refused. Exception::: " + exceptionStatus);
            errorStatus.setStatusMessage(rrn);
            responseModel = getBusinessServiceResponse(rrn, errorStatus.getStatusCode(), errorStatus);
            res.put("errorMessage", errorStatus.getStatusMessage() + errorStatus.getStatusDesc());
            res.put("statusCode", String.valueOf(httpStatusCode));
            res.put("bsResponse", gson.toJson(responseModel));
            log.error("Exception Occurred in HttpUtil.postRequest Method. Request To PCES Broker Failed. Connection To URL: " + url + " Refused. Exception::: " + exceptionStatus);
            return res;
        } finally {
            if (response != null) {
                try {
                    response.close();
                } catch (IOException e) {
                    log.error("IOException Exception Occurred While Closing CloseableHttpResponse Service::: " + e.getMessage());
                }
            }
        }
        res = new HashMap<>();
        SyncResponse syncResponse = getSyncResponse(jsonResponse);
        String status = syncResponse.getStatus();
//        String status = syncResponse.getStatus() == null ? "200" : syncResponse.getStatus();
        res.put("httpStatusCode", String.valueOf(httpStatusCode));
        res.put("statusCode", status);
        res.put("statusReason", statusReason);
        res.put("jsonResponse", jsonResponse);
        res.put("tranId", syncResponse.getTransactionID());
        log.info("ResponseMap::: " + (res));
        log.info("ResponseJson::: " + (gson.toJson(syncResponse)));
        return res;
    }

    private SyncResponse getSyncResponse(String jsonResponse) {
        return gson.fromJson(jsonResponse, SyncResponse.class);
    }

    private ErrorModel getBrokerError(String jsonResponse) {
        return gson.fromJson(jsonResponse, ErrorModel.class);
    }

    private BusinessServiceResponseModel getBusinessServiceResponse(String rrn, String statusCode, ErrorStatus errorStatus) {
        BusinessServiceResponseModel responseModel = new BusinessServiceResponseModel();
        Eazzycashres eazzycashres = new Eazzycashres();
        String errorDesc = errorCodes.getErrorMsg(statusCode);
        eazzycashres.setStatus("ERROR|" + errorStatus.getStatusCode() + "|" + errorDesc + errorStatus.getStatusDesc());
        eazzycashres.setTranID("");
        responseModel.setMsgId(rrn);
        responseModel.setEazzycashres(eazzycashres);
        return responseModel;
    }
}
