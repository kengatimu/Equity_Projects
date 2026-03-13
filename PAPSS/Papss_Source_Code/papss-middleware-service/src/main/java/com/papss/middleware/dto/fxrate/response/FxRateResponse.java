package com.papss.middleware.dto.fxrate.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.math.BigDecimal;

@Data
public class FxRateResponse {

    @JsonProperty("usd_to_sender_currency_rate")
    private BigDecimal usdToSenderCurrencyRate;

    @JsonProperty("usd_to_receiver_currency_rate")
    private BigDecimal usdToReceiverCurrencyRate;

    @JsonProperty("sender_to_receiver_currency_rate")
    private BigDecimal senderToReceiverCurrencyRate;

    @JsonProperty("sender_amount")
    private BigDecimal senderAmount;

    @JsonProperty("receiver_amount")
    private BigDecimal receiverAmount;

    @JsonProperty("usd_exchange_amount")
    private BigDecimal exchangeAmount;

    @JsonProperty("sender_currency_fee_amount")
    private BigDecimal nationalFeeAmount;

    @JsonProperty("usd_fee_amount")
    private BigDecimal feeAmount;

    private String time;
}
