package com.papss.middleware.service.outbound;

import com.papss.middleware.dto.rtpmessage.RtpMessageDto;
import com.papss.middleware.enums.Direction;
import com.papss.middleware.models.Participant;
import com.papss.middleware.service.LoggerService;
import com.papss.middleware.service.PapssService;
import com.papss.middleware.service.PapssSignature;
import com.papss.middleware.service.outbound.domains.credittransfer.FTResponse;
import com.papss.middleware.service.outbound.domains.financialinstitution.FinancialInstitutionRequest;
import com.papss.middleware.utils.RequestUtils;
import com.papss.middleware.utils.ResponseUtils;
import com.papss.middleware.utils.Utils;
import jakarta.xml.bind.JAXBException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.xml.datatype.XMLGregorianCalendar;
import java.io.IOException;
import java.security.SignatureException;

@Slf4j
@Service
@RequiredArgsConstructor
public class FinancialInstitutionService {
    private final RequestUtils requestUtils;
    private final ResponseUtils responseUtils;
    private final PapssSignature papssSignature;
    private final PapssService papssService;
    private final LoggerService loggerService;

    public FTResponse sendFinancialInstitutionMessage(FinancialInstitutionRequest dto, String papssId, Participant participant) throws SignatureException, JAXBException, IOException {
        log.debug("Sending OutBound Financial Institution Request");

        XMLGregorianCalendar creationDateTime = Utils.generateZuluDateTime2();
        String pacs009XML = requestUtils.generateFinancialInstitutionMessage(dto, creationDateTime, papssId, participant.getSslKeyAlias());
        String signedMsg = papssSignature.generateSignature(pacs009XML, participant.getSslKeyAlias(), participant.getKeyPass());

        log.info("Message to be sent SIGNED: {}", signedMsg);

        RtpMessageDto rtpMessageDto = papssService.sendMessage(papssId, signedMsg, participant.getSslKeyAlias());

        log.debug("Done OutBound Financial Institution Request");
        return responseUtils.generateResponse(rtpMessageDto, dto, creationDateTime);
    }
}