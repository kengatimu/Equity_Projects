package com.papss.middleware.dto.fxrate;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.papss.middleware.utils.RegularExpressions;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.ToString;

import java.math.BigDecimal;

@Data
@ToString
public class GetFxRateDto {

    @NotEmpty(message = "localInstrumentType Field is Required")
    @Size(min = 2, max = 60, message = "Invalid Character length")
    @Pattern(regexp = RegularExpressions.ALPHANUMERIC, message = "Field Can Only Be Alphanumeric")
    private String localInstrumentType;

    @DecimalMin(value = "0.0", inclusive = false)
    @Digits(integer = 100, fraction = 2)
    private BigDecimal amount;

    @JsonProperty("is_invoice")
    private Boolean isInvoice;

    @NotNull(message = "Sender Cannot Be Blank")
    @Valid
    private FxRateSender sender;

    @NotNull(message = "Receiver Cannot Be Blank")
    @Valid
    private FxRateReceiver receiver;

}
