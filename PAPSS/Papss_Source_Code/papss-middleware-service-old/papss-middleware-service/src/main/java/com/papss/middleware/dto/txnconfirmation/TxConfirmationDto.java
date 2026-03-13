package com.papss.middleware.dto.txnconfirmation;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.papss.middleware.dto.txstatus.OriginalTxInfo;
import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class TxConfirmationDto {

    private String transRef;
    private String tranDateTime;
    private String instId;
    @JsonProperty("originalTxInfo")
    private OriginalTxInfo originalTxInfo;
    private Status status;

}
