package com.papss.middleware.dto.participantinfo;

import com.papss.middleware.utils.RegularExpressions;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;


@Data
public class ParticipantInfoDto {

    @NotNull(message = "Sender Cannot Be Blank")
    @Valid
    private Sender sender;

    @NotEmpty(message = "inst_id Field is Required")
    @Size(min = 4, max = 15, message = "Invalid Character length")
    @Pattern(regexp = RegularExpressions.ALPHANUMERIC, message = "Institution ID Can Only Be Alphanumeric")
    private String inst_id;
}
