package com.equitybank.payments.imt.b2c.drcbroker.service.util;

import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class XMLToJsonConverter {
    private static final Logger log = LoggerFactory.getLogger(XMLToJsonConverter.class);

    public String convertXMLToJson(String xmlString, ErrorStatus errorStatus) {
        String dummyRrn = "1";
        //Convert XML to JSON - Tree Traversal
        String convertedJsonString;
        try {
            XmlMapper xmlMapper = new XmlMapper();
            JsonNode node = xmlMapper.readTree(xmlString.getBytes());
            ObjectMapper jsonMapper = new ObjectMapper();
            convertedJsonString = jsonMapper.writeValueAsString(node);
        } catch (Exception e) {
            errorStatus.setStatus("Failed");
            errorStatus.setStatusCode("800");
            errorStatus.setStatusDesc(" Internal Exception Occurred. Failed to Convert XML To Json");
            errorStatus.setStatusMessage(dummyRrn);
            errorStatus.setHttpStatusDesc("null");
            log.error(String.format("Exception Occurred in XMLToJsonConvertor.convertXMLToJson Method::: %s", e.getMessage()));
            return null;
        }
        log.info("Converted Json String::: " + convertedJsonString);
        return convertedJsonString;
    }
}
