package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.service.ExceptionReaderService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.*;

@Service
public class ExceptionReaderServiceImpl implements ExceptionReaderService {
    private static final Logger log = LoggerFactory.getLogger(ExceptionReaderServiceImpl.class);

    private final Map<String, String> finErrorDescMap;

    @Autowired
    public ExceptionReaderServiceImpl(@Qualifier("finacleErrorMapping") Map<String, String> finErrorDescMap) {
        this.finErrorDescMap = finErrorDescMap;
    }

    @Override
    public Map<String, String> readExceptionMessage(String exceptionMessage) {
        log.info("Exception Message: " + exceptionMessage);
        Map<String, String> exceptionMap = new HashMap<>();
        String errorDescription = exceptionMessage.toLowerCase();
        String httpStatusCode = "";
        String errorCode = "";

        //split the errorMessage
        String[] errorArray = exceptionMessage.split("\\|");
        log.error("ERROR MAP: " + Arrays.toString(errorArray));
        if (errorArray.length > 1) {
            errorCode = errorArray[0];
            httpStatusCode = errorCode;
            errorDescription = errorArray[1].toLowerCase();
        } else {
            errorCode = String.valueOf(DEFAULT_HTTP_STATUS_CODE);
            httpStatusCode = errorCode;
            errorDescription = errorArray[0].toLowerCase();
        }

        // Check if the errorCode exists in the fin error map. return http status 400 if it exists
        if (finErrorDescMap.containsKey(errorCode)) {
            httpStatusCode = String.valueOf(DEFAULT_HTTP_STATUS_CODE);
            errorDescription = finErrorDescMap.get(errorCode);
        }

        // Update error code for timeout and authorization
        if (errorCode.equals("408")
                || errorDescription.contains("timeout")
                || errorDescription.contains("time out")
                || errorDescription.contains("timed out")) {
            httpStatusCode = "408";
            errorCode = TIMEOUT_STATUS_CODE;
        } else if (errorCode.equals("401")) {
            httpStatusCode = "401";
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
