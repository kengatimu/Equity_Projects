package com.papss.middleware.service.outbound.domains.pending;

import lombok.Data;

@Data
public class PendingRequest {
    private String instId;
    private String instBic;
    private String originalEndToEndRef;
    private String currency;
    private String amount;
    private String settlementDate;
    private String modInstruction;
}