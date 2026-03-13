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
import java.util.concurrent.atomic.AtomicLong;

@RestController
@RequestMapping(path = "/papss/Message")
public class InboundTransactionController {

    private static final Logger log = LoggerFactory.getLogger(InboundTransactionController.class);

    // Toggles TRUE/FALSE for alternating responses
    private final AtomicBoolean toggle = new AtomicBoolean(true);

    // For message sequence generation
    private static final AtomicLong MESSAGE_SEQ_COUNTER = new AtomicLong(202631019000000095L);  // your starting value
    private static final int SEQ_LENGTH = 18;

    /**
     * Simulates PAPSS inbound poll endpoint.
     * Alternates between PACS008 XML and EMPTY response.
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

        // Otherwise → FULL PACS008 XML
        // Create incremented MessageSeq
        String messageSeq = nextMessageSeq();
        String creditAccount = "0020171975437";

        try {
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
                    "        <BizMsgIdr>CT0" + messageSeq + "</BizMsgIdr>\n" +
                    "        <MsgDefIdr>pacs.008.001.07</MsgDefIdr>\n" +
                    "        <CreDt>2025-12-04T13:09:46Z</CreDt>\n" +
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
                    "                        <DigestValue>3GAK9bdBvOf685hjSr02icVLcN4WGNwm1bech/ttn84=</DigestValue>\n" +
                    "                    </Reference>\n" +
                    "                </SignedInfo>\n" +
                    "                <SignatureValue>qeuYpZPtQ/u14zHwfvge4hqzd7Gmmg9+WyLc5vAYMLQFIJJEtEDLVqW5jdXTLcPPekRQ1qFpyAm1&#13;\n" +
                    " GY0OPO3esbddXoeG7TJohxyJ0qJqRI2dPY+Gq01z3tLuSPP0liUHhPhTJ0P3BKvPxCuhTDc4LDVx&#13;\n" +
                    " 3vo4RK8MRBxmidco8VKy374IxUd+b44rBm/IRB6yHrokc9ZLvVmxQnp09TVORVCxTpvY1G2yimeh&#13;\n" +
                    " /9lt5WZWqq6MoVlorMQymzzf1oAhdRmRgLWfNq8i8HAfx1lIU0W4TbTQaWMNaSBh5n53ZN+Mzq1W&#13;\n" +
                    " b6kLQrXWMnNJkwZ9k4mmyTaKxOXbkf1N1t5DSA==</SignatureValue>\n" +
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
                    "    <hdr:FIToFICstmrCdtTrf\n" +
                    "        xmlns=\"urn:iso:std:iso:20022:tech:xsd:pacs.008.001.07\">\n" +
                    "        <GrpHdr>\n" +
                    "            <MsgId>CT0" + messageSeq + "</MsgId>\n" +
                    "            <CreDtTm>2025-12-04T13:09:46Z</CreDtTm>\n" +
                    "            <NbOfTxs>1</NbOfTxs>\n" +
                    "            <TtlIntrBkSttlmAmt Ccy=\"USD\">19.60</TtlIntrBkSttlmAmt>\n" +
                    "            <IntrBkSttlmDt>2025-12-04</IntrBkSttlmDt>\n" +
                    "            <SttlmInf>\n" +
                    "                <SttlmMtd>CLRG</SttlmMtd>\n" +
                    "                <ClrSys>\n" +
                    "                    <Prtry>PAPSS</Prtry>\n" +
                    "                </ClrSys>\n" +
                    "            </SttlmInf>\n" +
                    "            <PmtTpInf>\n" +
                    "                <SvcLvl>\n" +
                    "                    <Prtry>INST</Prtry>\n" +
                    "                </SvcLvl>\n" +
                    "                <LclInstrm>\n" +
                    "                    <Cd>SSA3</Cd>\n" +
                    "                </LclInstrm>\n" +
                    "                <CtgyPurp>\n" +
                    "                    <Cd>SUPP</Cd>\n" +
                    "                </CtgyPurp>\n" +
                    "            </PmtTpInf>\n" +
                    "            <InstdAgt>\n" +
                    "                <FinInstnId>\n" +
                    "                    <BICFI>OMGGDJCK</BICFI>\n" +
                    "                    <ClrSysMmbId>\n" +
                    "                        <ClrSysId>\n" +
                    "                            <Prtry>PAPSS</Prtry>\n" +
                    "                        </ClrSysId>\n" +
                    "                        <MmbId>KE1011</MmbId>\n" +
                    "                    </ClrSysMmbId>\n" +
                    "                </FinInstnId>\n" +
                    "            </InstdAgt>\n" +
                    "        </GrpHdr>\n" +
                    "        <CdtTrfTxInf>\n" +
                    "            <PmtId>\n" +
                    "                <InstrId>20251204DJ1009130944</InstrId>\n" +
                    "                <EndToEndId>CT0" + messageSeq + "</EndToEndId>\n" +
                    "                <TxId>20251204DJ1" + messageSeq + "</TxId>\n" +
                    "            </PmtId>\n" +
                    "            <IntrBkSttlmAmt Ccy=\"USD\">19.60</IntrBkSttlmAmt>\n" +
                    "            <AccptncDtTm>2025-12-04T13:09:45Z</AccptncDtTm>\n" +
                    "            <InstdAmt Ccy=\"DJF\">50</InstdAmt>\n" +
                    "            <XchgRate>0.392000000</XchgRate>\n" +
                    "            <ChrgBr>SLEV</ChrgBr>\n" +
                    "            <UltmtDbtr>\n" +
                    "                <Nm>Joel Eze</Nm>\n" +
                    "            </UltmtDbtr>\n" +
                    "            <Dbtr>\n" +
                    "                <Nm>Joel Eze</Nm>\n" +
                    "                <PstlAdr>\n" +
                    "                    <Ctry>DJ</Ctry>\n" +
                    "                    <AdrLine>Lagos</AdrLine>\n" +
                    "                </PstlAdr>\n" +
                    "            </Dbtr>\n" +
                    "            <DbtrAcct>\n" +
                    "                <Id>\n" +
                    "                    <Othr>\n" +
                    "                        <Id>1234567890</Id>\n" +
                    "                        <SchmeNm>\n" +
                    "                            <Cd>BBAN</Cd>\n" +
                    "                        </SchmeNm>\n" +
                    "                    </Othr>\n" +
                    "                </Id>\n" +
                    "            </DbtrAcct>\n" +
                    "            <DbtrAgt>\n" +
                    "                <FinInstnId>\n" +
                    "                    <BICFI>OMGGDJCK</BICFI>\n" +
                    "                    <ClrSysMmbId>\n" +
                    "                        <MmbId>DJ1009</MmbId>\n" +
                    "                    </ClrSysMmbId>\n" +
                    "                </FinInstnId>\n" +
                    "            </DbtrAgt>\n" +
                    "            <CdtrAgt>\n" +
                    "                <FinInstnId>\n" +
                    "                    <ClrSysMmbId>\n" +
                    "                        <ClrSysId>\n" +
                    "                            <Prtry>PAPSS</Prtry>\n" +
                    "                        </ClrSysId>\n" +
                    "                        <MmbId>KE1011</MmbId>\n" +
                    "                    </ClrSysMmbId>\n" +
                    "                </FinInstnId>\n" +
                    "            </CdtrAgt>\n" +
                    "            <Cdtr>\n" +
                    "                <Nm>GEORGE OGARO ONGUSO</Nm>\n" +
                    "                <PstlAdr>\n" +
                    "                    <Ctry>KE</Ctry>\n" +
                    "                    <AdrLine>Kenya</AdrLine>\n" +
                    "                </PstlAdr>\n" +
                    "            </Cdtr>\n" +
                    "            <CdtrAcct>\n" +
                    "                <Id>\n" +
                    "                    <Othr>\n" +
                    "                        <Id>" + creditAccount + "</Id>\n" +
                    "                        <SchmeNm>\n" +
                    "                            <Cd>BBAN</Cd>\n" +
                    "                        </SchmeNm>\n" +
                    "                    </Othr>\n" +
                    "                </Id>\n" +
                    "            </CdtrAcct>\n" +
                    "            <Purp>\n" +
                    "                <Cd>ADVA</Cd>\n" +
                    "            </Purp>\n" +
                    "            <RmtInf>\n" +
                    "                <Ustrd>Testing Payment</Ustrd>\n" +
                    "            </RmtInf>\n" +
                    "        </CdtTrfTxInf>\n" +
                    "        <SplmtryData>\n" +
                    "            <Envlp>\n" +
                    "                <AuditInfo>SECRET</AuditInfo>\n" +
                    "                <Sender>\n" +
                    "                    <Rate>350.0000</Rate>\n" +
                    "                    <Amt Ccy=\"DJF\">50.</Amt>\n" +
                    "                    <SttAmt Ccy=\"USD\">0.14</SttAmt>\n" +
                    "                </Sender>\n" +
                    "                <Receiver>\n" +
                    "                    <Rate>140.0000</Rate>\n" +
                    "                    <Amt Ccy=\"USD\">19.60</Amt>\n" +
                    "                    <SttAmt Ccy=\"USD\">0.14</SttAmt>\n" +
                    "                </Receiver>\n" +
                    "            </Envlp>\n" +
                    "        </SplmtryData>\n" +
                    "    </hdr:FIToFICstmrCdtTrf>\n" +
                    "</hdr:Message>";

            // Optional: You can update timestamps dynamically if needed
//            String dynamicXml = xmlResponse.replace("2025-11-12T12:21:53Z", ZonedDateTime.now().format(DateTimeFormatter.ISO_INSTANT));

            log.info("[PAPSS SIMULATOR]: Sending PACS008 mock response");


            HttpHeaders headers = new HttpHeaders();
            headers.add("Content-Type", "text/xml;charset=utf-8");
            headers.add("X-PAPSSRTP-Version", "1");
            headers.add("X-PAPSSRTP-MessageSeq", messageSeq);
//            headers.add("X-PAPSSRTP-MessageSeq", "202512040000000048");
            headers.add("X-PAPSSRTP-MessageType", "pacs.008");
            headers.add("X-PAPSSRTP-RemainingOutputs", "1");
            headers.add("X-PAPSSRTP-PossibleDuplicate", "false");

            return ResponseEntity.ok().headers(headers).body(xmlResponse);

        } catch (Exception e) {
            log.error("Error loading PACS008 template: {}", e.getMessage());
            return ResponseEntity.internalServerError().body("Error loading XML template");
        }

    }

    // --- Generates next PAPSS MessageSeq (always padded to 18 digits) ---
    private String nextMessageSeq() {
        long next = MESSAGE_SEQ_COUNTER.incrementAndGet();
        return String.format("%0" + SEQ_LENGTH + "d", next);
    }
}
