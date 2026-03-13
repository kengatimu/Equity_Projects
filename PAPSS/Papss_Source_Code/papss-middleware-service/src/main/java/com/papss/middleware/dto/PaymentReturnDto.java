package com.papss.middleware.dto;

import lombok.Data;

@Data
public class PaymentReturnDto {
    private String bizMsgId;
    private String msgDefId;
    private String creationDate;
    private String fromMemberId;
    private String toBic;
    private String toMemberId;
    private String groupMsgId;
    private String nbOfTxs;
    private String totalAmount;
    private String currency;
    private String settlementDate;
    private String returnId;
    private String originalMsgId;
    private String originalEndToEndId;
    private String originalTxId;
    private String originalAmount;
    private String returnedAmount;
    private String returnReason;
    private String debtorName;
    private String debtorAccount;
    private String creditorName;
    private String creditorAccount;

}
