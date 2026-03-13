package com.equitybank.gag.orange_money_ms.service.impl;

import com.equitybank.gag.orange_money_ms.service.ExceptionReaderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

import static com.equitybank.gag.orange_money_ms.config.StatusCodeMessages.*;

@Service
public class ExceptionReaderServiceImpl implements ExceptionReaderService {
    private static final Logger log = LoggerFactory.getLogger(ExceptionReaderServiceImpl.class);

    @Override
    public Map<String, String> readExceptionMessage(String exceptionMessage) {
        Map<String, String> exceptionMap = new HashMap<>();
        String errorDescription = exceptionMessage.toLowerCase();
        String httpStatusCode = "";
        String errorCode = "";

        //split the errorMessage
        String[] errorArray = exceptionMessage.split("\\|");
        if (errorArray.length > 1) {
            errorCode = errorArray[0];
            httpStatusCode = errorCode;
            errorDescription = errorArray[1].toLowerCase();
        }

        // Update error code for timeout and authorization
        if (errorCode.equals("408")
                || errorDescription.contains("timeout")
                || errorDescription.contains("time out")
                || errorDescription.contains("timed out")) {
            httpStatusCode = errorCode;
            errorCode = TIMEOUT_STATUS_CODE;
        } else if (errorCode.equals("401")) {
            httpStatusCode = errorCode;
            errorCode = SIGNATURE_VALIDATION_STATUS_CODE;
        }

        // Update the map
        exceptionMap.put("errorCode", errorCode);
        exceptionMap.put("httpStatusCode", httpStatusCode);
        exceptionMap.put("errorDescription", errorDescription);

        // Console log
        log.info("Exception Map Values: \n{}", exceptionMap);
        return exceptionMap;
    }
}
