package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.africell;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class AirtimeTelcoRequestDTO {
    private String UserID;
    private String targetDealerNumber;
    private String creditAmount;
    private String SendSMSNotifications;
    private String SenderMSISDN;
    private String MMTransactionID;
    
}

/*
Broker to Africell

{"UserID":"*****","targetDealerNumber":"243900590652","creditAmount":"300.0000","SendSMSNotifications":"true","MMTransactionID":"8998471"}


{"Code":"0","Description":"Successful","MMTransactionID":"8998471","AfrTransactionID":"6584871162"}
*/