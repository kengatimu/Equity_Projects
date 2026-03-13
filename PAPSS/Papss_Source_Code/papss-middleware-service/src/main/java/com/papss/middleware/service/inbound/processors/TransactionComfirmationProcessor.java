package com.papss.middleware.service.inbound.processors;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.papss.middleware.config.CoreBankingProperties;
import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.dto.txnconfirmation.response.TxConfirmationResponse;
import com.papss.middleware.dto.txstatus.OriginalTxInfo;
import com.papss.middleware.dto.txstatus.TxStatusRequest;
import com.papss.middleware.service.PapssService;
import com.papss.middleware.service.PapssSignature;
import com.papss.middleware.service.inbound.MessageProcessor;
import com.papss.middleware.service.inbound.domains.PartnerResponse;
import com.papss.middleware.service.outbound.domains.credittransfer.FTResponse;
import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import com.papss.middleware.utils.ConstantUtils;
import com.papss.middleware.utils.HttpClient;
import com.papss.middleware.utils.ResponseUtils;
import com.papss.middleware.utils.Utils;
import iso.std.iso._20022.tech.xsd.pacs_002_001.FIToFIPaymentStatusReportV07;
import iso.std.iso._20022.tech.xsd.pacs_002_001.PaymentTransaction63;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import montran.message.Message;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Optional;

import static com.papss.middleware.utils.Utils.generateStringFromZuluDateTime;

@Slf4j
@Service(value = "pacs.002")
@RequiredArgsConstructor
public class TransactionComfirmationProcessor implements MessageProcessor {

    private final HttpClient httpClient;
    private final CoreBankingProperties coreBankingProperties;

    @Override
    public PartnerResponse processMessage(RtpMessageDto messageDto) {

        String payload = Optional.ofNullable(messageDto).map(RtpMessageDto::getContent).orElse(null);
        Message message = Utils.unmarshallMessageResponse(payload);
        String messageId = message.getAppHdr().getBizMsgIdr();

        String papssId = messageDto.getPapssId();
        String sslKeyAlias = messageDto.getSslKeyAlias();

        String statusType;
        String statusReason;

        List<PaymentTransaction63> txInfAndStsList = Optional.of(message).map(Message::getFIToFIPmtStsRpt).map(FIToFIPaymentStatusReportV07::getTxInfAndSts).orElse(null);

        if (txInfAndStsList.size() == 0) {
            statusType = message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getGrpSts().name();
            statusReason = message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getStsRsnInves().get(0).getRsn().getCd();
        } else {
            statusType = message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts() == null ? message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getGrpSts().value() : message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts().value(); // todo resolve
            // nullpointer exception
            // on this line
            statusReason = message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts() == null ? "000" : message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getStsRsnInves().get(0).getRsn().getCd();
        }

        TxStatusRequest txStatusDto = null;
        try {
            txStatusDto = TxStatusRequest.builder()
                    .instId(message.getAppHdr().getTo().getFIId().getFinInstnId().getClrSysMmbId().getMmbId())
                    .tranDateTime(generateStringFromZuluDateTime((GregorianCalendar) message.getAppHdr().getCreDt()))
                    .transRef(message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getStsId())
                    .originalTxInfo(OriginalTxInfo.builder().endToEndRef(message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getOrgnlTxId())
                            .transRef(message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getOrgnlMsgId()).build())
                    .status(Status.builder().type(statusType).code(statusReason).description("").build()).build();

            boolean isProcessed = false;
            boolean isConfirmed = false;

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
            ObjectMapper objectMapper = new ObjectMapper();
            String request = objectMapper.writeValueAsString(txStatusDto);
            HttpEntity<String> entity = new HttpEntity<String>(request, headers);

            log.info("Sending transaction confirmation request to Core Banking");
            log.debug("TX Core Banking Request: {}", request);

            ResponseEntity<String> response = httpClient.postClient(coreBankingProperties.getUrl() + coreBankingProperties.getPath().getTxConfirmation(), entity, messageDto.getSslKeyAlias(), String.class);

            log.info("Received response from Core Banking");
            log.debug("Core Banking Response: {}", response.getBody());

            TxConfirmationResponse txConfirmationResponse = new TxConfirmationResponse();
            if (response.getStatusCode().is2xxSuccessful()) {

                FTResponse ftResponse = objectMapper.readValue(response.getBody(), FTResponse.class);
                txConfirmationResponse.setInstId(papssId);
                txConfirmationResponse.setStatus(Status.builder().code(ftResponse.getStatus().getCode()).type(ftResponse.getStatus().getType()).build());
                txConfirmationResponse.setTranDateTime(ftResponse.getTranDateTime());
                txConfirmationResponse.setTransRef(ftResponse.getTransRef());
                if (txConfirmationResponse.getStatus().getType().equalsIgnoreCase(ConstantUtils.ACCP) || txConfirmationResponse.getStatus().getType().equalsIgnoreCase(ConstantUtils.ACSC)) {
                    isProcessed = true;
                }
            }
            return PartnerResponse.builder().message(response.getBody()).statusCode(response.getStatusCode().value()).build();

        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new RuntimeException(e);
        }
    }
}
