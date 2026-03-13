package com.equitybank.gag.papss.ots.service;

import java.util.Map;

public interface ExceptionReaderService {
    Map<String, String> readExceptionMessage(String exceptionMessage);
}
