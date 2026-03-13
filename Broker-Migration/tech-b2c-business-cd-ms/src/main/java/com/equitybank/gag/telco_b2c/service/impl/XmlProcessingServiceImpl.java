package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyFactory.MoneyGramStrategyFactory;
import com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyFactory.WalletStrategyFactory;
import com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyService.XmlTypeProcessingStrategyService;
import com.equitybank.gag.telco_b2c.service.XmlProcessingService;
import org.springframework.stereotype.Service;

import java.security.SignatureException;
import java.util.Map;

@Service
public class XmlProcessingServiceImpl implements XmlProcessingService {

    private final MoneyGramStrategyFactory moneyGramFactory; // Factory for MoneyGram-specific strategies
    private final WalletStrategyFactory walletFactory; // Factory for Wallet-related strategies (e.g. namecheck, status-check)

    public XmlProcessingServiceImpl(MoneyGramStrategyFactory moneyGramFactory,
                                    WalletStrategyFactory walletFactory) {
        this.moneyGramFactory = moneyGramFactory;
        this.walletFactory = walletFactory;
    }

    @Override
    public String processXmlRequests(boolean isInternal, String requestXml, Map<String, String> xmlTagsMap, String rrn, String type) throws CustomException, SignatureException {
        XmlTypeProcessingStrategyService strategy;

        // Choose strategy based on type prefix
        if (type.startsWith("moneygram-")) {
            strategy = moneyGramFactory.getStrategy(type, rrn);
        } else {
            strategy = walletFactory.getStrategy(type, rrn);
        }

        // Process using the selected strategy
        return strategy.process(isInternal, requestXml, xmlTagsMap, rrn, type);
    }
}
