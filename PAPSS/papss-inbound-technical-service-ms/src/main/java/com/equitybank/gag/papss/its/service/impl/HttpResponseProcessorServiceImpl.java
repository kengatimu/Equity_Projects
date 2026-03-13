package com.equitybank.gag.papss.its.service.impl;

import com.equitybank.gag.papss.its.exception.CustomException;
import com.equitybank.gag.papss.its.pojo.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.its.service.HttpResponseProcessorService;
import com.equitybank.gag.papss.its.service.PayloadChannelResponseComposerService;
import com.equitybank.gag.papss.its.service.XmlReaderService;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.Map;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.HTTP_RESPONSE_LOG_TEMPLATE;
import static com.equitybank.gag.papss.its.config.StatusCodeMessages.*;

@Service
public class HttpResponseProcessorServiceImpl implements HttpResponseProcessorService {
    private static final Logger log = LoggerFactory.getLogger(HttpResponseProcessorServiceImpl.class);

    private final XmlReaderService xmlReaderService;
    private final PayloadChannelResponseComposerService payloadChannelResponseComposerService;

    @Autowired
    public HttpResponseProcessorServiceImpl(XmlReaderService xmlReaderService,
                                            PayloadChannelResponseComposerService payloadChannelResponseComposerService) {
        this.xmlReaderService = xmlReaderService;
        this.payloadChannelResponseComposerService = payloadChannelResponseComposerService;
    }

    @Override
    public ChannelResponse processNamecheckResponse(String rrn, CloseableHttpResponse response, String type) throws CustomException {
        return processCommonResponse(rrn, response, type);
    }

    @Override
    public ChannelResponse processTransactionResponse(String rrn, CloseableHttpResponse response, String type) throws CustomException {
        return processCommonResponse(rrn, response, type);
    }

    @Override
    public ChannelResponse processStatusCheckResponse(String rrn, CloseableHttpResponse response, String type) throws CustomException {
        return processCommonResponse(rrn, response, type);
    }

    private ChannelResponse processCommonResponse(String rrn, CloseableHttpResponse response, String type) throws CustomException {
        try {
            HttpEntity entity = response.getEntity();
            int statusCode = response.getStatusLine().getStatusCode();
            String httpStatusMsg = response.getStatusLine().getReasonPhrase();

            if (entity == null || entity.getContentLength() == 0 || statusCode == 0) {
                throw new CustomException(PAPSS_TIMEOUT_ERROR);
            }

            String responseXmlString = EntityUtils.toString(entity);
            log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, httpStatusMsg, responseXmlString));

            Map<String, String> resultMap = xmlReaderService.processInboundXml(rrn, responseXmlString, type);
            log.info("{}: The Response Map: {}", rrn, resultMap);

            return mapResponseObject(rrn, resultMap, type);
        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        } catch (IOException e) {
            throw new CustomException(DEFAULT_PROCESSING_FAILURE + e.getMessage());
        }
    }

    private ChannelResponse mapResponseObject(String rrn, Map<String, String> resultMap, String type) throws CustomException {
        return switch (type.toUpperCase()) {
            case "NAMECHECK" -> payloadChannelResponseComposerService.composeNamecheckResponse(rrn, resultMap, type);
            case "CREDIT_TRANSFER", "CREDIT_TRANSFER_CALLBACK" ->
                    payloadChannelResponseComposerService.composeTransactionResponse(rrn, resultMap, type);
            case "STATUS_CHECK" ->
                    payloadChannelResponseComposerService.composeStatusCheckResponse(rrn, resultMap, type);
            default -> throw new CustomException(DEFAULT_ERROR + "Unsupported Transaction Type: " + type);
        };
    }
}
