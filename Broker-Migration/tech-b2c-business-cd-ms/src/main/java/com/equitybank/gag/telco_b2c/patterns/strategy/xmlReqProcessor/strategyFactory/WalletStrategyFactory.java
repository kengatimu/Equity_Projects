package com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyFactory;

import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyService.XmlTypeProcessingStrategyService;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class WalletStrategyFactory {
    private final Map<String, XmlTypeProcessingStrategyService> strategies;

    public WalletStrategyFactory(@Qualifier("nameCheckStrategy") XmlTypeProcessingStrategyService nameCheckStrategy,
                                 @Qualifier("statusCheckStrategy") XmlTypeProcessingStrategyService statusCheckStrategy
    ) {
        this.strategies = Map.ofEntries(
                Map.entry("bank-to-wallet-namecheck", nameCheckStrategy),
                Map.entry("airtime-topup-namecheck", nameCheckStrategy),
                Map.entry("float-purchase-namecheck", nameCheckStrategy),
                Map.entry("status-check-banktowallet", statusCheckStrategy),
                Map.entry("status-check-airtime", statusCheckStrategy),
                Map.entry("status-check-floatpurchase", statusCheckStrategy)
        );
    }

    public XmlTypeProcessingStrategyService getStrategy(String type, String rrn) throws CustomException {
        XmlTypeProcessingStrategyService walletStrategy = strategies.get(type);
        if (walletStrategy == null) {
            throw new CustomException("Unsupported Wallet strategy type: " + type);
        }
        return walletStrategy;
    }
}
