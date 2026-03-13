package com.papss.middleware.dto.fxrate.response;
import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import lombok.Builder;
import lombok.Data;


@Data
@Builder
public class PostFxRateResponse {
    private String tranRef;
    private String tranDateTime;
    private String fxRateName;
    private Status status;
}
