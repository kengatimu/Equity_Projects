package com.papss.middleware.dto.txnconfirmation;

import com.papss.middleware.dto.txstatus.OriginalTxInfo;
import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TxStatusDto {

	private String transRef;
	private String tranDateTime;
	private OriginalTxInfo originalTxInfo;
	private String instId;
	private Status status;

}
