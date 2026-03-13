package com.papss.middleware.dto.txnconfirmation;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class TxStatus {
    private String type;
    private String reason;
}
