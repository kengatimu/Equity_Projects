package com.papss.middleware.service.outbound.domains.creditreturn;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Data;

@Data
public class CreditReturnRequest {
    @NotBlank(message = "instId cannot be blank")
    private String instId;

    @NotBlank(message = "instBic cannot be blank")
    @Size(min = 8, max = 11, message = "instBic must be between 8 and 11 characters")
    private String instBic;

    @NotBlank(message = "tranDateTime cannot be blank")
    @Pattern(regexp = "\\d{4}-\\d{2}-\\d{2}", message = "tranDateTime must be in the format YYYY-MM-DD")
    private String tranDateTime;

    @NotBlank(message = "endToEndRef cannot be blank")
    private String endToEndRef;

    @NotBlank(message = "returnReasonCode cannot be blank")
    private String returnReasonCode;

    @Valid
    @NotNull(message = "originalTran cannot be null")
    private OriginalTran originalTran;

    private SupplementaryDataDto supplementaryData;
}
