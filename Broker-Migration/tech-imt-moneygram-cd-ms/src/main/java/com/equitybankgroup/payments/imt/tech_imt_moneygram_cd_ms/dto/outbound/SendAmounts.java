package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.dto.outbound;


import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Builder
public class SendAmounts {
    private BigDecimal sendAmount;
    private String sendCurrency;
    private BigDecimal totalSendFees;
    private BigDecimal totalDiscountAmount;
    private BigDecimal totalSendTaxes;
    private BigDecimal totalAmountToCollect;
    private DetailSendAmounts detailSendAmounts;

}