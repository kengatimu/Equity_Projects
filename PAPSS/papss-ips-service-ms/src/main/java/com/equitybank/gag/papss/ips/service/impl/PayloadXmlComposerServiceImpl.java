package com.equitybank.gag.papss.ips.service.impl;

import com.equitybank.gag.papss.ips.service.PayloadXmlComposerService;
import com.equitybank.gag.papss.ips.pojo.channelRequest.namecheck.ChannelNamecheckDetailsReq;
import com.equitybank.gag.papss.ips.pojo.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ips.service.DateService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PayloadXmlComposerServiceImpl implements PayloadXmlComposerService {
    private static final Logger log = LoggerFactory.getLogger(PayloadXmlComposerServiceImpl.class);

    private final DateService dateService;

    @Autowired
    public PayloadXmlComposerServiceImpl(DateService dateService) {
        this.dateService = dateService;
    }

    @Override
    public String composeAcmt023NamecheckRequest(ChannelNamecheckDetailsReq channelNamecheckDetailsReq) {
        String currentIsoDateTime = dateService.getCurrentIsoDateAndTime();

        String senderInstitutionId = channelNamecheckDetailsReq.getSender().getInstitutionId();
        String senderBic = channelNamecheckDetailsReq.getSender().getBic();
        String receiverInstitutionId = channelNamecheckDetailsReq.getReceiver().getInstitutionId();
        String receiverBic = channelNamecheckDetailsReq.getReceiver().getBic();
        String receiverAccount = channelNamecheckDetailsReq.getReceiver().getAccountNumber();
        String rrn = channelNamecheckDetailsReq.getChannelInfo().getRrn();

        return "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n" +
                "<hdr:Message xmlns:hdr=\"urn:montran:message.01\">\n" +
                "    <hdr:AppHdr xmlns=\"urn:iso:std:iso:20022:tech:xsd:head.001.001.01\">\n" +
                "        <Fr>\n" +
                "            <FIId>\n" +
                "                <FinInstnId>\n" +
                "                    <ClrSysMmbId>\n" +
                "                        <ClrSysId>\n" +
                "                            <Prtry>PAPSS</Prtry>\n" +
                "                        </ClrSysId>\n" +
                "                        <MmbId>" + senderInstitutionId + "</MmbId>\n" +
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
                "                        <MmbId>" + receiverInstitutionId + "</MmbId>\n" +
                "                    </ClrSysMmbId>\n" +
                "                </FinInstnId>\n" +
                "            </FIId>\n" +
                "        </To>\n" +
                "        <BizMsgIdr>" + rrn + "</BizMsgIdr>\n" +
                "        <MsgDefIdr>acmt.023.001.02</MsgDefIdr>\n" +
                "        <BizSvc>RTP</BizSvc>\n" +
                "        <CreDt>" + currentIsoDateTime + "</CreDt>\n" +
                "    </hdr:AppHdr>\n" +
                "    <hdr:IdVrfctnReq xmlns=\"urn:iso:std:iso:20022:tech:xsd:acmt.023.001.02\">\n" +
                "        <Assgnmt>\n" +
                "            <MsgId>" + rrn + "</MsgId>\n" +
                "            <CreDtTm>" + currentIsoDateTime + "</CreDtTm>\n" +
                "            <Assgnr>\n" +
                "                <Agt>\n" +
                "                    <FinInstnId>\n" +
                "                        <BICFI>" + senderBic + "</BICFI>\n" +
                "                        <ClrSysMmbId>\n" +
                "                            <ClrSysId>\n" +
                "                                <Prtry>PAPSS</Prtry>\n" +
                "                            </ClrSysId>\n" +
                "                            <MmbId>" + senderInstitutionId + "</MmbId>\n" +
                "                        </ClrSysMmbId>\n" +
                "                    </FinInstnId>\n" +
                "                </Agt>\n" +
                "            </Assgnr>\n" +
                "            <Assgne>\n" +
                "                <Agt>\n" +
                "                    <FinInstnId>\n" +
                "                        <BICFI>" + receiverBic + "</BICFI>\n" +
                "                        <ClrSysMmbId>\n" +
                "                            <ClrSysId>\n" +
                "                                <Prtry>PAPSS</Prtry>\n" +
                "                            </ClrSysId>\n" +
                "                            <MmbId>" + receiverInstitutionId + "</MmbId>\n" +
                "                        </ClrSysMmbId>\n" +
                "                    </FinInstnId>\n" +
                "                </Agt>\n" +
                "            </Assgne>\n" +
                "        </Assgnmt>\n" +
                "        <Vrfctn>\n" +
                "            <Id>" + rrn + "</Id>\n" +
                "            <PtyAndAcctId>\n" +
                "                <Acct>\n" +
                "                    <Othr>\n" +
                "                        <Id>" + receiverAccount + "</Id>\n" +
                "                        <SchmeNm>\n" +
                "                            <Cd>BBAN</Cd>\n" +
                "                        </SchmeNm>\n" +
                "                    </Othr>\n" +
                "                </Acct>\n" +
                "            </PtyAndAcctId>\n" +
                "        </Vrfctn>\n" +
                "    </hdr:IdVrfctnReq>\n" +
                "</hdr:Message>";
    }

    @Override
    public String composePacs008TransactionRequest(ChannelCreditTransferDetailsReq req) {
        String currentIsoDateTime = dateService.getCurrentIsoDateAndTime();
        String currentIsoDateOnly = dateService.getCurrentIsoDateOnly();

        // Extracting sender values
        String senderInstitutionId = req.getSender().getInstitutionId();
        String senderBic = req.getSender().getBic();
        String sourceCurrency = req.getSender().getCurrency();
        String senderAccountName = req.getSender().getAccountName();
        String senderCountryCode = req.getSender().getCountryCode();
        String senderAddress = req.getSender().getAddress();
        String senderAccountNumber = req.getSender().getAccountNumber();

        // Extracting receiver values
        String receiverInstitutionId = req.getReceiver().getInstitutionId();
        String receiverBic = req.getReceiver().getBic();
        String receiverAccountName = req.getReceiver().getAccountName();
        String receiverCountryCode = req.getReceiver().getCountryCode();
        String receiverEmailAddress = req.getReceiver().getEmailAddress();
        String receiverAccountNumber = req.getReceiver().getAccountNumber();
        String receiverCurrency = req.getReceiver().getCurrency();

        // Extracting transaction info
        String amount = req.getTransactionInfo().getAmount();
        String narration = req.getTransactionInfo().getNarration();

        // Extracting channel info
        String rrn = req.getChannelInfo().getRrn();
        String endToEndId = dateService.getEndToEndId(rrn, senderInstitutionId, receiverInstitutionId);

        String pacs008RequestXml = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n" +
                "<hdr:Message xmlns:hdr=\"urn:montran:message.01\">\n" +
                "    <hdr:AppHdr xmlns=\"urn:iso:std:iso:20022:tech:xsd:head.001.001.01\">\n" +
                "        <Fr>\n" +
                "            <FIId>\n" +
                "                <FinInstnId>\n" +
                "                    <ClrSysMmbId>\n" +
                "                        <ClrSysId>\n" +
                "                            <Prtry>PAPSS</Prtry>\n" +
                "                        </ClrSysId>\n" +
                "                        <MmbId>" + senderInstitutionId + "</MmbId>\n" +
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
                "                        <MmbId>" + receiverInstitutionId + "</MmbId>\n" +
                "                    </ClrSysMmbId>\n" +
                "                </FinInstnId>\n" +
                "            </FIId>\n" +
                "        </To>\n" +
                "        <BizMsgIdr>" + rrn + "</BizMsgIdr>\n" +
                "        <MsgDefIdr>pacs.008.001.07</MsgDefIdr>\n" +
                "        <BizSvc>RTP</BizSvc>\n" +
                "        <CreDt>" + currentIsoDateTime + "</CreDt>\n" +
                "    </hdr:AppHdr>\n" +
                "    <hdr:FIToFICstmrCdtTrf xmlns=\"urn:iso:std:iso:20022:tech:xsd:pacs.008.001.07\">\n" +
                "        <GrpHdr>\n" +
                "            <MsgId>" + rrn + "</MsgId>\n" +
                "            <CreDtTm>" + currentIsoDateTime + "</CreDtTm>\n" +
                "            <NbOfTxs>1</NbOfTxs>\n" +
                "            <TtlIntrBkSttlmAmt Ccy=\"" + receiverCurrency + "\">" + amount + "</TtlIntrBkSttlmAmt>\n" +
                "            <IntrBkSttlmDt>" + currentIsoDateOnly + "</IntrBkSttlmDt>\n" +
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
                "                    <Cd>ET</Cd>\n" +
                "                </LclInstrm>\n" +
                "                <CtgyPurp>\n" +
                "                    <Cd>SUPP</Cd>\n" +
                "                </CtgyPurp>\n" +
                "            </PmtTpInf>\n" +
                "            <InstgAgt>\n" +
                "                <FinInstnId>\n" +
                "                    <BICFI>" + senderBic + "</BICFI>\n" +
                "                    <ClrSysMmbId>\n" +
                "                        <ClrSysId>\n" +
                "                            <Prtry>PAPSS</Prtry>\n" +
                "                        </ClrSysId>\n" +
                "                        <MmbId>" + senderInstitutionId + "</MmbId>\n" +
                "                    </ClrSysMmbId>\n" +
                "                </FinInstnId>\n" +
                "            </InstgAgt>\n" +
                "        </GrpHdr>\n" +
                "        <CdtTrfTxInf>\n" +
                "            <PmtId>\n" +
                "                <InstrId>" + rrn + "</InstrId>\n" +
                "                <EndToEndId>" + endToEndId + "</EndToEndId>\n" +
                "                <TxId>" + rrn + "</TxId>\n" +
                "            </PmtId>\n" +
                "            <IntrBkSttlmAmt Ccy=\"" + receiverCurrency + "\">" + amount + "</IntrBkSttlmAmt>\n" +
                "            <AccptncDtTm>" + currentIsoDateTime + "</AccptncDtTm>\n" +
                "            <InstdAmt Ccy=\"" + sourceCurrency + "\"/>\n" +
                "            <XchgRate>1</XchgRate>\n" +
                "            <ChrgBr>SLEV</ChrgBr>\n" +
                "            <UltmtDbtr>\n" +
                "                <Nm>" + senderAccountName + "</Nm>\n" +
                "            </UltmtDbtr>\n" +
                "            <Dbtr>\n" +
                "                <Nm>" + senderAccountName + "</Nm>\n" +
                "                <PstlAdr>\n" +
                "                    <Ctry>" + senderCountryCode + "</Ctry>\n" +
                "                    <AdrLine>" + senderAddress + "</AdrLine>\n" +
                "                </PstlAdr>\n" +
                "            </Dbtr>\n" +
                "            <DbtrAcct>\n" +
                "                <Id>\n" +
                "                    <Othr>\n" +
                "                        <Id>" + senderAccountNumber + "</Id>\n" +
                "                        <SchmeNm>\n" +
                "                            <Cd>BBAN</Cd>\n" +
                "                        </SchmeNm>\n" +
                "                    </Othr>\n" +
                "                </Id>\n" +
                "            </DbtrAcct>\n" +
                "            <DbtrAgt>\n" +
                "                <FinInstnId>\n" +
                "                    <BICFI>" + senderBic + "</BICFI>\n" +
                "                    <ClrSysMmbId>\n" +
                "                        <MmbId>" + senderInstitutionId + "</MmbId>\n" +
                "                    </ClrSysMmbId>\n" +
                "                </FinInstnId>\n" +
                "            </DbtrAgt>\n" +
                "            <CdtrAgt>\n" +
                "                <FinInstnId>\n" +
                "                    <BICFI>" + receiverBic + "</BICFI>\n" +
                "                    <ClrSysMmbId>\n" +
                "                        <ClrSysId>\n" +
                "                            <Prtry>PAPSS</Prtry>\n" +
                "                        </ClrSysId>\n" +
                "                        <MmbId>" + receiverInstitutionId + "</MmbId>\n" +
                "                    </ClrSysMmbId>\n" +
                "                </FinInstnId>\n" +
                "            </CdtrAgt>\n" +
                "            <Cdtr>\n" +
                "                <Nm>" + receiverAccountName + "</Nm>\n" +
                "                <PstlAdr>\n" +
                "                    <Ctry>" + receiverCountryCode + "</Ctry>\n" +
                "                    <AdrLine>" + receiverEmailAddress + "</AdrLine>\n" +
                "                </PstlAdr>\n" +
                "            </Cdtr>\n" +
                "            <CdtrAcct>\n" +
                "                <Id>\n" +
                "                    <Othr>\n" +
                "                        <Id>" + receiverAccountNumber + "</Id>\n" +
                "                        <SchmeNm>\n" +
                "                            <Cd>BBAN</Cd>\n" +
                "                        </SchmeNm>\n" +
                "                    </Othr>\n" +
                "                </Id>\n" +
                "            </CdtrAcct>\n" +
                "    <UltmtCdtr>\n" +
                "        <Nm>" + receiverAccountName + "</Nm>\n" +
                "        <CtryOfRes>" + receiverCountryCode + "</CtryOfRes>\n" +
                "        <CtctDtls>\n" +
                "            <EmailAdr>" + receiverEmailAddress + "</EmailAdr>\n" +
                "        </CtctDtls>\n" +
                "    </UltmtCdtr>\n" +
                "    <RmtInf>\n" +
                "        <Ustrd>" + narration + "</Ustrd>\n" +
                "    </RmtInf>\n" +
                "        </CdtTrfTxInf>\n" +
                "        <SplmtryData>\n" +
                "            <Envlp>\n" +
                "                <AuditInfo>\n" +
                "                    <IP>10.77.7.13</IP>\n" +
                "                    <PC>vi-papss</PC>\n" +
                "                </AuditInfo>\n" +
                "            </Envlp>\n" +
                "        </SplmtryData>\n" +
                "    </hdr:FIToFICstmrCdtTrf>\n" +
                "</hdr:Message>";

//        log.info("{}: Generated Pacs.008 Credit Transfer Request: {}", rrn, pacs008RequestXml);
        return pacs008RequestXml;
    }
}
