package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.enums.TransactionStatus;
import com.equitybank.gag.telco_b2c.service.DatabaseOperationService;
import com.equitybank.gag.telco_b2c.service.ImtGetReferenceNumberService;
import com.equitybank.gag.telco_b2c.service.PayloadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ImtGetReferenceNumberServiceImpl implements ImtGetReferenceNumberService {
    private final DatabaseOperationService databaseOperationService;
    private final PayloadService payloadService;

    @Autowired
    public ImtGetReferenceNumberServiceImpl(DatabaseOperationService databaseOperationService,
                                            PayloadService payloadService) {
        this.databaseOperationService = databaseOperationService;
        this.payloadService = payloadService;
    }

    @Override
    public String getImtCommitResponse(String rrn) {
        TransactionDetails transactionDetails = databaseOperationService.getRecordByRRN(rrn);

        if (transactionDetails.getRrn() == null || transactionDetails.getImtReferenceNumber() == null) {
            return payloadService.imtDefaultErrorResponseXml(rrn, "404", "IMT Reference Number Does Not Exist", TransactionStatus.ERROR);
        }
        return getImtCommitDetails(transactionDetails, rrn);
    }

    private String getImtCommitDetails(TransactionDetails transactionDetails, String rrn) {

        return "<statusDetails>\n" +
                "    <rrn>" + rrn + "</rrn>\n" +
                "    <status>" + transactionDetails.getStatusDetails().getStatus() + "</status>\n" +
                "    <imtStatus>" + transactionDetails.getStatusDetails().getImtStatus() + "</imtStatus>\n" +
                "    <responseCode>" + transactionDetails.getStatusDetails().getStatusCode() + "</responseCode>\n" +
                "    <responseDesc>" + transactionDetails.getStatusDetails().getImtStatusDescription() + "</responseDesc>\n" +
                "    <referenceNumber>" + transactionDetails.getImtReferenceNumber() + "</referenceNumber>\n" +
                "    <expectedDateOfDelivery>" + transactionDetails.getImtExpectedDateOfDelivery() + "</expectedDateOfDelivery>\n" +
                "    <transactionDateTime>" + transactionDetails.getImtTransactionDateTime() + "</transactionDateTime>\n" +
                "</statusDetails>";
    }
}
