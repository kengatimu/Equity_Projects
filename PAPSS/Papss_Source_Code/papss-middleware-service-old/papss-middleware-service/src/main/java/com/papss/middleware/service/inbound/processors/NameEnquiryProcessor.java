package com.papss.middleware.service.inbound.processors;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.papss.middleware.config.CoreBankingProperties;
import com.papss.middleware.config.SystemConfig;
import com.papss.middleware.dto.nameinquiry.NameInquiryDto;
import com.papss.middleware.dto.nameinquiry.response.NameInquiryResponseDto;
import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.exception.ApiException;
import com.papss.middleware.service.inbound.domains.PartnerResponse;
import com.papss.middleware.service.PapssService;
import com.papss.middleware.service.PapssSignature;
import com.papss.middleware.service.inbound.MessageProcessor;
import com.papss.middleware.utils.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import montran.message.Message;
import org.springframework.http.*;
import org.springframework.stereotype.Service;

import javax.xml.datatype.XMLGregorianCalendar;
import java.util.Collections;
import java.util.Optional;

@Slf4j
@Service(value = "acmt.023")
@RequiredArgsConstructor
public class NameEnquiryProcessor implements MessageProcessor {

   // private final RetryableHttpClient httpClient;
    private final HttpClient httpClient;
    private final CoreBankingProperties coreBankingProperties;
    private final PapssSignature papssSignature;
    private final ResponseUtils responseUtils;
    private final PapssService papssService;
    private final SystemConfig systemConfig;
    private final ObjectMapper objectMapper;

    @Override
    public PartnerResponse processMessage(RtpMessageDto messageDto) {
        log.info("Processing Name Enquiry message");

        String payload = Optional.ofNullable(messageDto).map(RtpMessageDto::getContent).orElse(null);
        String papssId = messageDto.getPapssId();
        String bic = messageDto.getBic();

        try {
            Message message = Utils.unmarshallMessageResponse(payload);
            NameInquiryDto nameInquiryDto = RequestUtils.mapInwardNameInquiryDto(message);
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
            String request = objectMapper.writeValueAsString(nameInquiryDto);

            log.info("Sending name inquiry request to Core Banking {} ", request);
            log.debug("Name Inquiry request: {}", request);
            HttpEntity<String> entity = new HttpEntity<String>(request, headers);

            ResponseEntity<String> responseEntity = httpClient.postClient(coreBankingProperties.getUrl() + coreBankingProperties.getPath().getNameInquiry(), entity, messageDto.getSslKeyAlias(), String.class);

            String responseBody = responseEntity.getBody();

            log.info("Received response from Core Banking {} ",responseBody);
            log.debug("Name Inquiry response: {}",responseBody);

            boolean isProcessed = false;
            boolean isConfirmed = false;
            boolean isAccountVerified = false;
            if (responseEntity.getStatusCode().is2xxSuccessful()) {
                NameInquiryResponseDto nameInquiryResponse = objectMapper.readValue(responseBody, NameInquiryResponseDto.class);
                if (nameInquiryResponse.getStatus().getType().equalsIgnoreCase(ConstantUtils.ACCP)) {
                    isProcessed = true;
                    isAccountVerified = true;
                } else {
                    isProcessed = true;
                }

                XMLGregorianCalendar creationDateTime = Utils.generateZuluDateTime();
                String acmt024MessageId = Utils.generateMessageId(papssId);
                String acmt024Xml = responseUtils.generateResponseMessage(acmt024MessageId, creationDateTime, message, nameInquiryResponse, bic, papssId, isAccountVerified);

                String signedAcmt024Xml = papssSignature.generateSignature(acmt024Xml, messageDto.getSslKeyAlias(), messageDto.getKeyPass());

                RtpMessageDto acmt024Response = papssService.sendMessage(papssId, signedAcmt024Xml, messageDto.getSslKeyAlias());
                isConfirmed = papssService.confirmReceivedMessage(acmt024Response.getSequence(), papssId,  messageDto.getSslKeyAlias());
                //TODO: Come back to this name enquiry processor
            }else{
                papssService.confirmReceivedMessage(messageDto.getSequence(), papssId, messageDto.getSslKeyAlias());
                log.error("Error processing Name Enquiry message: {}", responseEntity.getBody());
            }

            return PartnerResponse.builder().message(responseEntity.getBody()).statusCode(responseEntity.getStatusCode().value()).build();
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new ApiException(HttpStatus.BAD_REQUEST, "Error processing Name Enquiry message");
        }
    }
}
