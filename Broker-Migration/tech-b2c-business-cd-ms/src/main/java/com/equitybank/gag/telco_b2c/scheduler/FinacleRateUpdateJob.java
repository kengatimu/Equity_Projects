package com.equitybank.gag.telco_b2c.scheduler;

import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.DatabaseService;
import com.equitybank.gag.telco_b2c.service.HttpService;
import com.equitybank.gag.telco_b2c.service.PayloadService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.time.DayOfWeek;
import java.time.LocalDate;

@Service
public class FinacleRateUpdateJob {
    private static final Logger log = LoggerFactory.getLogger(FinacleRateUpdateJob.class);

    // Environment variables
    private final String finacleFIEndpoint;

    // Other variables
    private final DatabaseService databaseService;
    private final PayloadService payloadService;
    private final HttpService httpService;

    @Autowired
    public FinacleRateUpdateJob(@Value("${finacle.endpoints.fi}") String finacleFIEndpoint,
                                DatabaseService databaseService,
                                PayloadService payloadService,
                                HttpService httpService) {
        this.finacleFIEndpoint = finacleFIEndpoint;
        this.databaseService = databaseService;
        this.payloadService = payloadService;
        this.httpService = httpService;
    }

    @Scheduled(fixedDelay = 3600000, zone = "Africa/Nairobi") // 1-hour delay
    public void getAndUpdateFinacleRate() {
        log.info("Cron Job To Get USD/CDF Fx Rate Starting...");

        // Execute the job logic only on weekdays. Check if today is Monday through Friday
        DayOfWeek today = LocalDate.now().getDayOfWeek();
        if (today != DayOfWeek.SATURDAY && today != DayOfWeek.SUNDAY) {
            executeCroneJob();
        } else {
            log.info("Skipping job execution on weekend.");
        }
    }

    private void executeCroneJob() {
        try {
            // Prepare Finacle Get Rate FI XML string
            String finacleRequestXML = composeFinacleFIXML();

            // Call finacle and get response
            String finacleResponseXml = callFinacleAndGetResponse(finacleRequestXML, finacleFIEndpoint);

            // Process the response
            String rate = processFinacleResponse(finacleResponseXml);
            log.info("Received USD/CDF rate : " + rate);

            // Update database with the rate
            updateDatabase(rate);
        } catch (Exception e) {
            log.error(String.format("Error occurred on FinacleRateUpdateJob Class: %s", e.getMessage()));
        }
    }

    private String callFinacleAndGetResponse(String finacleRequestXML, String finacleFIEndpoint) throws CustomException {
        return httpService.finacleHttpCall(finacleRequestXML, finacleFIEndpoint);
    }

    private String composeFinacleFIXML() {
        return payloadService.composeFinacleGetRateXmlRequest();
    }

    private void updateDatabase(String rate) {
        databaseService.updateConfigRecord(rate);
    }

    private String processFinacleResponse(String finacleResponseXml) throws CustomException {
        try {
            Document doc = DocumentBuilderFactory.newInstance()
                    .newDocumentBuilder()
                    .parse(new ByteArrayInputStream(finacleResponseXml.getBytes()));

            XPath xPath = XPathFactory.newInstance().newXPath();

            // Fetching Status from HostTransaction
            // local-name() allows us to ignore namespaces in the XML.
            // This is useful if you don't want to specify the exact namespace URI.
            String status = xPath.evaluate(
                    "//*[local-name()='HostTransaction' or local-name()='hostTransaction' or local-name()='HOSTTRANSACTION' or local-name()='hosttransaction']" +
                            "/*[local-name()='Status' or local-name()='status' or local-name()='STATUS']", doc);
            log.info("Finacle status: " + status);

            // Throw error if status is not success
            processStatus(status.toUpperCase());

            // Fetching amountValue from outputAmount
            return xPath.evaluate(
                    "//*[local-name()='outputAmount' or local-name()='outputamount' or local-name()='OUTPUTAMOUNT' or local-name()='Outputamount']" +
                            "/*[local-name()='amountValue' or local-name()='amountvalue' or local-name()='AMOUNTVALUE' or local-name()='Amountvalue']", doc);

        } catch (XPathExpressionException
                 | IOException
                 | ParserConfigurationException
                 | SAXException
                 | CustomException e) {
            throw new CustomException(e.getMessage());
        }
    }

    private void processStatus(String status) throws CustomException {
        if (!"SUCCESS".equals(status)) {
            throw new CustomException("Finacle returned Failure response");
        }
    }
}