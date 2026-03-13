package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.dto.outbound;

import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.enums.DataType;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class FieldsForProductResponseDTO {
    private FqdoInfo fqdoInfo;
    private ProductFieldInfo productFieldInfo;
    private DynamicFieldInfo dynamicFieldInfo;
}
