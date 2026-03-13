package com.equitybank.gag.papss.its.service;

import com.equitybank.gag.papss.its.pojo.papssMessages.InboundMessageReqObject;

public interface PapssInboundMessageRouterService {
    void route(InboundMessageReqObject inboundReq, boolean possibleDuplicate);
}
