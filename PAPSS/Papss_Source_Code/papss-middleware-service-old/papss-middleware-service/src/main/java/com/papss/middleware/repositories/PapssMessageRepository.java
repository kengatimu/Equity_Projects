package com.papss.middleware.repositories;

import com.papss.middleware.entities.PapssMessage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface PapssMessageRepository extends JpaRepository<PapssMessage, Long> {

    Optional<PapssMessage> findBySequenceNumber(long sequenceNumber);
    Optional<PapssMessage> findBySequenceNumberAndConfirmed(long sequenceNumber, boolean isConfirmed);
}
