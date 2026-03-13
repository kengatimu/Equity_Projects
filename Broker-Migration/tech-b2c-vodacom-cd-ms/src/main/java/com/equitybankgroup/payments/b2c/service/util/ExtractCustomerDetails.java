/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.service.util;

/**
 *
 * @author ronaldcheruiyot
 */
import com.equitybankgroup.payments.b2c.dto.vodacom.namecheck.response.AgentResultData;
import com.equitybankgroup.payments.b2c.dto.vodacom.namecheck.response.CustomerResultData;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

public class ExtractCustomerDetails {
    
    public static CustomerResultData extractCustomerResultData(String json) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(json);
        JsonNode resultData = root.get("ResultData");
        String resultCode = root.get("ResultCode").asText();
        String firstName = resultData.get("First Name").asText();
        String lastName = resultData.get("Last Name").asText();
        String gender = resultData.get("Gender").asText();
        String address = resultData.get("Address street").asText() + ", " +
                         resultData.get("Address town").asText() + ", " +
                         resultData.get("Address commune").asText();

        System.out.println("Customer Name: " + firstName + " " + lastName);
        System.out.println("Gender: " + gender);
        System.out.println("Address: " + address);
        String[] names = firstName.split(" ");
        CustomerResultData customerResultData = new CustomerResultData();
        customerResultData.setResultCode(resultCode);
        customerResultData.setFirstName(names[0]);
        customerResultData.setLastName(lastName);
        
        customerResultData.setMiddleName((names.length > 1) ? names[1] : "");
        return customerResultData;
    }
    
    public static AgentResultData extractOrganizationResultData(String json) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();
        JsonNode root = mapper.readTree(json);
        JsonNode resultData = root.get("ResultData");
        String resultCode = root.get("ResultCode").asText();
        String companyName = resultData.get("Company Name").asText();

        System.out.println("Customer Name: " + companyName);
        AgentResultData agentResultData = new AgentResultData();
        agentResultData.setCompanyName(companyName);
        agentResultData.setResultCode(resultCode);
        return agentResultData;
    }
    
    public static void main(String[] args) throws Exception {
        String json = "{ \"ResultCode\": \"0\", \"ResultDesc\": \"Process service request successfully.\", \"OriginatorConversationID\": \"000000131634\", \"ConversationID\": \"JychXI0DkgLdSkZH7D9v8ze3J24HmD4i\", \"ResultData\": { \"Kind of premium subscriber\": \"\", \"Place of birth\": \"[[KYC][Personnal upgraded info][Place of birth]]\", \"ICAPID\": \"655767868787778\", \"Email address\": \"\", \"Nationality\": \"[[KYC][Personnal upgraded info][Nationality]]\", \"Gender\": \"0\", \"Address commune\": \"GOMBE\", \"Address province\": \"\", \"Id Card Recevied\": \"0\", \"First Name\": \"TEST CUSTOMER\", \"Middle Name\": \"[[KYC][Personnal upgraded info][Middle Name]]\", \"Last Name\": \"GATIMU\", \"Date of Birth\": \"556577676\", \"Address street\": \"19 KALEMIE, GARE\", \"Address town\": \"kinshasa\" }, \"audit\": { \"start_time\": \"20250722101529\", \"completed_time\": \"20250722101530\", \"original_time\": \"20250721182249\" } }";
        CustomerResultData result = extractCustomerResultData(json);
        System.out.println((new Gson()).toJson(result));
        
    }
    
    String json = "{\n" +
"    \"ResultCode\": \"-100\",\n" +
"    \"ResultDesc\": \"Pending\",\n" +
"    \"OriginatorConversationID\": \"337922252414\",\n" +
"    \"ConversationID\": \"MTrQ4wq4oxLDtK4uBHwprlmgyOSlVaix\",\n" +
"    \"ResultData\": {\n" +
"        \"Bank account\": \"[[KYC][Organization Details][Bank account]]\",\n" +
"        \"Kind of Agents\": \"[[KYC][Organization Details][Kind of Agents]]\",\n" +
"        \"Agent Province\": \"[[KYC][Organization Details][Agent Province]]\",\n" +
"        \"Agent Type\": \"[[KYC][Organization Details][Agent Type]]\",\n" +
"        \"Settlement Number\": \"[[KYC][Organization Details][Settlement Number]]\",\n" +
"        \"Vat Registered\": \"[[KYC][Organization Details][Vat Registered]]\",\n" +
"        \"Vat Number\": \"[[KYC][Organization Details][Vat Number]]\",\n" +
"        \"Vodashop Name\": \"[[KYC][Organization Details][Vodashop Name]]\",\n" +
"        \"Location\": \"[[KYC][Organization Details][Location]]\",\n" +
"        \"Vodashop Unique ID\": \"[[KYC][Organization Details][Vodashop Unique ID]]\",\n" +
"        \"Organisation Category Code\": \"[[KYC][Organization Details][Organisation Category Code]]\",\n" +
"        \"Company Registration Number/RCCM\": \"[[KYC][Organization Details][Company Registration Number/RCCM]]\",\n" +
"        \"Company Name\": \"[[KYC][Organization Details][Company Name]]\",\n" +
"        \"Notification Receiving E-mail\": \"[[KYC][Contact Details][Notification Receiving E-mail]]\",\n" +
"        \"Notification Receiving MSISDN\": \"[[KYC][Contact Details][Notification Receiving MSISDN]]\",\n" +
"        \"Preferred Notification Channel\": \"[[KYC][Contact Details][Preferred Notification Channel]]\",\n" +
"        \"Has Bank Account\": \"[[KYC][Has Bank Account][Has Bank Account]]\"\n" +
"    },\n" +
"    \"audit\": {\n" +
"        \"start_time\": \"20250722181043\",\n" +
"        \"completed_time\": \"20250722181044\",\n" +
"        \"original_time\": \"20250722201038\"\n" +
"    }\n" +
"}";
}

