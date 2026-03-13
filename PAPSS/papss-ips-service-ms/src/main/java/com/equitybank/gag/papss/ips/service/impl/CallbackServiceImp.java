package com.equitybank.gag.papss.ips.service.impl;

import com.equitybank.gag.papss.ips.service.CallbackService;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.ByteArrayInputStream;
import java.io.IOException;

@Service
public class CallbackServiceImp implements CallbackService {
    private static final Logger log = LoggerFactory.getLogger(CallbackServiceImp.class);
    private static final String CALLBACKURL = "https://localhost:10443/api/v1/outbound/credit-transfer/callback";
    public static final String HTTP_RESPONSE_LOG_TEMPLATE = "HTTP Response: \n STATUS CODE: %s\n STATUS MESSAGE: %s\n RESPONSE BODY STRING: %s\n";

    private final CloseableHttpClient closeableHttpClient;

    @Autowired
    public CallbackServiceImp(@Qualifier("closeableHttpClient") CloseableHttpClient closeableHttpClient) {
        this.closeableHttpClient = closeableHttpClient;
    }

    @Override
    public void sendCallback(String state, String creditTransferXmlRequest) throws ParserConfigurationException, IOException, SAXException {
        String responseXml = "Final-Success".equals(state) ? getSuccessfulResponse(creditTransferXmlRequest) : getFailureResponse(creditTransferXmlRequest);

        CloseableHttpResponse response = null;
        try {
            HttpPost httpPost = getPostRequestHeaders(CALLBACKURL, new StringEntity(responseXml));
            log.info("Sending Callback Post HTTP Request to Equity Via: {}", CALLBACKURL);
            response = closeableHttpClient.execute(httpPost);

            HttpEntity entity = response.getEntity();
            int statusCode = response.getStatusLine().getStatusCode();
            String httpStatusMsg = response.getStatusLine().getReasonPhrase();

//            if (entity == null || entity.getContentLength() == 0 || statusCode == 0) {
//                log.error("Timeout Occurred When Sending Callback To Equity Bank");
//                return;
//            }

            String channelResponseString = EntityUtils.toString(entity);
            log.info(String.format(HTTP_RESPONSE_LOG_TEMPLATE, statusCode, httpStatusMsg, channelResponseString));

        } catch (IOException e) {
            log.error("Exception Occurred When Sending The Callback To Equity Bank: {}", e.getMessage());

            String errorDescription = e.getMessage();
            if (errorDescription != null && (
                    errorDescription.contains("timeout")
                            || errorDescription.contains("time out")
                            || errorDescription.contains("timed out"))) {
                log.error("Timeout Occurred When Sending Callback To Equity Bank");
            }
            log.error("Timeout Occurred When Sending Callback To Equity Bank");
        } finally {
            closeQuietly(response);
        }
    }

    private HttpPost getPostRequestHeaders(String url, StringEntity stringEntity) {
        HttpPost httpPost = new HttpPost(url);
        httpPost.setEntity(stringEntity);
        httpPost.setHeader("Content-Type", MediaType.APPLICATION_XML_VALUE);
        return httpPost;
    }

    private void closeQuietly(CloseableHttpResponse response) {
        if (response != null) {
            try {
                response.close();
            } catch (IOException e) {
                log.error("Failed to close CloseableHttpResponse: {}", e.getMessage());
            }
        }
    }

    private String getSuccessfulResponse(String creditTransferXmlRequest) throws ParserConfigurationException, IOException, SAXException {
        String rrn = rrnExtract(creditTransferXmlRequest);
        return "<hdr:Message xmlns:hdr=\"urn:montran:message.01\">\n" +
                "    <hdr:AppHdr xmlns=\"urn:iso:std:iso:20022:tech:xsd:head.001.001.01\">\n" +
                "        <Fr>\n" +
                "            <FIId>\n" +
                "                <FinInstnId>\n" +
                "                    <ClrSysMmbId>\n" +
                "                        <ClrSysId>\n" +
                "                            <Prtry>PAPSS</Prtry>\n" +
                "                        </ClrSysId>\n" +
                "                        <MmbId>GM1015</MmbId>\n" +
                "                    </ClrSysMmbId>\n" +
                "                </FinInstnId>\n" +
                "            </FIId>\n" +
                "        </Fr>\n" +
                "        <To>\n" +
                "            <FIId>\n" +
                "                <FinInstnId>\n" +
                "                    <BICFI>EQBLKENA</BICFI>\n" +
                "                    <ClrSysMmbId>\n" +
                "                        <ClrSysId>\n" +
                "                            <Prtry>PAPSS</Prtry>\n" +
                "                        </ClrSysId>\n" +
                "                        <MmbId>KE1005</MmbId>\n" +
                "                    </ClrSysMmbId>\n" +
                "                </FinInstnId>\n" +
                "            </FIId>\n" +
                "        </To>\n" +
                "        <BizMsgIdr>" + rrn + "</BizMsgIdr>\n" +
                "        <MsgDefIdr>pacs.002.001.07</MsgDefIdr>\n" +
                "        <CreDt>2025-04-11T15:50:15Z</CreDt>\n" +
                "    </hdr:AppHdr>\n" +
                "\n" +
                "    <hdr:FIToFIPmtStsRpt xmlns=\"urn:iso:std:iso:20022:tech:xsd:pacs.002.001.07\">\n" +
                "        <GrpHdr>\n" +
                "            <MsgId>" + rrn + "</MsgId>\n" +
                "            <CreDtTm>2025-04-11T15:50:15Z</CreDtTm>\n" +
                "            <InstdAgt>\n" +
                "                <FinInstnId>\n" +
                "                    <ClrSysMmbId>\n" +
                "                        <MmbId>KE1005</MmbId>\n" +
                "                    </ClrSysMmbId>\n" +
                "                </FinInstnId>\n" +
                "            </InstdAgt>\n" +
                "        </GrpHdr>\n" +
                "\n" +
                "        <OrgnlGrpInfAndSts>\n" +
                "            <OrgnlMsgId>" + rrn + "</OrgnlMsgId>\n" +
                "            <OrgnlMsgNmId>pacs.008.001.07</OrgnlMsgNmId>\n" +
                "            <GrpSts>ACSC</GrpSts>\n" +
                "        </OrgnlGrpInfAndSts>\n" +
                "\n" +
                "        <TxInfAndSts>\n" +
                "            <StsId>" + rrn + "</StsId>\n" +
                "            <OrgnlInstrId>" + rrn + "</OrgnlInstrId>\n" +
                "            <OrgnlEndToEndId>KE1005GM101520250411164907111996657013</OrgnlEndToEndId>\n" +
                "            <OrgnlTxId>" + rrn + "</OrgnlTxId>\n" +
                "            <AccptncDtTm>2025-04-11T15:49:07Z</AccptncDtTm>\n" +
                "            <OrgnlTxRef>\n" +
                "                <IntrBkSttlmAmt Ccy=\"GMD\">100</IntrBkSttlmAmt>\n" +
                "                <Amt>\n" +
                "                    <InstdAmt Ccy=\"KES\">100</InstdAmt>\n" +
                "                </Amt>\n" +
                "                <PmtTpInf>\n" +
                "                    <SvcLvl>\n" +
                "                        <Cd>INST</Cd>\n" +
                "                    </SvcLvl>\n" +
                "                    <LclInstrm>\n" +
                "                        <Cd>ET</Cd>\n" +
                "                    </LclInstrm>\n" +
                "                    <CtgyPurp>\n" +
                "                        <Cd>SUPP</Cd>\n" +
                "                    </CtgyPurp>\n" +
                "                </PmtTpInf>\n" +
                "                <DbtrAgt>\n" +
                "                    <FinInstnId>\n" +
                "                        <BICFI>EQBLKENA</BICFI>\n" +
                "                        <ClrSysMmbId>\n" +
                "                            <MmbId>KE1005</MmbId>\n" +
                "                        </ClrSysMmbId>\n" +
                "                    </FinInstnId>\n" +
                "                </DbtrAgt>\n" +
                "            </OrgnlTxRef>\n" +
                "        </TxInfAndSts>\n" +
                "    </hdr:FIToFIPmtStsRpt>\n" +
                "</hdr:Message>\n";
    }

    private String getFailureResponse(String creditTransferXmlRequest) throws ParserConfigurationException, IOException, SAXException {
        String rrn = rrnExtract(creditTransferXmlRequest);
        return "<hdr:Message xmlns:hdr=\"urn:montran:message.01\">\n" +
                "    <hdr:AppHdr xmlns=\"urn:iso:std:iso:20022:tech:xsd:head.001.001.01\">\n" +
                "        <Fr>\n" +
                "            <FIId>\n" +
                "                <FinInstnId>\n" +
                "                    <ClrSysMmbId>\n" +
                "                        <ClrSysId>\n" +
                "                            <Prtry>PAPSS</Prtry>\n" +
                "                        </ClrSysId>\n" +
                "                        <MmbId>GM1015</MmbId>\n" +
                "                    </ClrSysMmbId>\n" +
                "                </FinInstnId>\n" +
                "            </FIId>\n" +
                "        </Fr>\n" +
                "        <To>\n" +
                "            <FIId>\n" +
                "                <FinInstnId>\n" +
                "                    <BICFI>EQBLKENA</BICFI>\n" +
                "                    <ClrSysMmbId>\n" +
                "                        <ClrSysId>\n" +
                "                            <Prtry>PAPSS</Prtry>\n" +
                "                        </ClrSysId>\n" +
                "                        <MmbId>KE1005</MmbId>\n" +
                "                    </ClrSysMmbId>\n" +
                "                </FinInstnId>\n" +
                "            </FIId>\n" +
                "        </To>\n" +
                "        <BizMsgIdr>" + rrn + "</BizMsgIdr>\n" +
                "        <MsgDefIdr>pacs.002.001.07</MsgDefIdr>\n" +
                "        <CreDt>2025-04-11T15:50:30Z</CreDt>\n" +
                "    </hdr:AppHdr>\n" +
                "\n" +
                "    <hdr:FIToFIPmtStsRpt xmlns=\"urn:iso:std:iso:20022:tech:xsd:pacs.002.001.07\">\n" +
                "        <GrpHdr>\n" +
                "            <MsgId>" + rrn + "</MsgId>\n" +
                "            <CreDtTm>2025-04-11T15:50:30Z</CreDtTm>\n" +
                "            <InstdAgt>\n" +
                "                <FinInstnId>\n" +
                "                    <ClrSysMmbId>\n" +
                "                        <MmbId>KE1005</MmbId>\n" +
                "                    </ClrSysMmbId>\n" +
                "                </FinInstnId>\n" +
                "            </InstdAgt>\n" +
                "        </GrpHdr>\n" +
                "\n" +
                "        <OrgnlGrpInfAndSts>\n" +
                "            <OrgnlMsgId>" + rrn + "</OrgnlMsgId>\n" +
                "            <OrgnlMsgNmId>pacs.008.001.07</OrgnlMsgNmId>\n" +
                "            <GrpSts>RJCT</GrpSts>\n" +
                "        </OrgnlGrpInfAndSts>\n" +
                "\n" +
                "        <TxInfAndSts>\n" +
                "            <StsId>" + rrn + "</StsId>\n" +
                "            <OrgnlInstrId>" + rrn + "</OrgnlInstrId>\n" +
                "            <OrgnlEndToEndId>KE1005GM101520250411164907111996657013</OrgnlEndToEndId>\n" +
                "            <OrgnlTxId>" + rrn + "</OrgnlTxId>\n" +
                "            <AccptncDtTm>2025-04-11T15:49:07Z</AccptncDtTm>\n" +
                "            <StsRsnInf>\n" +
                "                <Orgtr>\n" +
                "                    <OrgId>\n" +
                "                        <Othr>\n" +
                "                            <Id>PAPSS</Id>\n" +
                "                        </Othr>\n" +
                "                    </OrgId>\n" +
                "                </Orgtr>\n" +
                "                <Rsn>\n" +
                "                    <Cd>500</Cd>\n" +
                "                </Rsn>\n" +
                "                <AddtlInf>Time out Error</AddtlInf>\n" +
                "            </StsRsnInf>\n" +
                "            <OrgnlTxRef>\n" +
                "                <IntrBkSttlmAmt Ccy=\"GMD\">100</IntrBkSttlmAmt>\n" +
                "                <Amt>\n" +
                "                    <InstdAmt Ccy=\"KES\">100</InstdAmt>\n" +
                "                </Amt>\n" +
                "                <PmtTpInf>\n" +
                "                    <SvcLvl>\n" +
                "                        <Cd>INST</Cd>\n" +
                "                    </SvcLvl>\n" +
                "                    <LclInstrm>\n" +
                "                        <Cd>ET</Cd>\n" +
                "                    </LclInstrm>\n" +
                "                    <CtgyPurp>\n" +
                "                        <Cd>SUPP</Cd>\n" +
                "                    </CtgyPurp>\n" +
                "                </PmtTpInf>\n" +
                "                <DbtrAgt>\n" +
                "                    <FinInstnId>\n" +
                "                        <BICFI>EQBLKENA</BICFI>\n" +
                "                        <ClrSysMmbId>\n" +
                "                            <MmbId>KE1005</MmbId>\n" +
                "                        </ClrSysMmbId>\n" +
                "                    </FinInstnId>\n" +
                "                </DbtrAgt>\n" +
                "            </OrgnlTxRef>\n" +
                "        </TxInfAndSts>\n" +
                "    </hdr:FIToFIPmtStsRpt>\n" +
                "</hdr:Message>\n";
    }

    private String rrnExtract(String xmlString) throws ParserConfigurationException, IOException, SAXException {
        Document doc = DocumentBuilderFactory.newInstance()
                .newDocumentBuilder()
                .parse(new ByteArrayInputStream(xmlString.getBytes()));

        NodeList msgIdNodes = doc.getElementsByTagName("MsgId");
        String rrn = msgIdNodes.item(0).getTextContent();
        System.out.println("RRN: " + rrn);

        return rrn;
    }

}
