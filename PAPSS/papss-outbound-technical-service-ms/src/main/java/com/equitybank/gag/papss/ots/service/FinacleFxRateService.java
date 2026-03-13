package com.equitybank.gag.papss.ots.service;

import com.equitybank.gag.papss.ots.exception.CustomException;

import java.util.Map;

public interface FinacleFxRateService {

    // Fetches FX rates from Finacle using TTS and TTB rate codes.
    Map<String, String> fetchUsdKesRates() throws CustomException;
}
