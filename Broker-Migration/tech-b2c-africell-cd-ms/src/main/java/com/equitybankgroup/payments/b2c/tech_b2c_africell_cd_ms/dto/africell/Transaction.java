/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.africell;

import lombok.Builder;
import lombok.Data;


@Data
@Builder
public class Transaction
{
    private String serviceFlowId;
    private String transactionAmount;
    private String initiator;
    private String currency;
    private String bearerCode;
    private String language;
    private String externalReferenceId;
    private String remarks;
    private String transactionMode;
    private String requestedServiceCode;
    private String serviceCode;
    private String productOwnerCode;
    private String productBrand;
    private String productCategory;
    private Transactor transactor;
    private Receiver receiver;

    @Data
    @Builder
    public static class Transactor {
        private String idType;
        private String idValue;
        private String bankId;
        private String bankAccountNumber;
    }

    @Data
    @Builder
    public static class Receiver {
        private String idType;
        private String idValue;
        private String productId;
    }
}
