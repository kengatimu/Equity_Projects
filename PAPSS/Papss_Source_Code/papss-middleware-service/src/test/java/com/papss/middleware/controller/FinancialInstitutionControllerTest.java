package com.papss.middleware.controller;

import com.papss.middleware.config.ParticipantsConfig;
import com.papss.middleware.models.Participant;
import com.papss.middleware.service.outbound.FinancialInstitutionService;
import com.papss.middleware.service.outbound.domains.credittransfer.FTResponse;
import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import com.papss.middleware.service.outbound.domains.financialinstitution.FinancialInstitutionRequest;
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
class FinancialInstitutionControllerTest {

    @Mock private ParticipantsConfig participantsConfig;
    @Mock private FinancialInstitutionService financialInstitutionService;
    @InjectMocks private FinancialInstitutionController controller;

    private Participant participant;

    @BeforeEach
    void setUp() {
        participant = new Participant();
        participant.setInstId("INST1");
        participant.setSslKeyAlias("alias");
    }

    @Test
    void sendFinancialInstitutionTransfer_shouldDelegateAndReturn() throws Exception {
        String papssId = "PAPSS123";
        String apiKey = "APIKEY";
        FinancialInstitutionRequest req = new FinancialInstitutionRequest();
        FTResponse expected = FTResponse.builder().instId("INST1").status(new Status("SUCCESS","200","OK")).build();

        when(participantsConfig.getParticipantConfig(papssId)).thenReturn(participant);
        doNothing().when(participantsConfig).validateParticipantByApiKey(apiKey, participant);
        when(financialInstitutionService.sendFinancialInstitutionMessage(eq(req), eq("INST1"), eq(participant)))
                .thenReturn(expected);

        FTResponse resp = controller.sendFinancialInstitutionTransfer(papssId, apiKey, req);
        assertThat(resp).isEqualTo(expected);
        verify(financialInstitutionService).sendFinancialInstitutionMessage(eq(req), eq("INST1"), eq(participant));
    }
}
