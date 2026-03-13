package com.papss.middleware.service.inbound.processors;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.papss.middleware.config.CoreBankingProperties;
import com.papss.middleware.dto.paymentreturn.PaymentRecallDto;
import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.dto.txnconfirmation.TxConfirmationDto;
import com.papss.middleware.service.PapssService;
import com.papss.middleware.service.PapssSignature;
import com.papss.middleware.service.inbound.MessageProcessor;
import com.papss.middleware.service.inbound.domains.PartnerResponse;
import com.papss.middleware.utils.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import montran.message.Message;
import org.springframework.context.ApplicationContext;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import javax.xml.datatype.XMLGregorianCalendar;
import java.util.Collections;
import java.util.Optional;

@Slf4j
@Service(value = "camt.056")
@RequiredArgsConstructor
public class RecallRequestProcessor implements MessageProcessor {

    private final RequestUtils requestUtils;

    private final ApplicationContext applicationContext;
    private final ResponseUtils responseUtils;
    private final HttpClient httpClient;
    private final CoreBankingProperties coreBankingProperties;
    private final PapssSignature papssSignature;
    private final PapssService papssService;

    @Override
    public PartnerResponse processMessage(RtpMessageDto messageDto) {
        String payload = Optional.ofNullable(messageDto).map(RtpMessageDto::getContent).orElse(null);
        Message message = Utils.unmarshallMessageResponse(payload);

        PaymentRecallDto recallRequestDto = PaymentRecallMapper.parseXMLToPaymentRecallDto(payload);
        XMLGregorianCalendar creationDateTime = Utils.generateZuluDateTime();

        String papssId = messageDto.getPapssId();
        String sslKeyAlias = messageDto.getSslKeyAlias();
        PartnerResponse partnerResponse = null;
        try {
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
            ObjectMapper objectMapper = new ObjectMapper();
            String request = objectMapper.writeValueAsString(recallRequestDto);

            log.info("Sending recall request to Core Banking");
            log.debug("Core Bank Request: {}", request);

            HttpEntity<String> entity = new HttpEntity<>(request, headers);

            boolean isConfirmed = false;
            boolean isProcessed = false;

            ResponseEntity<String> response = httpClient.postClient(coreBankingProperties.getUrl() + coreBankingProperties.getPath().getRecallRequest(), entity, messageDto.getSslKeyAlias(), String.class);
            if (response.getStatusCode().is2xxSuccessful()) {
                TxConfirmationDto txConfirmationResponse = objectMapper.readValue(response.getBody(), TxConfirmationDto.class);
                if ((txConfirmationResponse.getStatus().getType().equalsIgnoreCase(ConstantUtils.ACCP) || txConfirmationResponse.getStatus().getType().equalsIgnoreCase(ConstantUtils.ACSC))) {

                    isProcessed = true;
                    isConfirmed = true;
                   // String pacs002MessageId = Utils.generateMessageId("XA0001");

//                    String cam056Xml = generatePaymentCancellationRequest(message, cam056MessageId,
//                            creationDateTime, txConfirmationResponse);

                   // String pacs002Xml = responseUtils.generatePaymentResponseMessage(message, pacs002MessageId, isProcessed, creationDateTime, txConfirmationResponse);

                   // String signedPacs002Xml = papssSignature.generateSignature(pacs002Xml, messageDto.getSslKeyAlias(), messageDto.getKeyPass());

                    //log.info("PASS 002 Message: {}", pacs002Xml);
//
//                    RtpMessageDto pacs002Response = papssService.sendMessage(papssId, signedPacs002Xml, sslKeyAlias);
//                    pacs002Response.setBic(messageDto.getBic());
//                    pacs002Response.setSslKeyAlias(sslKeyAlias);
//                    pacs002Response.setPapssId(papssId);
//                    pacs002Response.setKeyPass(messageDto.getKeyPass());
//                    pacs002Response.setSequence(messageDto.getSequence());
//                    pacs002Response.setContent(signedPacs002Xml);
//
//                    MessageProcessor messageProcessor = applicationContext.getBean(pacs002Response.getMessageType(), MessageProcessor.class);
//                    partnerResponse = messageProcessor.processMessage(pacs002Response);


                    return PartnerResponse.builder().message("").statusCode(response.getStatusCode().value()).build();

                } else {
                    throw new RuntimeException("Transaction not successful");
                }
            }
            return partnerResponse;

        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }
}
