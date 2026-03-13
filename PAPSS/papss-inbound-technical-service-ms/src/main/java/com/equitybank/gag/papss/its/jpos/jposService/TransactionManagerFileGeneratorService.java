package com.equitybank.gag.papss.its.jpos.jposService;

public interface TransactionManagerFileGeneratorService {
    // Returns the queue name of the generated TM, or null on failure.
    String generateTmXmlFile(String rrn, int tmIndex);
}
