package com.papss.middleware.dto.txnconfirmation.response;

import com.papss.middleware.dto.txstatus.OriginalTxInfo;
import com.papss.middleware.dto.txstatusreponse.TxOriginalInfo;
import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TxStatusResponseDto {

	private String transRef;
	private String originalTransactionRef;
	private String tranDateTime;
	private String instId;
	private Status status;
}
