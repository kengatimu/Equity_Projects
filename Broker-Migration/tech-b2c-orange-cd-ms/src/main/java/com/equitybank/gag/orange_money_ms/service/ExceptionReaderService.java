package com.equitybank.gag.orange_money_ms.service;

import java.util.Map;

public interface ExceptionReaderService {
    Map<String, String> readExceptionMessage(String exceptionMessage);
}
