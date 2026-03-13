package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.dto.thunes.response.ChannelResponse;
import com.equitybank.gag.telco_b2c.service.JsonKeyNormalizerService;
import com.equitybank.gag.telco_b2c.service.ThunesChannelResponseWrapperService;
import com.google.gson.Gson;

public class Test {

    public static void main(String[] args) {

        String thunesString = "{\n" +
                "    \"id\": 1,\n" +
                "    \"external_id\": \"1481184321405\",\n" +
                "    \"payer\": {\n" +
                "        \"id\": 1,\n" +
                "        \"name\": \"Sample Payer\",\n" +
                "        \"currency\": \"USD\",\n" +
                "        \"country_iso_code\": \"ZWE\",\n" +
                "        \"service\": {\n" +
                "            \"id\": 1,\n" +
                "            \"name\": \"MobileWallet\"\n" +
                "        }\n" +
                "    },\n" +
                "    \"mode\": \"SOURCE_AMOUNT\",\n" +
                "    \"transaction_type\": \"C2C\",\n" +
                "    \"source\": {\n" +
                "        \"country_iso_code\": \"FRA\",\n" +
                "        \"currency\": \"EUR\",\n" +
                "        \"amount\": 10\n" +
                "    },\n" +
                "    \"destination\": {\n" +
                "        \"currency\": \"USD\",\n" +
                "        \"amount\": 10.69\n" +
                "    },\n" +
                "    \"sent_amount\": {\n" +
                "        \"currency\": \"EUR\",\n" +
                "        \"amount\": 10\n" +
                "    },\n" +
                "    \"wholesale_fx_rate\": 1.06891969534071,\n" +
                "    \"fee\": {\n" +
                "        \"currency\": \"EUR\",\n" +
                "        \"amount\": 1.88\n" +
                "    },\n" +
                "    \"creation_date\": \"2016-11-02T09:07:44\",\n" +
                "    \"expiration_date\": \"2016-11-03T09:07:44\"\n" +
                "}";

        // instantiate the service directly (no Spring context)
        JsonKeyNormalizerService jsonKeyNormalizerService = new JsonKeyNormalizerServiceImpl();

        ThunesChannelResponseWrapperService service = new ThunesChannelResponseWrapperServiceImpl(jsonKeyNormalizerService);

        // call and print the result
        ChannelResponse response = service.wrapImtResponse(thunesString);
        System.out.println(new Gson().toJson(response));
    }
}
