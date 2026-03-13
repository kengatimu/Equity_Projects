package com.papss.middleware.repositories;

import com.papss.middleware.entities.PapssMessage;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.test.context.TestPropertySource;

import java.time.OffsetDateTime;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
@EntityScan(basePackages = "com.papss.middleware.entities")
@EnableJpaRepositories(basePackages = "com.papss.middleware.repositories")
@TestPropertySource(properties = {
        "spring.jpa.hibernate.ddl-auto=create-drop",
        "spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.H2Dialect"
})
class PapssMessageRepositoryTest {

    @Autowired
    private PapssMessageRepository repository;

    private PapssMessage buildMessage(long sequence, boolean confirmed) {
        PapssMessage m = new PapssMessage();
        m.setSequenceNumber(sequence);
        m.setConfirmed(confirmed);
        m.setStatus("NEW");
        m.setCleared(false);
        m.setProcessingDuration(0);
        m.setProcessed(false);
        m.setMessageType("TEST");
        m.setPapssId("PAPSS123");
        m.setCountryCode("GH");
        m.setParticipantBic("PAPSSGHACXXX");
        return m;
    }

    @Test
    @DisplayName("findBySequenceNumber should return the saved message")
    void testFindBySequenceNumber() {
        PapssMessage saved = repository.save(buildMessage(1001L, false));
        Optional<PapssMessage> found = repository.findBySequenceNumber(1001L);
        assertThat(found).isPresent();
        assertThat(found.get().getId()).isEqualTo(saved.getId());
        assertThat(found.get().getSequenceNumber()).isEqualTo(1001L);
    }

    @Test
    @DisplayName("findBySequenceNumber should be empty for unknown sequence")
    void testFindBySequenceNumberNotFound() {
        assertThat(repository.findBySequenceNumber(9999L)).isNotPresent();
    }

    @Test
    @DisplayName("findBySequenceNumberAndConfirmed should honor both fields")
    void testFindBySequenceNumberAndConfirmed() {
        repository.save(buildMessage(2002L, true));
        repository.save(buildMessage(2003L, false));

        assertThat(repository.findBySequenceNumberAndConfirmed(2002L, true)).isPresent();
        assertThat(repository.findBySequenceNumberAndConfirmed(2002L, false)).isNotPresent();
        assertThat(repository.findBySequenceNumberAndConfirmed(2003L, false)).isPresent();
        assertThat(repository.findBySequenceNumberAndConfirmed(2003L, true)).isNotPresent();
    }
}
