package com.papss.middleware.dto.fxrate;

import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import lombok.Data;
import lombok.ToString;

import java.math.BigDecimal;

@Data
@ToString
public class PostFxRateDto {

    private String instId;
    private String accountType;
    @DecimalMin(value = "0.0", inclusive = false)
    @Digits(integer = 100, fraction = 2)
    private BigDecimal buyRate;
    @DecimalMin(value = "0.0", inclusive = false)
    @Digits(integer = 100, fraction = 2)
    private BigDecimal sellRate;
    private String countryCode;
    private String localCurrency;
    private String fxRateName;
}
