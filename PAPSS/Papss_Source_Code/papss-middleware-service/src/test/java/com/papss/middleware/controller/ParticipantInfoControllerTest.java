package com.papss.middleware.controller;

import com.papss.middleware.config.ParticipantsConfig;
import com.papss.middleware.enums.ParticipantType;
import com.papss.middleware.models.Participant;
import com.papss.middleware.models.participantinfo.Participants;
import com.papss.middleware.service.ParticipantInfoService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ParticipantInfoControllerTest {

    @Mock private ParticipantInfoService participantInfoService;
    @Mock private ParticipantsConfig participantsConfig;

    @InjectMocks private ParticipantInfoController controller;

    private Participant participant;

    @BeforeEach
    void setUp() {
        participant = new Participant();
        participant.setSslKeyAlias("alias");
    }

    @Test
    void getAllParticipantStatus_shouldDelegateAndReturn() throws Exception {
        String papssId = "PAPSS";
        String apiKey = "KEY";
        Participants expected = new Participants();

        when(participantsConfig.getParticipantConfig(papssId)).thenReturn(participant);
        doNothing().when(participantsConfig).validateParticipantByApiKey(apiKey, participant);
        when(participantInfoService.getAllParticipantsStatus(anyBoolean(), any(), anyString(), eq(papssId), eq("alias")))
                .thenReturn(expected);

        Participants resp = controller.getAllParticipantStatus(papssId, apiKey, false, ParticipantType.BANK, "GH");
        assertThat(resp).isEqualTo(expected);
        verify(participantInfoService).getAllParticipantsStatus(anyBoolean(), any(), anyString(), eq(papssId), eq("alias"));
    }

    @Test
    void getParticipantStatus_shouldDelegateAndReturn() {
        String papssId = "PAPSS";
        String apiKey = "KEY";
        Participants expected = new Participants();

        when(participantsConfig.getParticipantConfig(papssId)).thenReturn(participant);
        doNothing().when(participantsConfig).validateParticipantByApiKey(apiKey, participant);
        when(participantInfoService.getParticipantStatus(eq(papssId), eq("RCV"), eq("alias")))
                .thenReturn(expected);

        Participants resp = controller.getParticipantStatus(papssId, apiKey, "RCV");
        assertThat(resp).isEqualTo(expected);
        verify(participantInfoService).getParticipantStatus(eq(papssId), eq("RCV"), eq("alias"));
    }
}
