package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.dto.outbound;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Builder
public class DetailEstimatedReceiveAmounts {
    private BigDecimal amount;
    private String amountType;
    private String amountCurrency;
}