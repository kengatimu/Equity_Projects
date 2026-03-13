package com.papss.middleware.dto.rtpmessage;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class RtpMessageDto {
    private String messageType;
    private Long sequence;
    private String statusCode;
    private String errorMapping;
    private String description;
    private String content;

    private String responseContent;
    private Integer remainingOutputs;
    private Boolean possibleDuplicate;
    private Boolean isCleared;
    private Long processingDuration;

    private String papssId;
    private String countryCode;
    private String bic;
    private String sslKeyAlias;
    private String keyPass;
}
