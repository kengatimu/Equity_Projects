package com.papss.middleware.dto.txnconfirmation.response;

import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
public class TxConfirmationResponse {
    private String transRef;
    private String tranDateTime;
    private String instId;
    private Status status;

}
