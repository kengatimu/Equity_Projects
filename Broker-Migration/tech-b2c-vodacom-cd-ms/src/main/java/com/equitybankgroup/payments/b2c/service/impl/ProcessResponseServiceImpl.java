package com.equitybankgroup.payments.b2c.service.impl;

import com.equitybankgroup.payments.b2c.dto.vodacom.namecheck.response.AgentResultData;
import com.equitybankgroup.payments.b2c.dto.vodacom.namecheck.response.CustomerResultData;
import com.equitybankgroup.payments.b2c.dto.vodacom.namecheck.response.ResponseData;
import com.equitybankgroup.payments.b2c.error.CustomException;
import com.equitybankgroup.payments.b2c.service.ProcessResponseService;
import com.equitybankgroup.payments.b2c.service.util.ExtractCustomerDetails;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.logging.Level;

@Service
public class ProcessResponseServiceImpl<T> implements ProcessResponseService<T> {

    private static final Logger log = LoggerFactory.getLogger(ProcessResponseServiceImpl.class);
    private static final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public String generateXmlResponse(String responseData, String nameCheckXmlRequest, Map<String, String> xmlMapValues) throws CustomException {
        String customerNames;

        // Validate that responseData is not null
        if (responseData == null) {
            throw new CustomException("ERROR. ResponseData is missing.");
        }

        CustomerResultData resultData;
        AgentResultData agentResultData;
        String resultCode;
        String tillNumber = xmlMapValues.get("tillNumber");
        try {
            if (tillNumber != null && !tillNumber.isEmpty()) {
                agentResultData = ExtractCustomerDetails.extractOrganizationResultData(responseData);
                // Validate that resultCode is zero
                resultCode = agentResultData.getResultCode();
                if (!"0".equals(resultCode)) {
                    throw new CustomException("ERROR. Telco Returned Failure Result Code: Telco Result Code: " + resultCode);
                }

                customerNames = agentResultData.getCompanyName();
                log.info("Extracted customerNames: {}", customerNames);

                if (customerNames == null || customerNames.isEmpty()) {
                    throw new CustomException("ERROR. Merchant Name Is Empty or Null");
                }

            } else {
                resultData = ExtractCustomerDetails.extractCustomerResultData(responseData);
                resultCode = resultData.getResultCode();
                customerNames = String.format("%s %s %s",
                        resultData.getFirstName() != null ? resultData.getFirstName() : "",
                        resultData.getMiddleName() != null ? resultData.getMiddleName() : "",
                        resultData.getLastName() != null ? resultData.getLastName() : "");
                log.info("Extracted customerNames: {}", customerNames);
                if (customerNames == null || customerNames.isEmpty()) {
                    throw new CustomException("ERROR. Customer Name Is Empty or Null");
                }

            }
        } catch (JsonProcessingException ex) {
            ex.printStackTrace(System.out);
            throw new CustomException(ex.getMessage());
        }

        // Validate that resultCode is zero
        if (!"0".equals(resultCode)) {
            throw new CustomException("ERROR. Telco Returned Failure Result Code: Telco Result Code: " + resultCode);
        }

        // Check if 'tillNumber' exists in the request and is not empty
        if (tillNumber != null && !tillNumber.isEmpty()) {

        } else {

        }

        // Return the XML response with populated customerNames
        return "<MobileNumberInquireRes xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
                + "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">"
                + "<msgId>" + xmlMapValues.get("msgId") + "</msgId>"
                + "<channel>" + xmlMapValues.get("channel") + "</channel>"
                + "<telcom>" + xmlMapValues.get("telcom") + "</telcom>"
                + "<mobileNumber>" + xmlMapValues.get("mobileNumber") + "</mobileNumber>"
                + "<responseCode>00</responseCode>"
                + "<customerNames>" + customerNames + "</customerNames>"
                + "</MobileNumberInquireRes>";

    }

    /**
     * Helper method to convert a LinkedHashMap to a specific object type.
     *
     * @param data The data to convert (e.g., LinkedHashMap).
     * @param clazz The target class (e.g., AgentResultData.class).
     * @return The converted object.
     */
    private <T> T convertToObject(Object data, Class<T> clazz) {
        return objectMapper.convertValue(data, clazz);
    }
}
