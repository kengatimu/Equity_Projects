package com.papss.middleware.dto.nameinquiry;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
@Builder
public class NameInquiryDto {
    private String transRef;
    private String tranDateTime;
    private String instId;
    private NameInquirySender sender;
    private NameInquiryReceiver receiver;
}
