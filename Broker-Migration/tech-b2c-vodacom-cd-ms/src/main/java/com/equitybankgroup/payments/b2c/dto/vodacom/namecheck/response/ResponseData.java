package com.equitybankgroup.payments.b2c.dto.vodacom.namecheck.response;

import java.io.Serializable;

public class ResponseData<T> implements Serializable {
    private static final long serialVersionUID = 1L;

    private String ResultCode;
    private String ResultDesc;
    private String OriginatorConversationID;
    private String ConversationID;
    private T ResultData;
    private Audit audit;

    public String getResultCode() {
        return ResultCode;
    }

    public void setResultCode(String resultCode) {
        ResultCode = resultCode;
    }

    public String getResultDesc() {
        return ResultDesc;
    }

    public void setResultDesc(String resultDesc) {
        ResultDesc = resultDesc;
    }

    public String getOriginatorConversationID() {
        return OriginatorConversationID;
    }

    public void setOriginatorConversationID(String originatorConversationID) {
        OriginatorConversationID = originatorConversationID;
    }

    public String getConversationID() {
        return ConversationID;
    }

    public void setConversationID(String conversationID) {
        ConversationID = conversationID;
    }

    public T getResultData() {
        return ResultData;
    }

    public void setResultData(T resultData) {
        ResultData = resultData;
    }

    public Audit getAudit() {
        return audit;
    }

    public void setAudit(Audit audit) {
        this.audit = audit;
    }
}