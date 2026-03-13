package com.papss.middleware.dto.paymentreturn;

import com.papss.middleware.service.outbound.domains.credittransfer.TransferDetails;
import org.junit.jupiter.api.Test;

import java.math.BigDecimal;

import static org.assertj.core.api.Assertions.assertThat;

class PaymentRecallDtoTest {

    @Test
    void builderAndAccessors_work() {
        TransferDetails sender = new TransferDetails();
        TransferDetails receiver = new TransferDetails();

        PaymentRecallDto dto = PaymentRecallDto.builder()
                .settlementType("ST")
                .transactionDate("2025-01-01")
                .toClearingSystemId("CS")
                .originalEndToEndRef("E2E")
                .reasonCode("R")
                .amount(new BigDecimal("10.00"))
                .sender(sender)
                .receiver(receiver)
                .narration("Narr")
                .build();

        assertThat(dto.getReasonCode()).isEqualTo("R");
        assertThat(dto.getAmount()).isEqualTo(new BigDecimal("10.00"));
        assertThat(dto.getSender()).isNotNull();
    }
}
