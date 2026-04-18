package com.equitybank.payments.imt.b2c.drcbroker.repository.impl;

import com.equitybank.payments.imt.b2c.drcbroker.domain.SendToWalletDetails;
import com.equitybank.payments.imt.b2c.drcbroker.repository.SendToWalletRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@Transactional
public class SendToWalletRepositoryImpl {
    private final SendToWalletRepository sendToWalletRepository;

    @Autowired
    public SendToWalletRepositoryImpl(@Lazy SendToWalletRepository sendToWalletRepository) {
        this.sendToWalletRepository = sendToWalletRepository;
    }

    public void save(SendToWalletDetails sendToWalletDetails) {
        sendToWalletRepository.save(sendToWalletDetails);
    }

//    @Cacheable(value = "imtB2CTechDRCBrokerMSCache", key = "#rrn", unless = "#result == null")
    public Optional<SendToWalletDetails> findInputByRrn(String rrn) {
        return sendToWalletRepository.findByRrn(rrn);
    }
}
