/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.service.business;

import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.enums.TransactionStatus;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.model.Callback;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.model.PayloadDetails;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.model.StatusDetails;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.model.TransactionDetails;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.repository.TransactionDetailsRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Objects;
import java.util.Optional;


/**
 *
 * @author ronaldcheruiyot
 */
@Component
public class JDBCService {
    @Autowired
    private TransactionDetailsRepository transactionDetailsRepository;

    private static final Logger logger = LoggerFactory.getLogger(JDBCService.class);
    
    public TransactionDetails getB2cTransactionsByRrn(String rrn)
    {
        Optional<TransactionDetails> sdOpt = transactionDetailsRepository.findByRrn(rrn);
        return sdOpt.orElse(null);
    }
    
    public void updateLogDetails(String request, String channelResponse, String telcoReqStr, String telcoRespStr, String status1, String rrn, String status2, String msg,String tranId)
    {
        try {
                TransactionDetails transactionDetails = getB2cTransactionsByRrn(rrn);
                if (Objects.nonNull(transactionDetails)) {
                    StatusDetails statusDetails = transactionDetails.getStatusDetails();
                    statusDetails.setStatus(status1);
                    if (Objects.nonNull(tranId)) {
                        statusDetails.setTranId(tranId);
                    }
                    statusDetails.setStatusCode(status2);
                    statusDetails.setStatusMessage(msg);

                    // SAVE PAYLOAD
                    PayloadDetails payloadDetails = transactionDetails.getPayloadDetails();
                    if (Objects.nonNull(telcoReqStr)) {
                        payloadDetails.setTelcoRequest(telcoReqStr);
                    }
                    if (Objects.nonNull(telcoRespStr)) {
                        payloadDetails.setTelcoResponse(telcoRespStr);
                    }
                    if (Objects.nonNull(channelResponse)) {
                        payloadDetails.setChannelResponse(channelResponse);
                    }
                    payloadDetails.setChannelRequest(request);
                    transactionDetails.setPayloadDetails(payloadDetails);

                    //SAVE CALLBACK
                    Callback callback = transactionDetails.getCallback();
                    callback.setCallbackStatus(TransactionStatus.PENDING.name());
                    transactionDetails.setCallback(callback);
                    transactionDetailsRepository.save(transactionDetails);
                } else {
                    logger.info("Unknown Error Occurred");
                }
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
    }
}
