package com.papss.middleware.controller;

import com.papss.middleware.config.ParticipantsConfig;
import com.papss.middleware.dto.fxrate.PostFxRateDto;
import com.papss.middleware.dto.fxrate.response.FxRateData;
import com.papss.middleware.dto.fxrate.response.FxRateResponse;
import com.papss.middleware.dto.fxrate.response.PostFxRateResponse;
import com.papss.middleware.models.Participant;
import com.papss.middleware.service.outbound.FxRateService;
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
class FxRateControllerTest {

    @Mock private FxRateService fxRateService;
    @Mock private ParticipantsConfig participantsConfig;

    @InjectMocks private FxRateController controller;

    private Participant participant;

    @BeforeEach
    void setUp() {
        participant = new Participant();
        participant.setInstId("INST1");
        participant.setSslKeyAlias("alias");
        participant.setKeyPass("pass");
    }

    @Test
    void getFxRate_shouldDelegateAndReturn() throws Exception {
        String papssId = "PAPSS1";
        String apiKey = "KEY";
        FxRateResponse expected = new FxRateResponse();

        when(participantsConfig.getParticipantConfig(papssId)).thenReturn(participant);
        doNothing().when(participantsConfig).validateParticipantByApiKey(apiKey, participant);
        when(fxRateService.getFxRate(anyString(), anyString(), anyString(), anyString(), anyString(), anyString(), anyString(), anyBoolean(), eq("INST1"), eq("alias")))
                .thenReturn(expected);

        FxRateResponse resp = controller.getFxRate(papssId, apiKey,
                "GH", "GHS", "NG", "NGN", "PAPSS2", "ET", "100.00", false);

        assertThat(resp).isEqualTo(expected);
        verify(fxRateService).getFxRate(anyString(), anyString(), anyString(), anyString(), anyString(), anyString(), anyString(), anyBoolean(), eq("INST1"), eq("alias"));
    }

    @Test
    void getFxRateDetails_shouldDelegateAndReturn() throws Exception {
        String papssId = "PAPSS1";
        String apiKey = "KEY";
        FxRateData expected = new FxRateData();

        when(participantsConfig.getParticipantConfig(papssId)).thenReturn(participant);
        doNothing().when(participantsConfig).validateParticipantByApiKey(apiKey, participant);
        when(fxRateService.getFxRate(eq(papssId), eq("RATE1"), eq("alias"))).thenReturn(expected);

        FxRateData resp = controller.getFxRate(papssId, apiKey, "RATE1");
        assertThat(resp).isEqualTo(expected);
        verify(fxRateService).getFxRate(eq(papssId), eq("RATE1"), eq("alias"));
    }

    @Test
    void updateFxRate_shouldDelegateAndReturn() throws Exception {
        String papssId = "PAPSS1";
        String apiKey = "KEY";
        PostFxRateDto dto = new PostFxRateDto();
        PostFxRateResponse expected = PostFxRateResponse.builder().build();

        when(participantsConfig.getParticipantConfig(papssId)).thenReturn(participant);
        doNothing().when(participantsConfig).validateParticipantByApiKey(apiKey, participant);
        when(fxRateService.updateFxRate(eq(dto), eq("INST1"), eq("alias"), eq("pass"))).thenReturn(expected);

        PostFxRateResponse resp = controller.updateFxRate(papssId, apiKey, dto);
        assertThat(resp).isEqualTo(expected);
        verify(fxRateService).updateFxRate(eq(dto), eq("INST1"), eq("alias"), eq("pass"));
    }
}
