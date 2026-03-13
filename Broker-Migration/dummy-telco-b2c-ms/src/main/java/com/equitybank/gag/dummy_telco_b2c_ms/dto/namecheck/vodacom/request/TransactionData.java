package com.equitybank.gag.dummy_telco_b2c_ms.dto.namecheck.vodacom.request;

import java.io.Serializable;
import java.util.List;

public class TransactionData implements Serializable {
    private static final long serialVersionUID = 1L;

    private String OriginatorConversationID;
    private String Timestamp;
    private List<Identity> Identities;
    private Transaction Transaction;

    // Getters and Setters
    public String getOriginatorConversationID() {
        return OriginatorConversationID;
    }

    public void setOriginatorConversationID(String originatorConversationID) {
        this.OriginatorConversationID = originatorConversationID;
    }

    public String getTimestamp() {
        return Timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.Timestamp = timestamp;
    }

    public List<Identity> getIdentities() {
        return Identities;
    }

    public void setIdentities(List<Identity> identities) {
        this.Identities = identities;
    }

    public Transaction getTransaction() {
        return Transaction;
    }

    public void setTransaction(Transaction transaction) {
        this.Transaction = transaction;
    }
}