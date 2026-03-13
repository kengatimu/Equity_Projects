package com.papss.middleware.service.outbound.domains.financialinstitution;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.papss.middleware.utils.RegularExpressions;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.math.BigDecimal;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class FinancialInstitutionDetails {

    @NotEmpty(message = "instId Field is Required")
    @Size(min = 4, max = 15, message = "Invalid Character length")
    @Pattern(regexp = RegularExpressions.ALPHANUMERIC, message = "Institution ID Can Only Be Alphanumeric")
    @JsonProperty
    private String instId;

    private String instBic;

    @NotEmpty(message = "country Field is Required")
    @Size(min = 2, max = 60, message = "Invalid Character length")
    @Pattern(regexp = RegularExpressions.ALPHABETS, message = "Country Can Only Be Alphabets")
    private String country;

    @NotEmpty(message = "currency Field is Required")
    @Size(min = 2, max = 60, message = "Invalid Character length")
    @Pattern(regexp = RegularExpressions.ALPHABETS, message = "Currency Can Only Be Alphabets")
    private String currency;

    private String address;
}