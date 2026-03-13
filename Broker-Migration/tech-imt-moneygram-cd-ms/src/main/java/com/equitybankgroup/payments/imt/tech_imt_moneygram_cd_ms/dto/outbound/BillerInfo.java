package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.dto.outbound;


import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class BillerInfo {
    private String receiveCode;
    private String receiveAgentID;
    private String billerAccountNumber;
    private String billerName;
    private String billerAddress;
    private String billerAddress2;
    private String billerCity;
    private String billerState;
    private String productVariant;
    private String receiverFirstName;
    private String receiverMiddleName;
    private String receiverLastName;
    private String receiverLastName2;
}