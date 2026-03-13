package com.equitybank.gag.dummy_telco_b2c_ms.service.impl;

import com.equitybank.gag.dummy_telco_b2c_ms.service.MtnPayloadService;
import org.springframework.stereotype.Service;

@Service
public class MtnPayloadServiceImpl implements MtnPayloadService {
    @Override
    public String floatNamecheckSuccessResponse() {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<ns0:getaccountholderinforesponse\n" +
                "    xmlns:ns0=\"http://www.ericsson.com/cm/emm/provisioning/v2_1\">\n" +
                "    <accountholderbasicinfo>\n" +
                "        <firstname>NAMtest</firstname>\n" +
                "        <surname>testing</surname>\n" +
                "        <profilename>MTNZA LITE KYC ACCOUNT</profilename>\n" +
                "        <identityvalues>\n" +
                "            <identityvalue>ID:27700000003/MSISDN</identityvalue>\n" +
                "            <identityvalue>ID:11340008/ID</identityvalue>\n" +
                "        </identityvalues>\n" +
                "        <defaultfris>\n" +
                "            <defaultfri>\n" +
                "                <fri>FRI:8520011/MM</fri>\n" +
                "                <currency>\n" +
                "                    <code>ZAR</code>\n" +
                "                </currency>\n" +
                "            </defaultfri>\n" +
                "        </defaultfris>\n" +
                "        <acceptedte />\n" +
                "        <accountholderstatus>ACTIVE</accountholderstatus>\n" +
                "        <bankdomainname>MTNZA</bankdomainname>\n" +
                "        <hasparent>false</hasparent>\n" +
                "    </accountholderbasicinfo>\n" +
                "    <credentialslist/>\n" +
                "    <offinet>false</offinet>\n" +
                "</ns0:getaccountholderinforesponse>";
    }

    @Override
    public String floatNamecheckInactiveStatusFailureResponse() {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<ns0:getaccountholderinforesponse\n" +
                "    xmlns:ns0=\"http://www.ericsson.com/cm/emm/provisioning/v2_1\">\n" +
                "    <accountholderbasicinfo>\n" +
                "        <firstname>NAMtest</firstname>\n" +
                "        <surname>testing</surname>\n" +
                "        <profilename>MTNZA LITE KYC ACCOUNT</profilename>\n" +
                "        <identityvalues>\n" +
                "            <identityvalue>ID:27700000003/MSISDN</identityvalue>\n" +
                "            <identityvalue>ID:11340008/ID</identityvalue>\n" +
                "        </identityvalues>\n" +
                "        <defaultfris>\n" +
                "            <defaultfri>\n" +
                "                <fri>FRI:8520011/MM</fri>\n" +
                "                <currency>\n" +
                "                    <code>ZAR</code>\n" +
                "                </currency>\n" +
                "            </defaultfri>\n" +
                "        </defaultfris>\n" +
                "        <acceptedte />\n" +
                "        <accountholderstatus>INACTIVE</accountholderstatus>\n" +
                "        <bankdomainname>MTNZA</bankdomainname>\n" +
                "        <hasparent>false</hasparent>\n" +
                "    </accountholderbasicinfo>\n" +
                "    <credentialslist/>\n" +
                "    <offinet>false</offinet>\n" +
                "</ns0:getaccountholderinforesponse>";
    }

    @Override
    public String floatPurchaseSuccessResponse() {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<ns4:depositresponse\n" +
                "    xmlns:ns4=\"http://www.ericsson.com/em/emm/settlement/v1_0\"\n" +
                "    xmlns:s4=\"http://www.ericsson.com/em/emm/settlement/v1_0\"\n" +
                "    xmlns:op=\"http://www.ericsson.com/em/emm/v1_0/common\"\n" +
                "    xmlns:xs=\"http://www.w3.org/2001/XMLSchema\">\n" +
                "    <status>SUCCESS</status>\n" +
                "    <financialtransactionid>226923</financialtransactionid>\n" +
                "    <failurereason>failurereason</failurereason>\n" +
                "</ns4:depositresponse>";
    }

    @Override
    public String floatPurchaseStatusSuccessResponse() {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<ns2:gettransactionstatusresponse\n" +
                "    xmlns:ns2=\"http://www.ericsson.com/em/emm/financial/v1_2\">\n" +
                "    <financialtransactionid>12345</financialtransactionid>\n" +
                "    <status>SUCCESSFUL</status>\n" +
                "    <providertransactionid>providertransactionid</providertransactionid>\n" +
                "</ns2:gettransactionstatusresponse>";
    }

    @Override
    public String mtnGenericFailureResponse1() {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<ns0:errorResponse\n" +
                "    xmlns:ns0=\"http://www.ericsson.com/lwac\" errorcode=\"ACCOUNTHOLDER_NOT_FOUND\">\n" +
                "    <arguments name=\"id\" value=\"27700000003\" />\n" +
                "</ns0:errorResponse>";
    }

    @Override
    public String mtnGenericFailureResponse2() {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<ns0:errorResponse\n" +
                "    xmlns:ns0=\"http://www.ericsson.com/lwac\" errorcode=\"COMMUNICATION_ERROR\"/>";
    }

    @Override
    public String mtnGenericFailureResponse3() {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<ns2:errorResponse\n" +
                "    xmlns:ns2=\"http://www.ericsson.com/lwac\" errorcode=\"TRANSACTION_TIMED_OUT\"/>";
    }
}
