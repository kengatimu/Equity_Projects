package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.dto.outbound;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Builder
public class FieldsForProductRequestDTO {
    private String receiveCountry;
    private String deliveryOption;
    private String thirdPartyType;
    private String receiveAgentID;
    private String customerReceiveNumber;
    private String billerAccountNumber;
    private boolean cardSwiped;
    private String otherPayoutType;
    private String receiveCurrency;
    private BigDecimal amount;
    private String sendCurrency;
    private String productType;
    private String productVariant;
    private String serviceOfferingID;
    private String cunsumerId;
    private boolean formFreeStaging;
}
