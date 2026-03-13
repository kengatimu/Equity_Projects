/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.business;

import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.cache.CacheObject;
import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.cache.CacheService;
import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.cache.GlobalConstants;
import com.moneygram.agentconnect1512.AgentConnectService;
import com.moneygram.agentconnect1512.AmendTransactionRequest;
import com.moneygram.agentconnect1512.AmendTransactionResponse;
import com.moneygram.agentconnect1512.CodeTableRequest;
import com.moneygram.agentconnect1512.CodeTableResponse;
import com.moneygram.agentconnect1512.CommitTransactionRequest;
import com.moneygram.agentconnect1512.CommitTransactionResponse;
import com.moneygram.agentconnect1512.DetailLookupRequest;
import com.moneygram.agentconnect1512.DetailLookupResponse;
import com.moneygram.agentconnect1512.Errors_Exception;
import com.moneygram.agentconnect1512.FeeLookupRequest;
import com.moneygram.agentconnect1512.FeeLookupResponse;
import com.moneygram.agentconnect1512.GetFieldsForProductRequest;
import com.moneygram.agentconnect1512.GetFieldsForProductResponse;
import com.moneygram.agentconnect1512.MoneyGramConsumerLookupRequest;
import com.moneygram.agentconnect1512.MoneyGramConsumerLookupResponse;
import com.moneygram.agentconnect1512.SendReversalRequest;
import com.moneygram.agentconnect1512.SendReversalResponse;
import com.moneygram.agentconnect1512.SendValidationRequest;
import com.moneygram.agentconnect1512.SendValidationResponse;
import jakarta.xml.soap.SOAPMessage;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Executor;
import java.util.logging.Level;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
@Slf4j
@RequiredArgsConstructor
public class MoneySendGramService {
    
    private final CacheService cacheService;
    
    private final Executor taskExecutor;
    
    public FeeLookupResponse feeLookup(FeeLookupRequest feeLookupRequest) throws Errors_Exception
    {   
        AgentConnectService agentConnectService = new AgentConnectService();
        
        return agentConnectService.getAgentConnect().feeLookup(feeLookupRequest);
 
    }
    
    public MoneyGramConsumerLookupResponse moneyGramConsumerLookup(MoneyGramConsumerLookupRequest moneyGramConsumerLookupRequest) throws Errors_Exception
    {
        AgentConnectService agentConnectService = new AgentConnectService();
        
        return agentConnectService.getAgentConnect().moneyGramConsumerLookup(moneyGramConsumerLookupRequest);
 
    }
    
    public  GetFieldsForProductResponse getFieldsForProduct(GetFieldsForProductRequest getFieldsForProductRequest) throws Errors_Exception
    {
        AgentConnectService agentConnectService = new AgentConnectService();
        
        return agentConnectService.getAgentConnect().getFieldsForProduct(getFieldsForProductRequest);
    }
    
    public  SendValidationResponse sendValidation(SendValidationRequest sendValidationRequest) throws Errors_Exception
    {
        AgentConnectService agentConnectService = new AgentConnectService();
        
        return agentConnectService.getAgentConnect().sendValidation(sendValidationRequest);
    }
    
    public  CommitTransactionResponse commitTransaction(CommitTransactionRequest commitTransactionRequest) throws Errors_Exception
    {
        AgentConnectService agentConnectService = new AgentConnectService();
        
        return agentConnectService.getAgentConnect().commitTransaction(commitTransactionRequest);
    }
    
    public  DetailLookupResponse detailLookup(DetailLookupRequest detailLookupRequest) throws Errors_Exception
    {
        AgentConnectService agentConnectService = new AgentConnectService();
        
        return agentConnectService.getAgentConnect().detailLookup(detailLookupRequest);
    }
    
    public AmendTransactionResponse amendTransaction(AmendTransactionRequest amendTransactionRequest) throws Errors_Exception
    {
        AgentConnectService agentConnectService = new AgentConnectService();
        
        return agentConnectService.getAgentConnect().amendTransaction(amendTransactionRequest);
    }
    
    public SendReversalResponse sendReversal(SendReversalRequest sendReversalRequest) throws Errors_Exception
    {
        AgentConnectService agentConnectService = new AgentConnectService();
        
        return agentConnectService.getAgentConnect().sendReversal(sendReversalRequest);
    }
    
    public CodeTableResponse codeTable(CodeTableRequest codeTableRequest) throws Errors_Exception
    {   
        try {
            Object object = cacheService.retrieveObject(GlobalConstants.CACHE_KEY_CODE_TABLE);
            if(object != null)
            {   
                log.info("CodeTableResponse found in cache, returning value: ");
                return (CodeTableResponse) object;
            }
        } catch (ExecutionException ex) {
            log.error("Error on retrieving CodeTableResponse from cache, continuing...");
            ex.printStackTrace(System.out);
        }
        
        log.error("CodeTableResponse not found cache, continuing...");
        
        AgentConnectService agentConnectService = new AgentConnectService();
        
        CodeTableResponse codeTableResponse =  agentConnectService.getAgentConnect().codeTable(codeTableRequest);
        
        taskExecutor.execute(() -> {
            cacheService.insert(GlobalConstants.CACHE_KEY_CODE_TABLE, codeTableResponse);
        });
        
        return codeTableResponse;
        
    }
    
    
}

