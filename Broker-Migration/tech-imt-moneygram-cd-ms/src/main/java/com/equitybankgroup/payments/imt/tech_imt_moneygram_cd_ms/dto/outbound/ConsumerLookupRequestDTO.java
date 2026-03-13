package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.dto.outbound;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class ConsumerLookupRequestDTO {
    private String customerPhone;
    private String freqCustCardNumber;
    private String agentFrequentCustomerNumber;
    private int maxSendersToReturn;
    private int maxReceiversToReturn;
}
