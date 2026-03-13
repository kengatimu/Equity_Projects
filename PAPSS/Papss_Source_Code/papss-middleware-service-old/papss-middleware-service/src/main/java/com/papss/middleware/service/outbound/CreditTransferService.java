package com.papss.middleware.service.outbound;

import com.papss.middleware.dto.paymentreturn.PaymentRecallDto;
import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.dto.txnconfirmation.response.TxStatusResponseDto;
import com.papss.middleware.enums.Direction;
import com.papss.middleware.models.Participant;
import com.papss.middleware.service.LoggerService;
import com.papss.middleware.service.PapssService;
import com.papss.middleware.service.PapssSignature;
import com.papss.middleware.service.outbound.domains.creditreturn.CreditReturnRequest;
import com.papss.middleware.service.outbound.domains.creditreturn.PaymentRecallRejectionDto;
import com.papss.middleware.service.outbound.domains.credittransfer.CreditTransferRequest;
import com.papss.middleware.service.outbound.domains.credittransfer.FTResponse;
import com.papss.middleware.service.outbound.domains.pending.PendingRequest;
import com.papss.middleware.utils.RequestUtils;
import com.papss.middleware.utils.ResponseUtils;
import com.papss.middleware.utils.Utils;
import jakarta.xml.bind.JAXBException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.xml.datatype.XMLGregorianCalendar;
import java.io.IOException;
import java.security.SignatureException;

@Slf4j
@Service
@RequiredArgsConstructor
public class CreditTransferService {
    private final RequestUtils requestUtils;
    private final ResponseUtils responseUtils;
    private final PapssSignature papssSignature;
    private final PapssService papssService;
    private final LoggerService loggerService;


    public FTResponse requestModification(PendingRequest dto, String papssId, Participant participant) throws SignatureException, JAXBException, IOException {
        log.info("Sending OutBound Request");

        XMLGregorianCalendar creationDateTime = Utils.generateZuluDateTime();
        String camt007 = requestUtils.generateModifyPaymentMessage(dto);
        String signedMsg = papssSignature.generateSignature(camt007, participant.getSslKeyAlias(), participant.getKeyPass());

        log.debug("Message to be sent SIGNED: {}", signedMsg);

        RtpMessageDto rtpMessageDto = papssService.sendMessage(papssId, signedMsg, participant.getSslKeyAlias());

        log.info("Done OutBound Request");
        return responseUtils.generateResponse(rtpMessageDto, dto, creationDateTime);
    }


    public FTResponse sendFTMessage(CreditTransferRequest dto, String papssId, Participant participant) throws SignatureException, JAXBException, IOException {
        log.debug("Sending OutBound Request");

        XMLGregorianCalendar creationDateTime = Utils.generateZuluDateTime2();
        String pacs008XML = requestUtils.generateMessage(dto, creationDateTime, papssId, participant.getSslKeyAlias());
        String signedMsg = papssSignature.generateSignature(pacs008XML, participant.getSslKeyAlias(), participant.getKeyPass());

        log.info("Message to be sent SIGNED: {}", signedMsg);

        RtpMessageDto rtpMessageDto = papssService.sendMessage(papssId, signedMsg, participant.getSslKeyAlias());

        loggerService.logTransaction(signedMsg, rtpMessageDto, Direction.OUT);

        log.debug("Done OutBound Request");
        //return null;
        return responseUtils.generateResponse(rtpMessageDto, dto, creationDateTime);
    }

    public TxStatusResponseDto getTransactionStatus(String ref, String transactionDateTime, String papssId, String sslKeyAlias, String keyPass) throws SignatureException {
        String pacs028 = requestUtils.generateMessage(ref, transactionDateTime, papssId);
        String signedMsg = papssSignature.generateSignature(pacs028, sslKeyAlias, keyPass);


        log.info("Message to be sent SIGNED: {}", signedMsg);

        RtpMessageDto rtpMessageDto = papssService.sendMessage(papssId, signedMsg, sslKeyAlias);

        XMLGregorianCalendar xmlGregorianCalendar = Utils.generateZuluDateTime();

        return responseUtils.generateResponse(rtpMessageDto, xmlGregorianCalendar);
    }

    public TxStatusResponseDto paymentCancellationRequest(PaymentRecallDto paymentCancellationRequestDTO, String papssId, String sslKeyAlias, String keyPass) throws Exception {

        XMLGregorianCalendar creationDateTime = Utils.generateZuluDateTime();
        XMLGregorianCalendar creationDateSimple = Utils.generateSimpleDateTime();

        String camt056Message = requestUtils.generateMessageForPaymentCancellation(paymentCancellationRequestDTO, creationDateTime, creationDateSimple);
        String signedMsg = papssSignature.generateSignature(camt056Message, sslKeyAlias, keyPass);
        log.info("Message to be sent: {} ", signedMsg);

        RtpMessageDto rtpMessageDto = papssService.sendMessage(papssId, signedMsg, sslKeyAlias);

        return responseUtils.generateResponse(rtpMessageDto, creationDateTime, paymentCancellationRequestDTO);
    }

    public TxStatusResponseDto returnCreditReturnMessage(CreditReturnRequest creditReturnDto, String papssId, String sslKeyAlias, String keyPass) throws IOException, SignatureException, JAXBException {
        XMLGregorianCalendar creationDateTime = Utils.generateZuluDateTime();
        XMLGregorianCalendar creationDateSimple = Utils.generateSimpleDateTime();

        String pacs004XML = requestUtils.generateMessage(creditReturnDto, papssId, creationDateTime, creationDateSimple);
        String signedMsg = papssSignature.generateSignature(pacs004XML, sslKeyAlias, keyPass);
        log.info("Message to be sent: {} ", signedMsg);

        RtpMessageDto rtpMessageDto = papssService.sendMessage(papssId, signedMsg, sslKeyAlias);
        return responseUtils.generateResponse(rtpMessageDto, creationDateTime, creditReturnDto);
    }

    public TxStatusResponseDto paymentCancellationStatus(PaymentRecallRejectionDto paymentCancellationRequestDTO, String papssId, String sslKeyAlias, String keyPass) throws Exception {

        XMLGregorianCalendar creationDateTime = Utils.generateZuluDateTime();
        XMLGregorianCalendar creationDateSimple = Utils.generateSimpleDateTime();

        String camt29Message = requestUtils.generateMessageForPaymentCancellationStatus(paymentCancellationRequestDTO, creationDateTime, creationDateSimple);
        String signedMsg = papssSignature.generateSignature(camt29Message, sslKeyAlias, keyPass);

        log.info("Message to be sent: {} ", signedMsg);

        RtpMessageDto rtpMessageDto = papssService.sendMessage(papssId, signedMsg, sslKeyAlias);

        return responseUtils.generateResponse(rtpMessageDto, creationDateTime, paymentCancellationRequestDTO);
    }
}
