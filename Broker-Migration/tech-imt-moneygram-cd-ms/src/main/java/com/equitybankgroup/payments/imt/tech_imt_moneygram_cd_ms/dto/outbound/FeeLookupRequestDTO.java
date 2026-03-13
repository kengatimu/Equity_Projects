package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.dto.outbound;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Builder
public class FeeLookupRequestDTO {
    private String productType;
    private String productVariant;
    private String operatorName;
    private BigDecimal amountIncludingFee;
    private BigDecimal amountExcludingFee;
    private BigDecimal receiveAmount;
    private String receiveCountry;
    private String deliveryOption;
    private String mgiRewardsNumber;
    private String receiveCode;
    private String indicativeReceiveCurrency;
    private String receiveAgentID;
    private String receiveCurrency;
    private String sendCurrency;
    private String mgCustomerReceiveNumber;
    private BigDecimal defaultInformationFee;
    private String serviceOfferingID;
    private boolean defaultMaxFee;
    private boolean allOptions;
    private PromoCodeValues promoCodeValues;

}
