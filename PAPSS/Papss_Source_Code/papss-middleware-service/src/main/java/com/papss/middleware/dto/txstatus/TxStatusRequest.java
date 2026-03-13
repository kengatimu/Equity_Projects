package com.papss.middleware.dto.txstatus;

import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import com.papss.middleware.utils.RegularExpressions;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class TxStatusRequest {

    @NotEmpty(message = "TranRef Cannot Be Blank")
    @Size(min = 4, max = 60, message = "Invalid Character length")
    @Pattern(regexp = RegularExpressions.ALPHANUMERIC, message = "TransRef Can Only Be Alphanumeric")
    private String transRef;

    @NotNull(message = "Sender Cannot Be Blank")
    @Valid
    private Sender sender;

    @NotNull(message = "Original Txn Info Cannot Be Blank")
    @Valid
    private OriginalTxInfo originalTxInfo;

    private String instId;
    private String tranDateTime;
    private Status status;
}
