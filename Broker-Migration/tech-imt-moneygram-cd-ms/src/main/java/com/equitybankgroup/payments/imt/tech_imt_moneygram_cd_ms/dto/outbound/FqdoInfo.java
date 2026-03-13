package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.dto.outbound;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class FqdoInfo {
    private String receiveCountry;
    private String deliveryOption;
    private String receiveAgentID;
    private String receiveCurrency;
    private String receiveAgentName;
    private String receiveAgentAbbreviation;
    private String deliveryOptionDisplayName;
    private String registrationAuthorizationText;
    private String speedOfDeliveryText;
}
