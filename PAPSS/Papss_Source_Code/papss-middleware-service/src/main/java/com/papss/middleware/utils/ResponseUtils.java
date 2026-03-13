package com.papss.middleware.utils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.papss.middleware.config.SystemConfig;
import com.papss.middleware.dto.nameinquiry.response.NameInquiryResponse;
import com.papss.middleware.dto.nameinquiry.response.NameInquiryResponseDto;
import com.papss.middleware.dto.nameinquiry.response.NameInquiryResponseReceiver;
import com.papss.middleware.dto.nameinquiry.response.NameInquiryResponseSender;
import com.papss.middleware.dto.paymentreturn.PaymentRecallDto;
import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.dto.txnconfirmation.TxConfirmationDto;
import com.papss.middleware.dto.txnconfirmation.response.TxStatusResponseDto;
import com.papss.middleware.dto.txstatus.OriginalTxInfo;
import com.papss.middleware.enums.ErrorCodes;
import com.papss.middleware.enums.StatusCodes;
import com.papss.middleware.service.outbound.domains.creditreturn.CreditReturnRequest;
import com.papss.middleware.service.outbound.domains.creditreturn.PaymentRecallRejectionDto;
import com.papss.middleware.service.outbound.domains.credittransfer.CreditTransferRequest;
import com.papss.middleware.service.outbound.domains.credittransfer.FTResponse;
import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import com.papss.middleware.service.outbound.domains.financialinstitution.FinancialInstitutionRequest;
import com.papss.middleware.service.outbound.domains.pending.PendingRequest;
import iso.std.iso._20022.tech.xsd.acmt_024_001.IdentificationAssignment2;
import iso.std.iso._20022.tech.xsd.acmt_024_001.IdentificationVerificationReportV02;
import iso.std.iso._20022.tech.xsd.acmt_024_001.Party12Choice;
import iso.std.iso._20022.tech.xsd.pacs_002_001.FIToFIPaymentStatusReportV07;
import iso.std.iso._20022.tech.xsd.pacs_002_001.PaymentTransaction63;
import iso.std.iso._20022.tech.xsd.pacs_004_001.CategoryPurpose1Choice;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import montran.message.Message;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.XMLGregorianCalendar;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.text.ParseException;
import java.util.*;

import static com.papss.middleware.utils.Utils.generateStringFromZuluDateTime;

@Slf4j
@Service
@RequiredArgsConstructor
public class ResponseUtils {
    private final MustacheTemplateEngine templateEngine;

    private final SystemConfig systemConfig;

    public TxStatusResponseDto generateResponse(RtpMessageDto rtpMessageDto, XMLGregorianCalendar creationDateTime) {
        String payload = Optional.ofNullable(rtpMessageDto).map(RtpMessageDto::getContent).orElse(null);
        Message message = Utils.unmarshallMessageResponse(payload);
        String code = message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getGrpSts() == null ? message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts().value() : message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getGrpSts().value();

        return TxStatusResponseDto.builder()
                .transRef(message.getFIToFIPmtStsRpt().getGrpHdr().getMsgId())
                .instId(rtpMessageDto.getPapssId())
                .originalTransactionRef(message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getOrgnlMsgId())
                .tranDateTime(creationDateTime.toString())
                .status(Status.builder().type(code).code(code)
                        .description(rtpMessageDto.getDescription()).build())
                .build();
    }

    public FTResponse generateResponse(RtpMessageDto rtpMessageDto, CreditTransferRequest creditTransferDto, XMLGregorianCalendar creationDateTime) {
        String payload = Optional.ofNullable(rtpMessageDto).map(RtpMessageDto::getContent).orElse(null);
        Message message = Utils.unmarshallMessageResponse(payload);
        String statusType;
        String StatusReason;

        List<PaymentTransaction63> txInfAndStsList = Optional.ofNullable(message).map(Message::getFIToFIPmtStsRpt)
                .map(FIToFIPaymentStatusReportV07::getTxInfAndSts).orElse(null);

        if (txInfAndStsList.size() == 0) {
            statusType = message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getGrpSts().name();
            StatusReason = message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getStsRsnInves().get(0).getRsn()
                    .getCd();
        } else {
            statusType = message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts() == null
                    ? message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getGrpSts().value()
                    : message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts().value(); // todo resolve
            // nullpointer exception
            // on this line
            StatusReason = message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts() == null ? "000"
                    : message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getStsRsnInves().get(0).getRsn().getCd();
        }

        return FTResponse.builder()
                .transRef(message.getFIToFIPmtStsRpt().getGrpHdr().getMsgId())
                .tranDateTime(creationDateTime.toString())
                .originalTxInfo(OriginalTxInfo.builder()
                        .transRef(message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getOrgnlMsgId())
                        .tranDateTime(creationDateTime.toString())
                        .endToEndRef(creditTransferDto.getEndToEndRef()).build())
                .status(Status.builder().code(statusType).type(statusType).code(StatusReason).description(StatusReason).build())
                .instId(rtpMessageDto.getPapssId())
                .build();
    }

    public FTResponse generateResponse(RtpMessageDto rtpMessageDto, PendingRequest creditTransferDto, XMLGregorianCalendar creationDateTime) {
        String payload = Optional.ofNullable(rtpMessageDto).map(RtpMessageDto::getContent).orElse(null);
        Message message = Utils.unmarshallMessageResponse(payload);
        String statusType;
        String StatusReason;

        List<PaymentTransaction63> txInfAndStsList = Optional.ofNullable(message).map(Message::getFIToFIPmtStsRpt)
                .map(FIToFIPaymentStatusReportV07::getTxInfAndSts).orElse(null);

        if (txInfAndStsList.size() == 0) {
            statusType = message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getGrpSts().name();
            StatusReason = message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getStsRsnInves().get(0).getRsn()
                    .getCd();
        } else {
            statusType = message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts() == null
                    ? message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getGrpSts().value()
                    : message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts().value(); // todo resolve
            // nullpointer exception
            // on this line
            StatusReason = message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts() == null ? "000"
                    : message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getStsRsnInves().get(0).getRsn().getCd();
        }
        return FTResponse.builder()
                .transRef(message.getFIToFIPmtStsRpt().getGrpHdr().getMsgId())
                .tranDateTime(creationDateTime.toString())
                .originalTxInfo(OriginalTxInfo.builder()
                        .transRef(message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getOrgnlMsgId())
                        .endToEndRef(creditTransferDto.getOriginalEndToEndRef()).build())
                .status(Status.builder().code(statusType).type(statusType).code(StatusReason).description(getErrorCodes(StatusReason)).build())
                .build();
    }

    public FTResponse generateResponse(RtpMessageDto rtpMessageDto, FinancialInstitutionRequest dto, XMLGregorianCalendar creationDateTime) {
        String payload = Optional.ofNullable(rtpMessageDto).map(RtpMessageDto::getContent).orElse(null);
        Message message = Utils.unmarshallMessageResponse(payload);
        String statusType;
        String StatusReason;

        List<PaymentTransaction63> txInfAndStsList = Optional.ofNullable(message).map(Message::getFIToFIPmtStsRpt)
                .map(FIToFIPaymentStatusReportV07::getTxInfAndSts).orElse(null);

        if (txInfAndStsList.size() == 0) {
            statusType = message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getGrpSts().name();
            StatusReason = message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getStsRsnInves().get(0).getRsn()
                    .getCd();
        } else {
            statusType = message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts() == null
                    ? message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getGrpSts().value()
                    : message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts().value();
            StatusReason = message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts() == null ? "000"
                    : message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getStsRsnInves().get(0).getRsn().getCd();
        }

        return FTResponse.builder()
                .transRef(message.getFIToFIPmtStsRpt().getGrpHdr().getMsgId())
                .tranDateTime(creationDateTime.toString())
                .originalTxInfo(OriginalTxInfo.builder()
                        .transRef(message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getOrgnlMsgId())
                        .endToEndRef(dto.getEndToEndRef()).build())
                .status(Status.builder().code(statusType).type(statusType).code(StatusReason).description(getErrorCodes(StatusReason)).build())
                .build();
    }

    public NameInquiryResponse generateResponse(RtpMessageDto rtpMessageDto, String endToEndRef) {
        String payload = Optional.ofNullable(rtpMessageDto).map(RtpMessageDto::getContent).orElse(null);
        Message message = Utils.unmarshallMessageResponse(payload);

        NameInquiryResponseReceiver receiver;
        boolean isVerification = message.getIdVrfctnRpt().getRpts().get(0).isVrfctn();
        String type = "";
        String code = "";
        String description = "";
        ErrorCodes errorCodeEnum = null;

        Party12Choice assgnr = Optional.ofNullable(message).map(Message::getIdVrfctnRpt)
                .map(IdentificationVerificationReportV02::getAssgnmt).map(IdentificationAssignment2::getAssgnr)
                .orElse(null);
        if (assgnr == null) {
            type = "RJCT";
            receiver = NameInquiryResponseReceiver.builder().build();
            code = message.getIdVrfctnRpt().getRpts().get(0).getRsn().getCd();
            String finalCode = code;
            errorCodeEnum = Arrays.stream(ErrorCodes.values())
                    .filter(errorCode -> errorCode.getValue().equalsIgnoreCase(finalCode)).findFirst()
                    .orElse(ErrorCodes.UNKNOWN);

            description = errorCodeEnum.getDescription();

        } else {

            if (isVerification) {
                type = "ACCP";
                code = rtpMessageDto.getStatusCode();
                description = rtpMessageDto.getDescription();

                receiver = NameInquiryResponseReceiver.builder()
                        .instId(message.getIdVrfctnRpt().getAssgnmt().getAssgnr().getAgt().getFinInstnId()
                                .getClrSysMmbId().getMmbId())
                        .accountName(message.getIdVrfctnRpt().getRpts().get(0).getUpdtdPtyAndAcctId().getPty().getNm())
                        .emailAddress(message.getIdVrfctnRpt().getRpts().get(0).getUpdtdPtyAndAcctId().getPty()
                                .getCtctDtls() == null ? "" : message.getIdVrfctnRpt().getRpts().get(0).getUpdtdPtyAndAcctId().getPty()
                                .getCtctDtls().getEmailAdr())
                        .accountNumber(message.getIdVrfctnRpt().getRpts().get(0).getOrgnlPtyAndAcctId().getAcct().getOthr()
                                .getId())
                        .build();

            } else {
                type = "RJCT";

                receiver = NameInquiryResponseReceiver.builder()
                        .instId(message.getIdVrfctnRpt().getAssgnmt().getAssgnr().getAgt().getFinInstnId()
                                .getClrSysMmbId().getMmbId())
                        .accountNumber(message.getIdVrfctnRpt().getRpts().get(0).getOrgnlPtyAndAcctId().getAcct().getOthr()
                                .getId())
                        .build();

//                code = "501";
                code = ErrorCodes.CODE_502.getValue();
                String finalCode = code;
                errorCodeEnum = Arrays.stream(ErrorCodes.values())
                        .filter(errorCode -> errorCode.getMapping().equalsIgnoreCase(finalCode)).findFirst()
                        .orElse(ErrorCodes.CODE_501);

                description = "Account number on Name Inquiry cannot be verified.";

            }
        }

        return NameInquiryResponse.builder().tranRef(message.getIdVrfctnRpt().getAssgnmt().getMsgId())
                .endToEndRef(endToEndRef)
                .sender(NameInquiryResponseSender.builder()
                        .instId(message.getIdVrfctnRpt().getAssgnmt().getAssgne().getAgt().getFinInstnId()
                                .getClrSysMmbId().getMmbId())
                        .build())
                .receiver(receiver).status(Status.builder().type(type).code(code).description(description).build())
                .build();
    }

    public String generateResponseMessage(String messageId, XMLGregorianCalendar creationDateTime, Message message,
                                          NameInquiryResponseDto nameInquiryResponse, String participantsBic, String papssId,
                                          boolean isAccountVerified) throws DatatypeConfigurationException {

        log.info("Verificiation True {}", isAccountVerified);

        String responseMessage;

        Map<String, Object> templateData = new HashMap<>();
        templateData.put("participant_member_id", papssId);
        templateData.put("participant_clearing_system_id", systemConfig.getToClearingSystemId());
        templateData.put("message_id", messageId);
        templateData.put("msg_def_idr", "acmt.024.001.02");
        templateData.put("create_date_time", creationDateTime.toString());
        if (participantsBic != null && !participantsBic.isBlank()) {
            templateData.put("participant_bic_fi", participantsBic);
        }
        templateData.put("assignee_member_id",
                message.getIdVrfctnReq().getAssgnmt().getAssgnr().getAgt().getFinInstnId().getClrSysMmbId().getMmbId());
        templateData.put("original_assignment_message_id", message.getIdVrfctnReq().getAssgnmt().getMsgId());
        templateData.put("rpt_original_id", message.getIdVrfctnReq().getVrfctns().get(0).getId());
        templateData.put("rpt_vrfctn", isAccountVerified);
        templateData.put("scheme_name_cd", message.getIdVrfctnReq().getVrfctns().get(0).getPtyAndAcctId().getAcct().getOthr().getSchmeNm().getCd());
        templateData.put("clearing_sys_id_prtry", message.getAppHdr().getFr().getFIId().getFinInstnId().getClrSysMmbId().getClrSysId().getPrtry());
        templateData.put("account_number", nameInquiryResponse.getAccountNumber() == null ? message.getIdVrfctnReq().getVrfctns().get(0).getPtyAndAcctId().getAcct().getOthr().getId() : nameInquiryResponse.getAccountNumber());
        templateData.put("account_currency", nameInquiryResponse.getAccountCurrency() == null ? "N/A" : nameInquiryResponse.getAccountCurrency());

        if (!isAccountVerified) {
            templateData.put("reject_reason", nameInquiryResponse.getStatus().getType());
            responseMessage = templateEngine.render(MessageTypeConstants.ACMT_024_RCT_XML, templateData);

        } else {
            templateData.put("account_name", nameInquiryResponse.getAccountName() == null ? "." : nameInquiryResponse.getAccountName());
            templateData.put("account_email", nameInquiryResponse.getEmailAddress() == null ? "." : nameInquiryResponse.getEmailAddress());
            responseMessage = templateEngine.render(MessageTypeConstants.ACMT_024_XML, templateData);
        }

        return responseMessage;
    }

    public String generatePaymentResponseFinancialMessage(Message message, String messageId, boolean isProcessed,
                                                 XMLGregorianCalendar creationDateTime, TxConfirmationDto txConfirmationResponse)
            throws DatatypeConfigurationException, ParseException, JsonProcessingException {

//        String bic = message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getCdtr().getFinInstnId().getBICFI();
//        bic = (bic == null || bic.isEmpty()) ? message.getAppHdr().getFr().getFIId().getFinInstnId().getBICFI() : bic;

        Map<String, Object> templateData = new HashMap<>();
        templateData.put("fr_bicfi", "bic");
        templateData.put("fr_memberId", message.getAppHdr().getTo().getFIId().getFinInstnId().getClrSysMmbId().getMmbId());
        templateData.put("messageId", messageId);
        templateData.put("create_date", creationDateTime);
        templateData.put("creationDateTime", creationDateTime);
        templateData.put("original_messageId", message.getFIToFICstmrCdtTrf().getGrpHdr().getMsgId());
        //templateData.put("original_instrumentId",  message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getPmtId().getInstrId());
        templateData.put("original_instrumentId",  messageId);
        templateData.put("original_endToEndId",
                message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getPmtId().getEndToEndId());
        templateData.put("original_transactionId", message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getPmtId().getTxId());
        templateData.put("acceptance_dateTime", generateStringFromZuluDateTime((GregorianCalendar) message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getAccptncDtTm()));
        templateData.put("dbtr_bicFi",
                message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getDbtrAgt().getFinInstnId().getBICFI());
        templateData.put("dbtr_memberId", message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getDbtrAgt()
                .getFinInstnId().getClrSysMmbId().getMmbId());
        templateData.put("grp_sts", txConfirmationResponse.getStatus().getType());
        templateData.put("member_id", systemConfig.getToClearingSystemId());
        templateData.put("local_instrument",
                message.getFIToFICstmrCdtTrf().getGrpHdr().getPmtTpInf().getLclInstrm().getCd());
        templateData.put("ctgy_purp", message.getFIToFICstmrCdtTrf().getGrpHdr().getPmtTpInf().getCtgyPurp().getCd());
        String renderedTemplate;
        if (isProcessed) {
            templateData.put("grp_sts", txConfirmationResponse.getStatus().getType());
            renderedTemplate = templateEngine.render(MessageTypeConstants.PACS002, templateData);
        } else {
            templateData.put("grp_sts", StatusCodes.RJCT.toString());
            templateData.put("reason_code", txConfirmationResponse.getStatus().getCode() == null ? ErrorCodes.CODE_501.getMapping() : txConfirmationResponse.getStatus().getCode());
            renderedTemplate = templateEngine.render(MessageTypeConstants.PACS002_RJCT, templateData);
        }
        return renderedTemplate;
    }


    public String generatePaymentResponseMessage(Message message, String messageId, boolean isProcessed,
                                                 XMLGregorianCalendar creationDateTime, TxConfirmationDto txConfirmationResponse)
            throws DatatypeConfigurationException, ParseException, JsonProcessingException {

        String bic = message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getCdtrAgt().getFinInstnId().getBICFI();
        bic = (bic == null || bic.isEmpty()) ? message.getAppHdr().getFr().getFIId().getFinInstnId().getBICFI() : bic;

        Map<String, Object> templateData = new HashMap<>();
        templateData.put("fr_bicfi", bic);
        templateData.put("fr_memberId", message.getAppHdr().getTo().getFIId().getFinInstnId().getClrSysMmbId().getMmbId());
        templateData.put("messageId", messageId);
        templateData.put("create_date", creationDateTime);
        templateData.put("creationDateTime", creationDateTime);
        templateData.put("original_messageId", message.getFIToFICstmrCdtTrf().getGrpHdr().getMsgId());
        //templateData.put("original_instrumentId",  message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getPmtId().getInstrId());
        templateData.put("original_instrumentId",  messageId);
        templateData.put("original_endToEndId",
                message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getPmtId().getEndToEndId());
        templateData.put("original_transactionId", message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getPmtId().getTxId());
        templateData.put("acceptance_dateTime", generateStringFromZuluDateTime((GregorianCalendar) message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getAccptncDtTm()));
        templateData.put("dbtr_bicFi",
                message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getDbtrAgt().getFinInstnId().getBICFI());
        templateData.put("dbtr_memberId", message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getDbtrAgt()
                .getFinInstnId().getClrSysMmbId().getMmbId());
        templateData.put("grp_sts", txConfirmationResponse.getStatus().getType());
        templateData.put("member_id", systemConfig.getToClearingSystemId());
        templateData.put("local_instrument",
                message.getFIToFICstmrCdtTrf().getGrpHdr().getPmtTpInf().getLclInstrm().getCd());
        templateData.put("ctgy_purp", message.getFIToFICstmrCdtTrf().getGrpHdr().getPmtTpInf().getCtgyPurp().getCd());
        String renderedTemplate;
        if (isProcessed) {
            templateData.put("grp_sts", txConfirmationResponse.getStatus().getType());
            renderedTemplate = templateEngine.render(MessageTypeConstants.PACS002, templateData);
        } else {
            templateData.put("grp_sts", StatusCodes.RJCT.toString());
            templateData.put("reason_code", txConfirmationResponse.getStatus().getCode() == null ? ErrorCodes.CODE_501.getMapping() : txConfirmationResponse.getStatus().getCode());
            renderedTemplate = templateEngine.render(MessageTypeConstants.PACS002_RJCT, templateData);
        }
        return renderedTemplate;
    }


    public String generatePaymentResponseMessage004(Message message, String messageId, boolean isProcessed,
                                                    XMLGregorianCalendar creationDateTime, TxConfirmationDto txConfirmationResponse)
            throws DatatypeConfigurationException, ParseException, JsonProcessingException {

        String bic = message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getDbtrAgt().getFinInstnId().getBICFI();
        bic = (bic == null || bic.isEmpty()) ? message.getAppHdr().getFr().getFIId().getFinInstnId().getBICFI() : bic;

        Map<String, Object> templateData = new HashMap<>();
        templateData.put("fr_bicfi", bic);
        templateData.put("fr_memberId",message.getAppHdr().getTo().getFIId().getFinInstnId().getClrSysMmbId().getMmbId());
        templateData.put("messageId", messageId);
        templateData.put("create_date", creationDateTime);
        templateData.put("creationDateTime", creationDateTime);
        templateData.put("original_messageId", message.getPmtRtr().getGrpHdr().getMsgId());
        templateData.put("original_instrumentId", message.getPmtRtr().getTxInves().get(0).getOrgnlTxId());
        templateData.put("sender_currency", message.getPmtRtr().getTxInves().get(0).getRtrdInstdAmt().getCcy());
        templateData.put("sender_amount", message.getPmtRtr().getTxInves().get(0).getRtrdInstdAmt().getValue());
        templateData.put("receiver_currency", message.getPmtRtr().getTxInves().get(0).getRtrdIntrBkSttlmAmt().getCcy());
        templateData.put("receiver_amount", message.getPmtRtr().getTxInves().get(0).getRtrdIntrBkSttlmAmt().getValue());
        templateData.put("original_endToEndId", message.getPmtRtr().getTxInves().get(0).getOrgnlEndToEndId());
        templateData.put("original_transactionId", message.getPmtRtr().getTxInves().get(0).getOrgnlTxId());
        // Note: AccptncDtTm might not be directly available in PaymentTransaction76
        // You may need to get it from OriginalTransactionReference24 or adjust as needed
        templateData.put("acceptance_dateTime", generateStringFromZuluDateTime((GregorianCalendar) message.getPmtRtr().getGrpHdr().getCreDtTm()));
        templateData.put("dbtr_bicFi",
                message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getDbtrAgt().getFinInstnId().getBICFI());
        templateData.put("dbtr_memberId", message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getDbtrAgt().getFinInstnId().getClrSysMmbId().getMmbId());
        templateData.put("grp_sts", txConfirmationResponse.getStatus().getType());
        templateData.put("member_id", systemConfig.getToClearingSystemId());
        templateData.put("local_instrument",
                message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getPmtTpInf().getLclInstrm().getCd());

        // Add null check for CategoryPurpose
        templateData.put("ctgy_purp", "CCRD");
        String renderedTemplate;
        if (isProcessed) {
            templateData.put("grp_sts", txConfirmationResponse.getStatus().getType());
            renderedTemplate = templateEngine.render(MessageTypeConstants.PACS_002_004_XML, templateData);
        } else {
            templateData.put("grp_sts", StatusCodes.RJCT.toString());
            templateData.put("reason_code", txConfirmationResponse.getStatus().getType());
            renderedTemplate = templateEngine.render(MessageTypeConstants.PACS_002_004_RJCT_XML, templateData);
        }
        return renderedTemplate;
    }

    public TxStatusResponseDto generateResponse(RtpMessageDto rtpMessageDto, XMLGregorianCalendar creationDateTime, PaymentRecallDto paymentCancellationRequestDTO) throws Exception {
        String payload = Optional.ofNullable(rtpMessageDto).map(RtpMessageDto::getContent).orElse(null);
        Message message = Utils.unmarshallMessageResponse(payload);

        String statusType;
        String StatusReason;

        List<PaymentTransaction63> txInfAndStsList = Optional.ofNullable(message).map(Message::getFIToFIPmtStsRpt)
                .map(FIToFIPaymentStatusReportV07::getTxInfAndSts).orElse(null);

        if (txInfAndStsList.size() == 0) {
            statusType = message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getGrpSts().name();
            StatusReason = message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getStsRsnInves().get(0).getRsn()
                    .getCd();
        } else {
            statusType = message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts() == null
                    ? message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getGrpSts().value()
                    : message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts().value(); // todo resolve
            // nullpointer exception
            // on this line
            StatusReason = message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts() == null ? "000"
                    : message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getStsRsnInves().get(0).getRsn().getCd();
        }

        return TxStatusResponseDto.builder()
                .transRef(message.getFIToFIPmtStsRpt().getGrpHdr().getMsgId())
                .instId(message.getAppHdr().getTo().getFIId().getFinInstnId().getClrSysMmbId().getMmbId())
                .originalTransactionRef(message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getOrgnlMsgId())
                .tranDateTime(creationDateTime.toString())
                .status(Status.builder().type(statusType).code(StatusReason)
                        .description(rtpMessageDto.getDescription()).build())
                .build();
    }

    public TxStatusResponseDto generateResponse(RtpMessageDto rtpMessageDto, XMLGregorianCalendar creationDateTime, CreditReturnRequest creditReturnDto) {
        String payload = Optional.ofNullable(rtpMessageDto).map(RtpMessageDto::getContent).orElse(null);
        Message message = Utils.unmarshallMessageResponse(payload);

        String statusType;
        String StatusReason;

        List<PaymentTransaction63> txInfAndStsList = Optional.ofNullable(message).map(Message::getFIToFIPmtStsRpt)
                .map(FIToFIPaymentStatusReportV07::getTxInfAndSts).orElse(null);

        if (txInfAndStsList.size() == 0) {
            statusType = message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getGrpSts().name();
            StatusReason = message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getStsRsnInves().get(0).getRsn()
                    .getCd();
        } else {
            statusType = message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts() == null
                    ? message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getGrpSts().value()
                    : message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts().value(); // todo resolve
            // nullpointer exception
            // on this line
            StatusReason = message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getTxSts() == null ? "000"
                    : message.getFIToFIPmtStsRpt().getTxInfAndSts().get(0).getStsRsnInves().get(0).getRsn().getCd();
        }

        return TxStatusResponseDto.builder()
                .transRef(message.getFIToFIPmtStsRpt().getGrpHdr().getMsgId())
                .instId(rtpMessageDto.getPapssId())
                .originalTransactionRef(message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getOrgnlMsgId())
                .tranDateTime(creationDateTime.toString())
                .status(Status.builder().type(rtpMessageDto.getErrorMapping()).code(rtpMessageDto.getStatusCode())
                        .description(rtpMessageDto.getDescription()).build())
                .build();
    }

    public TxStatusResponseDto generateResponse(RtpMessageDto rtpMessageDto, XMLGregorianCalendar creationDateTime,
                                                PaymentRecallRejectionDto paymentCancellationRequestDTO) throws Exception {
        String payload = Optional.ofNullable(rtpMessageDto).map(RtpMessageDto::getContent).orElse(null);
        Message message = Utils.unmarshallMessageResponse(payload);

        // Parse the XML string into a Document
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document document = builder.parse(new java.io.ByteArrayInputStream(payload.getBytes()));

        // Extract rejection code from the <Cd> element under <Rsn>
        String rejectionCode = getValueByTagName(document, "Cd");
        log.info("Rejection Code: {}", rejectionCode);

        // Extract rejection reason from the <AddtlInf> element
        String rejectionReason = getValueByTagName(document, "AddtlInf");
        log.info("Rejection Reason: {}", rejectionReason);

        return TxStatusResponseDto.builder()
                .transRef(message.getFIToFIPmtStsRpt().getGrpHdr().getMsgId())
                .instId(rtpMessageDto.getPapssId())
                .originalTransactionRef(message.getFIToFIPmtStsRpt().getOrgnlGrpInfAndSts().get(0).getOrgnlMsgId())
                .tranDateTime(creationDateTime.toString())
                .status(Status.builder().type(rtpMessageDto.getErrorMapping()).code(rtpMessageDto.getStatusCode())
                        .description(rtpMessageDto.getDescription()).build())
                .build();
    }

    private static String getValueByTagName(Document document, String tagName) {
        NodeList nodeList = document.getElementsByTagName(tagName);
        if (nodeList.getLength() > 0) {
            Node node = nodeList.item(0);
            return node.getTextContent();
        }
        return null;
    }

    private String getErrorCodes(String sts) {
        return Arrays.stream(ErrorCodes.values())
                .filter(errorCode -> errorCode.getMapping().equalsIgnoreCase(sts))
                .findFirst()
                .orElse(ErrorCodes.UNKNOWN)
                .getDescription();
    }
}
