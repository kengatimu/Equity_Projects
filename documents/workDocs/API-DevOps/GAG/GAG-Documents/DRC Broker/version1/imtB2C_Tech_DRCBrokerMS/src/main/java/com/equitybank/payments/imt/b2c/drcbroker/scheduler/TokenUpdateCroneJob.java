package com.equitybank.payments.imt.b2c.drcbroker.scheduler;

import com.equitybank.payments.imt.b2c.drcbroker.domain.ParamConfigs;
import com.equitybank.payments.imt.b2c.drcbroker.repository.ParamConfigsRepository;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.TokenModel;
import com.equitybank.payments.imt.b2c.drcbroker.service.util.HttpBrokerCall;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class TokenUpdateCroneJob {
    private static final Logger log = LoggerFactory.getLogger(TokenUpdateCroneJob.class);
    private final String TOKEN = "jwt-token";
    private final String BASE_URL = "token-broker-ip-address";
    private final String PREFIX = "https://";
    private final String SUFFIX = "/token";

    private final ParamConfigsRepository paramConfigsRepository;
    private final HttpBrokerCall httpBrokerCall;
    private final Environment environment;
    private final Gson gson;

    @Autowired
    public TokenUpdateCroneJob(ParamConfigsRepository paramConfigsRepository, HttpBrokerCall httpBrokerCall, Environment environment, Gson gson) {
        this.paramConfigsRepository = paramConfigsRepository;
        this.httpBrokerCall = httpBrokerCall;
        this.environment = environment;
        this.gson = gson;
    }

    //5 minutes
    @Scheduled(fixedRate = 300000)
//    @Scheduled(fixedRate = 10000)
    public void updateJwtValue() {
        log.info("CRONE JOB FOR TOKEN UPDATE STARTED...");
        ErrorStatus errorStatus = new ErrorStatus();
        String grantType = environment.getProperty("token.grant-type");
        String username = environment.getProperty("token.username");
        String password = environment.getProperty("token.password");
        String jsonRequest;
        ParamConfigs token;
        String response;
        String baseUrl;
        String url;

        Optional<ParamConfigs> optionalBrokerBaseUrl = paramConfigsRepository.findByConfigId(BASE_URL);
        if (optionalBrokerBaseUrl.isPresent()) {
            baseUrl = optionalBrokerBaseUrl.get().getConfigValue();
            url = PREFIX + baseUrl + SUFFIX;
            jsonRequest = "grant_type=" + grantType + "&" + "username=" + username + "&" + "password=" + password;
            response = httpBrokerCall.postJson(url, jsonRequest, errorStatus);
            log.info("CRONE JOB JWT TOKEN JSON STRING::: " + response);

            //get token values
            String tokenValue = getToken(response);
            log.info("CRONE JOB JWT TOKEN VALUE::: " + tokenValue);

            //update the token in the config table
            Optional<ParamConfigs> optionalToken = paramConfigsRepository.findByConfigId(TOKEN);
            if (optionalToken.isPresent()) {
                token = optionalToken.get();
                token.setConfigValue(tokenValue.trim());

                paramConfigsRepository.save(token);
            } else log.error("Config Value with Config Id: " + TOKEN + " Does Not Exist In Param Config Table");
        } else log.error("Config Value with Config Id: " + BASE_URL + " Does Not Exist In Param Config Table");
    }

    private String getToken(String response) {
        TokenModel tokenModel = gson.fromJson(response, TokenModel.class);
        log.info("Ingettoken:::: " + tokenModel.getAccess_token().trim());
        return tokenModel.getAccess_token().trim();
    }
}
