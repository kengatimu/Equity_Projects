package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.dto.outbound;

import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.enums.AmountType;
import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.enums.DataType;
import lombok.Builder;
import lombok.Data;

import java.math.BigDecimal;

@Data
@Builder
public class FeeLookupResponseDTO {
    private FeeInfo feeInfo;
}
