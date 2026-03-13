package com.equitybank.gag.orange_money_ms.service;

import com.equitybank.gag.orange_money_ms.dto.channel.response.request;
import com.equitybank.gag.orange_money_ms.dto.channel.response.response;
import com.equitybank.gag.orange_money_ms.exception.CustomException;

import java.util.Map;

public interface XmlMapperService {
    String mapChannelRequestObjectToXml(request request);

    String mapBusinessServiceFailureResponseObjToXml(response res);

    Map<String, String> readTelcoResponseXmlValues(String rrn, String responseString) throws CustomException;

    String mapBusinessServiceSuccessResponseObjToXml(response response) throws CustomException;

}
