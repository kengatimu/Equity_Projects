package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.dto.response;

public interface XmlJsonMapperService {
    String b2cTransactionRequestToXml(request request);

    String airtimeTopUpRequestToXml(Envelope request);

    String responseToXml (response res);

    String requestToJson (request request);

    String responseToJson (response res);
}
