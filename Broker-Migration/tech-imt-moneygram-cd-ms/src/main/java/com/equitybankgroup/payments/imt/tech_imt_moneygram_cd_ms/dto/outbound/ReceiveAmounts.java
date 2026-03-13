package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.dto.outbound;


import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Builder
public class ReceiveAmounts {
    private BigDecimal receiveAmount;
    private String receiveCurrency;
    private boolean validCurrencyIndicator;
    private String payoutCurrency;
    private BigDecimal totalReceiveFees;
    private BigDecimal totalReceiveTaxes;
    private BigDecimal totalReceiveAmount;
    private boolean receiveFeesAreEstimated;
    private boolean receiveTaxesAreEstimated;
    private DetailEstimatedReceiveAmounts detailEstimatedReceiveAmounts;


}
