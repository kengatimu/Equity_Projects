package com.equitybank.gag.telco_b2c.service;

public interface TypeResolverService {
    boolean isMoneyGramService(String type);

    boolean isNonReversalType(String type);

    boolean isNonDatabaseUpdateType(String type);
}
