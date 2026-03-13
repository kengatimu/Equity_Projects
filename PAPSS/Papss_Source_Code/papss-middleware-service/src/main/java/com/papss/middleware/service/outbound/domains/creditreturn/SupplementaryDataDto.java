package com.papss.middleware.service.outbound.domains.creditreturn;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class SupplementaryDataDto {
    private SenderReceiverDto sender;
    private SenderReceiverDto receiver;
    private String auditInfo;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class SenderReceiverDto {
        private BigDecimal rate;
        private AmountDto amount;
        private AmountDto settlementAmount;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class AmountDto {
        private String currency;
        private BigDecimal value;
    }
}