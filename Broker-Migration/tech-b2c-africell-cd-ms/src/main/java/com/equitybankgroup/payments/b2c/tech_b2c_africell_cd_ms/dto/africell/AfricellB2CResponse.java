/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.africell;

import lombok.Data;


@Data
public class AfricellB2CResponse {
    private String status;
    private String message;
    private String receiverLastName;
    private String senderMobileNumber;
    private String txnsStatus;
    private String serviceRequestId;
    private String receiverMobileNumber;
    private String serviceFlow;
    private String senderLastName;
    private String transactionId;
}

