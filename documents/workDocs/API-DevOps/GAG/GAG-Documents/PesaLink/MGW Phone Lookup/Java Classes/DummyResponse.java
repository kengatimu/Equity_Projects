package com.equitybank.payments.interbank.outbound.service.utils;

import org.springframework.stereotype.Service;

@Service
public class DummyResponse {

    public String getXmlResponse(String type) {

        if (type.equalsIgnoreCase("single")) {
            return "<soap:Envelope\n" +
                "    xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
                "    <soap:Body>\n" +
                "        <ns2:getCustomerBankListResponse\n" +
                "            xmlns:ns2=\"http://ws.lookupdb.mgw.cwt.ru/\">\n" +
                "            <return>\n" +
                "                <destName>WANGUI,. DANIEL GITAHI</destName>\n" +
                "                <bankList>\n" +
                "                    <bank>\n" +
                "                        <bankName>KWFT BANK</bankName>\n" +
                "                        <def>true</def>\n" +
                "                        <lookupBankName>WANGUI,. DANIEL GITAHI</lookupBankName>\n" +
                "                        <sortCode>40478000</sortCode>\n" +
                "                    </bank>\n" +
                "                </bankList>\n" +
                "            </return>\n" +
                "        </ns2:getCustomerBankListResponse>\n" +
                "    </soap:Body>\n" +
                "</soap:Envelope>";
        } else if (type.equalsIgnoreCase("multiple")) {
            return "<soap:Envelope\n" +
                "    xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
                "    <soap:Body>\n" +
                "        <ns2:getCustomerBankListResponse\n" +
                "            xmlns:ns2=\"http://ws.lookupdb.mgw.cwt.ru/\">\n" +
                "            <return>\n" +
                "                <destName>Mr. GTS1 Kamels1 Testing1</destName>\n" +
                "                <bankList>\n" +
                "                    <bank>\n" +
                "                        <bankName>Equity Bank</bankName>\n" +
                "                        <def>true</def>\n" +
                "                        <lookupBankName>Mr. Equity Kamels1</lookupBankName>\n" +
                "                        <sortCode>40466000</sortCode>\n" +
                "                    </bank>\n" +
                "                    <bank>\n" +
                "                        <bankName>Absa Bank Kenya</bankName>\n" +
                "                        <def>false</def>\n" +
                "                        <lookupBankName>Mr. Absa Kamels1</lookupBankName>\n" +
                "                        <sortCode>40403000</sortCode>\n" +
                "                    </bank>\n" +
                "                    <bank>\n" +
                "                        <bankName>SIDIAN</bankName>\n" +
                "                        <def>false</def>\n" +
                "                        <lookupBankName>Mr. Sidian Kamels1</lookupBankName>\n" +
                "                        <sortCode>40404000</sortCode>\n" +
                "                    </bank>\n" +
                "                </bankList>\n" +
                "            </return>\n" +
                "        </ns2:getCustomerBankListResponse>\n" +
                "    </soap:Body>\n" +
                "</soap:Envelope>";
        } else if (type.equalsIgnoreCase("userNotFound")) {
            return "<soap:Envelope\n" +
                "    xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
                "    <soap:Body>\n" +
                "        <soap:Fault>\n" +
                "            <faultcode>soap:Server</faultcode>\n" +
                "            <faultstring>Fault occurred while processing.</faultstring>\n" +
                "            <detail>\n" +
                "                <ns1:LookupDbFault\n" +
                "                    xmlns:ns1=\"http://ws.lookupdb.mgw.cwt.ru/\">\n" +
                "                    <faultCode\n" +
                "                        xmlns:ns2=\"http://ws.lookupdb.mgw.cwt.ru/\">407\n" +
                "                    </faultCode>\n" +
                "                    <faultFactor\n" +
                "                        xmlns:ns2=\"http://ws.lookupdb.mgw.cwt.ru/\">USER\n" +
                "                    </faultFactor>\n" +
                "                    <faultString\n" +
                "                        xmlns:ns2=\"http://ws.lookupdb.mgw.cwt.ru/\">Object not found\n" +
                "                    </faultString>\n" +
                "                    <detail\n" +
                "                        xmlns:ns2=\"http://ws.lookupdb.mgw.cwt.ru/\">\n" +
                "                    </detail>\n" +
                "                </ns1:LookupDbFault>\n" +
                "            </detail>\n" +
                "        </soap:Fault>\n" +
                "    </soap:Body>\n" +
                "</soap:Envelope>";
        }
        return "<soap:Envelope\n" +
            "    xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
            "    <soap:Body>\n" +
            "        <soap:Fault>\n" +
            "            <faultcode>soap:Server</faultcode>\n" +
            "            <faultstring>Fault occurred while processing.</faultstring>\n" +
            "            <detail>\n" +
            "                <ns1:LookupDbFault\n" +
            "                    xmlns:ns1=\"http://ws.lookupdb.mgw.cwt.ru/\">\n" +
            "                    <faultCode\n" +
            "                        xmlns:ns2=\"http://ws.lookupdb.mgw.cwt.ru/\">405\n" +
            "                    </faultCode>\n" +
            "                    <faultFactor\n" +
            "                        xmlns:ns2=\"http://ws.lookupdb.mgw.cwt.ru/\">OnlineRequest\n" +
            "                    </faultFactor>\n" +
            "                    <faultString\n" +
            "                        xmlns:ns2=\"http://ws.lookupdb.mgw.cwt.ru/\">Authorisation fail\n" +
            "                    </faultString>\n" +
            "                    <detail\n" +
            "                        xmlns:ns2=\"http://ws.lookupdb.mgw.cwt.ru/\">\n" +
            "                    </detail>\n" +
            "                </ns1:LookupDbFault>\n" +
            "            </detail>\n" +
            "        </soap:Fault>\n" +
            "    </soap:Body>\n" +
            "</soap:Envelope>";
    }
}
