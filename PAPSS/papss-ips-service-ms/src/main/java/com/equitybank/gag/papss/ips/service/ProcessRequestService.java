package com.equitybank.gag.papss.ips.service;

import com.equitybank.gag.papss.ips.exception.CustomException;
import com.equitybank.gag.papss.ips.pojo.channelRequest.namecheck.ChannelNamecheckDetailsReq;
import com.equitybank.gag.papss.ips.pojo.channelResponse.ChannelResponse;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.util.Map;

public interface ProcessRequestService {
    String processGetParticipantsRequest(boolean isError, Map<String, Object> queryParams);

    String processFxRateRequest (boolean isError);

    String processNamecheckRequest (String namecheckRequestXml);

    String processCreditTransferRequest (String namecheckRequestXml, String state, String finalState) throws ParserConfigurationException, IOException, SAXException;

    String processStatusCheckRequest (String statusCheckRequestXml, String state, String finalState);

    ChannelResponse processInboundNamecheckRequest(ChannelNamecheckDetailsReq channelNamecheckDetailsReq) throws CustomException;

}
