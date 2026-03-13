//package com.equitybank.gag.papss.ips.web.controller;
//
//import com.equitybank.gag.papss.ips.pojo.channelRequest.namecheck.ChannelNamecheckDetailsReq;
//import com.equitybank.gag.papss.ips.pojo.channelResponse.ChannelResponse;
//import com.equitybank.gag.papss.ips.pojo.channelResponse.ChannelStatusInfo;
//import com.equitybank.gag.papss.ips.service.ProcessRequestService;
//import com.google.gson.Gson;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.MediaType;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//
//import java.util.HashMap;
//import java.util.Map;
//
//import static com.equitybank.gag.papss.ips.config.StatusCodeMessages.*;
//import static com.equitybank.gag.papss.ips.enums.TransactionStatus.FAILURE;
//import static com.equitybank.gag.papss.ips.enums.TransactionStatus.TIMEOUT;
//
//@RestController
//@RequestMapping(path = "/papss/api/v1/inbound")
//public class InboundNamecheckController {
//    private static final Logger log = LoggerFactory.getLogger(InboundNamecheckController.class);
//
//    private final Gson gson;
//    private final ProcessRequestService processRequest;
//
//    @Autowired
//    public InboundNamecheckController(Gson gson,
//                                      ProcessRequestService processRequest) {
//        this.gson = gson;
//        this.processRequest = processRequest;
//    }
//
//    @PostMapping(value = "/nameenquiry",
//            consumes = {MediaType.APPLICATION_JSON_VALUE},
//            produces = {MediaType.APPLICATION_JSON_VALUE})
//    ResponseEntity<?> nameCheck(@RequestBody ChannelNamecheckDetailsReq channelNamecheckDetailsReq) {
//        String rrn = channelNamecheckDetailsReq.getChannelInfo().getRrn();
//        ChannelResponse channelResponse = new ChannelResponse();
//        try {
//            log.info("Received Inbound Namecheck Request: " + gson.toJson(channelNamecheckDetailsReq));
//
//            // Process the request
//            channelResponse = processRequest.processInboundNamecheckRequest(channelNamecheckDetailsReq);
//
//            log.info("Returned Success Namecheck Response: " + gson.toJson(channelResponse));
//            return new ResponseEntity<>(channelResponse, HttpStatus.OK);
//        } catch (Exception e) {
//            log.error("Exception occurred: " + e.getMessage());
//
//            // Parse error code and message from exception
//            Map<String, String> errorMap = getErrorDesc(e.getMessage());
//            String errorMessage = errorMap.getOrDefault("message", "An unexpected error occurred");
//            String httpStatusCode = errorMap.getOrDefault("code", "400");
//
//            if ("0".equals(httpStatusCode) || httpStatusCode.isBlank()) {
//                httpStatusCode = String.valueOf(DEFAULT_HTTP_STATUS_CODE);
//            }
//
//            // Check if the HTTP status code is valid (within range 100-599)
//            if (Integer.parseInt(httpStatusCode) < 100 || Integer.parseInt(httpStatusCode) > 599) {
//                httpStatusCode = String.valueOf(DEFAULT_HTTP_STATUS_CODE);
//            }
//
//            // Construct the response
//            channelResponse = generateResponse(errorMessage, rrn);
//
//            log.info("Returned Failure Namecheck Response: " + gson.toJson(channelResponse));
//            return new ResponseEntity<>(channelResponse, HttpStatus.valueOf(Integer.parseInt(httpStatusCode)));
//        }
//    }
//
//    private ChannelResponse generateResponse(String errorMessage, String rrn) {
//        String errorCode = DEFAULT_ERROR_CODE;
//        String errorStatus = String.valueOf(FAILURE);
//
//        // Update error code for timeout and authorization
//        if (errorMessage.contains("timeout")
//                || errorMessage.contains("time out")
//                || errorMessage.contains("timed out")) {
//            errorCode = TIMEOUT_STATUS_CODE;
//            errorStatus = String.valueOf(TIMEOUT);
//        }
//
//        ChannelStatusInfo statusInfo = new ChannelStatusInfo();
//        statusInfo.setStatus(errorStatus);
//        statusInfo.setCode(errorCode);
//        statusInfo.setDescription(errorMessage);
//
//        ChannelResponse channelResponse = new ChannelResponse();
//        channelResponse.setRrn(rrn);
//        channelResponse.setChannelStatusInfo(statusInfo);
//
//        return channelResponse;
//    }
//
//    private Map<String, String> getErrorDesc(String errorMessage) {
//        Map<String, String> errorMap = new HashMap<>();
//
//        if (errorMessage == null || errorMessage.isEmpty()) {
//            errorMessage = DEFAULT_PROCESSING_FAILURE;
//        }
//
//        String[] parts = errorMessage.split("\\|", 2); // Limit to 2 parts
//
//        if (parts.length == 2) {
//            errorMap.put("code", parts[0]);
//            errorMap.put("message", parts[1]);
//        } else {
//            // Fallback if format is not as expected
//            errorMap.put("code", "400");
//            errorMap.put("message", "Internal Error: Could not process the request");
//        }
//
//        return errorMap;
//    }
//}