package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.dto.thunes.staticData.StaticDataRequest;
import com.equitybank.gag.telco_b2c.exception.CustomException;

public interface ThunesStaticDataProcessorService {
    String getStaticData(StaticDataRequest staticDataRequest, String type) throws CustomException;
}
