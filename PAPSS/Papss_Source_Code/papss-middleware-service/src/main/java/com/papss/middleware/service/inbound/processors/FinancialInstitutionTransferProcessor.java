package com.papss.middleware.service.inbound.processors;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.papss.middleware.config.CoreBankingProperties;
import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.dto.txnconfirmation.TxConfirmationDto;
import com.papss.middleware.service.LoggerService;
import com.papss.middleware.service.PapssService;
import com.papss.middleware.service.PapssSignature;
import com.papss.middleware.service.inbound.MessageProcessor;
import com.papss.middleware.service.inbound.domains.PartnerResponse;
import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import com.papss.middleware.service.outbound.domains.financialinstitution.FinancialInstitutionRequest;
import com.papss.middleware.utils.RequestUtils;
import com.papss.middleware.utils.ResponseUtils;
import com.papss.middleware.utils.RetryableHttpClient;
import com.papss.middleware.utils.Utils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import montran.message.Message;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Service;

import javax.xml.datatype.XMLGregorianCalendar;
import java.util.Optional;

@Slf4j
@Service(value = "pacs.009")
@RequiredArgsConstructor
public class FinancialInstitutionTransferProcessor implements MessageProcessor {
    private final ApplicationContext applicationContext;
    private final ResponseUtils responseUtils;
    private final RequestUtils requestUtils;
    private final RetryableHttpClient httpClient;
    private final CoreBankingProperties coreBankingProperties;
    private final PapssSignature papssSignature;
    private final PapssService papssService;
    private final LoggerService loggerService;
    private final ObjectMapper objectMapper;

    @Override
    public PartnerResponse processMessage(RtpMessageDto messageDto) {
        String payload = Optional.ofNullable(messageDto).map(RtpMessageDto::getContent).orElse(null);
        Message message = Utils.unmarshallMessageResponse(payload);

        XMLGregorianCalendar creationDateTime = Utils.generateZuluDateTime();
        PartnerResponse partnerResponse = null;
        String papssId = messageDto.getPapssId();
        String sslKeyAlias = messageDto.getSslKeyAlias();
        try {
            //String messageId = message.getFIToFICstmrCdtTrf().getGrpHdr().getMsgId();
            FinancialInstitutionRequest paymentInitiation = requestUtils.mapInwardFinancialTransferDto(message);

//            HttpHeaders headers = new HttpHeaders();
//            headers.setContentType(MediaType.APPLICATION_JSON);
//            headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
            String request = objectMapper.writeValueAsString(paymentInitiation);
//
            log.info("Sending payment request to Core Banking {}", request);
//            log.debug("Core Bank Request: {}", request);
//
//            HttpEntity<String> entity = new HttpEntity<>(request, headers);
//
//            ResponseEntity<String> response = httpClient.postWithRetry(coreBankingProperties.getUrl() + coreBankingProperties.getPath().getCreditTransfer(), entity, messageDto.getSslKeyAlias(), String.class);
//
//            var jsonResponse = response.getBody();
//            log.info("Received response from Core Banking {}", jsonResponse);
//            log.debug("Core Bank Response: {}", jsonResponse);

            boolean isConfirmed = false;
            boolean isProcessed = false;

            // if (response.getStatusCode().is2xxSuccessful()) {
            //   TxConfirmationDto txConfirmationResponse = objectMapper.readValue(jsonResponse, TxConfirmationDto.class);
            //    if ((txConfirmationResponse.getStatus().getType().equalsIgnoreCase(ConstantUtils.ACCP) || txConfirmationResponse.getStatus().getType().equalsIgnoreCase(ConstantUtils.ACSC))) {
            //        isProcessed = true;
            //           isConfirmed = true;
            //    }
            //        loggerService.logTransaction(messageDto, txConfirmationResponse, Direction.IN);


            TxConfirmationDto txConfirmationDto = new TxConfirmationDto();
            txConfirmationDto.setStatus(Status.builder().code("000").type("ACCP").build());

            //String pacs002MessageId = Utils.generateMessageId(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getCdtrAgt().getFinInstnId().getClrSysMmbId().getMmbId());
            String pacs002MessageId = Utils.generateMessageId(papssId);

            String pacs002Xml = responseUtils.generatePaymentResponseFinancialMessage(message, pacs002MessageId, true, creationDateTime, txConfirmationDto);

            String signedPacs002Xml = papssSignature.generateSignature(pacs002Xml, messageDto.getSslKeyAlias(), messageDto.getKeyPass());

            log.debug("PACS.002 Message: {}", pacs002Xml);

            RtpMessageDto pacs002Response = papssService.sendMessage(papssId, signedPacs002Xml, sslKeyAlias);
            pacs002Response.setBic(messageDto.getBic());
            pacs002Response.setSslKeyAlias(sslKeyAlias);
            pacs002Response.setPapssId(papssId);
            pacs002Response.setKeyPass(messageDto.getKeyPass());
            pacs002Response.setSequence(messageDto.getSequence());
            pacs002Response.setContent(signedPacs002Xml);
            pacs002Response.setStatusCode(txConfirmationDto.getStatus().getCode());

            try {
                MessageProcessor messageProcessor = applicationContext.getBean("pacs.002", MessageProcessor.class);
                messageProcessor.processMessage(pacs002Response);
            } catch (Exception e) {
                log.error(e.getMessage(), e);
            }

            partnerResponse = PartnerResponse.builder().message(pacs002Response.getContent()).statusCode(Integer.parseInt(pacs002Response.getStatusCode())).build();
//            } else {
//                throw new RuntimeException(response.getBody());
//            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }

        return partnerResponse;
    }
}
