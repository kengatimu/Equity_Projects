package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.dto.outbound;


import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.enums.AmountType;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class DetailSendAmounts {
    private BigDecimal amount;
    private String amountType;
    private String amountCurrency;

    private boolean isValidAmountType(String dataType) {
        try {
            AmountType.valueOf(dataType.toUpperCase());
            return true;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    public void setDataType(String dataType) {
        if (isValidAmountType(dataType)) {
            this.amountType = dataType;
        } else {
            throw new IllegalArgumentException("Invalid amount type: " + dataType);
        }
    }
}