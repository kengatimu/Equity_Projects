package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.service.TypeResolverService;
import org.springframework.stereotype.Service;

import java.util.Set;

@Service
public class TypeResolverServiceImpl implements TypeResolverService {
    @Override
    public boolean isMoneyGramService(String type) {
        Set<String> moneyGramServiceSet = Set.of(
                "moneygram-fee-lookup",
                "moneygram-receive-reference-number-request",
                "moneygram-get-field-for-product",
                "moneygram-receive-get-field-for-product",
                "moneygram-send-validation-request",
                "moneygram-receive-validation-request",
                "moneygram-commit-transaction",
                "moneygram-receive-commit-transaction",
                "moneygram-detail-lookup",
                "moneygram-amend-transaction",
                "moneygram-send-reversal",
                "moneygram-code-table-service",
                "moneygram-receive-reversal");
        return moneyGramServiceSet.contains(type);
    }

    @Override
    public boolean isNonReversalType(String type) {
        // Exclude types that do not require transaction reversal:
        // b2c transaction, airtime topup, float purchase, moneygram commit requests
        Set<String> nonReversalTypes = Set.of(
                "moneygram-fee-lookup",
                "moneygram-receive-reference-number-request",
                "moneygram-get-field-for-product",
                "moneygram-receive-get-field-for-product",
                "moneygram-send-validation-request",
                "moneygram-receive-validation-request",
                "moneygram-send-reversal",
                "moneygram-amend-transaction",
                "moneygram-receive-reversal",
                "moneygram-code-table-service",
                "moneygram-detail-lookup");
        return nonReversalTypes.contains(type);
    }

    @Override
    public boolean isNonDatabaseUpdateType(String type) {
        // Do not update Db for below responses
        Set<String> nonDatabaseUpdateType = Set.of(
                "wendi-b2c-namecheck",
                "thunes-credit-party-information",
                "thunes-credit-party-verify",
                "thunes-list-of-services",
                "thunes-bic-lookup",
                "thunes-list-of-countries",
                "thunes-payer_details",
                "thunes-payer_rates",
                "thunes-get-payers",
                "thunes-static-data-id-type",
                "thunes-static-data-purpose-of-payment",
                "thunes-static-data-bank-account-type",
                "thunes-create-quote",
                "status-check-airtime",
                "status-check-banktowallet",
                "status-check-floatpurchase",
                "bank-to-wallet-namecheck",
                "airtime-topup-namecheck",
                "float-purchase-namecheck",
                "moneygram-detail-lookup",
                "moneygram-send-reversal",
                "moneygram-amend-transaction",
                "moneygram-receive-reversal",
                "moneygram-code-table-service");
        return nonDatabaseUpdateType.contains(type);
    }
}
