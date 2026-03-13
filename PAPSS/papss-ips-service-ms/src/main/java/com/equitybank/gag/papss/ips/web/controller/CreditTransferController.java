package com.equitybank.gag.papss.ips.web.controller;

import com.equitybank.gag.papss.ips.service.ProcessRequestService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;

@RestController
@RequestMapping(path = "/papss")
public class CreditTransferController {
    private static final Logger log = LoggerFactory.getLogger(CreditTransferController.class);

    private final ProcessRequestService processRequest;

    @Autowired
    public CreditTransferController(ProcessRequestService processRequest) {
        this.processRequest = processRequest;
    }

    @PostMapping(value = "/Message",
            consumes = {MediaType.APPLICATION_XML_VALUE},
            produces = {MediaType.APPLICATION_XML_VALUE})
    ResponseEntity<?> nameCheck( @RequestBody String creditTransferXmlRequest, BindingResult bindingResult, WebRequest webRequest) throws ParserConfigurationException, IOException, SAXException {
        log.info("Received Credit Transfer Request: " + creditTransferXmlRequest);

        // Simulate timeouts
//        sleepFor90Seconds();

//        String state = "Success-ACK";
        String state = "Failure-ACK";
//        String finalState = "Final-Success";
        String finalState = "Final-Failure";

        // Process the request
        String responseXml = processRequest.processCreditTransferRequest(creditTransferXmlRequest, state, finalState);

        String ipsResponseXml = composeResponseMock();

        log.info("Returned Credit Transfer Response: " + responseXml);
        return new ResponseEntity<>(ipsResponseXml, HttpStatus.OK);
    }

    public void sleepFor90Seconds() {
        try {
            Thread.sleep(90_000); // 90 seconds = 90,000 milliseconds
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt(); // restore interrupt status
            System.err.println("Thread was interrupted during sleep: " + e.getMessage());
        }
    }

    private String composeResponseMock() {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n" +
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
                "        <BizMsgIdr>PS202601220000080101</BizMsgIdr>\n" +
                "        <MsgDefIdr>pacs.002.001.07</MsgDefIdr>\n" +
                "        <CreDt>2026-01-22T13:05:37Z</CreDt>\n" +
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
                "                        <DigestValue>ycqMaruN2SsZLOXXPKRtirenOJ4Lf86bDmxSspiqwww=</DigestValue>\n" +
                "                    </Reference>\n" +
                "                </SignedInfo>\n" +
                "                <SignatureValue>LoDVHOg4v3pJPsrm/ZFxDITGm3sZRHIUEp4ubM74vBzTkFpfzpAmkU5QwL2YHord6VAdNXr6C34O&#13;\n" +
                " HHB6KVRR8nyKXV7wgVUrz600slwSNMayu5aMYaTAdrT3jA6dudMit/CZNQten1ji1KDNN4ScMPG2&#13;\n" +
                " pHcAzbcxbqm9I+HaBfdGZ/jaMwQ4yGfcwkd+QvenwpqXIdRiXZug4kCjSKtgOjp/ZkxLx0RL7nB1&#13;\n" +
                " uZ6eo2XxC0vOiLgINgaWT+MdTvSTI3F6l6X2Xf/Rw66wrl8uOPvAk8b4l1kFwtYPX484dGD4wtaH&#13;\n" +
                " VstZsK8Tw1W2GmeXeFbaMb4R8bRdFASprscPYw==</SignatureValue>\n" +
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
                "    <hdr:FIToFIPmtStsRpt\n" +
                "        xmlns=\"urn:iso:std:iso:20022:tech:xsd:pacs.002.001.07\">\n" +
                "        <GrpHdr>\n" +
                "            <MsgId>PS202601220000080101</MsgId>\n" +
                "            <CreDtTm>2026-01-22T13:05:37Z</CreDtTm>\n" +
                "            <InstdAgt>\n" +
                "                <FinInstnId>\n" +
                "                    <ClrSysMmbId>\n" +
                "                        <MmbId>KE1011</MmbId>\n" +
                "                    </ClrSysMmbId>\n" +
                "                </FinInstnId>\n" +
                "            </InstdAgt>\n" +
                "        </GrpHdr>\n" +
                "        <OrgnlGrpInfAndSts>\n" +
                "            <OrgnlMsgId>20260122KE1011130536</OrgnlMsgId>\n" +
                "            <OrgnlMsgNmId>pacs.002.001.07</OrgnlMsgNmId>\n" +
                "            <GrpSts>ACSC</GrpSts>\n" +
                "        </OrgnlGrpInfAndSts>\n" +
                "        <TxInfAndSts>\n" +
                "            <StsId>PS202601220000080101</StsId>\n" +
                "            <OrgnlInstrId>20260122DJ1002130529</OrgnlInstrId>\n" +
                "            <OrgnlEndToEndId>202601220000032703129</OrgnlEndToEndId>\n" +
                "            <OrgnlTxId>20260122DJ1002130529</OrgnlTxId>\n" +
                "            <AccptncDtTm>2026-01-22T13:05:30Z</AccptncDtTm>\n" +
                "            <OrgnlTxRef>\n" +
                "                <IntrBkSttlmAmt Ccy=\"USD\">50.00</IntrBkSttlmAmt>\n" +
                "                <Amt>\n" +
                "                    <InstdAmt Ccy=\"USD\">50.00</InstdAmt>\n" +
                "                </Amt>\n" +
                "                <PmtTpInf>\n" +
                "                    <SvcLvl>\n" +
                "                        <Prtry>INST</Prtry>\n" +
                "                    </SvcLvl>\n" +
                "                    <LclInstrm>\n" +
                "                        <Cd>USDP</Cd>\n" +
                "                    </LclInstrm>\n" +
                "                    <CtgyPurp>\n" +
                "                        <Cd>CCRD</Cd>\n" +
                "                    </CtgyPurp>\n" +
                "                </PmtTpInf>\n" +
                "                <DbtrAgt>\n" +
                "                    <FinInstnId>\n" +
                "                        <BICFI>ISEADJJD</BICFI>\n" +
                "                        <ClrSysMmbId>\n" +
                "                            <ClrSysId>\n" +
                "                                <Prtry>PAPSS</Prtry>\n" +
                "                            </ClrSysId>\n" +
                "                            <MmbId>DJ1002</MmbId>\n" +
                "                        </ClrSysMmbId>\n" +
                "                    </FinInstnId>\n" +
                "                </DbtrAgt>\n" +
                "            </OrgnlTxRef>\n" +
                "        </TxInfAndSts>\n" +
                "    </hdr:FIToFIPmtStsRpt>\n" +
                "</hdr:Message>";
    }
}