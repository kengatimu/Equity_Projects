package com.papss.middleware.entities;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.OffsetDateTime;

@Data
@Entity
@NoArgsConstructor
public class PapssMessage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Lob
    private String requestPayload;

    @Lob
    private String responsePayload;

    private Integer errorCode;
    @Column(unique = true)
    private long sequenceNumber;
    private String status;
    private boolean isCleared;
    private long processingDuration;
    private boolean confirmed;
    private boolean processed;
    private String messageType;
    private String papssId;
    private String countryCode;
    private String participantBic;
    private OffsetDateTime systemDate;
}
