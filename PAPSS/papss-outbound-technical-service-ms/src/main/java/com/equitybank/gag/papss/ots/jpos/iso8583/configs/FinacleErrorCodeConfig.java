package com.equitybank.gag.papss.ots.jpos.iso8583.configs;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class FinacleErrorCodeConfig {

    @Bean(name = "finacleErrorMapping")
    public Map<String, String> mapErrorCodesToErrorDescription() {
        Map<String, String> errorCodeMap = new HashMap<>();

        // Initialize the error code map with finacle error code and error descriptions
        errorCodeMap.put("111", "Finacle CBS Failure. Invalid scheme type");
        errorCodeMap.put("114", "Finacle CBS Failure. Invalid account number");
        errorCodeMap.put("115", "Finacle CBS Failure. Requested function not supported (First two digits of processing code or Function code is invalid)");
        errorCodeMap.put("116", "Finacle CBS Failure. Insufficient funds");
        errorCodeMap.put("119", "Finacle CBS Failure. Transaction not permitted");
        errorCodeMap.put("121", "Finacle CBS Failure. Withdrawal amount limit exceeded");
        errorCodeMap.put("163", "Finacle CBS Failure. Invalid Cheque Status");
        errorCodeMap.put("180", "Finacle CBS Failure. Transfer Limit Exceeded");
        errorCodeMap.put("181", "Finacle CBS Failure. Cheque are in different books");
        errorCodeMap.put("182", "Finacle CBS Failure. Not all Cheque could be stopped");
        errorCodeMap.put("183", "Finacle CBS Failure. Cheque not issued to this account");
        errorCodeMap.put("184", "Finacle CBS Failure. Account is closed or frozen.");
        errorCodeMap.put("185", "Finacle CBS Failure. Invalid Currency/Transaction Amount");
        errorCodeMap.put("186", "Finacle CBS Failure. Block does not exist");
        errorCodeMap.put("187", "Finacle CBS Failure. Cheque Stopped");
        errorCodeMap.put("188", "Finacle CBS Failure. Invalid Rate Currency Combination");
        errorCodeMap.put("189", "Finacle CBS Failure. Cheque Book Already Issued");
        errorCodeMap.put("190", "Finacle CBS Failure. DD Already Paid");
        errorCodeMap.put("800", "Finacle CBS Failure. Network message was accepted");
        errorCodeMap.put("902", "Finacle CBS Failure. Invalid transaction (Invalid function code within network management messages)");
        errorCodeMap.put("904", "Finacle CBS Failure. Format Error");
        errorCodeMap.put("906", "Finacle CBS Failure. Cut-over in progress (When Stand-in Server is handing over control to Finacle)");
        errorCodeMap.put("907", "Finacle CBS Timeout Failure. Finacle timeout");
        errorCodeMap.put("909", "Finacle CBS Timeout Failure. Possibly database connection timeout");
        errorCodeMap.put("911", "Finacle CBS Timeout Failure. Card issuer timeout");
        errorCodeMap.put("913", "Finacle CBS Failure. Duplicate transaction");
        errorCodeMap.put("999", "Finacle CBS Timeout Failure");

        return errorCodeMap;
    }
}
