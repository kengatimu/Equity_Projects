package com.equitybank.gag.papss.ips.web.controller.inbound;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.concurrent.atomic.AtomicBoolean;

@RestController
//@RequestMapping(path = "/papss/Message")
@RequestMapping(path = "/papss/Message/disabled")
public class InboundNamecheckController {

    private static final Logger log = LoggerFactory.getLogger(InboundNamecheckController.class);

    // Toggles TRUE/FALSE for alternating responses
    private final AtomicBoolean toggle = new AtomicBoolean(true);

    /**
     * Simulates PAPSS inbound poll endpoint.
     * Alternates between ACMT023 XML and EMPTY response.
     */
    @GetMapping(produces = MediaType.TEXT_XML_VALUE)
    public ResponseEntity<String> simulatePapssInboundNamecheck() {
        boolean sendFullMessage = toggle.getAndSet(!toggle.get());

//        // If toggle is FALSE → return EMPTY
//        if (!sendFullMessage) {
//            log.info("[PAPSS SIMULATOR]: Sending EMPTY response");
//
//            HttpHeaders headers = new HttpHeaders();
//            headers.add("Content-Type", "text/xml;charset=utf-8");
//            headers.add("X-PAPSSRTP-Version", "1");
//            headers.add("X-PAPSSRTP-ReqSts", "EMPTY");
//            headers.add("X-PAPSSRTP-RemainingOutputs", "0");
//
//            return ResponseEntity.ok()
//                    .headers(headers)
//                    .body("<html/>");  // PAPSS usually returns <html/> for empty
//        }

        // Otherwise → FULL ACMT023 XML
        try {
//            String xmlResponse = loadTemplate("/templates/ACMT023.xml");
            String xmlResponse = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n" +
                    "<hdr:Message\n" +
                    "    xmlns:hdr=\"urn:montran:message.01\">\n" +
                    "    <hdr:AppHdr\n" +
                    "        xmlns=\"urn:iso:std:iso:20022:tech:xsd:head.001.001.01\">\n" +
                    "        <Fr>\n" +
                    "            <FIId>\n" +
                    "                <FinInstnId>\n" +
                    "                    <ClrSysMmbId>\n" +
                    "                        <ClrSysId>\n" +
                    "                            <Prtry>PAPSS</Prtry>\n" +
                    "                        </ClrSysId>\n" +
                    "                        <MmbId>XA0001</MmbId>\n" +
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
                    "                        <MmbId>KE1011</MmbId>\n" +
                    "                    </ClrSysMmbId>\n" +
                    "                </FinInstnId>\n" +
                    "            </FIId>\n" +
                    "        </To>\n" +
                    "        <BizMsgIdr>CT0202512010000423003</BizMsgIdr>\n" +
                    "        <MsgDefIdr>acmt.023.001.02</MsgDefIdr>\n" +
                    "        <CreDt>2025-12-01T11:23:07Z</CreDt>\n" +
                    "        <Sgntr>\n" +
                    "            <Signature\n" +
                    "                xmlns=\"http://www.w3.org/2000/09/xmldsig#\">\n" +
                    "                <SignedInfo>\n" +
                    "                    <CanonicalizationMethod Algorithm=\"http://www.w3.org/TR/2001/REC-xml-c14n-20010315\"/>\n" +
                    "                    <SignatureMethod Algorithm=\"http://www.w3.org/2001/04/xmldsig-more#rsa-sha256\"/>\n" +
                    "                    <Reference URI=\"\">\n" +
                    "                        <Transforms>\n" +
                    "                            <Transform Algorithm=\"http://www.w3.org/2000/09/xmldsig#enveloped-signature\"/>\n" +
                    "                            <Transform Algorithm=\"http://www.w3.org/2006/12/xml-c14n11\"/>\n" +
                    "                        </Transforms>\n" +
                    "                        <DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/>\n" +
                    "                        <DigestValue>cua7HXOv/EMFwYlDw+jwyVJJFLkYCSWh9YNMv3bax8M=</DigestValue>\n" +
                    "                    </Reference>\n" +
                    "                </SignedInfo>\n" +
                    "                <SignatureValue>fXOxC1ZfaQYizEo99RQ3YlzaV7kwVFl8EDpQVzBmQ7/Ii4F5IsPpBsoSPtiu/P/5TnDcP2TTHrm6&#13;\n" +
                    "pLoTtqQ5ATYTo0wcqgjBa8GrCOFiXdItlX1pPjxW2PCMePlr6DZuJT3pgLNUMlSj03IQQq34ltc8&#13;\n" +
                    "7Wpu7xhDIjD96njDwTNzp6zWi7Ekm7w1zl2aw9yVi5NfCjr803AP3FrtKxw/EMGyK4fY8qg67IqM&#13;\n" +
                    "k5bhIlVjSb/ky2ifTTNq7VJKtFzkeEAayCKEfnB3VVCgHUQlMu6p847Hr13EqPkPdetkG72TSCpV&#13;\n" +
                    "4IyCAf9PAW3tUL3wezkleO51JXxU7G0xEpnyhA==</SignatureValue>\n" +
                    "                <KeyInfo>\n" +
                    "                    <X509Data>\n" +
                    "                        <X509SubjectName>CN=server-c1</X509SubjectName>\n" +
                    "                        <X509IssuerSerial>\n" +
                    "                            <X509IssuerName>CN=AFXM CA</X509IssuerName>\n" +
                    "                            <X509SerialNumber>60805792545685327299985507214109568141</X509SerialNumber>\n" +
                    "                        </X509IssuerSerial>\n" +
                    "                    </X509Data>\n" +
                    "                </KeyInfo>\n" +
                    "            </Signature>\n" +
                    "        </Sgntr>\n" +
                    "    </hdr:AppHdr>\n" +
                    "    <hdr:IdVrfctnReq\n" +
                    "        xmlns=\"urn:iso:std:iso:20022:tech:xsd:acmt.023.001.02\">\n" +
                    "        <Assgnmt>\n" +
                    "            <MsgId>CT0202512010000423003</MsgId>\n" +
                    "            <CreDtTm>2025-12-01T11:23:07Z</CreDtTm>\n" +
                    "            <Assgnr>\n" +
                    "                <Agt>\n" +
                    "                    <FinInstnId>\n" +
                    "                        <BICFI>FIBSSLFT</BICFI>\n" +
                    "                        <ClrSysMmbId>\n" +
                    "                            <ClrSysId>\n" +
                    "                                <Prtry>PAPSS</Prtry>\n" +
                    "                            </ClrSysId>\n" +
                    "                            <MmbId>SL1002</MmbId>\n" +
                    "                        </ClrSysMmbId>\n" +
                    "                    </FinInstnId>\n" +
                    "                </Agt>\n" +
                    "            </Assgnr>\n" +
                    "            <Assgne>\n" +
                    "                <Agt>\n" +
                    "                    <FinInstnId>\n" +
                    "                        <ClrSysMmbId>\n" +
                    "                            <ClrSysId>\n" +
                    "                                <Prtry>PAPSS</Prtry>\n" +
                    "                            </ClrSysId>\n" +
                    "                            <MmbId>KE1011</MmbId>\n" +
                    "                        </ClrSysMmbId>\n" +
                    "                    </FinInstnId>\n" +
                    "                </Agt>\n" +
                    "            </Assgne>\n" +
                    "        </Assgnmt>\n" +
                    "        <Vrfctn>\n" +
                    "            <Id>20251201SL100288185616</Id>\n" +
                    "            <PtyAndAcctId>\n" +
                    "                <Acct>\n" +
                    "                    <Othr>\n" +
                    "                        <Id>1970184901456</Id>\n" +
                    "                        <SchmeNm>\n" +
                    "                            <Cd>BBAN</Cd>\n" +
                    "                        </SchmeNm>\n" +
                    "                    </Othr>\n" +
                    "                </Acct>\n" +
                    "            </PtyAndAcctId>\n" +
                    "        </Vrfctn>\n" +
                    "    </hdr:IdVrfctnReq>\n" +
                    "</hdr:Message>";

            // Optional: You can update timestamps dynamically if needed
//            String dynamicXml = xmlResponse.replace("2025-11-12T12:21:53Z", ZonedDateTime.now().format(DateTimeFormatter.ISO_INSTANT));

            log.info("[PAPSS SIMULATOR]: Sending ACMT023 mock response");

            HttpHeaders headers = new HttpHeaders();
            headers.add("Content-Type", "text/xml;charset=utf-8");
            headers.add("X-PAPSSRTP-Version", "1");
            headers.add("X-PAPSSRTP-MessageSeq", "202511120000072401");
            headers.add("X-PAPSSRTP-MessageType", "acmt.023");
            headers.add("X-PAPSSRTP-RemainingOutputs", "1");
            headers.add("X-PAPSSRTP-PossibleDuplicate", "true");

            return ResponseEntity.ok()
                    .headers(headers)
                    .body(xmlResponse);

        } catch (Exception e) {
            log.error("Error loading ACMT023 template: {}", e.getMessage());
            return ResponseEntity.internalServerError().body("Error loading XML template");
        }
    }

    // Utility loader
    private String loadTemplate(String path) throws Exception {
        try (InputStream input = getClass().getResourceAsStream(path)) {
            if (input == null) {
                throw new IllegalArgumentException("Template not found: " + path);
            }
            return new String(input.readAllBytes(), StandardCharsets.UTF_8);
        }
    }
}
