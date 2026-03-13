package com.papss.middleware.dto.nameinquiry.response;

import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class NameInquiryResponseDtosTest {

    @Test
    void responseDtos_buildersAndAccessors() {
        NameInquiryResponseSender sender = NameInquiryResponseSender.builder()
                .instId("S1").build();
        NameInquiryResponseReceiver receiver = NameInquiryResponseReceiver.builder()
                .instId("R1").accountNumber("123").accountName("John").emailAddress("a@b.com").build();

        NameInquiryResponse resp = NameInquiryResponse.builder()
                .tranRef("T1").endToEndRef("E2E")
                .sender(sender).receiver(receiver)
                .status(new Status("SUCCESS","200","OK"))
                .build();

        assertThat(resp.getReceiver().getAccountName()).isEqualTo("John");
        assertThat(resp.getStatus().getCode()).isEqualTo("200");
    }

    @Test
    void nameInquiryResponseDto_accessors() throws Exception {
        NameInquiryResponseDto dto = new NameInquiryResponseDto();
        dto.setTranRef("TR");
        dto.setInstId("INST");
        dto.setAccountNumber("123");
        dto.setAccountName("John");
        dto.setEmailAddress("a@b.com");
        dto.setStatus(new Status("SUCCESS","200","OK"));
        assertThat(dto.getInstId()).isEqualTo("INST");
        assertThat(dto.getStatus().getType()).isEqualTo("SUCCESS");
    }
}
