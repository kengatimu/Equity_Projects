package com.papss.middleware.service.outbound.domains.financialinstitution;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.papss.middleware.utils.RegularExpressions;
import jakarta.validation.Valid;
import jakarta.validation.constraints.*;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.math.BigDecimal;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FinancialInstitutionRequest {

    @NotNull(message = "endToEndRef cannot be blank")
    private String endToEndRef;


    @NotNull(message = "narration cannot be blank")
    @Size(max = 140)
    private String narration;

    @NotNull(message = "isInvoice cannot be blank")
    @JsonProperty("isInvoice")
    private Boolean isInvoice;

    @NotNull(message = "categoryPurpose cannot be blank")
    @Pattern(regexp = RegularExpressions.ALPHANUMERIC, message = "categoryPurpose can only be alphanumeric")
    private String categoryPurpose;

    @NotNull(message = "localInstrumentType cannot be blank")
    @Pattern(regexp = RegularExpressions.ALPHANUMERIC, message = "localInstrumentType can only be alphanumeric")
    private String localInstrumentType;

    @DecimalMin(value = "0.00", inclusive = false)
    @Digits(integer = 100, fraction = 2)
    private BigDecimal amount;

    @NotNull(message = "Sender Cannot Be Blank")
    @Valid
    private FinancialInstitutionDetails sender;

    @NotNull(message = "Receiver Cannot Be Blank")
    @Valid
    private FinancialInstitutionDetails receiver;

    private String instId;
    private String transRef;
}