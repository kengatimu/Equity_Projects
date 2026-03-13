package com.equitybank.gag.papss.ips.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class ErrorMappingConfiguration {

    @Bean(name = "papssErrorCodeMapping")
    public Map<String, String> mapPapssErrorCodesToErrorDescription() {
        HashMap<String, String> errorCodeMap = new HashMap<>();

        // Papss error mapping
        errorCodeMap.put("0", "000:Success");
        errorCodeMap.put("100", "MS03:Internal processing error");
        errorCodeMap.put("500", "AB05/TM01:Timeout at the creditor agent");
        errorCodeMap.put("501", "MS02:Payment rejected by receiver Participant");
        errorCodeMap.put("502", "AB08:Receiver Participant is disconnected");
        errorCodeMap.put("1000", "MS03:Generic error");
        errorCodeMap.put("1001", "MS03:Generic validaEon error");
        errorCodeMap.put("1002", "FF01:The currency is invalid");
        errorCodeMap.put("1003", "FF01:The amount is invalid (less than or equal to zero)");
        errorCodeMap.put("1004", "DNOR:Value of field DbtrAgt is invalid: No active Participant with this BIC was found");
        errorCodeMap.put("1005", "CNOR:Value of field CdtrAgt is invalid: No active Participant with this BIC was found");
        errorCodeMap.put("1006", "RC01:Value of field InstgAgt is invalid: No active Participant with this BIC was found.");
        errorCodeMap.put("1007", "RC01:Generic error");
        errorCodeMap.put("1008", "AC01:The debtor Account or IBAN is invalid");
        errorCodeMap.put("1009", "AC01:The creditor Account or IBAN is invalid");
        errorCodeMap.put("1010", "AM05:De Dup. A payment with the same reference has been detected within processing");
        errorCodeMap.put("1011", "AM05:De Dup. A payment with the same reference has been detected as already processed");
        errorCodeMap.put("1012", "FF01:Settlement date is invalid (IntrBkSYlmDt)");
        errorCodeMap.put("1013", "FF01:Invalid XML format");
        errorCodeMap.put("1014", "Unused:Unused");
        errorCodeMap.put("1015", "AB05:Timeout error");
        errorCodeMap.put("1016", "AG09:Invalid original reference");
        errorCodeMap.put("1017", "AG09:Invalid status of the original transaction");
        errorCodeMap.put("1018", "RC01:No valid sender – the sender Participant is not ACTIVE");
        errorCodeMap.put("1019", "AG01:The payment schema is not defined for the currency mentioned in the message");
        errorCodeMap.put("1020", "AM02:The amount is too large in comparison to the parameter defined in the payment schema");
        errorCodeMap.put("1021", "AG10:The sender is BLOCKED (temporary deactivated)");
        errorCodeMap.put("1022", "RR04:The Participant is not mapped in the payment schema. Both Participant mentioned in the message need to be checked");
        errorCodeMap.put("1026", "FF01:Invalid XML field");
        errorCodeMap.put("1027", "RC01:Invalid receiver message field");
        errorCodeMap.put("1028", "FF01:The value of field Original Settlement Date is not valid in comparison to the payment schema and the current day");
        errorCodeMap.put("1029", "RC01:Transaction/message On Us. Debtor Agent and Creditor Agent are equal");
        errorCodeMap.put("1030", "RC01:Invalid originator. The sender of the payment is not the instigated agent");
        errorCodeMap.put("1031", "MS03:Invalid national payment message. In case of an escrow reservation the sender country must be the same as the receiver country");
        errorCodeMap.put("1032", "MS03:Missing sender Settlement Region. No Settlement region was found for the sender country and currency");
        errorCodeMap.put("1033", "MS03:Missing instructed amount");
        errorCodeMap.put("1034", "MS05:Missing receiver Settlement Region");
        errorCodeMap.put("1035", "MS03:Missing FX Rate");
        errorCodeMap.put("1036", "MS05:Account disabled");
        errorCodeMap.put("1037", "MS03:Invalid sender agent");
        errorCodeMap.put("1038", "MS03:Compliance check failure");
        errorCodeMap.put("2000", "AM23:Insufficient funds for the transaction clearing");
        errorCodeMap.put("3000", "FF01:The Participant has no ACTIVE registered DS certificate for the validaEon of messages");
        errorCodeMap.put("3001", "FF01:The XML message does not entail the digital signature in the specified format");
        errorCodeMap.put("3002", "FF01:The digital signature does not protect the enEre XML message");
        errorCodeMap.put("3003", "FF01:Invalid digital signature");
        errorCodeMap.put("3004", "FF01:The certificate used for the signature is expired or it has been revoked");
        errorCodeMap.put("9001", "MS03:Settlement posting failure");

        return errorCodeMap;
    }

    @Bean(name = "finacleErrorMapping")
    public Map<String, String> finacleErrorCodesToErrorDescription() {
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
