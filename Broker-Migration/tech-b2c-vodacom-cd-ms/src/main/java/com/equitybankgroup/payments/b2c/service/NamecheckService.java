package com.equitybankgroup.payments.b2c.service;

import com.equitybankgroup.payments.b2c.dto.vodacom.namecheck.response.ResponseData;
import com.equitybankgroup.payments.b2c.error.CustomException;

import java.util.Map;

public interface NamecheckService<T> {
    String processNamecheckRequest(String nameCheckXmlRequest, Map<String, String> xmlMapValues) throws CustomException;

    Map<String, String> parseXML(String nameCheckXmlRequest) throws CustomException;
}
