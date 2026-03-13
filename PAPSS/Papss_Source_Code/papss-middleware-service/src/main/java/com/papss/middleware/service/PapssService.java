package com.papss.middleware.service;

import com.papss.middleware.config.SystemConfig;
import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.enums.ErrorCodes;
import com.papss.middleware.utils.HttpClient;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Objects;

@Slf4j
@Service
@RequiredArgsConstructor
public class PapssService {
    private final SystemConfig systemConfig;
    private final HttpClient httpClient;

    public boolean confirmReceivedMessage(long sequence, String papssId, String sslKeyAlias) {
        log.info("Acknowledging the request {} ", sequence);
        boolean isConfirmed = false;

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_XML);
        headers.add("X-PAPSSRTP-Channel", papssId);
        headers.add("X-PAPSSRTP-MessageSeq", Long.toString(sequence));

        HttpEntity<String> request = new HttpEntity<>(headers);

        String papssUrl = "https://" + systemConfig.getIpsBaseUrl() + ":" + systemConfig.getIpsPort() + "/papss/MessageAck";


        ResponseEntity<String> response = httpClient.postClient(papssUrl, request, sslKeyAlias, String.class);
        if (Objects.requireNonNull(response.getBody()).equalsIgnoreCase("Stored")) {
            isConfirmed = true;
        }
        return isConfirmed;
    }

    public RtpMessageDto sendMessage(String papssId, String signedMsg, String sslKeyAlias) {

        String ipsDns = systemConfig.getIpsBaseUrl();
        String ipsPort = systemConfig.getIpsPort();

        String papssUrl = "https://" + ipsDns + ":" + ipsPort + "/papss/Message";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_XML);
        headers.add("X-PAPSSRTP-Channel", papssId);
        headers.add("X-PAPSS-RTP-Version", "1");
        headers.add("Host", ipsDns + ":" + ipsPort);
        headers.add("Accept", "*/*");
        headers.add("Accept-Encoding", "gzip");

        HttpEntity<String> request = new HttpEntity<>(signedMsg.replace("] as \"application/xml\"", ""), headers);

        ResponseEntity<String> replyFromIPS = httpClient.postClient(papssUrl, request, sslKeyAlias, String.class);

        String sts = replyFromIPS.getHeaders().get("X-PAPSSRTP-ReqSts").get(0);

        ErrorCodes errorCodeEnum;

        if (sts.equalsIgnoreCase("ACCP") | sts.equalsIgnoreCase("RCVD") | sts.equalsIgnoreCase("ACSP")
                | sts.equalsIgnoreCase("ACSC")) {
            errorCodeEnum = Arrays.stream(ErrorCodes.values())
                    .filter(errorCode -> errorCode.getMapping().equalsIgnoreCase(sts)).findFirst()
                    .orElse(ErrorCodes.UNKNOWN);
        } else {
            errorCodeEnum = Arrays.stream(ErrorCodes.values())
                    .filter(errorCode -> errorCode.getValue().equalsIgnoreCase(sts.substring(5))).findFirst()
                    .orElse(ErrorCodes.UNKNOWN);
        }

        return RtpMessageDto.builder()
                .messageType(replyFromIPS.getHeaders().get("X-PAPSSRTP-MessageType").get(0))
                .sequence(Long.valueOf(replyFromIPS.getHeaders().get("X-PAPSSRTP-MessageSeq").get(0)))
                .errorMapping(errorCodeEnum.getMapping())
                .statusCode(errorCodeEnum.getValue())
                .description(errorCodeEnum.getDescription()).content(replyFromIPS.getBody()).build();
    }

}
