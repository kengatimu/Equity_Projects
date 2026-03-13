package com.equitybank.gag.orange_money_ms.service;

import com.equitybank.gag.orange_money_ms.dto.channel.response.request;
import com.equitybank.gag.orange_money_ms.exception.CustomException;
import org.springframework.validation.BindingResult;

public interface TransactionService {
    String processRequest(request req, BindingResult result) throws CustomException;
    boolean isB2cActivated();
}
