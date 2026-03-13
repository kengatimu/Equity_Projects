package com.papss.middleware.service.outbound.domains.creditreturn;

import com.papss.middleware.service.outbound.domains.credittransfer.TransferDetails;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

@Data
public class OriginalTran {
    @NotBlank(message = "transRef cannot be blank")
    private String transRef;

    @NotBlank(message = "tranDateTime cannot be blank")
    @Pattern(regexp = "\\d{4}-\\d{2}-\\d{2}", message = "tranDateTime must be in the format YYYY-MM-DD")
    private String tranDateTime;

    @NotBlank(message = "categoryPurpose cannot be blank")
    private String categoryPurpose;

    @NotBlank(message = "narration cannot be blank")
    private String narration;

    @NotBlank(message = "endToEndRef cannot be blank")
    private String endToEndRef;

    @NotBlank(message = "localInstrumentType cannot be blank")
    private String localInstrumentType;

    @NotBlank(message = "instId cannot be blank")
    private String instId;

    @NotNull(message = "isInvoice cannot be null")
    private Boolean isInvoice;

    @Valid
    @NotNull(message = "sender cannot be null")
    private TransferDetails sender;

    @Valid
    @NotNull(message = "receiver cannot be null")
    private TransferDetails receiver;
}
