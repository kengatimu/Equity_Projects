package com.papss.middleware.service.inbound.processors;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.papss.middleware.config.CoreBankingProperties;
import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.service.inbound.domains.PartnerResponse;
import com.papss.middleware.service.inbound.MessageProcessor;
import com.papss.middleware.utils.HttpClient;
import com.papss.middleware.utils.Utils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Collections;

import static com.papss.middleware.utils.ConstantUtils.requestId;

@Slf4j
@Service(value = "rcon.001")
@RequiredArgsConstructor
public class ReconProcessor implements MessageProcessor {

    private final HttpClient httpClient;
    private final CoreBankingProperties coreBankingProperties;

    @Override
    public PartnerResponse processMessage(RtpMessageDto message) {
        log.info("Processing Recon message");
        String responseMsg = null;
        int statusCode = 0;
        try {

            JsonNode jsonNode = Utils.toJsonNode(message.getContent());
            assert jsonNode != null;
            if (jsonNode.isObject()) {
                ObjectNode objectNode = (ObjectNode) jsonNode;
                objectNode.put(requestId, message.getSequence());
            }

            String coreBankingRequest = Utils.toJson(jsonNode);

            log.debug("Core Banking Request: {}", coreBankingRequest);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
            HttpEntity<String> entity = new HttpEntity<>(coreBankingRequest, headers);

            log.info("Sending reconciliation request to Core Banking");
            ResponseEntity<String> responseEntity = httpClient.postClient(coreBankingProperties.getUrl() + coreBankingProperties.getPath().getRecon(), entity, message.getSslKeyAlias(), String.class);

            responseMsg = responseEntity.getBody();
            statusCode = responseEntity.getStatusCode().value();
            log.info("Received response from Core Banking");
            log.debug("Core Banking Response: {}", responseMsg);
        } catch (Exception e) {
            log.error("Error processing Recon message: {}", e.getMessage(), e);
            return PartnerResponse.builder().message(e.getMessage()).statusCode(statusCode).build();
        }
        return PartnerResponse.builder().message(responseMsg).statusCode(statusCode).build();

    }
}
