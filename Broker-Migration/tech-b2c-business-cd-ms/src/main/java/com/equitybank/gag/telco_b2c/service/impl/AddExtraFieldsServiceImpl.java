package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.service.AddExtraFieldsService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.*;

@Service
public class AddExtraFieldsServiceImpl implements AddExtraFieldsService {
    private static final Logger log = LoggerFactory.getLogger(AddExtraFieldsServiceImpl.class);

    @Override
    public String addMoneygramExtraFields(String requestXml, String tagName) {
        String nameSpace = " xmlns=\"http://www.moneygram.com/AgentConnect1512\"";

        // Edge case
        if (tagName == null || tagName.isBlank()) {
            return requestXml;
        }

        // Get timestamp in Nairobi time
        String timeStamp = getCurrentTimestamp();

        // Moneygram static extra fields
        String moneygramExtraFields = """
                    <unitProfileID>%s</unitProfileID>
                    <agentID>%s</agentID>
                    <agentSequence>%s</agentSequence>
                    <token>%s</token>
                    <timeStamp>%s</timeStamp>
                    <apiVersion>%s</apiVersion>
                    <clientSoftwareVersion>%s</clientSoftwareVersion>
                    <channelType>%s</channelType>
                """.formatted(UNIT_PROFILE_ID, AGENT_ID, AGENT_SEQUENCE, TOKEN, timeStamp, API_VERSION, CLIENT_SOFTWARE_VERSION, CHANNEL_TYPE);

        // Find the tag and insert new fields
        return requestXml.contains("<" + tagName + nameSpace + ">")
                ? requestXml.replace("<" + tagName + nameSpace + ">", "<" + tagName + nameSpace + ">" + "\n" + moneygramExtraFields)
                : requestXml.replace("<" + tagName + ">", "<" + tagName + ">\n" + moneygramExtraFields);
    }

    private String getCurrentTimestamp() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSXXX");
        ZonedDateTime now = ZonedDateTime.now(ZoneId.of("Africa/Nairobi")); // Nairobi time zone (EAT)
        return now.format(formatter);
    }
}
