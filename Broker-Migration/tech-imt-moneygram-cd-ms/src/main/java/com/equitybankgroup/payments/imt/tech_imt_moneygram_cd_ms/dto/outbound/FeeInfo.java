package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.dto.outbound;


import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Builder
public class FeeInfo {

    private BigDecimal validReceiveAmount;
    private String validReceiveCurrency;
    private BigDecimal  validExchangeRate;
    private BigDecimal estimatedReceiveAmount;
    private String estimatedReceiveCurrency;
    private BigDecimal estimatedExchangeRate;
    private BigDecimal totalAmount;
    private String receiveCountry;
    private String deliveryOption;
    private boolean receiveAmountAltered;
    private String speedOfDeliveryText;
    private BigDecimal saLimitAvailable;
    private boolean revisedInformationalFee;
    private String deliveryOptId;
    private String deliveryOptDisplayName;
    private String regAuthText;
    private String receiveAgentID;
    private String receiveAgentName;
    private String receiveAgentAbbreviation;
    private String mgManaged;
    private String disclosureText;
    private String mgiTransactionSessionID;
    private boolean sendAmountAltered;
    private String additionalInfoText;
    private PromotionInfo promotionInfo;
    private String longLanguage;
    private String textTranslation;
    private SendAmounts sendAmounts;
    private ReceiveAmounts receiveAmounts;
}