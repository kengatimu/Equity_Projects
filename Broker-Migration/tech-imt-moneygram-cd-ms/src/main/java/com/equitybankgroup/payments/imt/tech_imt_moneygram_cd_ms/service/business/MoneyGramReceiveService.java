/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.business;

import com.moneygram.agentconnect1512.AgentConnectService;
import com.moneygram.agentconnect1512.CommitTransactionRequest;
import com.moneygram.agentconnect1512.CommitTransactionResponse;
import com.moneygram.agentconnect1512.Errors_Exception;
import com.moneygram.agentconnect1512.GetFieldsForProductRequest;
import com.moneygram.agentconnect1512.GetFieldsForProductResponse;
import com.moneygram.agentconnect1512.ReceiveReversalRequest;
import com.moneygram.agentconnect1512.ReceiveReversalResponse;
import com.moneygram.agentconnect1512.ReceiveValidationRequest;
import com.moneygram.agentconnect1512.ReceiveValidationResponse;
import com.moneygram.agentconnect1512.ReferenceNumberRequest;
import com.moneygram.agentconnect1512.ReferenceNumberResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 *
 * @author ronaldcheruiyot
 */
@Service
@Slf4j
public class MoneyGramReceiveService {
    
    public ReferenceNumberResponse referenceNumber(ReferenceNumberRequest referenceNumberRequest) throws Errors_Exception
    {
        AgentConnectService agentConnectService = new AgentConnectService();
        
        return agentConnectService.getAgentConnect().referenceNumber(referenceNumberRequest);
    }
    
    public  GetFieldsForProductResponse getFieldsForProduct(GetFieldsForProductRequest getFieldsForProductRequest) throws Errors_Exception
    {
        AgentConnectService agentConnectService = new AgentConnectService();
        
        return agentConnectService.getAgentConnect().getFieldsForProduct(getFieldsForProductRequest);
    }
    
    public  ReceiveValidationResponse receiveValidation(ReceiveValidationRequest receiveValidationRequest) throws Errors_Exception
    {
        AgentConnectService agentConnectService = new AgentConnectService();
        
        return agentConnectService.getAgentConnect().receiveValidation(receiveValidationRequest);
    }
    
    public  CommitTransactionResponse commitTransaction(CommitTransactionRequest commitTransactionRequest) throws Errors_Exception
    {
        AgentConnectService agentConnectService = new AgentConnectService();
        
        return agentConnectService.getAgentConnect().commitTransaction(commitTransactionRequest);
    }
    
    public  ReceiveReversalResponse receiveReversal(ReceiveReversalRequest receiveReversalRequest) throws Errors_Exception
    {
        AgentConnectService agentConnectService = new AgentConnectService();
        
        return agentConnectService.getAgentConnect().receiveReversal(receiveReversalRequest);
    }
    
    
}
