package com.equitybank.gag.papss.ots.service.impl;

import com.equitybank.gag.papss.ots.dto.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.service.HttpResponseProcessorService;
import com.equitybank.gag.papss.ots.service.PayloadChannelResponseComposerService;
import com.equitybank.gag.papss.ots.service.XmlResponseReaderService;
import org.jpos.transaction.Context;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.DEFAULT_ERROR;

@Service
public class HttpResponseProcessorServiceImpl implements HttpResponseProcessorService {
    private static final Logger log = LoggerFactory.getLogger(HttpResponseProcessorServiceImpl.class);

    private final XmlResponseReaderService xmlResponseReaderService;
    private final PayloadChannelResponseComposerService payloadChannelResponseComposerService;

    @Autowired
    public HttpResponseProcessorServiceImpl(XmlResponseReaderService xmlResponseReaderService,
                                            PayloadChannelResponseComposerService payloadChannelResponseComposerService) {
        this.xmlResponseReaderService = xmlResponseReaderService;
        this.payloadChannelResponseComposerService = payloadChannelResponseComposerService;
    }

    @Override
    public ChannelResponse processNamecheckResponse(String rrn, String httpResponseString, String type) throws CustomException {
        return processCommonResponse(new Context(), rrn, "", httpResponseString, type);
    }

    @Override
    public ChannelResponse processTransactionResponse(Context ctx, String rrn, String httpResponseString, String type) throws CustomException {
        return processCommonResponse(ctx, rrn, "", httpResponseString, type);
    }

    @Override
    public ChannelResponse processStatusCheckResponse(String rrn, String originalRrn, String httpResponseString, String type) throws CustomException {
        return processCommonResponse(new Context(), rrn, originalRrn, httpResponseString, type);
    }

    private ChannelResponse processCommonResponse(Context ctx, String rrn, String originalRrn, String httpResponseString, String type) throws CustomException {
            Map<String, String> resultMap = xmlResponseReaderService.processXmlResponse(ctx, rrn, originalRrn, httpResponseString, type);

            log.info("{}: The Response Map: {}", rrn, resultMap);
            return mapResponseObject(rrn, resultMap, type);
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
