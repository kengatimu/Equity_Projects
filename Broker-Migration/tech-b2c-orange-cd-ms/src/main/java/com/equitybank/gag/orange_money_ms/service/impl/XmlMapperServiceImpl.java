package com.equitybank.gag.orange_money_ms.service.impl;

import com.equitybank.gag.orange_money_ms.dto.channel.response.request;
import com.equitybank.gag.orange_money_ms.dto.channel.response.response;
import com.equitybank.gag.orange_money_ms.exception.CustomException;
import com.equitybank.gag.orange_money_ms.service.XmlMapperService;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import static com.equitybank.gag.orange_money_ms.config.StatusCodeMessages.DEFAULT_PROCESSING_FAILURE;

@Service
public class XmlMapperServiceImpl implements XmlMapperService {
    private static final Logger log = LoggerFactory.getLogger(XmlMapperServiceImpl.class);

    @Override
    public String mapChannelRequestObjectToXml(request request) {
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
    public String mapBusinessServiceFailureResponseObjToXml(response res) {
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
    public Map<String, String> readTelcoResponseXmlValues(String rrn, String responseString) throws CustomException {
        Map<String, String> responseMap = new HashMap<>();
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true);
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new java.io.ByteArrayInputStream(responseString.getBytes()));

            XPathFactory xPathFactory = XPathFactory.newInstance();
            XPath xpath = xPathFactory.newXPath();

            // XPath queries to retrieve values
            String responseCode = xpath.evaluate("//mmHeaderInfo/responseCode", doc);
            String responseMessage = xpath.evaluate("//mmHeaderInfo/responseMessage", doc);
            String cbaReferenceNo = xpath.evaluate("//return/CBAReferenceNo", doc);

            responseMap.put("responseCode", responseCode);
            responseMap.put("responseMessage", responseMessage);
            responseMap.put("CBAReferenceNo", cbaReferenceNo);
            responseMap.put("responseString", responseString);

            return responseMap;
        } catch (XPathExpressionException | ParserConfigurationException | IOException | SAXException e) {
            throw new CustomException(String.format("%sUnable to read XML values from the telco response xml string. %s", DEFAULT_PROCESSING_FAILURE, e.getMessage()));
        }
    }

    @Override
    public String mapBusinessServiceSuccessResponseObjToXml(response response) throws CustomException {
        try {
            XmlMapper xmlMapper = new XmlMapper();
            return xmlMapper.writerWithDefaultPrettyPrinter().writeValueAsString(response);
        } catch (Exception e) {
            throw new CustomException(String.format("%sUnable to generate XML string from the provided object. %s", DEFAULT_PROCESSING_FAILURE, e.getMessage()));
        }
    }
}
