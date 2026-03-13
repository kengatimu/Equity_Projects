package com.papss.middleware.controller;

import com.papss.middleware.config.ParticipantsConfig;
import com.papss.middleware.dto.nameinquiry.response.NameInquiryResponse;
import com.papss.middleware.models.Participant;
import com.papss.middleware.service.outbound.NameEnquiryService;
import com.papss.middleware.service.outbound.domains.nameenquiry.NameInquiryRequest;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class NameEnquiryControllerTest {

    @Mock private ParticipantsConfig participantsConfig;
    @Mock private NameEnquiryService nameEnquiryService;

    @InjectMocks private NameEnquiryController controller;

    private Participant participant;

    @BeforeEach
    void setUp() {
        participant = new Participant();
        participant.setInstId("INST1");
    }

    @Test
    void nameInquiry_shouldDelegateAndReturn() throws Exception {
        String papssId = "PAPSS";
        String apiKey = "KEY";
        NameInquiryRequest req = new NameInquiryRequest();
        NameInquiryResponse expected = NameInquiryResponse.builder().build();

        when(participantsConfig.getParticipantConfig(papssId)).thenReturn(participant);
        doNothing().when(participantsConfig).validateParticipantByApiKey(apiKey, participant);
        when(nameEnquiryService.sendNameInquiryMessage(eq(req), eq("INST1"), eq(participant))).thenReturn(expected);

        NameInquiryResponse resp = controller.nameInquiry(papssId, apiKey, req);
        assertThat(resp).isEqualTo(expected);
        verify(nameEnquiryService).sendNameInquiryMessage(eq(req), eq("INST1"), eq(participant));
    }
}
