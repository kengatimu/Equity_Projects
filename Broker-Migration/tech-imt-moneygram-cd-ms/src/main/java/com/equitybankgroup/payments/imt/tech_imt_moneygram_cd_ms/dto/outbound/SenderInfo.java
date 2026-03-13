package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.dto.outbound;


import lombok.Builder;
import lombok.Data;

import java.sql.Date;

@Data
@Builder
public class SenderInfo {
    private String senderFirstName;
    private String senderMiddleName;
    private String senderLastName;
    private String senderLastName2;
    private String senderAddress;
    private String senderAddress2;
    private String senderAddress3;
    private String senderAddress4;
    private String senderCity;
    private String senderState;
    private String senderZipCode;
    private String senderCountry;
    private String senderHomePhone;
    private String freqCustCardNumber;
    private String agentFrequentCustomerNumber;
    private String customerId;
    private String senderBirthCountry;
    private Date senderDOB;
    private String senderHomePhoneCountryCode;
    private boolean senderTransactionEmailNotificationOptIn;
    private boolean senderTransactionSMSNotificationOptIn;
    private boolean senderMarketingEmailNotificationOptIn;
    private boolean senderMarketingSMSNotificationOptIn;
    private String senderEmailAddress;
    private String senderMobilePhone;
    private ReceiverInfo receiverInfo;
    private BillerInfo billerInfo;
}