package com.papss.middleware.service.inbound.processors;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import com.papss.middleware.config.CoreBankingProperties;
import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.dto.txnconfirmation.TxConfirmationDto;
import com.papss.middleware.enums.Direction;
import com.papss.middleware.service.LoggerService;
import com.papss.middleware.service.PapssService;
import com.papss.middleware.service.PapssSignature;
import com.papss.middleware.service.inbound.MessageProcessor;
import com.papss.middleware.service.inbound.domains.PartnerResponse;
import com.papss.middleware.service.outbound.domains.creditreturn.CreditReturnRequest;
import com.papss.middleware.service.outbound.domains.credittransfer.CreditTransferRequest;
import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import com.papss.middleware.utils.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import montran.message.Message;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import javax.xml.datatype.XMLGregorianCalendar;
import java.util.Collections;
import java.util.Optional;

import static com.papss.middleware.utils.ConstantUtils.RJCT;

@Slf4j
@Service(value = "pacs.004")
@RequiredArgsConstructor
public class PaymentReturnProcessor implements MessageProcessor {

    private final ResponseUtils responseUtils;
    private final RequestUtils requestUtils;
    private final HttpClient httpClient;
    private final CoreBankingProperties coreBankingProperties;
    private final PapssSignature papssSignature;
    private final PapssService papssService;
    private final LoggerService loggerService;
    @Override
    public PartnerResponse processMessage(RtpMessageDto messageDto) {
        String payload = Optional.ofNullable(messageDto).map(RtpMessageDto::getContent).orElse(null);
        Message message = Utils.unmarshallMessageResponse(payload);

        XMLGregorianCalendar creationDateTime = Utils.generateZuluDateTime();
        PartnerResponse partnerResponse = null;
        String papssId = messageDto.getPapssId();
        String sslKeyAlias = messageDto.getSslKeyAlias();
        try {

            CreditReturnRequest paymentInitiation = CreditReturnMapper.mapXmlToCreditReturnRequest(message);

            log.info("Processing payment return request");
            log.debug("Payment Initiation: {}", paymentInitiation);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
            ObjectMapper objectMapper = new ObjectMapper();
            String request = objectMapper.writeValueAsString(paymentInitiation);

            log.info("Sending payment return request to Core Banking");
            log.debug("Core Bank Request: {}", request);

            HttpEntity<String> entity = new HttpEntity<>(request, headers);

            ResponseEntity<String> response = httpClient.postClient(coreBankingProperties.getUrl() + coreBankingProperties.getPath().getPaymentReturn(), entity, messageDto.getSslKeyAlias(), String.class);

            var jsonResponse = response.getBody();
            log.info("Received response from Core Banking");
            log.debug("Core Bank Response: {}", jsonResponse);

            boolean isConfirmed = false;
            boolean isProcessed = false;

            if (response.getStatusCode().is2xxSuccessful()) {
                TxConfirmationDto txConfirmationResponse = objectMapper.readValue(jsonResponse, TxConfirmationDto.class);

                loggerService.logTransaction(messageDto, txConfirmationResponse, Direction.IN);
                if ((txConfirmationResponse.getStatus().getType().equalsIgnoreCase(ConstantUtils.ACCP) || txConfirmationResponse.getStatus().getType().equalsIgnoreCase(ConstantUtils.ACSC))) {
                    isProcessed = true;
                    isConfirmed = true;
                }

                String pacs002MessageId = Utils.generateMessageId(papssId);

                String pacs002Xml = responseUtils.generatePaymentResponseMessage004(message, pacs002MessageId, isProcessed, creationDateTime, txConfirmationResponse);
                //String pacs002Xml = Pacs004ResponseUtil.createPacs004Response(pacs002MessageId, paymentInitiation.getEndToEndRef(), papssId, "", papssId, paymentInitiation.getOriginalTran().getSender().getAccountNumber(), paymentInitiation.getOriginalTran().getReceiver().getAccountNumber(), paymentInitiation.getOriginalTran().getSender().getAmount().toEngineeringString(), paymentInitiation.getOriginalTran().getSender().getCurrency());

                log.info("Sending payment return request to Core Banking {}", pacs002Xml);
                String signedPacs002Xml = papssSignature.generateSignature(pacs002Xml, messageDto.getSslKeyAlias(), messageDto.getKeyPass());

                log.info("Generated PACS.002 response message");
                log.debug("PACS.002 Message: {}", pacs002Xml);

                RtpMessageDto pacs002Response = papssService.sendMessage(papssId, signedPacs002Xml, sslKeyAlias);
                pacs002Response.setBic(messageDto.getBic());
                pacs002Response.setSslKeyAlias(sslKeyAlias);
                pacs002Response.setPapssId(papssId);
                pacs002Response.setKeyPass(messageDto.getKeyPass());
                pacs002Response.setSequence(messageDto.getSequence());
                pacs002Response.setContent(signedPacs002Xml);
                pacs002Response.setSequence(messageDto.getSequence());
                //MessageProcessor messageProcessor = applicationContext.getBean("pacs.002", MessageProcessor.class);
                partnerResponse = PartnerResponse.builder().message(pacs002Response.getContent()).statusCode(Integer.parseInt(pacs002Response.getStatusCode())).build();
            } else {
                TxConfirmationDto txConfirmationResponse = new TxConfirmationDto();
                txConfirmationResponse.setStatus(Status.builder().code(RJCT).type(RJCT).build());
                String pacs002MessageId = Utils.generateMessageId(papssId);

                String pacs002Xml = responseUtils.generatePaymentResponseMessage(message, pacs002MessageId, isProcessed, creationDateTime, txConfirmationResponse);

                String signedPacs002Xml = papssSignature.generateSignature(pacs002Xml, messageDto.getSslKeyAlias(), messageDto.getKeyPass());

                RtpMessageDto pacs002Response = papssService.sendMessage(papssId, signedPacs002Xml, sslKeyAlias);
                pacs002Response.setBic(messageDto.getBic());
                pacs002Response.setSslKeyAlias(sslKeyAlias);
                pacs002Response.setPapssId(papssId);
                pacs002Response.setKeyPass(messageDto.getKeyPass());
                pacs002Response.setSequence(messageDto.getSequence());
                pacs002Response.setContent(signedPacs002Xml);
                pacs002Response.setSequence(messageDto.getSequence());
                pacs002Response.setStatusCode("200");
                partnerResponse = PartnerResponse.builder().message(pacs002Response.getContent()).statusCode(Integer.parseInt(pacs002Response.getStatusCode())).build();

            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }

        return partnerResponse;
    }
}
