package com.equitybank.payments.imt.b2c.drcbroker.repository.impl;

import com.equitybank.payments.imt.b2c.drcbroker.domain.AtmCodeDetails;
import com.equitybank.payments.imt.b2c.drcbroker.repository.AtmCodeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@Transactional
public class AtmCodeRepositoryImpl {
    private final AtmCodeRepository atmCodeRepository;

    @Autowired
    public AtmCodeRepositoryImpl(@Lazy AtmCodeRepository atmCodeRepository) {
        this.atmCodeRepository = atmCodeRepository;
    }

    public void save(AtmCodeDetails atmCodeDetails) {
        atmCodeRepository.save(atmCodeDetails);
    }

    //    @Cacheable(value = "imtB2CTechDRCBrokerMSCache", key = "#rrn", unless = "#result == null")
    public Optional<AtmCodeDetails> findInputByRrn(String rrn) {
        return atmCodeRepository.findByRrn(rrn);
    }
}
