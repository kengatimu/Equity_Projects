package com.equitybank.gag.papss.ots.service.impl;

import com.equitybank.gag.papss.ots.exception.CustomException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.ByteArrayInputStream;
import java.math.BigDecimal;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.DEFAULT_RESPONSE_PROCESSING_FAILURE;

public class Test {
    private static final Logger log = LoggerFactory.getLogger(Test.class);

    private final Map<String, String> papssErrorMap;

    public Test(@Qualifier("papssErrorCodeMapping") Map<String, String> papssErrorMap) {
        this.papssErrorMap = papssErrorMap;
    }


    public static void main(String[] args) {
        String responseXml = "<FIXML xsi:schemaLocation=\"http://www.finacle.com/fixml getExchangeRateForRateCode.xsd\"\n" +
                "    xmlns=\"http://www.finacle.com/fixml\"\n" +
                "    xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\n" +
                "    <Header>\n" +
                "        <ResponseHeader>\n" +
                "            <RequestMessageKey>\n" +
                "                <RequestUUID>Req_17587062517951</RequestUUID>\n" +
                "                <ServiceRequestId>getExchangeRateForRateCode</ServiceRequestId>\n" +
                "                <ServiceRequestVersion>10.2</ServiceRequestVersion>\n" +
                "                <ChannelId>TPG</ChannelId>\n" +
                "            </RequestMessageKey>\n" +
                "            <ResponseMessageInfo>\n" +
                "                <BankId>54</BankId>\n" +
                "                <TimeZone>GMT+05:30</TimeZone>\n" +
                "                <MessageDateTime>2026-02-05T13:11:09.517</MessageDateTime>\n" +
                "            </ResponseMessageInfo>\n" +
                "            <UBUSTransaction>\n" +
                "                <Id/>\n" +
                "                <Status/>\n" +
                "            </UBUSTransaction>\n" +
                "            <HostTransaction>\n" +
                "                <Id/>\n" +
                "                <Status>SUCCESS</Status>\n" +
                "            </HostTransaction>\n" +
                "            <HostParentTransaction>\n" +
                "                <Id/>\n" +
                "                <Status/>\n" +
                "            </HostParentTransaction>\n" +
                "            <CustomInfo/>\n" +
                "        </ResponseHeader>\n" +
                "    </Header>\n" +
                "    <Body>\n" +
                "        <getExchangeRateForRateCodeResponse>\n" +
                "            <ExchangeRateForRateCodeOutputVO>\n" +
                "                <fxdCrncyCode>USD</fxdCrncyCode>\n" +
                "                <fxdCrncyUnits>1.0</fxdCrncyUnits>\n" +
                "                <isRateLatest>N</isRateLatest>\n" +
                "                <outputAmount>\n" +
                "                    <amountValue>125.5</amountValue>\n" +
                "                    <currencyCode>KES</currencyCode>\n" +
                "                </outputAmount>\n" +
                "                <varCrncyCode>KES</varCrncyCode>\n" +
                "                <varCrncyUnits>125.5</varCrncyUnits>\n" +
                "            </ExchangeRateForRateCodeOutputVO>\n" +
                "            <getExchangeRateForRateCode_CustomData>\n" +
                "                <THB>49</THB>\n" +
                "            </getExchangeRateForRateCode_CustomData>\n" +
                "        </getExchangeRateForRateCodeResponse>\n" +
                "    </Body>\n" +
                "</FIXML>";
        try {

            String input = "1234-5678";
            int len = input.length();
            System.out.println(input.substring(8, 4));
        } catch (Exception e) {
            log.error("Exception occurred: " + e.getMessage());
            e.printStackTrace(System.out);
        }
    }

    private static Document parseXml(String xml) throws Exception {

        // Namespace awareness is mandatory for Finacle FIXML
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);

        return factory.newDocumentBuilder().parse(new ByteArrayInputStream(xml.getBytes(StandardCharsets.UTF_8)));
    }

    private String extractFirstTagValue(Document doc, String tagName) {

        // Namespace-agnostic lookup
        NodeList nodes = doc.getElementsByTagNameNS("*", tagName);

        if (nodes != null && nodes.getLength() > 0) {
            String value = nodes.item(0).getTextContent();
            return value != null ? value.trim() : null;
        }

        return null;
    }

}