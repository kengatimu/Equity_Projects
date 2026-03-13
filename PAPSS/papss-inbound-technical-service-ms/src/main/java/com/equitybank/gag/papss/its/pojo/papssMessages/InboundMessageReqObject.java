package com.equitybank.gag.papss.its.pojo.papssMessages;

/**
 * Lightweight wrapper for PAPSS inbound messages.
 * Contains only the extracted metadata and raw payload.
 */
public class InboundMessageReqObject {
    private final String messageType; // e.g., pacs.008 or acmt.023
    private final String messageSeq;  // X-PAPSSRTP-MessageSeq
    private final String payload;     // Full XML payload

    public InboundMessageReqObject(String messageType, String messageSeq, String payload) {
        this.messageType = messageType;
        this.messageSeq = messageSeq;
        this.payload = payload;
    }

    public String getMessageType() {
        return messageType;
    }

    public String getMessageSeq() {
        return messageSeq;
    }

    public String getPayload() {
        return payload;
    }
}
