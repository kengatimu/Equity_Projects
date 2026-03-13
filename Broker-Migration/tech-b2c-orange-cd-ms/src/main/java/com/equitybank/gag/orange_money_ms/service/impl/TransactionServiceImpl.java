package com.equitybank.gag.orange_money_ms.service.impl;

import com.equitybank.gag.orange_money_ms.constants.TPGConstants;
import com.equitybank.gag.orange_money_ms.dto.channel.response.request;
import com.equitybank.gag.orange_money_ms.entity.TransactionDetails;
import com.equitybank.gag.orange_money_ms.exception.CustomException;
import com.equitybank.gag.orange_money_ms.mapper.CustomMapperService;
import com.equitybank.gag.orange_money_ms.service.DatabaseService;
import com.equitybank.gag.orange_money_ms.service.HttpTransactionRequestService;
import com.equitybank.gag.orange_money_ms.service.TransactionService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;

@Service
public class TransactionServiceImpl implements TransactionService {
    private static final Logger log = LoggerFactory.getLogger(TransactionServiceImpl.class);

    private final HttpTransactionRequestService httpTransactionRequestService;
    private final CustomMapperService customMapperService;
    private final DatabaseService databaseService;
    
    @Value("$(service.activation.b2c)")
    private String b2cActivationStr;
    
    private final boolean b2cActivated;

    @Override
    public boolean isB2cActivated() {
        return b2cActivated;
    }
    
    

    public TransactionServiceImpl(HttpTransactionRequestService httpTransactionRequestService,
                                  CustomMapperService customMapperService,
                                  DatabaseService databaseService) {
        this.httpTransactionRequestService = httpTransactionRequestService;
        this.customMapperService = customMapperService;
        this.databaseService = databaseService;
        this.b2cActivated = Boolean.valueOf(b2cActivationStr);
    }
    
    @Override
    public String processRequest(request request, BindingResult result) throws CustomException {
        String rrn = request.getEazzycash().getRrn();
        try {
            
            if(!isB2cActivated())
            {
                return getErrorResponse(request, "503", TPGConstants.B2C_SERVICE_NOT_ACTIVATED +  " for ORANGE");
            }
            
            // Check if the transaction exists
            confirmTransactionExists(rrn);

            // Compose telco request
            String telcoXmlRequest = composeTelcoRequest(request);

            // Update database with the telcoJsonReq payload
            updateDatabaseWithTelcoRequest(rrn, telcoXmlRequest);

            // Call telco with the request
            return httpTransactionRequestService.transactionRequestHttpCall(telcoXmlRequest, rrn);

        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    private String composeTelcoRequest(request request) throws CustomException {
        try {
            return customMapperService.composeTelcoTransactionRequestString(request);
        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    private void updateDatabaseWithTelcoRequest(String rrn, String telcoJsonReq) {
        String message = String.format("%s: Updating db with telco request", rrn);

        // Prepare entity for database update
        TransactionDetails entity = customMapperService.composeEntityForTelcoRequestUpdate(rrn, telcoJsonReq);

        // Updating db with telco request
        updateDatabase(entity, message);

    }

    @Transactional(readOnly = true)
    private void confirmTransactionExists(String rrn) throws CustomException {
        try {
            databaseService.confirmTransactionRecord(rrn);
        } catch (CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    @Transactional
    private void updateDatabase(TransactionDetails entity, String message) {
        if (entity != null) {
            log.info(message);
            databaseService.updateTransactionRecord(entity);
        }
    }
    
    private String getErrorResponse(request request, String responseCode, String responseDesc)
    {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n" +
"<response>\n" +
"    <msgId>" + request.getMsgId() + "</msgId>\n" +
"    <eazzycashres>\n" +
"        <status>ERROR|" + responseCode + "</status>\n" +
"        <responseCode>" + responseCode + "</responseCode>\n" +
"        <responseDesc>" + responseDesc + "</responseDesc>\n" +
"    </eazzycashres>\n" +
"</response>";
    }
}
