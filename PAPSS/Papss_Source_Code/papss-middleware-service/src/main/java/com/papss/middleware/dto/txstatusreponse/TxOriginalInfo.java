package com.papss.middleware.dto.txstatusreponse;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class TxOriginalInfo {
    private String transRef;
    private String endToEndRef;
}
