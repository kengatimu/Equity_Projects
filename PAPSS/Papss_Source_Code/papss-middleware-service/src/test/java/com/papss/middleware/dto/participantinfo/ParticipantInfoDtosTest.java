package com.papss.middleware.dto.participantinfo;

import com.papss.middleware.enums.ParticipantType;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class ParticipantInfoDtosTest {

    @Test
    void participantInfoDto_accessors() {
        Sender sender = new Sender();
        sender.setInst_id("INST");

        ParticipantInfoDto dto = new ParticipantInfoDto();
        dto.setSender(sender);
        dto.setInst_id("RCV");

        assertThat(dto.getSender().getInst_id()).isEqualTo("INST");
        assertThat(dto.getInst_id()).isEqualTo("RCV");
    }

    @Test
    void participantInfoListDto_accessors() {
        Sender sender = new Sender();
        sender.setInst_id("INST");
        ParticipantInfoListDto listDto = new ParticipantInfoListDto();
        listDto.setSender(sender);
        listDto.setOnline(true);
        listDto.setParticipantType(ParticipantType.BANK);

        assertThat(listDto.isOnline()).isTrue();
        assertThat(listDto.getParticipantType()).isEqualTo(ParticipantType.BANK);
    }
}
