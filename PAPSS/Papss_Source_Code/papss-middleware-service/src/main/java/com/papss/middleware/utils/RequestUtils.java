package com.papss.middleware.utils;

import com.papss.middleware.config.SystemConfig;
import com.papss.middleware.dto.paymentreturn.PaymentRecallDto;
import com.papss.middleware.service.outbound.domains.creditreturn.CreditReturnRequest;
import com.papss.middleware.service.outbound.domains.creditreturn.PaymentRecallRejectionDto;
import com.papss.middleware.service.outbound.domains.nameenquiry.NameInquiryRequest;
import com.papss.middleware.service.outbound.domains.credittransfer.CreditTransferRequest;
import com.papss.middleware.service.outbound.domains.credittransfer.TransferDetails;
import com.papss.middleware.service.outbound.domains.financialinstitution.FinancialInstitutionRequest;
import com.papss.middleware.service.outbound.domains.financialinstitution.FinancialInstitutionDetails;
import com.papss.middleware.dto.fxrate.FxRateReceiver;
import com.papss.middleware.dto.fxrate.FxRateSender;
import com.papss.middleware.dto.fxrate.GetFxRateDto;
import com.papss.middleware.dto.fxrate.response.FxRateResponse;
import com.papss.middleware.dto.nameinquiry.NameInquiryDto;
import com.papss.middleware.dto.nameinquiry.NameInquiryReceiver;
import com.papss.middleware.dto.nameinquiry.NameInquirySender;
import com.papss.middleware.enums.CategoryPurpose;
import com.papss.middleware.enums.PurposeCode;
import com.papss.middleware.service.outbound.FxRateService;
import com.papss.middleware.service.outbound.domains.pending.PendingRequest;
import jakarta.xml.bind.JAXBException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import montran.message.Message;
import org.springframework.stereotype.Service;

import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.XMLGregorianCalendar;
import java.io.IOException;
import java.text.ParseException;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;

import static com.papss.middleware.utils.Utils.generateStringFromZuluDateTime;

@Slf4j
@Service
@RequiredArgsConstructor
public class RequestUtils {
    private final MustacheTemplateEngine templateEngine;
    private final SystemConfig systemConfig;
    private final FxRateService fxRateService;

    public CreditTransferRequest mapInwardPaymentDto(final Message message) {

        boolean isInvoice = (message.getFIToFICstmrCdtTrf().getGrpHdr().getPmtTpInf().getCtgyPurp().getCd()
                .equalsIgnoreCase("SUPP")
                && (message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getPurp().getCd())
                .equalsIgnoreCase("RCPT"));

        CreditTransferRequest paymentRequest;
        try {
            paymentRequest = CreditTransferRequest.builder()
                    .endToEndRef(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getPmtId().getTxId())
                    .categoryPurpose(message.getFIToFICstmrCdtTrf().getGrpHdr().getPmtTpInf().getCtgyPurp().getCd())
                    .isInvoice(isInvoice)
                    .amount(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getInstdAmt().getValue())
                    .instId(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getCdtrAgt().getFinInstnId()
                            .getClrSysMmbId().getMmbId())
                    .localInstrumentType(message.getFIToFICstmrCdtTrf().getGrpHdr().getPmtTpInf().getLclInstrm().getCd())
                    .narration(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getRmtInf() == null ? "": message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getRmtInf().getUstrds().get(0))
                    .tranDateTime(generateStringFromZuluDateTime((GregorianCalendar) message.getAppHdr().getCreDt()))
                    .transRef(message.getFIToFICstmrCdtTrf().getGrpHdr().getMsgId())
                    .sender(TransferDetails.builder()
                            .amount(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getInstdAmt().getValue())
                            .accountName(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getDbtr().getNm())
                            .accountNumber(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getDbtrAcct().getId()
                                    .getOthr().getId())
                            .address(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getDbtr().getPstlAdr()
                                    .getAdrLines().get(0))
                            .currency(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getInstdAmt().getCcy())
                            .country(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getDbtr().getPstlAdr()
                                    .getCtry())
                            .instBic(
                                    message.getFIToFICstmrCdtTrf().getGrpHdr().getInstdAgt().getFinInstnId().getBICFI())
                            .instId(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getDbtrAgt()
                                    .getFinInstnId().getClrSysMmbId().getMmbId())

                            .build())
                    .receiver(TransferDetails.builder()
                            .amount(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getIntrBkSttlmAmt().getValue())
                            .accountName(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getCdtr().getNm())
                            .accountNumber(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getCdtrAcct().getId()
                                    .getOthr().getId())
                            .address(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getCdtr().getPstlAdr()
                                    .getAdrLines().get(0))
                            .currency(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getIntrBkSttlmAmt().getCcy())
                            .country(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getCdtr().getPstlAdr()
                                    .getCtry())
                            .instBic(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getCdtrAgt()
                                    .getFinInstnId().getBICFI())
                            .instId(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getCdtrAgt()
                                    .getFinInstnId().getClrSysMmbId().getMmbId())

                            .build())
                    .build();
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new RuntimeException(e);
        }

        return paymentRequest;

    }


    public FinancialInstitutionRequest mapInwardFinancialTransferDto(final Message message) {

        boolean isInvoice = (message.getFIToFICstmrCdtTrf().getGrpHdr().getPmtTpInf().getCtgyPurp().getCd()
                .equalsIgnoreCase("SUPP")
                && (message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getPurp().getCd())
                .equalsIgnoreCase("RCPT"));

        FinancialInstitutionRequest financialInstitutionRequest;
        try {
            financialInstitutionRequest = FinancialInstitutionRequest.builder()
                    .endToEndRef(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getPmtId().getTxId())
                    .categoryPurpose(message.getFIToFICstmrCdtTrf().getGrpHdr().getPmtTpInf().getCtgyPurp().getCd())
                    .isInvoice(isInvoice)
                    .amount(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getInstdAmt().getValue())
                    .instId(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getCdtrAgt().getFinInstnId()
                            .getClrSysMmbId().getMmbId())
                    .localInstrumentType(message.getFIToFICstmrCdtTrf().getGrpHdr().getPmtTpInf().getLclInstrm().getCd())
                    .narration(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getRmtInf() == null ? "": message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getRmtInf().getUstrds().get(0))
                    .transRef(message.getFIToFICstmrCdtTrf().getGrpHdr().getMsgId())
                    .sender(FinancialInstitutionDetails.builder()
                            .address(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getDbtr().getPstlAdr()
                                    .getAdrLines().get(0))
                            .currency(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getInstdAmt().getCcy())
                            .country(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getDbtr().getPstlAdr()
                                    .getCtry())
                            .instBic(
                                    message.getFIToFICstmrCdtTrf().getGrpHdr().getInstdAgt().getFinInstnId().getBICFI())
                            .instId(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getDbtrAgt()
                                    .getFinInstnId().getClrSysMmbId().getMmbId())
                            .build())
                    .receiver(FinancialInstitutionDetails.builder()
                            .address(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getCdtr().getPstlAdr()
                                    .getAdrLines().get(0))
                            .currency(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getIntrBkSttlmAmt().getCcy())
                            .country(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getCdtr().getPstlAdr()
                                    .getCtry())
                            .instBic(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getCdtrAgt()
                                    .getFinInstnId().getBICFI())
                            .instId(message.getFIToFICstmrCdtTrf().getCdtTrfTxInves().get(0).getCdtrAgt()
                                    .getFinInstnId().getClrSysMmbId().getMmbId())
                            .build())
                    .build();
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new RuntimeException(e);
        }

        return financialInstitutionRequest;

    }

    public String generateMessage(NameInquiryRequest dto) {
        Map<String, Object> templateData = new HashMap<>();
        templateData.put("messageId", Utils.generateMessageId((dto.getSender().getInstId())));

        templateData.put("toClearingSystemId", systemConfig.getToClearingSystemId());
        templateData.put("sender_papss_id", dto.getSender().getInstId());
        templateData.put("creationDateTime", Utils.generateZuluDateTime());
        templateData.put("sender_bic_code", dto.getSender().getInstBic());
        templateData.put("receiver_papss_id", dto.getReceiver().getInstId());
        templateData.put("account_number", dto.getReceiver().getAccountNumber());
        templateData.put("end_to_end_ref", dto.getEndToEndRef());

        return templateEngine.render(MessageTypeConstants.ACMT_023_XML, templateData);
    }

    public String generateMessage(String ref, String transactionDateTime, String papssId) {

        XMLGregorianCalendar creationDateTime = Utils.generateZuluDateTime();
        XMLGregorianCalendar creationDateSimple = Utils.generateSimpleDateTime();
        Map<String, Object> templateData = new HashMap<>();
        templateData.put("messageId", Utils.generateMessageId(papssId));
        templateData.put("toClearingSystemId", systemConfig.getToClearingSystemId());
        templateData.put("senderPapssId", papssId);
        templateData.put("creationDateTime", creationDateTime);
        templateData.put("creationDateSimple", creationDateSimple);
        templateData.put("originalMessageId", ref);
        templateData.put("originalTransactionDateTime", transactionDateTime);

        return templateEngine.render(MessageTypeConstants.PACS_028_XML, templateData);
    }

    public String generateMessage(CreditTransferRequest creditTransferDto, XMLGregorianCalendar creationDateTime, String papssId, String sslAliasKey)
            throws JAXBException, IOException {

        XMLGregorianCalendar creationDateSimple = Utils.generateSimpleDateTime();
        Map<String, Object> templateData = new HashMap<>();
        templateData.put("messageId", Utils.generateMessageId(creditTransferDto.getSender().getInstId()));
        templateData.put("toClearingSystemId", systemConfig.getToClearingSystemId());

        String purposeCode = null;
        String categoryPurpose = null;

        if (creditTransferDto.getIsInvoice()) {
            purposeCode = PurposeCode.RCPT.name();
            categoryPurpose = CategoryPurpose.SUPP.name();

        } else {
            purposeCode = PurposeCode.ADVA.name();
            categoryPurpose = CategoryPurpose.findByValue(creditTransferDto.getCategoryPurpose()).name();
        }

        FxRateResponse fxRateResponse = this.getFxRate(creditTransferDto, papssId, sslAliasKey);

        templateData.put("sender_papss_id", creditTransferDto.getSender().getInstId());
        templateData.put("sender_bic_id", creditTransferDto.getSender().getInstBic());
        templateData.put("sender_country", creditTransferDto.getSender().getCountry());
        templateData.put("sender_currency", creditTransferDto.getSender().getCurrency());
        templateData.put("sender_account_number", creditTransferDto.getSender().getAccountNumber());
        templateData.put("sender_account_name", creditTransferDto.getSender().getAccountName());
        templateData.put("sender_address", creditTransferDto.getSender().getAddress());
        templateData.put("sender_amount", fxRateResponse.getSenderAmount());

        templateData.put("receiver_papss_id", creditTransferDto.getReceiver().getInstId());
        templateData.put("receiver_bic_id", creditTransferDto.getReceiver().getInstBic());
        templateData.put("receiver_country", creditTransferDto.getReceiver().getCountry());
        templateData.put("receiver_currency", creditTransferDto.getReceiver().getCurrency());
        templateData.put("receiver_account_number", creditTransferDto.getReceiver().getAccountNumber());
        templateData.put("receiver_account_name", creditTransferDto.getReceiver().getAccountName());
        templateData.put("receiver_address", creditTransferDto.getReceiver().getAddress());
        templateData.put("receiver_amount", fxRateResponse.getReceiverAmount());

        templateData.put("creationDateTime", creationDateTime);
        templateData.put("creationDateSimple", creationDateSimple);

        templateData.put("ctgy_purp", categoryPurpose);
        templateData.put("instrm_type", creditTransferDto.getLocalInstrumentType());
        templateData.put("narration", creditTransferDto.getNarration());
        templateData.put("purpose_code", purposeCode);
        templateData.put("end_to_end_ref", creditTransferDto.getEndToEndRef());

        templateData.put("fx_rate", fxRateResponse.getSenderToReceiverCurrencyRate());
        templateData.put("transactionChannel", creditTransferDto.getTransactionChannel().name());

        return templateEngine.render(MessageTypeConstants.PACS_008_XML, templateData);
    }

    FxRateResponse getFxRate(CreditTransferRequest creditTransferDto, String papssId, String sslAliasKey) throws JAXBException, IOException {

        FxRateSender fxRateSender = new FxRateSender();
        fxRateSender.setInstId(creditTransferDto.getSender().getInstId());
        fxRateSender.setCountry(creditTransferDto.getSender().getCountry());
        fxRateSender.setCurrency(creditTransferDto.getSender().getCurrency());

        FxRateReceiver fxRateReceiver = new FxRateReceiver();
        fxRateReceiver.setCurrency(creditTransferDto.getReceiver().getCurrency());
        fxRateReceiver.setCountry(creditTransferDto.getReceiver().getCountry());
        fxRateReceiver.setInstId(creditTransferDto.getReceiver().getInstId());

        GetFxRateDto fxRateDto = new GetFxRateDto();
        fxRateDto.setAmount(creditTransferDto.getAmount());
        fxRateDto.setIsInvoice(creditTransferDto.getIsInvoice());
        fxRateDto.setLocalInstrumentType(creditTransferDto.getLocalInstrumentType());
        fxRateDto.setSender(fxRateSender);
        fxRateDto.setReceiver(fxRateReceiver);

        return fxRateService.getFxRate(fxRateDto, papssId, sslAliasKey);
    }

    FxRateResponse getFxRate(CreditReturnRequest creditTransferDto, String papssId, String sslAliasKey) throws JAXBException, IOException {

        FxRateSender fxRateSender = new FxRateSender();
        fxRateSender.setInstId(creditTransferDto.getOriginalTran().getSender().getInstId());
        fxRateSender.setCountry(creditTransferDto.getOriginalTran().getSender().getCountry());
        fxRateSender.setCurrency(creditTransferDto.getOriginalTran().getSender().getCurrency());

        FxRateReceiver fxRateReceiver = new FxRateReceiver();
        fxRateReceiver.setCurrency(creditTransferDto.getOriginalTran().getReceiver().getCurrency());
        fxRateReceiver.setCountry(creditTransferDto.getOriginalTran().getReceiver().getCountry());
        fxRateReceiver.setInstId(creditTransferDto.getOriginalTran().getReceiver().getInstId());

        GetFxRateDto fxRateDto = new GetFxRateDto();
        fxRateDto.setAmount(creditTransferDto.getOriginalTran().getSender().getAmount());
        fxRateDto.setIsInvoice(creditTransferDto.getOriginalTran().getIsInvoice());
        fxRateDto.setLocalInstrumentType(creditTransferDto.getOriginalTran().getLocalInstrumentType());
        fxRateDto.setSender(fxRateSender);
        fxRateDto.setReceiver(fxRateReceiver);

        return fxRateService.getFxRate(fxRateDto, papssId, sslAliasKey);
    }

    public static NameInquiryDto mapInwardNameInquiryDto(final Message message) throws DatatypeConfigurationException, ParseException {
        NameInquiryDto nameInquiryDto = NameInquiryDto.builder()
                .transRef(message.getIdVrfctnReq().getVrfctns().get(0).getId())
                .instId(message.getIdVrfctnReq().getAssgnmt().getAssgne().getAgt().getFinInstnId().getClrSysMmbId()
                        .getMmbId())
                .receiver(NameInquiryReceiver.builder()
                        .accountNumber(message.getIdVrfctnReq().getVrfctns().get(0).getPtyAndAcctId().getAcct().getOthr()
                                .getId())
                        .instId(message.getIdVrfctnReq().getAssgnmt().getAssgne().getAgt().getFinInstnId()
                                .getClrSysMmbId().getMmbId())
                        .build())
                .sender(NameInquirySender.builder()
                        .instId(message.getIdVrfctnReq().getAssgnmt().getAssgnr().getAgt().getFinInstnId()
                                .getClrSysMmbId().getMmbId())
                        .instBic(message.getIdVrfctnReq().getAssgnmt().getAssgnr().getAgt().getFinInstnId().getBICFI())
                        .build())
                .tranDateTime(generateStringFromZuluDateTime((GregorianCalendar) message.getAppHdr().getCreDt())).build();
        return nameInquiryDto;
    }

    public String generateModifyPaymentMessage(PendingRequest creditReturnDto) {


        XMLGregorianCalendar creationDateTime = Utils.generateZuluDateTime();

        Map<String, Object> templateData = new HashMap<>();

        // Generate Message ID
        templateData.put("message_id", Utils.generateMessageId(creditReturnDto.getInstId()));
        // Sender Details
        templateData.put("sender_papss_id", creditReturnDto.getInstId());
        templateData.put("sender_bic", creditReturnDto.getInstBic());
        // Receiver Details
        templateData.put("receiver_papss_id", "XA0001");
        // Transaction Details
        templateData.put("original_message_id", creditReturnDto.getOriginalEndToEndRef());
        templateData.put("original_end_to_end_id", creditReturnDto.getOriginalEndToEndRef());
        templateData.put("currency", creditReturnDto.getCurrency());
        templateData.put("amount", creditReturnDto.getAmount());

        // Date Fields
        templateData.put("creation_date", creationDateTime);
        templateData.put("assignment_date", creationDateTime);
        templateData.put("settlement_date", creditReturnDto.getSettlementDate());

        // Modification Instruction
        templateData.put("mod_instruction", creditReturnDto.getModInstruction());
        return templateEngine.render(MessageTypeConstants.CAMT007, templateData);
    }
    public String generateMessageForPaymentCancellation(PaymentRecallDto paymentCancellationRequestDTO, XMLGregorianCalendar creationDateTime,
                                                        XMLGregorianCalendar creationDateSimple) {
        Map<String, Object> templateData = new HashMap<>();
        templateData.put("messageId", Utils.generateMessageId(paymentCancellationRequestDTO.getSender().getInstId()));
        templateData.put("toClearingSystemId", systemConfig.getToClearingSystemId());
        templateData.put("creationDateTime", creationDateTime);
        templateData.put("transactionDate", paymentCancellationRequestDTO.getTransactionDate());
        templateData.put("to_clearing_system_id", paymentCancellationRequestDTO.getToClearingSystemId());
        templateData.put("sender_papss_id", paymentCancellationRequestDTO.getSender().getInstId());
        templateData.put("sender_currency", paymentCancellationRequestDTO.getReceiver().getCurrency());
        templateData.put("sender_amount", paymentCancellationRequestDTO.getAmount());
        templateData.put("sender_account_number", paymentCancellationRequestDTO.getSender().getAccountNumber());
        templateData.put("sender_account_name", paymentCancellationRequestDTO.getSender().getAccountName());
        templateData.put("sender_country_code", paymentCancellationRequestDTO.getSender().getCountry());
        templateData.put("sender_address", paymentCancellationRequestDTO.getSender().getAddress());
        templateData.put("sender_bank_scheme", paymentCancellationRequestDTO.getSender().getInstBic());
        templateData.put("receiver_papss_id", paymentCancellationRequestDTO.getReceiver().getInstId());
        templateData.put("receiver_account_name", paymentCancellationRequestDTO.getReceiver().getAccountName());
        templateData.put("receiver_account_number", paymentCancellationRequestDTO.getReceiver().getAccountNumber());
        templateData.put("receiver_bank_scheme", paymentCancellationRequestDTO.getReceiver().getInstBic());
        templateData.put("iban", "BBAN");
        templateData.put("receiver_address", paymentCancellationRequestDTO.getReceiver().getAddress());
        templateData.put("receiver_country_code", paymentCancellationRequestDTO.getReceiver().getCountry());
        templateData.put("receiver_currency", paymentCancellationRequestDTO.getReceiver().getCurrency());
        templateData.put("receiver_amount", paymentCancellationRequestDTO.getAmount());

        templateData.put("creation_date_time", creationDateTime);
        templateData.put("original_end_to_end_ref", paymentCancellationRequestDTO.getOriginalEndToEndRef());
        templateData.put("original_message_id", paymentCancellationRequestDTO.getOriginalEndToEndRef());

        templateData.put("transaction_date", creationDateSimple);
        templateData.put("reasonCode", paymentCancellationRequestDTO.getReasonCode());
        templateData.put("narration", paymentCancellationRequestDTO.getNarration());
        templateData.put("settlementType", paymentCancellationRequestDTO.getSettlementType());
        templateData.put("papss_ip", "10.115.0.20");
        templateData.put("pc_name", "NIBSS_SERVER");


        return templateEngine.render(MessageTypeConstants.CAMT056, templateData);
    }

    public String generateMessage(CreditReturnRequest creditReturnDto, String papssId,  String sslAliasKey, XMLGregorianCalendar creationDateTime,  XMLGregorianCalendar creationDateSimple) throws JAXBException, IOException {

        Map<String, Object> templateData = new HashMap<>();
        templateData.put("messageId", Utils.generateMessageId(papssId));
        templateData.put("toClearingSystemId", systemConfig.getToClearingSystemId());
        String interbankSttlmtDate = creditReturnDto.getTranDateTime()  != null ?  creditReturnDto.getTranDateTime().substring(0, 10) : creditReturnDto.getOriginalTran().getTranDateTime().substring(0, 10);

        String purposeCode = null;

        if (creditReturnDto.getOriginalTran().getIsInvoice()) {
            purposeCode = PurposeCode.RCPT.name();

        } else {
            purposeCode = PurposeCode.ADVA.name();
        }

        //FxRateResponse fxRateResponse = this.getFxRate(creditReturnDto, papssId, sslAliasKey);

        templateData.put("sender_papss_id", creditReturnDto.getOriginalTran().getSender().getInstId());
        templateData.put("sender_bic_id", creditReturnDto.getOriginalTran().getSender().getInstBic());
        templateData.put("sender_country", creditReturnDto.getOriginalTran().getSender().getCountry());
        templateData.put("sender_currency", creditReturnDto.getOriginalTran().getSender().getCurrency());
        templateData.put("sender_account_number", creditReturnDto.getOriginalTran().getSender().getAccountNumber());
        templateData.put("sender_account_name", creditReturnDto.getOriginalTran().getSender().getAccountName());
        templateData.put("sender_address", creditReturnDto.getOriginalTran().getSender().getAddress());
        templateData.put("sender_amount", creditReturnDto.getOriginalTran().getSender().getAmount());

        templateData.put("receiver_papss_id", creditReturnDto.getOriginalTran().getReceiver().getInstId());
        templateData.put("receiver_bic_id", creditReturnDto.getOriginalTran().getReceiver().getInstBic());
        templateData.put("receiver_country", creditReturnDto.getOriginalTran().getReceiver().getCountry());
        templateData.put("receiver_currency", creditReturnDto.getOriginalTran().getReceiver().getCurrency());
        templateData.put("receiver_account_number", creditReturnDto.getOriginalTran().getReceiver().getAccountNumber());
        templateData.put("receiver_account_name", creditReturnDto.getOriginalTran().getReceiver().getAccountName());
        templateData.put("receiver_address", creditReturnDto.getOriginalTran().getReceiver().getAddress());
        templateData.put("receiver_amount", creditReturnDto.getOriginalTran().getReceiver().getAmount());

        templateData.put("original_messageId", creditReturnDto.getOriginalTran().getTransRef());
        templateData.put("original_end_to_end_ref", creditReturnDto.getOriginalTran().getEndToEndRef());

        templateData.put("creationDateTime", creationDateTime);
        templateData.put("creationDateSimple", creationDateSimple);
        templateData.put("interbankSttlmtDate", interbankSttlmtDate);

        templateData.put("ctgy_purp", creditReturnDto.getOriginalTran().getCategoryPurpose());
        templateData.put("instrm_type", creditReturnDto.getOriginalTran().getLocalInstrumentType());
        templateData.put("narration", creditReturnDto.getOriginalTran().getNarration());
        templateData.put("purpose_code", purposeCode);
        templateData.put("end_to_end_tran_ref", creditReturnDto.getOriginalTran().getEndToEndRef());
        templateData.put("end_to_end_ref", creditReturnDto.getEndToEndRef());
        templateData.put("return_reason_code", creditReturnDto.getReturnReasonCode());
        templateData.put("transactionChannel", creditReturnDto.getTransactionChannel().name());

        return templateEngine.render(MessageTypeConstants.PACS004, templateData);
    }

    public String generateMessageForPaymentCancellationStatus(PaymentRecallRejectionDto paymentCancellationRequestDTO, XMLGregorianCalendar creationDateTime,
                                                               XMLGregorianCalendar creationDateSimple) {
        Map<String, Object> templateData = new HashMap<>();
        templateData.put("messageId", Utils.generateMessageId(paymentCancellationRequestDTO.getInstId()));
        templateData.put("toClearingSystemId", systemConfig.getToClearingSystemId());
        templateData.put("creationDateTime", creationDateTime);
        templateData.put("transactionDate", paymentCancellationRequestDTO.getTransactionDate());
        templateData.put("to_clearing_system_id", paymentCancellationRequestDTO.getToClearingSystemId());
        templateData.put("sender_papss_id", paymentCancellationRequestDTO.getSender().getInstId());
        templateData.put("sender_currency", paymentCancellationRequestDTO.getSender().getCurrency());
        templateData.put("sender_amount", paymentCancellationRequestDTO.getAmount());
        templateData.put("sender_account_number", paymentCancellationRequestDTO.getSender().getAccountNumber());
        templateData.put("sender_account_name", paymentCancellationRequestDTO.getSender().getAccountName());
        templateData.put("sender_country_code", paymentCancellationRequestDTO.getSender().getCountry());
        templateData.put("sender_address", paymentCancellationRequestDTO.getSender().getAddress());
        templateData.put("sender_bank_scheme", paymentCancellationRequestDTO.getSender().getInstBic());
        templateData.put("receiver_papss_id", paymentCancellationRequestDTO.getReceiver().getInstId());
        templateData.put("receiver_account_name", paymentCancellationRequestDTO.getReceiver().getAccountName());
        templateData.put("receiver_account_number", paymentCancellationRequestDTO.getReceiver().getAccountNumber());
        templateData.put("receiver_bank_scheme", paymentCancellationRequestDTO.getReceiver().getInstBic());
        templateData.put("iban", "BBAN");
        templateData.put("receiver_address", paymentCancellationRequestDTO.getReceiver().getAddress());
        templateData.put("receiver_country_code", paymentCancellationRequestDTO.getReceiver().getCountry());
        templateData.put("receiver_currency", paymentCancellationRequestDTO.getReceiver().getCurrency());
        templateData.put("receiver_amount", paymentCancellationRequestDTO.getAmount());

        templateData.put("creation_date_time", creationDateTime);
        templateData.put("original_end_to_end_ref", paymentCancellationRequestDTO.getOriginalEndToEndRef());
        templateData.put("original_message_id", paymentCancellationRequestDTO.getOriginalMessageId());

        templateData.put("transaction_date", creationDateSimple);
        templateData.put("reasonCode", paymentCancellationRequestDTO.getReasonCode().name());
        templateData.put("narration", paymentCancellationRequestDTO.getNarration());
        templateData.put("settlementType", paymentCancellationRequestDTO.getSettlementType());
        templateData.put("papss_ip", "10.115.0.20");
        templateData.put("pc_name", "NIBSS_SERVER");


        return templateEngine.render(MessageTypeConstants.CAMT029, templateData);
    }



    public String generateFinancialInstitutionMessage(FinancialInstitutionRequest dto, XMLGregorianCalendar creationDateTime, String papssId, String sslAliasKey)
            throws JAXBException, IOException {

        XMLGregorianCalendar creationDateSimple = Utils.generateSimpleDateTime();
        Map<String, Object> templateData = new HashMap<>();
        templateData.put("messageId", Utils.generateMessageId(dto.getSender().getInstId()));
        templateData.put("toClearingSystemId", systemConfig.getToClearingSystemId());

        String purposeCode = null;
        String categoryPurpose = null;

        if (dto.getIsInvoice()) {
            //purposeCode = PurposeCode.RCPT.name();
            categoryPurpose = CategoryPurpose.SUPP.name();
        } else {
            //purposeCode = PurposeCode.ADVA.name();
            categoryPurpose = CategoryPurpose.findByValue(dto.getCategoryPurpose()).name();
        }

        FxRateResponse fxRateResponse = this.getFxRate(dto, papssId, sslAliasKey);

        templateData.put("sender_papss_id", dto.getSender().getInstId());
        templateData.put("sender_bic_id", dto.getSender().getInstBic());
        templateData.put("sender_country", dto.getSender().getCountry());
        templateData.put("sender_currency", dto.getSender().getCurrency());
        //templateData.put("sender_account_number", dto.getSender().getAccountNumber());
        //templateData.put("sender_account_name", dto.getSender().getAccountName());
        templateData.put("sender_address", dto.getSender().getAddress());
        templateData.put("sender_amount", fxRateResponse.getSenderAmount());

        templateData.put("receiver_papss_id", dto.getReceiver().getInstId());
        templateData.put("receiver_bic_id", dto.getReceiver().getInstBic());
        templateData.put("receiver_country", dto.getReceiver().getCountry());
        templateData.put("receiver_currency", dto.getReceiver().getCurrency());
       //templateData.put("receiver_account_number", dto.getReceiver().getAccountNumber());
        //templateData.put("receiver_account_name", dto.getReceiver().getAccountName());
        templateData.put("receiver_address", dto.getReceiver().getAddress());
        templateData.put("receiver_amount", fxRateResponse.getReceiverAmount());

        templateData.put("creationDateTime", creationDateTime);
        templateData.put("creationDateSimple", creationDateSimple);

        templateData.put("ctgy_purp", categoryPurpose);
        templateData.put("instrm_type", dto.getLocalInstrumentType());
        templateData.put("narration", dto.getNarration());
        //templateData.put("purpose_code", purposeCode);
        templateData.put("end_to_end_ref", dto.getEndToEndRef());

        templateData.put("fx_rate", fxRateResponse.getSenderToReceiverCurrencyRate());

        return templateEngine.render(MessageTypeConstants.PACS_009_XML, templateData);
    }

    FxRateResponse getFxRate(FinancialInstitutionRequest dto, String papssId, String sslAliasKey) throws JAXBException, IOException {
        FxRateSender fxRateSender = new FxRateSender();
        fxRateSender.setInstId(dto.getSender().getInstId());
        fxRateSender.setCountry(dto.getSender().getCountry());
        fxRateSender.setCurrency(dto.getSender().getCurrency());

        FxRateReceiver fxRateReceiver = new FxRateReceiver();
        fxRateReceiver.setCurrency(dto.getReceiver().getCurrency());
        fxRateReceiver.setCountry(dto.getReceiver().getCountry());
        fxRateReceiver.setInstId(dto.getReceiver().getInstId());

        GetFxRateDto fxRateDto = new GetFxRateDto();
        fxRateDto.setAmount(dto.getAmount());
        fxRateDto.setIsInvoice(dto.getIsInvoice());
        fxRateDto.setLocalInstrumentType(dto.getLocalInstrumentType());
        fxRateDto.setSender(fxRateSender);
        fxRateDto.setReceiver(fxRateReceiver);

        return fxRateService.getFxRate(fxRateDto, papssId, sslAliasKey);
    }
}
