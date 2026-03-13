package com.papss.middleware.service.outbound;

import com.papss.middleware.service.outbound.domains.nameenquiry.NameInquiryRequest;
import com.papss.middleware.dto.nameinquiry.response.NameInquiryResponse;
import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.models.Participant;
import com.papss.middleware.service.PapssService;
import com.papss.middleware.service.PapssSignature;
import com.papss.middleware.utils.RequestUtils;
import com.papss.middleware.utils.ResponseUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import java.security.SignatureException;

@Slf4j
@Service
@RequiredArgsConstructor
public class NameEnquiryService {

    private final RequestUtils requestUtils;
    private final ResponseUtils responseUtils;
    private final PapssSignature papssSignature;
    private final PapssService papssService;

    public NameInquiryResponse sendNameInquiryMessage(NameInquiryRequest dto, String papssId, Participant participant)
            throws SignatureException {

        log.info("Sending OutBound Request");

        String endToEndRef = dto.getEndToEndRef();
        String acmt023XML = requestUtils.generateMessage(dto);
        String signedMsg = papssSignature.generateSignature(acmt023XML, participant.getSslKeyAlias(), participant.getKeyPass());
        log.debug("Message to be sent SIGNED: {}", signedMsg);

        RtpMessageDto rtpMessageDto = papssService.sendMessage(papssId, signedMsg, participant.getSslKeyAlias());

        log.info("Done OutBound Request");
        //return null;
        return responseUtils.generateResponse(rtpMessageDto, endToEndRef);
    }

}
