package com.papss.middleware.service.inbound.domains;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class PartnerResponse {
    private int statusCode;
    private String message;
    private String error = "";
}
