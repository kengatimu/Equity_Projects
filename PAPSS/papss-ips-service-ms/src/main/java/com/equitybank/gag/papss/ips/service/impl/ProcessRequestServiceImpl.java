package com.equitybank.gag.papss.ips.service.impl;

import com.equitybank.gag.papss.ips.enums.TransactionType;
import com.equitybank.gag.papss.ips.exception.CustomException;
import com.equitybank.gag.papss.ips.pojo.channelRequest.namecheck.ChannelNamecheckDetailsReq;
import com.equitybank.gag.papss.ips.pojo.channelResponse.ChannelResponse;
import com.equitybank.gag.papss.ips.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.task.TaskExecutor;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.Map;

@Service
public class ProcessRequestServiceImpl implements ProcessRequestService {
    private static final Logger log = LoggerFactory.getLogger(ProcessRequestServiceImpl.class);

    private final TaskExecutor taskExecutor;
    private final CallbackService callbackService;
    private final HttpAdapterService httpAdapterService;
    private final ValidateSignatureService validateSignatureService;
    private final PayloadXmlComposerService payloadXmlComposerService;
    private final GenerateXMLDigitalSignatureService generateXMLDigitalSignatureService;

    @Autowired
    public ProcessRequestServiceImpl(@Qualifier("taskExecutor") TaskExecutor taskExecutor,
                                     CallbackService callbackService,
                                     HttpAdapterService httpAdapterService,
                                     ValidateSignatureService validateSignatureService,
                                     PayloadXmlComposerService payloadXmlComposerService,
                                     GenerateXMLDigitalSignatureService generateXMLDigitalSignatureService) {
        this.taskExecutor = taskExecutor;
        this.callbackService = callbackService;
        this.httpAdapterService = httpAdapterService;
        this.validateSignatureService = validateSignatureService;
        this.payloadXmlComposerService = payloadXmlComposerService;
        this.generateXMLDigitalSignatureService = generateXMLDigitalSignatureService;
    }

    @Override
    public String processGetParticipantsRequest(boolean isError, Map<String, Object> queryParams) {
        String bic = (String) queryParams.get("bic");
        String countryCode = (String) queryParams.get("countryCode");


        if (bic != null && !bic.trim().isEmpty()) {
//            return "";
            return "<participants>\n" +
                    "    <participant papssId=\"GH1040\">\n" +
                    "        <bic>ABNGGHAC</bic>\n" +
                    "        <name>ACCESS BANK (GHANA) PLC</name>\n" +
                    "        <countryCode>GH</countryCode>\n" +
                    "        <status>ACTIVE</status>\n" +
                    "        <paymentschemas>\n" +
                    "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-All</paymentschema>\n" +
                    "            <paymentschema>PS-GH-GHS-GH1040-GH-GHS-SSA_3-DEF-SSA3</paymentschema>\n" +
                    "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-LLL</paymentschema>\n" +
                    "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-ESS-LMT</paymentschema>\n" +
                    "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-NNN</paymentschema>\n" +
                    "            <paymentschema>PS-GH-GHS-USD-SSA_3-USDP</paymentschema>\n" +
                    "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-SSS</paymentschema>\n" +
                    "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GAM</paymentschema>\n" +
                    "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GNN</paymentschema>\n" +
                    "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GGG</paymentschema>\n" +
                    "        </paymentschemas>\n" +
                    "        <currencies>\n" +
                    "            <currency>GHS</currency>\n" +
                    "            <currency>USD</currency>\n" +
                    "        </currencies>\n" +
                    "        <online>true</online>\n" +
                    "        <nonInstant>false</nonInstant>\n" +
                    "    </participant>\n" +
                    "</participants>";
        }
        if (countryCode != null && !countryCode.trim().isEmpty()) {
            return "<participants>\n" +
                    "    <participant papssId=\"KE0008NP\">\n" +
                    "        <bic>KCOOKENE</bic>\n" +
                    "        <name>COOP BANK</name>\n" +
                    "        <countryCode>KE</countryCode>\n" +
                    "        <status>ACTIVE</status>\n" +
                    "        <paymentschemas/>\n" +
                    "        <currencies/>\n" +
                    "        <online>true</online>\n" +
                    "        <nonInstant>false</nonInstant>\n" +
                    "    </participant>\n" +
                    "    <participant papssId=\"KE0007NP\">\n" +
                    "        <bic>DTKEKENM</bic>\n" +
                    "        <name>DTB BANK</name>\n" +
                    "        <countryCode>KE</countryCode>\n" +
                    "        <status>ACTIVE</status>\n" +
                    "        <paymentschemas>\n" +
                    "            <paymentschema>PS-KE-KES-KE1002-KE-KES-SSA_3-DEF-All</paymentschema>\n" +
                    "        </paymentschemas>\n" +
                    "        <currencies>\n" +
                    "            <currency>KES</currency>\n" +
                    "        </currencies>\n" +
                    "        <online>true</online>\n" +
                    "        <nonInstant>false</nonInstant>\n" +
                    "    </participant>\n" +
                    "    <participant papssId=\"KE0002NP\">\n" +
                    "        <bic>KPOBKEN1</bic>\n" +
                    "        <name>POST BANK</name>\n" +
                    "        <countryCode>KE</countryCode>\n" +
                    "        <status>ACTIVE</status>\n" +
                    "        <paymentschemas>\n" +
                    "            <paymentschema>PS-KE-KES-KE1002-KE-KES-SSA_3-DEF-All</paymentschema>\n" +
                    "        </paymentschemas>\n" +
                    "        <currencies>\n" +
                    "            <currency>KES</currency>\n" +
                    "        </currencies>\n" +
                    "        <online>true</online>\n" +
                    "        <nonInstant>false</nonInstant>\n" +
                    "    </participant>\n" +
                    "    <participant papssId=\"KE1035\">\n" +
                    "        <bic>SBICKENX</bic>\n" +
                    "        <name>Stanbic Bank Kenya Limited</name>\n" +
                    "        <countryCode>KE</countryCode>\n" +
                    "        <status>ACTIVE</status>\n" +
                    "        <paymentschemas>\n" +
                    "            <paymentschema>PS-KE-KES-USD-SSA_3-USDP</paymentschema>\n" +
                    "            <paymentschema>PS-KE-KES-KE1035-KE-KES-SSA_3-DEF-SSA3</paymentschema>\n" +
                    "        </paymentschemas>\n" +
                    "        <currencies>\n" +
                    "            <currency>KES</currency>\n" +
                    "            <currency>USD</currency>\n" +
                    "        </currencies>\n" +
                    "        <online>true</online>\n" +
                    "        <nonInstant>false</nonInstant>\n" +
                    "    </participant>\n" +
                    "    <participant papssId=\"KE0004NP\">\n" +
                    "        <bic>CBAFKENT</bic>\n" +
                    "        <name>NCBA Bank</name>\n" +
                    "        <countryCode>KE</countryCode>\n" +
                    "        <status>ACTIVE</status>\n" +
                    "        <paymentschemas>\n" +
                    "            <paymentschema>PS-KE-KES-KE1002-KE-KES-SSA_3-DEF-All</paymentschema>\n" +
                    "        </paymentschemas>\n" +
                    "        <currencies>\n" +
                    "            <currency>KES</currency>\n" +
                    "        </currencies>\n" +
                    "        <online>true</online>\n" +
                    "        <nonInstant>false</nonInstant>\n" +
                    "    </participant>\n" +
                    "    <participant papssId=\"KE1002\">\n" +
                    "        <bic>KCBLKENX</bic>\n" +
                    "        <name>KCB BANK KENYA LTD</name>\n" +
                    "        <countryCode>KE</countryCode>\n" +
                    "        <status>ACTIVE</status>\n" +
                    "        <paymentschemas>\n" +
                    "            <paymentschema>PS-KE-KES-KE1002-KE-KES-SSA_3-DEF-All</paymentschema>\n" +
                    "            <paymentschema>PS-KE-KES-KE1002-KE-KES-SSA_3-DEF-SSA3</paymentschema>\n" +
                    "            <paymentschema>PS-KE-KES-USD-SSA_3-USDP</paymentschema>\n" +
                    "        </paymentschemas>\n" +
                    "        <currencies>\n" +
                    "            <currency>KES</currency>\n" +
                    "            <currency>USD</currency>\n" +
                    "        </currencies>\n" +
                    "        <online>true</online>\n" +
                    "        <nonInstant>false</nonInstant>\n" +
                    "    </participant>\n" +
                    "    <participant papssId=\"KE0006NP\">\n" +
                    "        <bic>DUIBKENA</bic>\n" +
                    "        <name>DIB BANK</name>\n" +
                    "        <countryCode>KE</countryCode>\n" +
                    "        <status>ACTIVE</status>\n" +
                    "        <paymentschemas>\n" +
                    "            <paymentschema>PS-KE-KES-KE1002-KE-KES-SSA_3-DEF-All</paymentschema>\n" +
                    "        </paymentschemas>\n" +
                    "        <currencies>\n" +
                    "            <currency>KES</currency>\n" +
                    "        </currencies>\n" +
                    "        <online>true</online>\n" +
                    "        <nonInstant>false</nonInstant>\n" +
                    "    </participant>\n" +
                    "    <participant papssId=\"KE1006\">\n" +
                    "        <bic>IMBLKENA</bic>\n" +
                    "        <name>I&M Bank Limited</name>\n" +
                    "        <countryCode>KE</countryCode>\n" +
                    "        <status>ACTIVE</status>\n" +
                    "        <paymentschemas>\n" +
                    "            <paymentschema>PS-KE-KES-KE1006-KE-KES-SSA_3-DEF-SSA3</paymentschema>\n" +
                    "            <paymentschema>PS-KE-KES-KE1001-KE-KES-SSA_1-DEF-All</paymentschema>\n" +
                    "            <paymentschema>PS-KE-KES-USD-SSA_3-USDP</paymentschema>\n" +
                    "        </paymentschemas>\n" +
                    "        <currencies>\n" +
                    "            <currency>KES</currency>\n" +
                    "            <currency>USD</currency>\n" +
                    "        </currencies>\n" +
                    "        <online>true</online>\n" +
                    "        <nonInstant>false</nonInstant>\n" +
                    "    </participant>\n" +
                    "</participants>";
        }
        return "<participants>\n" +
                "    <participant papssId=\"GH1040\">\n" +
                "        <bic>ABNGGHAC</bic>\n" +
                "        <name>ACCESS BANK (GHANA) PLC</name>\n" +
                "        <countryCode>GH</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1040-GH-GHS-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-LLL</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-ESS-LMT</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-NNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-SSS</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GAM</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GGG</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>GHS</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"KE0008NP\">\n" +
                "        <bic>KCOOKENE</bic>\n" +
                "        <name>COOP BANK</name>\n" +
                "        <countryCode>KE</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas/>\n" +
                "        <currencies/>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"GH1038\">\n" +
                "        <bic>NIBGGHAC</bic>\n" +
                "        <name>National Investment Bank Limited</name>\n" +
                "        <countryCode>GH</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1038-GH-GHS-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-SSS</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GAM</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-ESS-LMT</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GGG</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-NNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-LLL</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>GHS</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"GH1036\">\n" +
                "        <bic>BARCGHAC</bic>\n" +
                "        <name>Absa Bank Ghana Limited</name>\n" +
                "        <countryCode>GH</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-GH-GHS-GH1036-GH-GHS-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-ESS-LMT</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GGG</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GAM</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-SSS</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-NNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-LLL</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>GHS</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"GN1004\">\n" +
                "        <bic>PCMGGNCK</bic>\n" +
                "        <name>Pay Card</name>\n" +
                "        <countryCode>GN</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-GN-GNF-GN1001-GN-GNF-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-GN-GNF-GN1001-GN-GNF-SSA_1-DEF-ET</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>GNF</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"GN1005\">\n" +
                "        <bic>OMGGGNCK</bic>\n" +
                "        <name>Orange Money Guinea</name>\n" +
                "        <countryCode>GN</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-GN-GNF-GN1001-GN-GNF-SSA_1-DEF-SS3</paymentschema>\n" +
                "            <paymentschema>PS-GN-GNF-GN1001-GN-GNF-SSA_1-DEF-ET</paymentschema>\n" +
                "            <paymentschema>PS-GN-GNF-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>GNF</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"KE0007NP\">\n" +
                "        <bic>DTKEKENM</bic>\n" +
                "        <name>DTB BANK</name>\n" +
                "        <countryCode>KE</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-KE-KES-KE1002-KE-KES-SSA_3-DEF-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>KES</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"GH2023\">\n" +
                "        <bic>FAMCGHAC</bic>\n" +
                "        <name>First Atlantic Bank Ghana Limited</name>\n" +
                "        <countryCode>GH</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-GH-GHS-GH2023-GH-GHS-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GGG</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-123-DLT</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>GHS</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZW9000\">\n" +
                "        <bic>STUVWXYZ</bic>\n" +
                "        <name>ZimSwitch Bank</name>\n" +
                "        <countryCode>ZW</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-ZW-USD-ZW9000-ZW-USD-SSA_3-ZUS-All</paymentschema>\n" +
                "            <paymentschema>PS-ZW-USD-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-ZW-ZIG-ZW9000-ZW-ZIG-SSA_3-DEF-SSA3</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>USD</currency>\n" +
                "            <currency>ZIG</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1003\">\n" +
                "        <bic>SCBLNGLA</bic>\n" +
                "        <name>Standard Chartered Bank</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas/>\n" +
                "        <currencies/>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1002\">\n" +
                "        <bic>ECOCNGLA</bic>\n" +
                "        <name>Ecobank Nigeria limited</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1002-NG-NGN-SSA_3-DEF-SSA3</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZW0003NP\">\n" +
                "        <bic>ZWMFZWHA</bic>\n" +
                "        <name>Zimbabwe Women Microfinance Bank</name>\n" +
                "        <countryCode>ZW</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-ZW-USD-ZW1008-ZW-USD-SSA_3-ZUS-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1012\">\n" +
                "        <bic>HBSLAU4T</bic>\n" +
                "        <name>Heritage Bank PLC</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1012-NG-NGN-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1013\">\n" +
                "        <bic>FCMBNGLA</bic>\n" +
                "        <name>First City Monument Bank Limited</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1013-NG-NGN-SSA_3-DEF-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"LR1009\">\n" +
                "        <bic>ACLILRLM</bic>\n" +
                "        <name>Access Bank Liberia Limited</name>\n" +
                "        <countryCode>LR</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-AAA-CAR</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-LLL</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-AAA-NNN</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-ET</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-GGG</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-AAA-GGG</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-NNN</paymentschema>\n" +
                "            <paymentschema>PS-LR-USD-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-GAM</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-SSS</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-GNN</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-AAA-EDU</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-XA0002-LR-LRD-SSA_2-DEF-REI</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1009-LR-LRD-SSA_3-DEF-SSA3</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>LRD</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1015\">\n" +
                "        <bic>UNTYNGLA</bic>\n" +
                "        <name>Unity Bank</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-VIC-SS3</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1015-NG-NGN-SSA_3-DEF-SSA3</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>true</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"LR1008\">\n" +
                "        <bic>PHBXLRLM</bic>\n" +
                "        <name>BLOOM BANK AFRICA LR</name>\n" +
                "        <countryCode>LR</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-LR-LRD-LR1008-LR-LRD-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-LR-USD-LR1001-LR-USD-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-AAA-EDU</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-XA0002-LR-LRD-SSA_2-DEF-REI</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-GAM</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-GNN</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-LR-USD-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-AAA-GGG</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-NNN</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-AAA-NNN</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-ET</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-GGG</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-LLL</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-AAA-CAR</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>LRD</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1010\">\n" +
                "        <bic>FBNINGLA</bic>\n" +
                "        <name>First Bank of Nigeria Limited</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1010-NG-NGN-SSA_3-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZM0004NP\">\n" +
                "        <bic>BARCZMLX</bic>\n" +
                "        <name>ABSA ZAMBIA</name>\n" +
                "        <countryCode>ZM</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-ZM-ZMW-ZM1004-ZM-ZMW-SSA_3-DEF-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>ZMW</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"KE0002NP\">\n" +
                "        <bic>KPOBKEN1</bic>\n" +
                "        <name>POST BANK</name>\n" +
                "        <countryCode>KE</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-KE-KES-KE1002-KE-KES-SSA_3-DEF-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>KES</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1008\">\n" +
                "        <bic>FIDTNGLA</bic>\n" +
                "        <name>Fidelity Bank PLC</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1008-NG-NGN-SSA_3-DEF-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"KE1035\">\n" +
                "        <bic>SBICKENX</bic>\n" +
                "        <name>Stanbic Bank Kenya Limited</name>\n" +
                "        <countryCode>KE</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-KE-KES-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-KE-KES-KE1035-KE-KES-SSA_3-DEF-SSA3</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>KES</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1021\">\n" +
                "        <bic>UMPLNGLA</bic>\n" +
                "        <name>Providus Bank Limited</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1021-NG-NGN-SSA_3-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1020\">\n" +
                "        <bic>NVBNGLAG</bic>\n" +
                "        <name>NOVA BANK</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1020-NG-NGN-SSA_3-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-VIC-SS3</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-WHO-who</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1034\">\n" +
                "        <bic>PASSSTRL</bic>\n" +
                "        <name>Sterling Bank</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1034-NG-NGN-SSA_3-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1033\">\n" +
                "        <bic>UNAFNGLA</bic>\n" +
                "        <name>United Bank For Africa Nigeria PLC</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1033-NG-NGN-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-DEF-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1036\">\n" +
                "        <bic>WEMANGLA</bic>\n" +
                "        <name>Wema Bank Plc</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1036-NG-NGN-SSA_3-DEF-SSA3</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1035\">\n" +
                "        <bic>SBICNGLX</bic>\n" +
                "        <name>StanbicIBTC Bank</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1035-NG-NGN-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1038\">\n" +
                "        <bic>PLNINGLA</bic>\n" +
                "        <name>KEYSTONE BANK LIMITED</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1038-NG-NGN-SSA_3-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1037\">\n" +
                "        <bic>ZEIBNGLA</bic>\n" +
                "        <name>Zenith Bank Plc</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1037-NG-NGN-SSA_3-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-WHO-who</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"RW1004\">\n" +
                "        <bic>BKIGRWRW</bic>\n" +
                "        <name>Bank of Kigali Plc</name>\n" +
                "        <countryCode>RW</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-RW-RWF-RW1004-RW-RWF-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-RW-RWF-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-RW-RWF-RW1001-RW-RWF-SSA_1-DEF-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>RWF</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1039\">\n" +
                "        <bic>UBNINGLA</bic>\n" +
                "        <name>UNION BANK OF NIGERIA PLC</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1039-NG-NGN-SSA_3-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"RW1002\">\n" +
                "        <bic>BPRWRWRW</bic>\n" +
                "        <name>BPR Bank Rwanda Plc</name>\n" +
                "        <countryCode>RW</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-RW-RWF-RW1002-RW-RWF-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-RW-RWF-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>RWF</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZM0003NP\">\n" +
                "        <bic>PYGOZMZM</bic>\n" +
                "        <name>Paygo Bank</name>\n" +
                "        <countryCode>ZM</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas/>\n" +
                "        <currencies/>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1045\">\n" +
                "        <bic>KDHLNGLA</bic>\n" +
                "        <name>FBNQuest Merchant Bank Limited</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-WHO-who</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1045-NG-NGN-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-DEF-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1044\">\n" +
                "        <bic>FSDHNGLA</bic>\n" +
                "        <name>FSDH Merchant Bank Limited</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1044-NG-NGN-SSA_3-DEF-SSA3</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1047\">\n" +
                "        <bic>OPTSNGLA</bic>\n" +
                "        <name>Optimus Bank Limited</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1047-NG-NGN-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1046\">\n" +
                "        <bic>TAJJNGLA</bic>\n" +
                "        <name>TAJBank Ltd</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1046-NG-NGN-SSA_3-DEF-SSA3</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1049\">\n" +
                "        <bic>FIRNNGLA</bic>\n" +
                "        <name>Rand Merchant Bank Nigeria Limited</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1049-NG-NGN-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1048\">\n" +
                "        <bic>PARANGLA</bic>\n" +
                "        <name>Parallex Bank Limited</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1048-NG-NGN-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-DEF-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"KE0004NP\">\n" +
                "        <bic>CBAFKENT</bic>\n" +
                "        <name>NCBA Bank</name>\n" +
                "        <countryCode>KE</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-KE-KES-KE1002-KE-KES-SSA_3-DEF-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>KES</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZW0001NP\">\n" +
                "        <bic>MBOZZWHA</bic>\n" +
                "        <name>Metbank Zimbabwe</name>\n" +
                "        <countryCode>ZW</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas/>\n" +
                "        <currencies/>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1041\">\n" +
                "        <bic>PRDTNGLA</bic>\n" +
                "        <name>POLARIS BANK LIMITED</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1041-NG-NGN-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1040\">\n" +
                "        <bic>ABNGNGLA</bic>\n" +
                "        <name>Access Bank Plc</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-WHO-who</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1040-NG-NGN-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1043\">\n" +
                "        <bic>CMBBNGLA</bic>\n" +
                "        <name>CORONATION MERCHANT BANK LIMITED</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1043-NG-NGN-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-WHO-who</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG2010\">\n" +
                "        <bic>RTPBIC99</bic>\n" +
                "        <name>Test Participant</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG2010-NG-NGN-SSA_3-TSP-SS3</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"GM1011\">\n" +
                "        <bic>SKYEGMGM</bic>\n" +
                "        <name>Bloom Bank Africa Gambia Limited</name>\n" +
                "        <countryCode>GM</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-GM-GMD-GM1011-GM-GMD-SSA_3-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-GM-GMD-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>GMD</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG2028\">\n" +
                "        <bic>LOTUNGLA</bic>\n" +
                "        <name> LOTUS Bank Limited</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG2028-NG-NGN-SSA_3-DEF-SSA3</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG2027\">\n" +
                "        <bic>JAIZNGLA</bic>\n" +
                "        <name>JAIZ BANK PLC</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-WHO-who</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1050\">\n" +
                "        <bic>ICITNGLA</bic>\n" +
                "        <name>Unity Bank Plc</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1050-NG-NGN-SSA_3-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG1051\">\n" +
                "        <bic>PTRUNGLA</bic>\n" +
                "        <name>PremiumTrust Bank Limited</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-ETN-ET</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG1051-NG-NGN-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"GM1003\">\n" +
                "        <bic>TBLTGMGM</bic>\n" +
                "        <name>TRUST BANK LIMITED</name>\n" +
                "        <countryCode>GM</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-GM-GMD-GM1003-GM-GMD-SSA_3-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-GM-GMD-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>GMD</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZW1016\">\n" +
                "        <bic>COBZZWHA</bic>\n" +
                "        <name>CBZ Bank Limited</name>\n" +
                "        <countryCode>ZW</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-ZW-USD-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-ZW-USD-ZW1016-ZW-USD-SSA_3-DEF-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>true</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZM0002NP\">\n" +
                "        <bic>BYPTZMZM</bic>\n" +
                "        <name>BAYPORT BANK</name>\n" +
                "        <countryCode>ZM</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-ZM-ZMW-ZM1004-ZM-ZMW-SSA_3-DEF-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>ZMW</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZW1012\">\n" +
                "        <bic>AGRZZWHA</bic>\n" +
                "        <name>AFC Commercial Bank Limited</name>\n" +
                "        <countryCode>ZW</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-ZW-USD-ZW1012-ZW-USD-SSA_3-ZUS-All</paymentschema>\n" +
                "            <paymentschema>PS-ZW-USD-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZW1011\">\n" +
                "        <bic>CABSZWHA</bic>\n" +
                "        <name>Central Africa Building Society</name>\n" +
                "        <countryCode>ZW</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-ZW-USD-ZW1011-ZW-USD-SSA_3-ZUS-All</paymentschema>\n" +
                "            <paymentschema>PS-ZW-USD-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZW1014\">\n" +
                "        <bic>STBLZWHX</bic>\n" +
                "        <name>Steward Bank Zimbabwe</name>\n" +
                "        <countryCode>ZW</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-ZW-USD-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-ZW-USD-ZW1014-ZW-USD-SSA_3-ZUS-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZW1013\">\n" +
                "        <bic>ZBCOZWHX</bic>\n" +
                "        <name>ZB Bank Limited</name>\n" +
                "        <countryCode>ZW</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-ZW-USD-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-ZW-USD-ZW1013-ZW-USD-SSA_3-ZUS-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"LR1010\">\n" +
                "        <bic>LBDELRLM</bic>\n" +
                "        <name>Liberian Bank For Development & Investment</name>\n" +
                "        <countryCode>LR</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-LLL</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-GGG</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-AAA-NNN</paymentschema>\n" +
                "            <paymentschema>PS-LR-USD-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-NNN</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-AAA-GGG</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-GAM</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-GNN</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-XA0002-LR-LRD-SSA_2-DEF-REI</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-AAA-EDU</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-ET</paymentschema>\n" +
                "            <paymentschema>PS-LR-USD-LR1001-LR-USD-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-AAA-CAR</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1010-LR-LRD-SSA_3-DEF-SSA3</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>LRD</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZW1010\">\n" +
                "        <bic>EMPWZWHX</bic>\n" +
                "        <name>Empowerbank</name>\n" +
                "        <countryCode>ZW</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-ZW-USD-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-ZW-USD-ZW1010-ZW-USD-SSA_3-ZUS-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZW1008\">\n" +
                "        <bic>PWSBZWHX</bic>\n" +
                "        <name>People's Own Savings Bank</name>\n" +
                "        <countryCode>ZW</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-ZW-USD-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-ZW-USD-ZW1008-ZW-USD-SSA_3-ZUS-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZW1005\">\n" +
                "        <bic>AFCNZWHA</bic>\n" +
                "        <name>African Century Limited</name>\n" +
                "        <countryCode>ZW</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-ZW-USD-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-ZW-USD-ZW1005-ZW-USD-SSA_3-ZUS-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZW1004\">\n" +
                "        <bic>NMBLZWHX</bic>\n" +
                "        <name>NMB Bank Limited</name>\n" +
                "        <countryCode>ZW</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-ZW-USD-ZW1004-ZW-USD-SSA_3-ZUS-All</paymentschema>\n" +
                "            <paymentschema>PS-ZW-USD-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZW1006\">\n" +
                "        <bic>NABYZWHA</bic>\n" +
                "        <name>National Building Society</name>\n" +
                "        <countryCode>ZW</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-ZW-USD-ZW1006-ZW-USD-SSA_3-ZUS-All</paymentschema>\n" +
                "            <paymentschema>PS-ZW-USD-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"KE1006\">\n" +
                "        <bic>IMBLKENA</bic>\n" +
                "        <name>I&M Bank Limited</name>\n" +
                "        <countryCode>KE</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-KE-KES-KE1006-KE-KES-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-KE-KES-KE1001-KE-KES-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-KE-KES-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>KES</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"KE1002\">\n" +
                "        <bic>KCBLKENX</bic>\n" +
                "        <name>KCB BANK KENYA LTD</name>\n" +
                "        <countryCode>KE</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-KE-KES-KE1002-KE-KES-SSA_3-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-KE-KES-KE1002-KE-KES-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-KE-KES-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>KES</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZW1003\">\n" +
                "        <bic>NDORZWHX</bic>\n" +
                "        <name>Innbucks Microbank Limited</name>\n" +
                "        <countryCode>ZW</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-ZW-USD-ZW1003-ZW-USD-SSA_3-ZUS-All</paymentschema>\n" +
                "            <paymentschema>PS-ZW-USD-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZW1002\">\n" +
                "        <bic>GBSPZWHA</bic>\n" +
                "        <name>GetBucks Microfinance Bank Ltd</name>\n" +
                "        <countryCode>ZW</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-ZW-USD-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-ZW-USD-ZW1002-ZW-USD-SSA_3-ZUS-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"KE0003NP\">\n" +
                "        <bic>CBAFKENX</bic>\n" +
                "        <name>LOOP</name>\n" +
                "        <countryCode>KE</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-KE-KES-KE1002-KE-KES-SSA_3-DEF-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>KES</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZM0001NP\">\n" +
                "        <bic>FTSZZMZM</bic>\n" +
                "        <name>FTSZ Bank</name>\n" +
                "        <countryCode>ZM</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas/>\n" +
                "        <currencies/>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"KE0006NP\">\n" +
                "        <bic>DUIBKENA</bic>\n" +
                "        <name>DIB BANK</name>\n" +
                "        <countryCode>KE</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-KE-KES-KE1002-KE-KES-SSA_3-DEF-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>KES</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"NG9000\">\n" +
                "        <bic>TESTTPA1</bic>\n" +
                "        <name>Test Participant 1</name>\n" +
                "        <countryCode>NG</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-NG-NGN-NG1001-NG-NGN-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-NG-NGN-NG9000-NG-NGN-SSA_3-DEF-SSA3</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>NGN</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"SL1009\">\n" +
                "        <bic>FSTISLFR</bic>\n" +
                "        <name>VISTA BANK (SL) LIMITED</name>\n" +
                "        <countryCode>SL</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-GAM</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-GGG</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-GNN</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-SSS</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-LLL</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-NNN</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1009-SL-SLE-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-YER-IUAT</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-ET</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>SLE</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"KE0005NP\">\n" +
                "        <bic>KCOOKENF</bic>\n" +
                "        <name>STIMA SACCO</name>\n" +
                "        <countryCode>KE</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-KE-KES-KE1002-KE-KES-SSA_3-DEF-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>KES</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"LR2020\">\n" +
                "        <bic>AFXMLRLR</bic>\n" +
                "        <name>Afland Liberia Limited</name>\n" +
                "        <countryCode>LR</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-LR-USD-LR1001-LR-USD-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-LR-USD-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR1001-LR-LRD-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-LR-LRD-LR2020-LR-LRD-SSA_3-DEF-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>LRD</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>true</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"GH1018\">\n" +
                "        <bic>ACCCGHAC</bic>\n" +
                "        <name>CALBANK PLC</name>\n" +
                "        <countryCode>GH</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-GH-GHS-GH1018-GH-GHS-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-ESS-LMT</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GGG</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GAM</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-SSS</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-NNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-LLL</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>GHS</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"SL1002\">\n" +
                "        <bic>FIBSSLFT</bic>\n" +
                "        <name>First International Bank</name>\n" +
                "        <countryCode>SL</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-NNN</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-GGG</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-LLL</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-YER-IUAT</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-GNN</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-SSS</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-GAM</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>SLE</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"GH1017\">\n" +
                "        <bic>OMBLGHAC</bic>\n" +
                "        <name>OmniBSIC BANK GHANA LTD</name>\n" +
                "        <countryCode>GH</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-SSS</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-NNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1017-GH-GHS-SSA_3-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-LLL</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GAM</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GGG</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-ESS-LMT</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>GHS</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"SL1006\">\n" +
                "        <bic>SKBSRLFT</bic>\n" +
                "        <name>Skye Bank Sierra Leone</name>\n" +
                "        <countryCode>SL</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-SL-SLE-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-GNN</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-SSS</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1006-SL-SLE-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-LLL</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-ET</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-NNN</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1006-SL-SLE-SSA_3-DEF-REI</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-GAM</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-XA0002-SL-SLE-SSA_2-DEF-AGR</paymentschema>\n" +
                "            <paymentschema>PS-SL-SLE-SL1001-SL-SLE-SSA_1-DEF-GGG</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>SLE</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"GH1014\">\n" +
                "        <bic>MBGHGHAC</bic>\n" +
                "        <name>Universal Merchant Bank</name>\n" +
                "        <countryCode>GH</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GGG</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-ESS-LMT</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-NNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-LLL</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GAM</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-SSS</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>GHS</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"DJ1004\">\n" +
                "        <bic>EABBDJJD</bic>\n" +
                "        <name>East Africa Bank SA</name>\n" +
                "        <countryCode>DJ</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-DJ-DJF-DJ1004-DJ-DJF-SSA_3-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-DJ-DJF-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>DJF</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"GH1010\">\n" +
                "        <bic>ZEBLGHAC</bic>\n" +
                "        <name>ZENITH BANK GHANA LIMITED</name>\n" +
                "        <countryCode>GH</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-NNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-LLL</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-SSS</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GAM</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GGG</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1010-GH-GHS-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-ESS-LMT</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>GHS</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"GH1005\">\n" +
                "        <bic>ECOGGHAC</bic>\n" +
                "        <name>Ecobank Ghana Limited</name>\n" +
                "        <countryCode>GH</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-ESS-LMT</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GGG</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-LLL</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1005-GH-GHS-SSA_3-GHE-TIN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1005-GH-GHS-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GAM</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-NNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-SSS</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>GHS</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"GH1004\">\n" +
                "        <bic>GHCBGHAC</bic>\n" +
                "        <name>GCB Bank PLC</name>\n" +
                "        <countryCode>GH</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-GH-GHS-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-ESS-LMT</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GGG</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GAM</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-SSS</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-NNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1004-GH-GHS-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-LLL</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GNN</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>GHS</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZM1002\">\n" +
                "        <bic>UNAFZMLU</bic>\n" +
                "        <name>United Bank for Africa (Zambia)</name>\n" +
                "        <countryCode>ZM</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-ZM-ZMW-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-ZM-ZMW-ZM1001-ZM-ZMW-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-ZM-ZMW-ZM1002-ZM-ZMW-SSA_3-DEF-SSA3</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>USD</currency>\n" +
                "            <currency>ZMW</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"GH1008\">\n" +
                "        <bic>FBLIGHAC</bic>\n" +
                "        <name>FIDELITY BANK GHANA LIMITED</name>\n" +
                "        <countryCode>GH</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-All</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-SSS</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GAM</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-ESS-LMT</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-GGG</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-NNN</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1008-GH-GHS-SSA_3-DEF-SSA3</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-GH1001-GH-GHS-SSA_1-DEF-LLL</paymentschema>\n" +
                "            <paymentschema>PS-GH-GHS-USD-SSA_3-USDP</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>GHS</currency>\n" +
                "            <currency>USD</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "    <participant papssId=\"ZM1005\">\n" +
                "        <bic>ZNCOZMLU</bic>\n" +
                "        <name>Zanaco Bank</name>\n" +
                "        <countryCode>ZM</countryCode>\n" +
                "        <status>ACTIVE</status>\n" +
                "        <paymentschemas>\n" +
                "            <paymentschema>PS-ZM-ZMW-USD-SSA_3-USDP</paymentschema>\n" +
                "            <paymentschema>PS-ZM-ZMW-ZM1004-ZM-ZMW-SSA_3-DEF-All</paymentschema>\n" +
                "        </paymentschemas>\n" +
                "        <currencies>\n" +
                "            <currency>USD</currency>\n" +
                "            <currency>ZMW</currency>\n" +
                "        </currencies>\n" +
                "        <online>true</online>\n" +
                "        <nonInstant>false</nonInstant>\n" +
                "    </participant>\n" +
                "</participants>";
    }

    @Override
    public String processFxRateRequest(boolean isError) {
        if (!isError) {
            return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                    "<PaymentFXRate>\n" +
                    "    <Request LclInstrm=\"SSA3\" ReceiverBank=\"NG2020\" ReceiverCountry=\"NG\" ReceiverCurrency=\"NGN\" SenderCountry=\"KE\" SenderCurrency=\"KES\" amount=\"100\" isInvoice=\"false\" time=\"2025-04-30T11:58:41Z\"/>\n" +
                    "    <Response time=\"2025-04-30T11:58:41Z\">\n" +
                    "        <Rate type=\"USD/KES\" updateTime=\"2025-04-30T09:45:36Z\">129.55</Rate>\n" +
                    "        <Rate type=\"USD/NGN\" updateTime=\"2023-08-28T14:06:31Z\">750.0000</Rate>\n" +
                    "        <Rate type=\"KES/NGN\">5.775000000</Rate>\n" +
                    "        <SenderAmount Ccy=\"KES\">100.00</SenderAmount>\n" +
                    "        <ExchangeAmount Ccy=\"USD\">0.77</ExchangeAmount>\n" +
                    "        <ReceiverAmount Ccy=\"NGN\">577.50</ReceiverAmount>\n" +
                    "        <NationalFeeAmount Ccy=\"KES\">259.10</NationalFeeAmount>\n" +
                    "        <FeeAmount Ccy=\"USD\">2.00</FeeAmount>\n" +
                    "    </Response>\n" +
                    "</PaymentFXRate>";
        }
        return null;
    }

    @Override
    public String processNamecheckRequest(String namecheckRequestXml) {
        // Validate the cert
        boolean isValid = validateSignatureService.validateSignature(namecheckRequestXml);

        if (!isValid) {
            return invalidSignatureResponse();
        }

        return composeSuccess();
    }

    @Override
    public String processCreditTransferRequest(String creditTransferXmlRequest, String state, String finalState) throws ParserConfigurationException, IOException, SAXException {
        // Validate the cert
//        boolean isValid = validateSignatureService.validateSignature(creditTransferXmlRequest);

//        if (!isValid) {
//            return invalidSignatureResponse();
//        }

        //  Send final status via callback
//        taskExecutor.execute(() -> {
//            sleepFor5Seconds();
//            try {
//                callbackService.sendCallback(finalState, creditTransferXmlRequest);
//            } catch (Exception e) {
//                log.error("Exception occurred " + e.getMessage(), e);
//            }
//        });

        if ("Success-ACK".equals(state)) {
            return composePacs002SuccessACK(creditTransferXmlRequest);
        }
        if ("Failure-ACK".equals(state)) {
            return composePacs002FailureACK(creditTransferXmlRequest);
        }

        return "";
    }

    @Override
    public String processStatusCheckRequest(String statusCheckRequestXml, String state, String finalState) {
//        // Validate the cert
//        boolean isValid = validateSignatureService.validateSignature(statusCheckRequestXml);
//
//        if (!isValid) {
//            return invalidSignatureResponse();
//        }
        return "Final-Success".equals(finalState) ? getSuccessfulResponse() : getFailureResponse();

    }

    @Override
    public ChannelResponse processInboundNamecheckRequest(ChannelNamecheckDetailsReq channelNamecheckDetailsReq) throws CustomException {
        String rrn = channelNamecheckDetailsReq.getChannelInfo().getRrn();
        TransactionType type = TransactionType.NAMECHECK;

        // Compose ISO20022 acmt.023 message
        String acmt023NamecheckXmlReq = payloadXmlComposerService.composeAcmt023NamecheckRequest(channelNamecheckDetailsReq);

        // Sign the iso message using ISO specified methods
        String signedAcmt023XmlReq = generateXMLDigitalSignatureService.generateXMLDigitalSignature(rrn, acmt023NamecheckXmlReq, String.valueOf(type));

        // Send the signed request to IPS
        return httpAdapterService.sendHttpNamecheckRequest(rrn, signedAcmt023XmlReq, String.valueOf(type));
    }

    private String getSuccessfulResponse() {
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
                "        <BizMsgIdr>111996657013</BizMsgIdr>\n" +
                "        <MsgDefIdr>pacs.002.001.07</MsgDefIdr>\n" +
                "        <CreDt>2025-04-11T15:50:15Z</CreDt>\n" +
                "    </hdr:AppHdr>\n" +
                "\n" +
                "    <hdr:FIToFIPmtStsRpt xmlns=\"urn:iso:std:iso:20022:tech:xsd:pacs.002.001.07\">\n" +
                "        <GrpHdr>\n" +
                "            <MsgId>111996657012</MsgId>\n" +
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
                "            <OrgnlMsgId>112996657034</OrgnlMsgId>\n" +
                "            <OrgnlMsgNmId>pacs.008.001.07</OrgnlMsgNmId>\n" +
                "            <GrpSts>ACSC</GrpSts>\n" +
                "        </OrgnlGrpInfAndSts>\n" +
                "\n" +
                "        <TxInfAndSts>\n" +
                "            <StsId>111996657013</StsId>\n" +
                "            <OrgnlInstrId>112996657034</OrgnlInstrId>\n" +
                "            <OrgnlEndToEndId>KE1005GM101520250411164907111996657013</OrgnlEndToEndId>\n" +
                "            <OrgnlTxId>111996657013</OrgnlTxId>\n" +
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

    private String getFailureResponse() {
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
                "        <BizMsgIdr>PS202512040000207601</BizMsgIdr>\n" +
                "        <MsgDefIdr>pacs.002.001.07</MsgDefIdr>\n" +
                "        <CreDt>2025-12-04T13:02:28Z</CreDt>\n" +
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
                "                        <DigestValue>kycGvqQ/lrAALUFxYdZL3dhR77C6ioCSYe41ZUB2qQw=</DigestValue>\n" +
                "                    </Reference>\n" +
                "                </SignedInfo>\n" +
                "                <SignatureValue>iGtQGuztbXjCl8XfLSW6wyogKimTYVvf8RzvbDDy8avSKLAqiizrHqH18O+t9LavUTvhqzRJyfb7&#13;\n" +
                " Swtz/MUVRWBrQov4/2zlg2CGbbLP9YCNomME+jLTJWMIweaZE6K7NTuMyMpSa4nYC8TdYUg95r12&#13;\n" +
                " 0+KT7gX5SA7SBwKqyGIZqalR5BbeFCwQp0efFHKN/GlCKnUYkjUA315ecsTRK1CaIAHl9FMW3JZB&#13;\n" +
                " FmNKxHa+tmrmsneP2xi2WGmjQNBDmX/0DnZ6O8GJ0ZXOG5BHxZYRFTMXyPHV9c9WO/ZLwNumHpYF&#13;\n" +
                " dB/cDV5G18eu8xO/RrMDmtzIDbDDEiiHPrQDlg==</SignatureValue>\n" +
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
                "            <MsgId>PS202512040000207601</MsgId>\n" +
                "            <CreDtTm>2025-12-04T13:02:28Z</CreDtTm>\n" +
                "            <InstdAgt>\n" +
                "                <FinInstnId>\n" +
                "                    <ClrSysMmbId>\n" +
                "                        <MmbId>KE1011</MmbId>\n" +
                "                    </ClrSysMmbId>\n" +
                "                </FinInstnId>\n" +
                "            </InstdAgt>\n" +
                "        </GrpHdr>\n" +
                "        <OrgnlGrpInfAndSts>\n" +
                "            <OrgnlMsgId>20251204KE1011130228</OrgnlMsgId>\n" +
                "            <OrgnlMsgNmId>pacs.008.001.07</OrgnlMsgNmId>\n" +
                "        </OrgnlGrpInfAndSts>\n" +
                "        <TxInfAndSts>\n" +
                "            <StsId>PS202512040000207601</StsId>\n" +
                "            <OrgnlInstrId>20251204KE1011130228</OrgnlInstrId>\n" +
                "            <OrgnlEndToEndId>041602KE1011225399443250</OrgnlEndToEndId>\n" +
                "            <OrgnlTxId>20251204KE1011130228</OrgnlTxId>\n" +
                "            <TxSts>RJCT</TxSts>\n" +
                "            <StsRsnInf>\n" +
                "                <Orgtr>\n" +
                "                    <Id>\n" +
                "                        <OrgId>\n" +
                "                            <Othr>\n" +
                "                                <Id>XA0001</Id>\n" +
                "                            </Othr>\n" +
                "                        </OrgId>\n" +
                "                    </Id>\n" +
                "                </Orgtr>\n" +
                "                <Rsn>\n" +
                "                    <Cd>MS03</Cd>\n" +
                "                </Rsn>\n" +
                "            </StsRsnInf>\n" +
                "            <AccptncDtTm>2025-12-04T13:02:28.131Z</AccptncDtTm>\n" +
                "            <OrgnlTxRef>\n" +
                "                <PmtTpInf>\n" +
                "                    <SvcLvl>\n" +
                "                        <Prtry>INST</Prtry>\n" +
                "                    </SvcLvl>\n" +
                "                    <LclInstrm>\n" +
                "                        <Cd>SSA3</Cd>\n" +
                "                    </LclInstrm>\n" +
                "                    <CtgyPurp>\n" +
                "                        <Cd>CASH</Cd>\n" +
                "                    </CtgyPurp>\n" +
                "                </PmtTpInf>\n" +
                "                <DbtrAgt>\n" +
                "                    <FinInstnId>\n" +
                "                        <BICFI>EQBLKENA</BICFI>\n" +
                "                        <ClrSysMmbId>\n" +
                "                            <MmbId>KE1011</MmbId>\n" +
                "                        </ClrSysMmbId>\n" +
                "                    </FinInstnId>\n" +
                "                </DbtrAgt>\n" +
                "            </OrgnlTxRef>\n" +
                "        </TxInfAndSts>\n" +
                "    </hdr:FIToFIPmtStsRpt>\n" +
                "</hdr:Message>";
    }

    private String composePacs002SuccessACK(String creditTransferXmlRequest) throws ParserConfigurationException, IOException, SAXException {
        String rrn = rrnExtract(creditTransferXmlRequest);

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
                "        <BizMsgIdr>PS202512040000291201</BizMsgIdr>\n" +
                "        <MsgDefIdr>pacs.002.001.07</MsgDefIdr>\n" +
                "        <CreDt>2025-12-04T15:39:43Z</CreDt>\n" +
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
                "                        <DigestValue>h5XCe+SEgQ5aMg06LmhTvYoHywRQIHGT/dxzF1UZ24g=</DigestValue>\n" +
                "                    </Reference>\n" +
                "                </SignedInfo>\n" +
                "                <SignatureValue>qqW6NGQm9/8/g4+7p9Ad9uQEFUqc2i0kbSPNQbB8jr8fwkzFz6YkDGHHrWE916Ni0cNNYaZp8QwS&#13;\n" +
                "e7aRXdCH1Qb8KY+NfIrCiLq9AGCp4U5FtklOMRQZRCwP5FnuHepfWH+19eZQqUyNMdlD1F3xDT9I&#13;\n" +
                "7sae+J4ZZbydDmxg5AVSjEPzGv4YU2cgYaB4Cf7cR2GGuY6+e3JRqFrTzhtofDEnOPCsiZmknfHA&#13;\n" +
                "NwrWurb9QnMMXVnPwJ1Tu9KaM+d67W3mRxLNX1dmZfuUl1WHDy8Hymnn1T/VO2sUyc4GecymmTuG&#13;\n" +
                "X64Eos5iDymqfs96nTBb9sI8Icv4xl7d98npoA==</SignatureValue>\n" +
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
                "            <MsgId>PS202512040000291201</MsgId>\n" +
                "            <CreDtTm>2025-12-04T15:39:43Z</CreDtTm>\n" +
                "            <InstdAgt>\n" +
                "                <FinInstnId>\n" +
                "                    <ClrSysMmbId>\n" +
                "                        <MmbId>KE1011</MmbId>\n" +
                "                    </ClrSysMmbId>\n" +
                "                </FinInstnId>\n" +
                "            </InstdAgt>\n" +
                "        </GrpHdr>\n" +
                "        <OrgnlGrpInfAndSts>\n" +
                "            <OrgnlMsgId>20251204KE1011153935</OrgnlMsgId>\n" +
                "            <OrgnlMsgNmId>pacs.008.001.07</OrgnlMsgNmId>\n" +
                "            <GrpSts>ACSC</GrpSts>\n" +
                "        </OrgnlGrpInfAndSts>\n" +
                "        <TxInfAndSts>\n" +
                "            <StsId>PS202512040000291201</StsId>\n" +
                "            <OrgnlInstrId>20251204KE1011153935</OrgnlInstrId>\n" +
                "            <OrgnlEndToEndId>041839KE1011648627721002</OrgnlEndToEndId>\n" +
                "            <OrgnlTxId>20251204KE1011153935</OrgnlTxId>\n" +
                "            <ChrgsInf>\n" +
                "                <Amt Ccy=\"KES\">280.00</Amt>\n" +
                "                <Agt>\n" +
                "                    <FinInstnId>\n" +
                "                        <ClrSysMmbId>\n" +
                "                            <ClrSysId>\n" +
                "                                <Prtry>PAPSS</Prtry>\n" +
                "                            </ClrSysId>\n" +
                "                            <MmbId>XA0001</MmbId>\n" +
                "                        </ClrSysMmbId>\n" +
                "                    </FinInstnId>\n" +
                "                </Agt>\n" +
                "            </ChrgsInf>\n" +
                "            <AccptncDtTm>2025-12-04T15:39:35.817Z</AccptncDtTm>\n" +
                "            <OrgnlTxRef>\n" +
                "                <IntrBkSttlmAmt Ccy=\"KES\">3000.00</IntrBkSttlmAmt>\n" +
                "                <Amt>\n" +
                "                    <InstdAmt Ccy=\"SLE\">380.48</InstdAmt>\n" +
                "                </Amt>\n" +
                "                <PmtTpInf>\n" +
                "                    <SvcLvl>\n" +
                "                        <Prtry>INST</Prtry>\n" +
                "                    </SvcLvl>\n" +
                "                    <LclInstrm>\n" +
                "                        <Cd>SSA3</Cd>\n" +
                "                    </LclInstrm>\n" +
                "                    <CtgyPurp>\n" +
                "                        <Cd>CASH</Cd>\n" +
                "                    </CtgyPurp>\n" +
                "                </PmtTpInf>\n" +
                "                <DbtrAgt>\n" +
                "                    <FinInstnId>\n" +
                "                        <BICFI>EQBLKENA</BICFI>\n" +
                "                        <ClrSysMmbId>\n" +
                "                            <MmbId>KE1011</MmbId>\n" +
                "                        </ClrSysMmbId>\n" +
                "                    </FinInstnId>\n" +
                "                </DbtrAgt>\n" +
                "            </OrgnlTxRef>\n" +
                "        </TxInfAndSts>\n" +
                "    </hdr:FIToFIPmtStsRpt>\n" +
                "</hdr:Message>";
    }

    private String composePacs002FailureACK(String creditTransferXmlRequest) throws ParserConfigurationException, IOException, SAXException {
        String rrn = rrnExtract(creditTransferXmlRequest);

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
                "        <BizMsgIdr>PS202512040000207601</BizMsgIdr>\n" +
                "        <MsgDefIdr>pacs.002.001.07</MsgDefIdr>\n" +
                "        <CreDt>2025-12-04T13:02:28Z</CreDt>\n" +
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
                "                        <DigestValue>kycGvqQ/lrAALUFxYdZL3dhR77C6ioCSYe41ZUB2qQw=</DigestValue>\n" +
                "                    </Reference>\n" +
                "                </SignedInfo>\n" +
                "                <SignatureValue>iGtQGuztbXjCl8XfLSW6wyogKimTYVvf8RzvbDDy8avSKLAqiizrHqH18O+t9LavUTvhqzRJyfb7&#13;\n" +
                " Swtz/MUVRWBrQov4/2zlg2CGbbLP9YCNomME+jLTJWMIweaZE6K7NTuMyMpSa4nYC8TdYUg95r12&#13;\n" +
                " 0+KT7gX5SA7SBwKqyGIZqalR5BbeFCwQp0efFHKN/GlCKnUYkjUA315ecsTRK1CaIAHl9FMW3JZB&#13;\n" +
                " FmNKxHa+tmrmsneP2xi2WGmjQNBDmX/0DnZ6O8GJ0ZXOG5BHxZYRFTMXyPHV9c9WO/ZLwNumHpYF&#13;\n" +
                " dB/cDV5G18eu8xO/RrMDmtzIDbDDEiiHPrQDlg==</SignatureValue>\n" +
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
                "            <MsgId>PS202512040000207601</MsgId>\n" +
                "            <CreDtTm>2025-12-04T13:02:28Z</CreDtTm>\n" +
                "            <InstdAgt>\n" +
                "                <FinInstnId>\n" +
                "                    <ClrSysMmbId>\n" +
                "                        <MmbId>KE1011</MmbId>\n" +
                "                    </ClrSysMmbId>\n" +
                "                </FinInstnId>\n" +
                "            </InstdAgt>\n" +
                "        </GrpHdr>\n" +
                "        <OrgnlGrpInfAndSts>\n" +
                "            <OrgnlMsgId>20251204KE1011130228</OrgnlMsgId>\n" +
                "            <OrgnlMsgNmId>pacs.008.001.07</OrgnlMsgNmId>\n" +
                "        </OrgnlGrpInfAndSts>\n" +
                "        <TxInfAndSts>\n" +
                "            <StsId>PS202512040000207601</StsId>\n" +
                "            <OrgnlInstrId>20251204KE1011130228</OrgnlInstrId>\n" +
                "            <OrgnlEndToEndId>041602KE1011225399443250</OrgnlEndToEndId>\n" +
                "            <OrgnlTxId>20251204KE1011130228</OrgnlTxId>\n" +
                "            <TxSts>RJCT</TxSts>\n" +
                "            <StsRsnInf>\n" +
                "                <Orgtr>\n" +
                "                    <Id>\n" +
                "                        <OrgId>\n" +
                "                            <Othr>\n" +
                "                                <Id>XA0001</Id>\n" +
                "                            </Othr>\n" +
                "                        </OrgId>\n" +
                "                    </Id>\n" +
                "                </Orgtr>\n" +
                "                <Rsn>\n" +
                "                    <Cd>MS03</Cd>\n" +
                "                </Rsn>\n" +
                "            </StsRsnInf>\n" +
                "            <AccptncDtTm>2025-12-04T13:02:28.131Z</AccptncDtTm>\n" +
                "            <OrgnlTxRef>\n" +
                "                <PmtTpInf>\n" +
                "                    <SvcLvl>\n" +
                "                        <Prtry>INST</Prtry>\n" +
                "                    </SvcLvl>\n" +
                "                    <LclInstrm>\n" +
                "                        <Cd>SSA3</Cd>\n" +
                "                    </LclInstrm>\n" +
                "                    <CtgyPurp>\n" +
                "                        <Cd>CASH</Cd>\n" +
                "                    </CtgyPurp>\n" +
                "                </PmtTpInf>\n" +
                "                <DbtrAgt>\n" +
                "                    <FinInstnId>\n" +
                "                        <BICFI>EQBLKENA</BICFI>\n" +
                "                        <ClrSysMmbId>\n" +
                "                            <MmbId>KE1011</MmbId>\n" +
                "                        </ClrSysMmbId>\n" +
                "                    </FinInstnId>\n" +
                "                </DbtrAgt>\n" +
                "            </OrgnlTxRef>\n" +
                "        </TxInfAndSts>\n" +
                "    </hdr:FIToFIPmtStsRpt>\n" +
                "</hdr:Message>";
    }

    private String composeSuccess() {
        return "<hdr:Message\n" +
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
                "                        <MmbId>GM1001</MmbId>\n" +
                "                    </ClrSysMmbId>\n" +
                "                </FinInstnId>\n" +
                "            </FIId>\n" +
                "        </Fr>\n" +
                "        <To>\n" +
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
                "        </To>\n" +
                "        <BizMsgIdr>M20201022GM100166874699</BizMsgIdr>\n" +
                "        <MsgDefIdr>acmt.024.001.02</MsgDefIdr>\n" +
                "        <BizSvc>RTP</BizSvc>\n" +
                "        <CreDt>2020-10-22T11:41:14Z</CreDt>\n" +
                "    </hdr:AppHdr>\n" +
                "    <hdr:IdVrfctnRpt\n" +
                "        xmlns=\"urn:iso:std:iso:20022:tech:xsd:acmt.024.001.02\">\n" +
                "        <Assgnmt>\n" +
                "            <MsgId>M20201022GM100166874699</MsgId>\n" +
                "            <CreDtTm>2020-10-22T14:41:14+03:00</CreDtTm>\n" +
                "            <Assgnr>\n" +
                "                <Agt>\n" +
                "                    <FinInstnId>\n" +
                "                        <BICFI>CBGIGMBJ</BICFI>\n" +
                "                        <ClrSysMmbId>\n" +
                "                            <ClrSysId>\n" +
                "                                <Prtry>PAPSS</Prtry>\n" +
                "                            </ClrSysId>\n" +
                "                            <MmbId>GM1001</MmbId>\n" +
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
                "                            <MmbId>GN1001</MmbId>\n" +
                "                        </ClrSysMmbId>\n" +
                "                    </FinInstnId>\n" +
                "                </Agt>\n" +
                "            </Assgne>\n" +
                "        </Assgnmt>\n" +
                "        <OrgnlAssgnmt>\n" +
                "            <MsgId>CT0202010140000035401</MsgId>\n" +
                "        </OrgnlAssgnmt>\n" +
                "        <Rpt>\n" +
                "            <OrgnlId>20201022GN100166871226</OrgnlId>\n" +
                "            <Vrfctn>true</Vrfctn>\n" +
                "            <OrgnlPtyAndAcctId>\n" +
                "                <Acct>\n" +
                "                    <Othr>\n" +
                "                        <Id>SLL116030003</Id>\n" +
                "                        <SchmeNm>\n" +
                "                            <Cd>BBAN</Cd>\n" +
                "                        </SchmeNm>\n" +
                "                    </Othr>\n" +
                "                </Acct>\n" +
                "            </OrgnlPtyAndAcctId>\n" +
                "            <UpdtdPtyAndAcctId>\n" +
                "                <Pty>\n" +
                "                    <Nm>Michael Brown</Nm>\n" +
                "                </Pty>\n" +
                "\t\t\t\t<CtctDtls> \n" +
                "\t\t\t\t\t<EmailAdr>agadas@gmail.com</EmailAdr> \n" +
                "\t\t\t\t</CtctDtls>\n" +
                "                <Acct>\n" +
                "                    <IBAN>GM9739217549120</IBAN>\n" +
                "                </Acct>\n" +
                "                <Agt>\n" +
                "                    <FinInstnId>\n" +
                "                        <ClrSysMmbId>\n" +
                "                            <ClrSysId>\n" +
                "                                <Prtry>PAPSS</Prtry>\n" +
                "                            </ClrSysId>\n" +
                "                            <MmbId>GM1001</MmbId>\n" +
                "                        </ClrSysMmbId>\n" +
                "                    </FinInstnId>\n" +
                "                </Agt>\n" +
                "            </UpdtdPtyAndAcctId>\n" +
                "        </Rpt>\n" +
                "    </hdr:IdVrfctnRpt>\n" +
                "</hdr:Message>";
    }

    private String invalidSignatureResponse() {
        return "<hdr:Message\n" +
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
                "                        <MmbId>GM100001</MmbId>\n" +
                "                    </ClrSysMmbId>\n" +
                "                </FinInstnId>\n" +
                "            </FIId>\n" +
                "        </Fr>\n" +
                "        <To>\n" +
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
                "        </To>\n" +
                "        <BizMsgIdr>20211221GM100001163749000275</BizMsgIdr>\n" +
                "        <MsgDefIdr>acmt.024.001.02</MsgDefIdr>\n" +
                "        <BizSvc>RTP</BizSvc>\n" +
                "        <CreDt>2021-12-21T16:37:49Z</CreDt>\n" +
                "    </hdr:AppHdr>\n" +
                "    <hdr:IdVrfctnRpt\n" +
                "        xmlns=\"urn:iso:std:iso:20022:tech:xsd:acmt.024.001.02\">\n" +
                "        <Assgnmt>\n" +
                "            <MsgId>20211221GM100001163749000275</MsgId>\n" +
                "            <CreDtTm>2021-12-21T16:37:59Z</CreDtTm>\n" +
                "            <Assgnr>\n" +
                "                <Agt>\n" +
                "                    <FinInstnId>\n" +
                "                        <BICFI>CBGAGMGM</BICFI>\n" +
                "                        <ClrSysMmbId>\n" +
                "                            <ClrSysId>\n" +
                "                                <Prtry>PAPSS</Prtry>\n" +
                "                            </ClrSysId>\n" +
                "                            <MmbId>GM100001</MmbId>\n" +
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
                "                            <MmbId>LR100001</MmbId>\n" +
                "                        </ClrSysMmbId>\n" +
                "                    </FinInstnId>\n" +
                "                </Agt>\n" +
                "            </Assgne>\n" +
                "        </Assgnmt>\n" +
                "        <OrgnlAssgnmt>\n" +
                "            <MsgId>CT0202112210000006001</MsgId>\n" +
                "        </OrgnlAssgnmt>\n" +
                "        <Rpt>\n" +
                "            <OrgnlId>20211221LR100001163856</OrgnlId>\n" +
                "            <Vrfctn>false</Vrfctn>\n" +
                "            <Rsn>\n" +
                "                <Cd>3003</Cd>\n" +
                "            </Rsn>\n" +
                "            <OrgnlPtyAndAcctId>\n" +
                "                <Acct>\n" +
                "                    <Othr>\n" +
                "                        <Id>GMD140050001</Id>\n" +
                "                        <SchmeNm>\n" +
                "                            <Cd>BBAN</Cd>\n" +
                "                        </SchmeNm>\n" +
                "                    </Othr>\n" +
                "                </Acct>\n" +
                "            </OrgnlPtyAndAcctId>\n" +
                "        </Rpt>\n" +
                "    </hdr:IdVrfctnRpt>\n" +
                "</hdr:Message>";
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


    public void sleepFor5Seconds() {
        try {
            Thread.sleep(5_000); // 5 seconds = 5,000 milliseconds
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt(); // restore interrupt status
            System.err.println("Thread was interrupted during sleep: " + e.getMessage());
        }
    }
}
