package com.equitybankgroup.payments.b2c.dto.api;

import lombok.Builder;
import lombok.Data;
import org.springframework.http.HttpStatus;

import java.util.List;

@Data
@Builder
public class TransactionResponse {
    private String message;
    private Integer statusCode;
    private List<Payload> data;

    @Builder
    @Data
    public static class Payload {
        private String transactionDate;
        private String transactionID;
        private String accountNumber;
        private String currencyCode;
        private String amount;
        private String transactionDescription1;
        private String referenceNumber;
        private String transactionDescription2;
        private String remarks;
    }
}
