package com.equitybank.gag.papss.its.service;

import org.jpos.transaction.Context;

public interface SendAcknowledgementService {
    void sendAck (Boolean sendAck, Boolean sequenceExists, String messageSeq, String messageType, Context ctx);
}
