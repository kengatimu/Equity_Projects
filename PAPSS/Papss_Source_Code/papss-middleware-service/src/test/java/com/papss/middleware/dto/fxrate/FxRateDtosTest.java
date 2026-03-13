package com.papss.middleware.dto.fxrate;

import com.papss.middleware.dto.fxrate.response.FxRate;
import com.papss.middleware.dto.fxrate.response.FxRateData;
import com.papss.middleware.dto.fxrate.response.FxRateResponse;
import com.papss.middleware.dto.fxrate.response.PostFxRateResponse;
import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.assertj.core.api.Assertions.assertThat;

class FxRateDtosTest {

    @Test
    void senderReceiverAndGetFxRateDto_work() {
        FxRateSender sender = new FxRateSender();
        sender.setInstId("S1");
        sender.setCountry("GH");
        sender.setCurrency("GHS");

        FxRateReceiver receiver = new FxRateReceiver();
        receiver.setInstId("R1");
        receiver.setCountry("NG");
        receiver.setCurrency("NGN");

        GetFxRateDto dto = new GetFxRateDto();
        dto.setLocalInstrumentType("ET");
        dto.setAmount(new BigDecimal("100.00"));
        dto.setIsInvoice(Boolean.TRUE);
        dto.setSender(sender);
        dto.setReceiver(receiver);

        assertThat(dto.getSender().getInstId()).isEqualTo("S1");
        assertThat(dto.getReceiver().getCurrency()).isEqualTo("NGN");
        assertThat(dto.getLocalInstrumentType()).isEqualTo("ET");
    }

    @Test
    void postFxRateDto_andResponses_work() {
        PostFxRateDto dto = new PostFxRateDto();
        dto.setInstId("INST");
        dto.setAccountType("ACC");
        dto.setBuyRate(new BigDecimal("1.23"));
        dto.setSellRate(new BigDecimal("1.25"));
        dto.setCountryCode("GH");
        dto.setLocalCurrency("GHS");
        dto.setFxRateName("RATE1");

        assertThat(dto.getSellRate()).isEqualTo(new BigDecimal("1.25"));

        // FxRateResponse with numeric fields
        FxRateResponse resp = new FxRateResponse();
        resp.setUsdToSenderCurrencyRate(new BigDecimal("1.0"));
        resp.setUsdToReceiverCurrencyRate(new BigDecimal("2.0"));
        resp.setSenderToReceiverCurrencyRate(new BigDecimal("3.0"));
        resp.setSenderAmount(new BigDecimal("10"));
        resp.setReceiverAmount(new BigDecimal("20"));
        resp.setExchangeAmount(new BigDecimal("30"));
        resp.setNationalFeeAmount(new BigDecimal("0.5"));
        resp.setFeeAmount(new BigDecimal("0.4"));
        resp.setTime("now");
        assertThat(resp.getReceiverAmount()).isEqualTo(new BigDecimal("20"));

        // FxRate and FxRateData
        FxRate fx = new FxRate("GHS","USD","1.1","1.2","2025-01-01","SAV","N","GH");
        FxRateData data = new FxRateData(fx);
        assertThat(data.getFxRate().getSellRate()).isEqualTo("1.2");

        // PostFxRateResponse builder
        PostFxRateResponse p = PostFxRateResponse.builder()
                .tranRef("T1")
                .tranDateTime("2025-01-01T00:00:00Z")
                .fxRateName("RATE1")
                .status(new Status("SUCCESS","200","OK"))
                .build();
        assertThat(p.getFxRateName()).isEqualTo("RATE1");
    }
}
