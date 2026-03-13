package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.dto.response;
import com.equitybank.gag.telco_b2c.service.XmlJsonMapperService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class XmlJsonMapperServiceImpl implements XmlJsonMapperService {
    private static final Logger log = LoggerFactory.getLogger(XmlJsonMapperServiceImpl.class);

    @Override
    public String b2cTransactionRequestToXml(request request) {
        String defaultString = "<request/>";
        try {
            XmlMapper xmlMapper = new XmlMapper();
            String xml = xmlMapper.writerWithDefaultPrettyPrinter().writeValueAsString(request);
            String xml1 = xml.replace("<OmniRequestDto>", " <request>");
            return xml1.replace("</OmniRequestDto>", " </request>");
        } catch (Exception e) {
            log.error("Error Mapping Request To XML: " + e.getMessage());
            return defaultString;
        }
    }

    @Override
    public String airtimeTopUpRequestToXml(Envelope request) {
        String defaultString = "</>";
        try {
            XmlMapper xmlMapper = new XmlMapper();
            return xmlMapper.writerWithDefaultPrettyPrinter().writeValueAsString(request);
        } catch (Exception e) {
            log.error("Error Mapping Request To XML: " + e.getMessage());
            return defaultString;
        }
    }

    @Override
    public String responseToXml(response res) {
        String defaultString = "<response/>";
        try {
            XmlMapper xmlMapper = new XmlMapper();
            return xmlMapper.writerWithDefaultPrettyPrinter().writeValueAsString(res);
        } catch (Exception e) {
            log.error("Error Mapping Response To XML: " + e.getMessage());
            return defaultString;
        }
    }

    @Override
    public String requestToJson(request request) {
        String defaultString = "{}";
        try {
            ObjectMapper jsonMapper = new ObjectMapper();
            return jsonMapper.writerWithDefaultPrettyPrinter().writeValueAsString(request);
        } catch (Exception e) {
            log.error("Error Mapping Request To JSON: " + e.getMessage());
            return defaultString;
        }
    }

    @Override
    public String responseToJson(response res) {
        String defaultString = "{}";
        try {
            ObjectMapper jsonMapper = new ObjectMapper();
            return jsonMapper.writerWithDefaultPrettyPrinter().writeValueAsString(res);
        } catch (Exception e) {
            log.error("Error Mapping Response To JSON: " + e.getMessage());
            return defaultString;
        }
    }
}
