package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.africell;

import lombok.Data;

@Data
public class AfricellTokenRespDTO {
    private String access_token;
    private String token_type;
    private Long expires_in;
    private String scope;
}
