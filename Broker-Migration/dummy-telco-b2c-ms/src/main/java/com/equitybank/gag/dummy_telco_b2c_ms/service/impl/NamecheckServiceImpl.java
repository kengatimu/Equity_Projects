package com.equitybank.gag.dummy_telco_b2c_ms.service.impl;

import com.equitybank.gag.dummy_telco_b2c_ms.dto.namecheck.vodacom.request.TransactionData;
import com.equitybank.gag.dummy_telco_b2c_ms.dto.namecheck.vodacom.response.AgentResultData;
import com.equitybank.gag.dummy_telco_b2c_ms.dto.namecheck.vodacom.response.Audit;
import com.equitybank.gag.dummy_telco_b2c_ms.dto.namecheck.vodacom.response.CustomerResultData;
import com.equitybank.gag.dummy_telco_b2c_ms.dto.namecheck.vodacom.response.ResponseData;
import com.equitybank.gag.dummy_telco_b2c_ms.service.NamecheckService;
import com.google.gson.Gson;
import org.springframework.stereotype.Service;

@Service
public class NamecheckServiceImpl<T> implements NamecheckService<T> {

    @Override
    public ResponseData<T> processNamecheckRequest(TransactionData transactionData) {
        ResponseData<T> responseData = new ResponseData<>();

        // Set common fields
        responseData.setResultCode("0");
        responseData.setResultDesc("Process service request successfully.");
        responseData.setOriginatorConversationID(transactionData.getOriginatorConversationID());
        responseData.setConversationID("L3W3xfB3P9LJnXQoj3fOeLfvUK8JAHfq");

        // Determine the type of ResultData based on IdentifierType
        if (transactionData.getIdentities() != null && !transactionData.getIdentities().isEmpty()) {
            String identifierType = transactionData.getIdentities().get(0).getIdentifierType();

            if ("MSISDN".equals(identifierType)) {
                // Handle CustomerResultData
                CustomerResultData customerResultData = new CustomerResultData();
                customerResultData.setKindOfPremiumSubscriber("");
                customerResultData.setPlaceOfBirth("test");
                customerResultData.setICAPID("12651666");
                customerResultData.setEmailAddress("");
                customerResultData.setNationality("51");
                customerResultData.setGender("0");
                customerResultData.setAddressCommune("test");
                customerResultData.setPicture("");
                customerResultData.setAddressProvince("test");
                customerResultData.setOptionalQuestion("0");
                customerResultData.setCustomerPromotion("");
                customerResultData.setVendorId("");
                customerResultData.setPicture2("");
                customerResultData.setIdCardRecevied("0");
                customerResultData.setEstatement("");
                customerResultData.setFirstName("christian");
                customerResultData.setMiddleName("christian");
                customerResultData.setLastName("christian");
                customerResultData.setBascongoPromotion("");
                customerResultData.setDateOfBirth("19890410");
                customerResultData.setAddressStreet("test");
                customerResultData.setRelationship("");
                customerResultData.setAddressTown("test");
                customerResultData.setAnswerOptionalQuestion("");

                responseData.setResultData((T) customerResultData);
            } else {
                // Handle AgentResultData
                AgentResultData agentResultData = new AgentResultData();
                agentResultData.setBankAccount("");
                agentResultData.setKindOfAgents("");
                agentResultData.setAgentProvince("");
                agentResultData.setAgentType("MERCHANT");
                agentResultData.setSettlementNumber("");
                agentResultData.setVatRegistered("");
                agentResultData.setVatNumber("125478");
                agentResultData.setVodashopName("");
                agentResultData.setLocation("");
                agentResultData.setVodashopUniqueID("");
                agentResultData.setOrganisationCategoryCode("");
                agentResultData.setCompanyRegistrationNumberRCCM("");
                agentResultData.setCompanyName("XYZ Limited");
//                agentResultData.setCompanyName("");
                agentResultData.setNotificationReceivingEmail("");
                agentResultData.setNotificationReceivingMSISDN("");
                agentResultData.setPreferredNotificationChannel("");
                agentResultData.setHasBankAccount("");

                responseData.setResultData((T) agentResultData);
            }
        }

        // Set audit data
        Audit audit = new Audit();
        audit.setStartTime("20221107070831");
        audit.setCompletedTime("20221107070832");
        audit.setOriginalTime("20221107070818");
        responseData.setAudit(audit);

        System.out.println("Returned Response: " + new Gson().toJson(responseData));
        return responseData;
    }
}