package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.africell;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AirtimeTelcoResponseDTO {
    private String Code;
    private String Description;
    private String MSISDNAllocate;
    private String AfrTransactionID;
    private String MMTransactionID;
}
