package com.papss.middleware.repositories;

import com.papss.middleware.entities.Transaction;
import com.papss.middleware.enums.Direction;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import static org.assertj.core.api.Assertions.assertThat;

@DataJpaTest
class TransactionRepositoryTest {

    @Autowired
    private TransactionRepository repository;

    private Transaction buildTx(String endToEndId) {
        Transaction t = new Transaction();
        t.setDirection(Direction.OUT);
        t.setMsgType("TEST");
        t.setReference("REF-1");
        t.setEndToEndId(endToEndId);
        t.setSender("SENDER");
        t.setSenderName("Sender Name");
        t.setSenderAccount("ACC123");
        t.setReceiverBank("RECBANK");
        t.setReceiverName("Receiver Name");
        t.setReceiverAccount("ACC999");
        t.setReceiveTime(LocalDateTime.now());
        t.setProcessCompletionTime(LocalDateTime.now());
        t.setCurrency("USD");
        t.setAmount(new BigDecimal("10.50"));
        t.setSenderFxRate(new BigDecimal("1.0"));
        t.setReceiverCurrency("USD");
        t.setReceiverAmount(new BigDecimal("10.50"));
        t.setReceiverFxRate(new BigDecimal("1.0"));
        t.setUsdAmount(new BigDecimal("10.50"));
        t.setFee(BigDecimal.ZERO);
        t.setSettlementFee(BigDecimal.ZERO);
        t.setSenderModel("MODEL1");
        t.setReceiverModel("MODEL2");
        t.setError(null);
        t.setErrorDescription(null);
        t.setStatus("NEW");
        return t;
    }

    @Test
    @DisplayName("findByEndToEndId should return saved entity")
    void testFindByEndToEndId() {
        repository.save(buildTx("E2E-ABC"));
        assertThat(repository.findByEndToEndId("E2E-ABC")).isPresent();
    }

    @Test
    @DisplayName("findByEndToEndId should be empty for unknown id")
    void testFindByEndToEndIdNotFound() {
        assertThat(repository.findByEndToEndId("UNKNOWN")).isNotPresent();
    }
}
