package com.papss.middleware.service.outbound;

import com.papss.middleware.config.SystemConfig;
import com.papss.middleware.utils.HttpClient;
import com.papss.middleware.utils.Utils;
import lombok.RequiredArgsConstructor;
import montran.positions.Positions;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class PositionsService {

    private final SystemConfig systemConfig;
    private final HttpClient httpClient;

    public Positions getParticipantPositions(String papssId, String sslKeyAlias) {

        String papssUrl = "https://" + systemConfig.getIpsBaseUrl() + ":" + systemConfig.getIpsPort() + "/papss/Positions";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_XML);
        headers.add("X-PAPSSRTP-Channel", papssId);

        HttpEntity<String> request = new HttpEntity<>(headers);

        ResponseEntity<String> response = httpClient.getClient(papssUrl, request, sslKeyAlias, String.class);

        return Utils.unmarshall(response.getBody(), Positions.class);
    }
}
