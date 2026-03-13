package com.papss.middleware.service;

import com.papss.middleware.config.SystemConfig;
import com.papss.middleware.enums.ParticipantType;
import com.papss.middleware.exception.ApiException;
import com.papss.middleware.models.participantinfo.Participants;
import com.papss.middleware.utils.HttpClient;
import com.papss.middleware.utils.Utils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.*;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Objects;

@Service
@Slf4j
@RequiredArgsConstructor
public class ParticipantInfoService {

    private final SystemConfig systemConfig;
    private final HttpClient httpClient;
    private final KeyStoreService keyStoreService;

    public Participants getAllParticipantsStatus(boolean isOnline, ParticipantType participantType, String countryCode, String papssId,
                                                 String sslKeyAlias) throws IOException {
        // Base URL construction
        StringBuilder urlBuilder = new StringBuilder("https://")
                .append(systemConfig.getIpsBaseUrl())
                .append(":")
                .append(systemConfig.getIpsPort())
                .append("/papss/api/participants?online=")
                .append(isOnline);

        // Add participantType parameter if provided
        if (participantType != null && StringUtils.isNotBlank(participantType.name())) {
            urlBuilder.append("&type=").append(participantType.name());
        }

        // Add countryCode parameter if provided
        if (countryCode != null && !countryCode.isEmpty()) {
            urlBuilder.append("&countryCode=").append(countryCode);
        }

        // Add papssId parameter if provided
        if (papssId != null && !papssId.isEmpty()) {
            urlBuilder.append("&papssId=").append(papssId);
        }

        String papssUrl = urlBuilder.toString();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_XML);
        headers.add("X-PAPSSRTP-Channel", papssId);

        HttpEntity<String> request = new HttpEntity<>(headers);

        ResponseEntity<String> responseEntity = httpClient.getClient(papssUrl, request, sslKeyAlias, String.class);

        String responseBody = responseEntity.getBody();

        if (Objects.isNull(responseBody)) {
            throw new ApiException(HttpStatus.BAD_REQUEST, "Response body is null");
        }
        responseBody = responseBody.replaceAll("&", "and");

        return Utils.unmarshall(responseBody, Participants.class);
    }

    public Participants getParticipantStatus(String papssId, String receivingPapssId, String sslKeyAlias) {

        String papssUrl = "https://" + systemConfig.getIpsBaseUrl() + ":" + systemConfig.getIpsPort() + "/papss/api/participants/PAPSSID/" + receivingPapssId;

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_XML);
        headers.add("X-PAPSSRTP-Channel", papssId);

        HttpEntity<String> request = new HttpEntity<>(headers);

        ResponseEntity<String> response = keyStoreService
                .getRestTemplate(sslKeyAlias)
                .exchange(papssUrl, HttpMethod.GET, request, String.class, receivingPapssId);

        String responseBody = response.getBody();
        if (Objects.isNull(responseBody)) {
            throw new ApiException(HttpStatus.BAD_REQUEST, "Response body is null");
        }
        responseBody = responseBody.replaceAll("&", "and");

        return Utils.unmarshall(responseBody, Participants.class);
    }
}
