package com.papss.middleware.dto.nameinquiry.response;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.papss.middleware.service.outbound.domains.credittransfer.Status;
import lombok.Data;

import javax.xml.datatype.XMLGregorianCalendar;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class NameInquiryResponseDto {
    private String tranRef;
    private XMLGregorianCalendar tranDateTime;
    private String instId;
    private String accountNumber;
    private String accountName;
    private String emailAddress;
    private Status status;
}
