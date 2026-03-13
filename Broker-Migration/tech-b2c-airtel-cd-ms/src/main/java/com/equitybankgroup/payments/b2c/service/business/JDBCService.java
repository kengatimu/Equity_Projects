/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.service.business;

import com.equitybankgroup.payments.b2c.enums.RequestTypes;
import com.equitybankgroup.payments.b2c.model.StatusDetails;
import com.equitybankgroup.payments.b2c.model.TransactionDetails;
import com.equitybankgroup.payments.b2c.repository.StatusDetailsRepository;
import com.equitybankgroup.payments.b2c.repository.TransactionDetailsRepository;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

/**
 *
 * @author ronaldcheruiyot
 */
@Component
@RequiredArgsConstructor
public class JDBCService {
    
    private final StatusDetailsRepository statusDetailsRepository;
    
    private final TransactionDetailsRepository transactionDetailsRepository;
    
    public StatusDetails getB2cTransactionsByRrn(String rrn)
    {
        Optional<StatusDetails> sdOpt = statusDetailsRepository.findByRrn(rrn);
        if(sdOpt.isPresent()) return sdOpt.get();
        return null;
    }
    
    public TransactionDetails getB2cTransactionDeatilsByRrn(String rrn, RequestTypes operationType)
    {
        Optional<TransactionDetails> tdOpt = transactionDetailsRepository.findByRrnAndOperationType(rrn, operationType);
        if(tdOpt.isPresent()) return tdOpt.get();
        return null;
    }
    
    public void editB2cTransactions(StatusDetails record, String status1, String rrn, String status2)
    {
        statusDetailsRepository.save(record);
    }
           
    
}
