package com.papss.middleware.config;

import com.papss.middleware.exception.GenericExceptionHandler;
import com.papss.middleware.models.Participant;
import com.papss.middleware.utils.MessageConstants;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

import java.util.ArrayList;
import java.util.List;

@Data
@Configuration
@ConfigurationProperties(prefix = "papss")
public class ParticipantsConfig {
    private List<Participant> participants = new ArrayList<>();

    public Participant getParticipantConfig(final String papssId) {
        return participants.stream().filter(p -> p.getInstId().equals(papssId)).findFirst().orElseThrow(() -> new IllegalArgumentException(String.format(MessageConstants.INVALID_PARTICIPANTS, papssId)));
    }

    public Long pollingWorkerCount() {
        return participants.stream().filter(p -> !p.getInstId().contains("${PAPSS_")).count();
    }
    public void validateParticipantByApiKey(final String authorization, final Participant participant) {
        if (!authorization.equals(participant.getApiKey())) {
            throw new GenericExceptionHandler("Invalid API Key Authentication");
        }
    }
}
