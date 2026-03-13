package com.equitybank.gag.telco_b2c.service;

import java.util.Map;

public interface ExceptionReaderService {
    Map<String, String> readExceptionMessage(String exceptionMessage);
}
