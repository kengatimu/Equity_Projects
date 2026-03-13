package com.papss.middleware.service.outbound.domains.credittransfer;

import com.papss.middleware.dto.txstatus.OriginalTxInfo;
import lombok.*;

@Data
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class FTResponse {
    private String transRef;
    private String tranDateTime;
    private OriginalTxInfo originalTxInfo;
    private Status status;
    private String instId;
}
