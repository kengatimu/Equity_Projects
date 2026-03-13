package com.papss.middleware.controller;

import com.papss.middleware.config.ParticipantsConfig;
import com.papss.middleware.models.Participant;
import com.papss.middleware.service.outbound.PositionsService;
import montran.positions.Positions;
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
class PositionsControllerTest {

    @Mock private PositionsService positionsService;
    @Mock private ParticipantsConfig participantsConfig;

    @InjectMocks private PositionsController controller;

    private Participant participant;

    @BeforeEach
    void setUp() {
        participant = new Participant();
        participant.setInstId("INST1");
        participant.setSslKeyAlias("alias");
    }

    @Test
    void getPosition_shouldDelegateAndReturn() {
        String papssId = "PAPSS";
        String apiKey = "KEY";
        Positions expected = new Positions();

        when(participantsConfig.getParticipantConfig(papssId)).thenReturn(participant);
        doNothing().when(participantsConfig).validateParticipantByApiKey(apiKey, participant);
        when(positionsService.getParticipantPositions(eq("INST1"), eq("alias"))).thenReturn(expected);

        Positions resp = controller.getPosition(papssId, apiKey);
        assertThat(resp).isEqualTo(expected);
        verify(positionsService).getParticipantPositions(eq("INST1"), eq("alias"));
    }
}
