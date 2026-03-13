package com.papss.middleware.dto.txstatus;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.papss.middleware.utils.RegularExpressions;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class OriginalTxInfo {

    @NotEmpty(message = "TranRef Cannot Be Blank")
    @Size(min = 4, max = 60, message = "Invalid Character length")
    @Pattern(regexp = RegularExpressions.ALPHANUMERIC, message = "TransRef Can Only Be Alphanumeric")
    private String transRef;

    @NotEmpty(message = "TranRef Cannot Be Blank")
    @Size(min = 4, max = 60, message = "Invalid Character length")
    @Pattern(regexp = RegularExpressions.ISODATE, message = "Invalid Date Format")
    private String tranDateTime;

    private String endToEndRef;


}
