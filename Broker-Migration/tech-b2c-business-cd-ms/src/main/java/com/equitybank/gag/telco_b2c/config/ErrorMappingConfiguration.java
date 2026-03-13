package com.equitybank.gag.telco_b2c.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;

@Configuration
public class ErrorMappingConfiguration {

    @Bean(name = "errorCodeMapping")
    public HashMap<String, String> mapErrorCodes() {
        HashMap<String, String> errorMap = new HashMap<>();

        errorMap.put("906", "Cut over (end of day) in progress");
        errorMap.put("911", "Host timed out");
        errorMap.put("116", "Insufficient Funds");
        errorMap.put("114", "Invalid Account Number");
        errorMap.put("902", "Invalid function code");
        errorMap.put("115", "Invalid processing code");
        errorMap.put("904", "Message incorrectly formatted");
        errorMap.put("908", "Processing host cannot be reached");
        errorMap.put("907", "Processing host is down");
        errorMap.put("909", "System Malfunction");
        errorMap.put("000", "Transaction Approved");
        errorMap.put("119", "Transaction Not Permitted");
        errorMap.put("180", "Transfer limit exceeded");
        errorMap.put("121", "Withdrawal limit exceeded");
        errorMap.put("77", "Payment Transaction Not found");
        errorMap.put("-1", "Validation: System error");
        errorMap.put("-2", "Validation: failed Missing Parameters");
        errorMap.put("-3", "Transaction Failed- Core banking system general error");
        errorMap.put("-4", "Transaction Failed- Failed to reach third party system");
        errorMap.put("5", "Validation:Telco validation failed");
        errorMap.put("6", "Validation: Bank validation failed");
        errorMap.put("-7", "Validation:Transaction Duplicate");
        errorMap.put("-9", "Invalid or Unrecognized Wallet code");
        errorMap.put("-10", "Validation Deposit Limits exceeded");
        errorMap.put("-12", "AML  Failure");
        errorMap.put("-99", "Validation: Transaction Integrity  Failed");
        errorMap.put("992", "Transaction rejected because of AML reasons");
        errorMap.put("993", "Transaction Held for AML investigation");
        errorMap.put("2", "Limit rule: less than the minimum transaction amount");
        errorMap.put("7", "Receiver mobile number is in invalid");
        errorMap.put("14", "Receiver mobile number is in an invalid state");
        errorMap.put("8", "Would exceed the maximum balance");
        errorMap.put("2040", "Receiver mobile number is unregistered in MPesa");
        errorMap.put("2080", "Maximum limit exceeded");
        errorMap.put("1000", "System is busy, the service request is rejected. Partner should retry the validation");
        errorMap.put("100000001", "The system is overloaded. Partner to do a status check");
        errorMap.put("100000002", "Throttling error. Partner to do a status check");
        return errorMap;
    }
}
