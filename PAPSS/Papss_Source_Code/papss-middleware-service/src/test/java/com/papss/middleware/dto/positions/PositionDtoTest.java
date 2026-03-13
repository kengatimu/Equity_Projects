package com.papss.middleware.dto.positions;

import com.papss.middleware.dto.participantinfo.Sender;
import com.papss.middleware.enums.AccountStatus;
import com.papss.middleware.enums.AccountType;
import com.papss.middleware.enums.ParticipantType;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class PositionDtoTest {

    @Test
    void accessors_work() {
        Sender sender = new Sender();
        sender.setInst_id("INST");
        PositionDto dto = new PositionDto();
        dto.setSender(sender);
        dto.setParticipant_type(ParticipantType.BANK);
        dto.setAccount_type(AccountType.SA_3);
        dto.setAccount_status(AccountStatus.ACTIVE);

        assertThat(dto.getSender().getInst_id()).isEqualTo("INST");
        assertThat(dto.getParticipant_type()).isEqualTo(ParticipantType.BANK);
        assertThat(dto.getAccount_type()).isEqualTo(AccountType.SA_3);
        assertThat(dto.getAccount_status()).isEqualTo(AccountStatus.ACTIVE);
    }
}
