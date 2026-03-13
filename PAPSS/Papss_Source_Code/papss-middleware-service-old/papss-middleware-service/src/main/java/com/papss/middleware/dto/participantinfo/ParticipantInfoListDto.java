package com.papss.middleware.dto.participantinfo;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.papss.middleware.enums.ParticipantType;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.Data;


@Data
public class ParticipantInfoListDto {

    @NotNull(message = "Sender Cannot Be Blank")
    @Valid
    private Sender sender;

    @JsonProperty("is_online")
    @NotNull(message = "is_online is a required field")
    private boolean online;

    @NotNull(message = "Participant Cannot Be Blank")
    @Valid
    private ParticipantType participantType;

}
