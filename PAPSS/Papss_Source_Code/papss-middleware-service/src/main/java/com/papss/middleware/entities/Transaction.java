package com.papss.middleware.entities;

import com.papss.middleware.enums.Direction;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Entity(name = "papss_transaction")
@NoArgsConstructor
public class Transaction {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Enumerated(EnumType.STRING)
    private Direction direction;

    private String msgType;
    private String reference;
    @Column(unique = true)
    private String endToEndId;

    private String sender;
    private String senderName;
    private String senderAccount;

    private String receiverBank;
    private String receiverName;
    private String receiverAccount;

    private LocalDateTime receiveTime;
    private LocalDateTime processCompletionTime;

    private String currency;
    private BigDecimal amount;

    private BigDecimal senderFxRate;

    private String receiverCurrency;
    private BigDecimal receiverAmount;
    private BigDecimal receiverFxRate;

    private BigDecimal usdAmount;
    private BigDecimal fee;
    private BigDecimal settlementFee;

    private String senderModel;
    private String receiverModel;

    private String error;
    private String errorDescription;
    private String status;
}
