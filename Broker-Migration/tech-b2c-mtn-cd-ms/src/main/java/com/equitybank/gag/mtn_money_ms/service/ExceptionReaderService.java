package com.equitybank.gag.mtn_money_ms.service;

import java.util.Map;

public interface ExceptionReaderService {
    Map<String, String> readExceptionMessage(String exceptionMessage);
}
