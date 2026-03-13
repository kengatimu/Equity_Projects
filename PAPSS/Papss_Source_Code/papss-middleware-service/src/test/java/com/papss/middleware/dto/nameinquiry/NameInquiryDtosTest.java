package com.papss.middleware.dto.nameinquiry;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class NameInquiryDtosTest {

    @Test
    void senderReceiverAndDto_buildersAndAccessors() {
        NameInquirySender sender = NameInquirySender.builder()
                .instId("S1")
                .instBic("SBIC")
                .build();

        NameInquiryReceiver receiver = NameInquiryReceiver.builder()
                .instId("R1")
                .instBic("RBIC")
                .accountNumber("123456")
                .build();

        NameInquiryDto dto = NameInquiryDto.builder()
                .transRef("T1")
                .tranDateTime("2025-01-01T00:00:00Z")
                .instId("INST")
                .sender(sender)
                .receiver(receiver)
                .build();

        assertThat(dto.getSender().getInstId()).isEqualTo("S1");
        assertThat(dto.getReceiver().getAccountNumber()).isEqualTo("123456");
        assertThat(dto.getTransRef()).isEqualTo("T1");
    }
}
