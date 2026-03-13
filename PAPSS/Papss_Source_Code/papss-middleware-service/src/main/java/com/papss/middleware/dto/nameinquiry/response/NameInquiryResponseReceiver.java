package com.papss.middleware.dto.nameinquiry.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class NameInquiryResponseReceiver {
    private String instId;
    private String accountNumber;
    private String accountName;
    private String emailAddress;
}
