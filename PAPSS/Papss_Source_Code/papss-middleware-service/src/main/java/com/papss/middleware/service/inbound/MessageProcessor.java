package com.papss.middleware.service.inbound;

import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.service.inbound.domains.PartnerResponse;

public interface MessageProcessor {
    PartnerResponse processMessage(RtpMessageDto message);
}
