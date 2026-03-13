package com.papss.middleware.utils;

import com.papss.middleware.dto.PaymentReturnDto;
import com.papss.middleware.entities.Transaction;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class TransactionParserTest {

    @Test
    void parseXMLToTransaction_returnsNonNullDefaultTransaction() {
        Transaction t = TransactionParser.parseXMLToTransaction("<any/>");
        assertNotNull(t);
        // current implementation returns a new Transaction with default fields
        assertNull(t.getEndToEndId());
    }

    @Test
    void paymentReturn_parsesMinimalXml() {
        String xml = "" +
                "<Envelope xmlns='urn:test'>" +
                "  <AppHdr>" +
                "    <Fr><FIId><FinInstnId><Othr><Id>FROM</Id></Othr></FinInstnId></FIId></Fr>" +
                "    <To><FIId><FinInstnId><BICFI>TOBIC</BICFI><Othr><Id>TO</Id></Othr></FinInstnId></FIId></To>" +
                "    <BizMsgIdr>MSGID</BizMsgIdr>" +
                "    <MsgDefIdr>pacs.004</MsgDefIdr>" +
                "    <CreDt>2025-01-01T00:00:00Z</CreDt>" +
                "  </AppHdr>" +
                "  <PmtRtr>" +
                "    <GrpHdr>" +
                "      <MsgId>GRPMSG</MsgId>" +
                "      <NbOfTxs>1</NbOfTxs>" +
                "      <TtlRtrdIntrBkSttlmAmt Ccy='USD'>100.00</TtlRtrdIntrBkSttlmAmt>" +
                "      <IntrBkSttlmDt>2025-01-02</IntrBkSttlmDt>" +
                "    </GrpHdr>" +
                "    <TxInf>" +
                "      <RtrId>RET1</RtrId>" +
                "      <OrgnlMsgId>OMSG</OrgnlMsgId>" +
                "      <OrgnlEndToEndId>OE2E</OrgnlEndToEndId>" +
                "      <OrgnlTxId>OTX</OrgnlTxId>" +
                "      <OrgnlIntrBkSttlmAmt>50.00</OrgnlIntrBkSttlmAmt>" +
                "      <RtrdIntrBkSttlmAmt>45.00</RtrdIntrBkSttlmAmt>" +
                "      <RtrRsnInf><Rsn><Cd>DUPL</Cd></Rsn></RtrRsnInf>" +
                "      <Dbtr><Nm>John D</Nm></Dbtr>" +
                "      <DbtrAcct><Id><Othr><Id>DBTR-ACC</Id></Othr></Id></DbtrAcct>" +
                "      <Cdtr><Nm>Jane C</Nm></Cdtr>" +
                "      <CdtrAcct><Id><Othr><Id>CDTR-ACC</Id></Othr></Id></CdtrAcct>" +
                "    </TxInf>" +
                "  </PmtRtr>" +
                "</Envelope>";

        PaymentReturnDto dto = TransactionParser.paymentReturn(xml);
        assertNotNull(dto);
        assertEquals("MSGID", dto.getBizMsgId());
        assertEquals("pacs.004", dto.getMsgDefId());
        assertEquals("FROM", dto.getFromMemberId());
        assertEquals("TOBIC", dto.getToBic());
        assertEquals("TO", dto.getToMemberId());

        assertEquals("GRPMSG", dto.getGroupMsgId());
        assertEquals("1", dto.getNbOfTxs());
        assertEquals("100.00", dto.getTotalAmount());
        assertEquals("USD", dto.getCurrency());
        assertEquals("2025-01-02", dto.getSettlementDate());

        assertEquals("RET1", dto.getReturnId());
        assertEquals("OMSG", dto.getOriginalMsgId());
        assertEquals("OE2E", dto.getOriginalEndToEndId());
        assertEquals("OTX", dto.getOriginalTxId());
        assertEquals("50.00", dto.getOriginalAmount());
        assertEquals("45.00", dto.getReturnedAmount());
        assertEquals("DUPL", dto.getReturnReason());
        assertEquals("John D", dto.getDebtorName());
        assertEquals("DBTR-ACC", dto.getDebtorAccount());
        assertEquals("Jane C", dto.getCreditorName());
        assertEquals("CDTR-ACC", dto.getCreditorAccount());
    }
}
