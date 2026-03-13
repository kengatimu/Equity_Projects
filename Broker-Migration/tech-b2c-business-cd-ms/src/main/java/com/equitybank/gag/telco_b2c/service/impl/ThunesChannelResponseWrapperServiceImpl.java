package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.dto.thunes.response.ChannelResponse;
import com.equitybank.gag.telco_b2c.dto.thunes.response.ChannelStatusInfo;
import com.equitybank.gag.telco_b2c.enums.TransactionStatus;
import com.equitybank.gag.telco_b2c.service.JsonKeyNormalizerService;
import com.equitybank.gag.telco_b2c.service.ThunesChannelResponseWrapperService;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.SUCCESS_CODE;

@Service
public class ThunesChannelResponseWrapperServiceImpl implements ThunesChannelResponseWrapperService {

    private static final Logger log = LoggerFactory.getLogger(ThunesChannelResponseWrapperServiceImpl.class);

    private final JsonKeyNormalizerService jsonKeyNormalizerService;

    public ThunesChannelResponseWrapperServiceImpl(JsonKeyNormalizerService jsonKeyNormalizerService) {
        this.jsonKeyNormalizerService = jsonKeyNormalizerService;
    }

    @Override
    public ChannelResponse wrapImtResponse(String imtResponseString) {
        // Parse the raw Thunes JSON string into a JSON element tree
        JsonElement parsed = JsonParser.parseString(imtResponseString);

        // Normalize all field names from snake_case to camelCase for consistency
        JsonElement normalizedCamelCaseResponse = jsonKeyNormalizerService.normalize(parsed);

        // Prepare the standard channel-level status block for successful processing
        ChannelStatusInfo statusInfo = new ChannelStatusInfo();
        statusInfo.setStatus(TransactionStatus.OK.name());
        statusInfo.setCode(SUCCESS_CODE);
        statusInfo.setDescription(TransactionStatus.OK.getDescription());

        // Combine the normalized Thunes response and status information into a single wrapper
        ChannelResponse response = new ChannelResponse();
        response.setRawResponse(normalizedCamelCaseResponse);
        response.setChannelStatusInfo(statusInfo);
        return response;
    }
}
