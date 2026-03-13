/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.service.business;

import com.equitybankgroup.payments.b2c.model.StatusDetails;
import com.equitybankgroup.payments.b2c.repository.StatusDetailsRepository;
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
    
    public StatusDetails getB2cTransactionsByRrn(String rrn)
    {
        Optional<StatusDetails> sdOpt = statusDetailsRepository.findByRrn(rrn);
        if(sdOpt.isPresent()) return sdOpt.get();
        return null;
    }
    
    public void editB2cTransactions(StatusDetails record)
    {
        statusDetailsRepository.save(record);
    }
           
    
}
