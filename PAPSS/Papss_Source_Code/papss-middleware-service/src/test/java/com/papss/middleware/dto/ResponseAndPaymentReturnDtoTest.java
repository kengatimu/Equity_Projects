package com.papss.middleware.dto;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class ResponseAndPaymentReturnDtoTest {

    @Test
    void responseDto_constructorsAndAccessorsWork() {
        ResponseDto noArgs = new ResponseDto();
        noArgs.setStatus(true);
        noArgs.setMessage("ok");
        noArgs.setData(123);
        assertThat(noArgs.isStatus()).isTrue();
        assertThat(noArgs.getMessage()).isEqualTo("ok");
        assertThat(noArgs.getData()).isEqualTo(123);

        ResponseDto twoArgs = new ResponseDto(true, "msg");
        assertThat(twoArgs.isStatus()).isTrue();
        assertThat(twoArgs.getMessage()).isEqualTo("msg");

        ResponseDto threeArgs = new ResponseDto(false, "err", "data");
        assertThat(threeArgs.isStatus()).isFalse();
        assertThat(threeArgs.getMessage()).isEqualTo("err");
        assertThat(threeArgs.getData()).isEqualTo("data");

        ResponseDto statusAndData = new ResponseDto(true, 42);
        assertThat(statusAndData.isStatus()).isTrue();
        assertThat(statusAndData.getData()).isEqualTo(42);
    }

    @Test
    void paymentReturnDto_gettersSettersAndEquality() {
        PaymentReturnDto a = new PaymentReturnDto();
        a.setBizMsgId("B1");
        a.setMsgDefId("MDI");
        a.setCreationDate("2025-01-01");
        a.setFromMemberId("FROM");
        a.setToBic("TOBIC");
        a.setToMemberId("TO");
        a.setGroupMsgId("G");
        a.setNbOfTxs("2");
        a.setTotalAmount("100");
        a.setCurrency("USD");
        a.setSettlementDate("2025-01-02");
        a.setReturnId("RID");
        a.setOriginalMsgId("OMID");
        a.setOriginalEndToEndId("E2E");
        a.setOriginalTxId("OTX");
        a.setOriginalAmount("90");
        a.setReturnedAmount("10");
        a.setReturnReason("RR");
        a.setDebtorName("DN");
        a.setDebtorAccount("DA");
        a.setCreditorName("CN");
        a.setCreditorAccount("CA");

        PaymentReturnDto b = new PaymentReturnDto();
        b.setBizMsgId("B1");
        b.setMsgDefId("MDI");
        b.setCreationDate("2025-01-01");
        b.setFromMemberId("FROM");
        b.setToBic("TOBIC");
        b.setToMemberId("TO");
        b.setGroupMsgId("G");
        b.setNbOfTxs("2");
        b.setTotalAmount("100");
        b.setCurrency("USD");
        b.setSettlementDate("2025-01-02");
        b.setReturnId("RID");
        b.setOriginalMsgId("OMID");
        b.setOriginalEndToEndId("E2E");
        b.setOriginalTxId("OTX");
        b.setOriginalAmount("90");
        b.setReturnedAmount("10");
        b.setReturnReason("RR");
        b.setDebtorName("DN");
        b.setDebtorAccount("DA");
        b.setCreditorName("CN");
        b.setCreditorAccount("CA");

        assertThat(a).isEqualTo(b);
        assertThat(a.hashCode()).isEqualTo(b.hashCode());
        assertThat(a.toString()).contains("B1");
    }
}
