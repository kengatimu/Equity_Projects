package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.dto.outbound;

import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Builder
public class ReceiverInfo {
    private String receiverCountry;
    private String receiverFirstName;
    private String receiverMiddleName;
    private String receiverLastName;
    private String receiverLastName2;
    private String receiverAddress;
    private String receiverAddress2;
    private String receiverAddress3;
    private String receiverAddress4;
    private String receiverCity;
    private String receiverState;
    private String receiverZipCode;
    private String receiverPhone;
    private BigDecimal sendAmount;
    private String deliveryOption;
    private String sendCurrency;
    private String direction1;
    private String direction2;
    private String direction3;
    private String customerReceiveNumber;
    private String accountNickname;
    private String displayAccountID;
    private String receiveAgentID;
    private String receiveAgentName;
    private String receiveAgentAbbreviation;
    private String receiverCurrency;
    private String payoutCurrency;
    private String receiverPhoneCountryCode;
}
