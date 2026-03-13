package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.dto.outbound;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Builder
public class PromotionInfo {
    private String promotionCode;
    private String promotionDiscountID;
    private String promotionCategoryID;
    private BigDecimal promotionDiscount;
    private BigDecimal promotionDiscountAmount;
    private String promotionErrorCode;
    private String promotionErrorMessage;
}
