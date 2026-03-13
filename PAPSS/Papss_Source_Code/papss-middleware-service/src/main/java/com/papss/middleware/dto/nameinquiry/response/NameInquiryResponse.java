package com.papss.middleware.dto.nameinquiry.response;

import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class NameInquiryResponse {
    private String tranRef;
    private String endToEndRef;
    private NameInquiryResponseSender sender;
    private NameInquiryResponseReceiver receiver;
    private Status status;

}
