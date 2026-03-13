package com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyFactory;

import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.patterns.strategy.xmlReqProcessor.strategyService.XmlTypeProcessingStrategyService;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class MoneyGramStrategyFactory {
    private final Map<String, XmlTypeProcessingStrategyService> strategies;

    public MoneyGramStrategyFactory(@Qualifier("feeLookupStrategy") XmlTypeProcessingStrategyService feeLookupStrategy,
                                    @Qualifier("imtReferenceNumberStrategy") XmlTypeProcessingStrategyService imtReferenceNumberStrategy,
                                    @Qualifier("getFieldForProductStrategy") XmlTypeProcessingStrategyService getFieldForProductStrategy,
                                    @Qualifier("receiveGetFieldForProductStrategy") XmlTypeProcessingStrategyService receiveGetFieldForProductStrategy,
                                    @Qualifier("sendValidationStrategy") XmlTypeProcessingStrategyService sendValidationStrategy,
                                    @Qualifier("receiveValidationStrategy") XmlTypeProcessingStrategyService receiveValidationStrategy,
                                    @Qualifier("commitTransactionStrategy") XmlTypeProcessingStrategyService commitTransactionStrategy,
                                    @Qualifier("receiveCommitTransactionStrategy") XmlTypeProcessingStrategyService receiveCommitTransactionStrategy,
                                    @Qualifier("detailLookupStrategy") XmlTypeProcessingStrategyService detailLookupStrategy,
                                    @Qualifier("callbackStrategy") XmlTypeProcessingStrategyService callbackStrategy,
                                    @Qualifier("imtSendReversalStrategy") XmlTypeProcessingStrategyService imtSendReversalStrategy,
                                    @Qualifier("imtReceiveReversalStrategy") XmlTypeProcessingStrategyService imtReceiveReversalStrategy,
                                    @Qualifier("imtAmendTransactionStrategy") XmlTypeProcessingStrategyService imtAmendTransactionStrategy,
                                    @Qualifier("imtCodeTableStrategy") XmlTypeProcessingStrategyService imtCodeTableStrategy) {

        this.strategies = Map.ofEntries(
                Map.entry("moneygram-fee-lookup", feeLookupStrategy),
                Map.entry("moneygram-receive-reference-number-request", imtReferenceNumberStrategy),
                Map.entry("moneygram-get-field-for-product", getFieldForProductStrategy),
                Map.entry("moneygram-receive-get-field-for-product", receiveGetFieldForProductStrategy),
                Map.entry("moneygram-send-validation-request", sendValidationStrategy),
                Map.entry("moneygram-receive-validation-request", receiveValidationStrategy),
                Map.entry("moneygram-commit-transaction", commitTransactionStrategy),
                Map.entry("moneygram-receive-commit-transaction", receiveCommitTransactionStrategy),
                Map.entry("moneygram-detail-lookup", detailLookupStrategy),
                Map.entry("moneygram-commit-callback", callbackStrategy),
                Map.entry("moneygram-send-reversal", imtSendReversalStrategy),
                Map.entry("moneygram-receive-reversal", imtReceiveReversalStrategy),
                Map.entry("moneygram-amend-transaction", imtAmendTransactionStrategy),
                Map.entry("moneygram-code-table-service", imtCodeTableStrategy)
        );
    }

    public XmlTypeProcessingStrategyService getStrategy(String type, String rrn) throws CustomException {
        XmlTypeProcessingStrategyService moneygramStrategy = strategies.get(type);
        if (moneygramStrategy == null) {
            throw new CustomException("Unsupported MoneyGram strategy type: " + type);
        }
        return moneygramStrategy;
    }
}
