package com.papss.middleware.dto.paymentreturn;

import com.papss.middleware.service.outbound.domains.credittransfer.TransferDetails;
import jakarta.validation.Valid;
import jakarta.validation.constraints.DecimalMin;
import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Builder
public class PaymentRecallDto {
    private String instId;
    private String settlementType;
    private String transactionDate;
    private String toClearingSystemId;
    private String originalEndToEndRef;
    private String reasonCode;


    @DecimalMin(value = "0.00", inclusive = false)
    @Digits(integer = 100, fraction = 2)
    private BigDecimal amount;

    @NotNull(message = "Sender Cannot Be Blank")
    @Valid
    private TransferDetails sender;

    @NotNull(message = "Receiver Cannot Be Blank")
    @Valid
    private TransferDetails receiver;
    @NotNull(message = "narration cannot be blank")
    // @Pattern(regexp= RegularExpressions., message="narration Can Only Be Alphanumeric")
    @Size(max = 140)
    private String narration;

}
