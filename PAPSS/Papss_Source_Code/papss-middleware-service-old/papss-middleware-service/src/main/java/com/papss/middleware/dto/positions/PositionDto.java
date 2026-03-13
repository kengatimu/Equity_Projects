package com.papss.middleware.dto.positions;


import com.papss.middleware.dto.participantinfo.Sender;
import com.papss.middleware.enums.AccountStatus;
import com.papss.middleware.enums.AccountType;
import com.papss.middleware.enums.ParticipantType;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.Data;


@Data
public class PositionDto {

    @NotNull(message = "Sender Cannot Be Blank")
    @Valid
    private Sender sender;

    @NotNull(message = "Participant Cannot Be Blank")
    @Valid
    private ParticipantType participant_type;

    @NotNull(message = "Participant Cannot Be Blank")
    @Valid
    private AccountType account_type;

    @NotNull(message = "Participant Cannot Be Blank")
    @Valid
    private AccountStatus account_status;
}
