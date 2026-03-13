package com.papss.middleware.service.outbound;

import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import com.papss.middleware.config.SystemConfig;
import com.papss.middleware.dto.fxrate.GetFxRateDto;
import com.papss.middleware.dto.fxrate.PostFxRateDto;
import com.papss.middleware.dto.fxrate.response.FxRateData;
import com.papss.middleware.dto.fxrate.response.FxRateResponse;
import com.papss.middleware.dto.fxrate.response.PostFxRateResponse;
import com.papss.middleware.enums.ErrorCodes;
import com.papss.middleware.exception.ApiException;
import com.papss.middleware.models.fxrate.PaymentFXRate;
import com.papss.middleware.models.fxrate.Rate;
import com.papss.middleware.service.PapssSignature;
import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import com.papss.middleware.utils.*;
import jakarta.xml.bind.JAXBException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;

import javax.xml.datatype.XMLGregorianCalendar;
import java.io.IOException;
import java.lang.reflect.Array;
import java.math.BigDecimal;
import java.security.SignatureException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

@Service
@Slf4j
@RequiredArgsConstructor
public class FxRateService {

    private final SystemConfig systemConfig;

    private final HttpClient httpClient;
    private final PapssSignature papssSignature;

    private final MustacheTemplateEngine templateEngine;

    public FxRateResponse getFxRate(GetFxRateDto fxRateDto, String papssId, String sslKeyAlias) throws IOException, JAXBException {

        String senderCountry = fxRateDto.getSender().getCountry();
        String senderCurrency = fxRateDto.getSender().getCurrency();
        String receiverCountry = fxRateDto.getReceiver().getCountry();
        String receiverCurrency = fxRateDto.getReceiver().getCurrency();
        String receiverPapssId = fxRateDto.getReceiver().getInstId();
        String localInstrument = fxRateDto.getLocalInstrumentType();
        String amount = String.valueOf(fxRateDto.getAmount());
        boolean isInvoice = fxRateDto.getIsInvoice();

        String papssUrl = "https://" + systemConfig.getIpsBaseUrl() + ":" + systemConfig.getIpsPort() + "/papss/FXRate?SenderCountry=" + senderCountry + "&SenderCurrency=" + senderCurrency + "&ReceiverCountry=" + receiverCountry + "&ReceiverCurrency=" + receiverCurrency + "&ReceiverBank=" + receiverPapssId + "&LclInstrm=" + localInstrument + "&amount=" + amount + "&isInvoice=" + isInvoice;


        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_XML);
        headers.add("X-PAPSSRTP-Channel", papssId);
        headers.add("X-PAPSS-RTP-Version", "1");

        HttpEntity<String> request = new HttpEntity<>(headers);

        ResponseEntity<String> response = httpClient.getClient(papssUrl, request, sslKeyAlias, String.class);

        PaymentFXRate paymentFXRate = Utils.unmarshall(response.getBody(), PaymentFXRate.class);

        if (paymentFXRate == null) {
            throw new ApiException(HttpStatus.BAD_REQUEST, response.getBody());
        }

        FxRateResponse fxRateResponse = new FxRateResponse();
        fxRateResponse.setSenderAmount(new BigDecimal(paymentFXRate.getFxResponse().getSenderAmount()));
        fxRateResponse.setReceiverAmount(new BigDecimal(paymentFXRate.getFxResponse().getReceiverAmount()));
        fxRateResponse.setNationalFeeAmount(new BigDecimal(paymentFXRate.getFxResponse().getNationalFeeAmount()));
        fxRateResponse.setExchangeAmount(new BigDecimal(paymentFXRate.getFxResponse().getExchangeAmount()));
        fxRateResponse.setFeeAmount(new BigDecimal(paymentFXRate.getFxResponse().getFeeAmount()));

        Rate usdToSenderCurrencyRate = (Rate) Array.get(paymentFXRate.getFxResponse().getRate(), 0);
        Rate usdToReceiverCurrencyRate = (Rate) Array.get(paymentFXRate.getFxResponse().getRate(), 1);
        Rate senderToReceiverCurrencyRate = (Rate) Array.get(paymentFXRate.getFxResponse().getRate(), 2);

        fxRateResponse.setUsdToSenderCurrencyRate(new BigDecimal(usdToSenderCurrencyRate.getValue()));
        fxRateResponse.setUsdToReceiverCurrencyRate(new BigDecimal(usdToReceiverCurrencyRate.getValue()));
        fxRateResponse.setSenderToReceiverCurrencyRate(new BigDecimal(senderToReceiverCurrencyRate.getValue()));
        fxRateResponse.setTime(paymentFXRate.getFxResponse().getTime());

        return fxRateResponse;
    }


    public FxRateResponse getFxRate(String senderCountry, String senderCurrency, String receiverCountry, String receiverCurrency, String receiverPapssId, String localInstrument, String amount, boolean isInvoice, String papssId, String sslKeyAlias) throws IOException, JAXBException {

        String papssUrl = "https://" + systemConfig.getIpsBaseUrl() + ":" + systemConfig.getIpsPort() + "/papss/FXRate?SenderCountry=" + senderCountry + "&SenderCurrency=" + senderCurrency + "&ReceiverCountry=" + receiverCountry + "&ReceiverCurrency=" + receiverCurrency + "&ReceiverBank=" + receiverPapssId + "&LclInstrm=" + localInstrument + "&amount=" + amount + "&isInvoice=" + isInvoice;


        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_XML);
        headers.add("X-PAPSSRTP-Channel", papssId);
        headers.add("X-PAPSS-RTP-Version", "1");

        HttpEntity<String> request = new HttpEntity<>(headers);

        ResponseEntity<String> response = httpClient.getClient(papssUrl, request, sslKeyAlias, String.class);

        PaymentFXRate paymentFXRate = Utils.unmarshall(response.getBody(), PaymentFXRate.class);

        if (paymentFXRate == null) {
            throw new ApiException(HttpStatus.BAD_REQUEST, response.getBody());
        }

        FxRateResponse fxRateResponse = new FxRateResponse();
        fxRateResponse.setSenderAmount(new BigDecimal(paymentFXRate.getFxResponse().getSenderAmount()));
        fxRateResponse.setReceiverAmount(new BigDecimal(paymentFXRate.getFxResponse().getReceiverAmount()));
        fxRateResponse.setNationalFeeAmount(new BigDecimal(paymentFXRate.getFxResponse().getNationalFeeAmount()));
        fxRateResponse.setExchangeAmount(new BigDecimal(paymentFXRate.getFxResponse().getExchangeAmount()));
        fxRateResponse.setFeeAmount(new BigDecimal(paymentFXRate.getFxResponse().getFeeAmount()));

        Rate usdToSenderCurrencyRate = (Rate) Array.get(paymentFXRate.getFxResponse().getRate(), 0);
        Rate usdToReceiverCurrencyRate = (Rate) Array.get(paymentFXRate.getFxResponse().getRate(), 1);
        Rate senderToReceiverCurrencyRate = (Rate) Array.get(paymentFXRate.getFxResponse().getRate(), 2);

        fxRateResponse.setUsdToSenderCurrencyRate(new BigDecimal(usdToSenderCurrencyRate.getValue()));
        fxRateResponse.setUsdToReceiverCurrencyRate(new BigDecimal(usdToReceiverCurrencyRate.getValue()));
        fxRateResponse.setSenderToReceiverCurrencyRate(new BigDecimal(senderToReceiverCurrencyRate.getValue()));
        fxRateResponse.setTime(paymentFXRate.getFxResponse().getTime());

        return fxRateResponse;
    }

    public FxRateData getFxRate(String papssId, String fxRateName, String sslKeyAlias) throws IOException, JAXBException {
        String papssUrl;
        if (fxRateName.equalsIgnoreCase("")) {
            papssUrl = "https://" + systemConfig.getIpsBaseUrl() + ":" + systemConfig.getIpsPort() + "/papss/FXRateApi?SenderBank=" + papssId;
        } else {
            papssUrl = "https://" + systemConfig.getIpsBaseUrl() + ":" + systemConfig.getIpsPort() + "/papss/FXRateApi?SenderBank=" + papssId + "&FxRateName=" + fxRateName;
        }
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_XML);
        headers.add("X-PAPSSRTP-Channel", papssId);
        headers.add("X-PAPSS-RTP-Version", "1");

        HttpEntity<String> request = new HttpEntity<>(headers);

        ResponseEntity<String> response = httpClient.getClient(papssUrl, request, sslKeyAlias, String.class);


        FxRateData fxRateData = new XmlMapper().readValue(response.getBody(), FxRateData.class);

        if (fxRateData == null) {
            throw new ApiException(HttpStatus.BAD_REQUEST, response.getBody());
        }

        return fxRateData;
    }


    public PostFxRateResponse updateFxRate(PostFxRateDto fxRateDto, String papssId, String sslKeyAlias, String key) throws SignatureException {

        String papssUrl = "https://" + systemConfig.getIpsBaseUrl() + ":" + systemConfig.getIpsPort() + "/papss/FXRateApi";

        HttpHeaders headers = new HttpHeaders();
        headers.add("X-PAPSSRTP-Channel", papssId);
        headers.add("X-PAPSS-RTP-Version", "1");

        XMLGregorianCalendar creationDateTime = Utils.generateZuluDateTime2();
        XMLGregorianCalendar creationDateSimple = Utils.generateSimpleDateTime();
        String messageId = Utils.generateMessageId(fxRateDto.getInstId());

        String fxRateXML = generateMessage(fxRateDto, creationDateTime, creationDateSimple, papssId, sslKeyAlias, messageId);
        String signedMsg = papssSignature.generateSignature(fxRateXML, sslKeyAlias, key);
        log.debug("Message to be sent: {} ", signedMsg);

        HttpEntity<String> request = new HttpEntity<>(signedMsg, headers);
        ErrorCodes errorCodeEnum;
        Status status;

        try {

            ResponseEntity<String> response = httpClient.postClient(papssUrl, request, sslKeyAlias, String.class);

            String sts = response.getHeaders().get("X-PAPSSRTP-ReqSts").get(0);
            if (sts.equalsIgnoreCase(ConstantUtils.ACCP)) {
                errorCodeEnum = Arrays.stream(ErrorCodes.values()).filter(errorCode -> errorCode.getMapping().equalsIgnoreCase(sts)).findFirst().orElse(ErrorCodes.UNKNOWN);
            } else {
                errorCodeEnum = Arrays.stream(ErrorCodes.values()).filter(errorCode -> errorCode.getValue().equalsIgnoreCase(sts.substring(5))).findFirst().orElse(ErrorCodes.UNKNOWN);
            }
            status = Status.builder().type(errorCodeEnum.getMapping()).code(errorCodeEnum.getValue()).description(errorCodeEnum.getDescription()).build();

        } catch (HttpClientErrorException e) {
            if (e.getStatusCode() == HttpStatus.BAD_REQUEST) {
                String badRequestCode = e.getResponseBodyAsString().trim();
                String last4 = badRequestCode.substring(badRequestCode.length() - 4);
                errorCodeEnum = Arrays.stream(ErrorCodes.values()).filter(errorCode -> errorCode.getValue().equalsIgnoreCase(last4)).findFirst().orElse(ErrorCodes.UNKNOWN);

                status = Status.builder().type(ConstantUtils.RJCT).code(last4).description(errorCodeEnum.getDescription()).build();
                // Log the error or handle it as necessary
                log.error("400 Error occurred: {}", e.getResponseBodyAsString());
            } else {
                // Handle other status codes or rethrow the exception
                throw e;
            }
        }
        return PostFxRateResponse.builder().tranRef(messageId).fxRateName(fxRateDto.getFxRateName()).tranDateTime(creationDateTime.toString()).status(status).build();
    }

    private String generateMessage(PostFxRateDto fxRateDto, XMLGregorianCalendar creationDateTime, XMLGregorianCalendar creationDateSimple, String papssId, String sslAliasKey, String messageId) {
        Map<String, Object> templateData = new HashMap<>();
        templateData.put("messageId", messageId);
        templateData.put("toClearingSystemId", systemConfig.getToClearingSystemId());
        templateData.put("creationDateTime", creationDateTime);
        templateData.put("creationDateSimple", creationDateSimple);
        templateData.put("senderPapssId", fxRateDto.getInstId());
        templateData.put("accountType", fxRateDto.getAccountType());
        templateData.put("buyRate", fxRateDto.getBuyRate());
        templateData.put("countryCode", fxRateDto.getCountryCode());
        templateData.put("localCurrency", fxRateDto.getLocalCurrency());
        templateData.put("fxRateName", fxRateDto.getFxRateName());
        templateData.put("sellRate", fxRateDto.getSellRate());

        return templateEngine.render(MessageTypeConstants.POST_FX_RATE_XML, templateData);
    }
}
