package com.equitybank.payments.imt.b2c.drcbroker.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.HashMap;

@Service
public class ErrorCodes {
    private static final Logger log = LoggerFactory.getLogger(ErrorCodes.class);

    public String getErrorMsg(String statCode) {
        String errMsg;
        HashMap<String, String> ErrorCodeMap = new HashMap<>();

        ErrorCodeMap.put("100", "Pending");
        ErrorCodeMap.put("200", "Success");
        ErrorCodeMap.put("300", "AuthenticationError: ");
        ErrorCodeMap.put("400", "MissingParameter: ");
        ErrorCodeMap.put("500", "SystemError: ");
        ErrorCodeMap.put("600", "ValidationError: ");
        ErrorCodeMap.put("700", "HTTP RequestError: ");
        ErrorCodeMap.put("800", "GAG InternalError: ");
        ErrorCodeMap.put("900", "DUP! DuplicateTransaction: ");
        ErrorCodeMap.put("1000", "Data PersistenceError: ");
        ErrorCodeMap.put("999", "SystemGenericError: ");

        errMsg = ErrorCodeMap.get(statCode);
        return errMsg == null ? "SystemGenericError" : errMsg;
    }
}
