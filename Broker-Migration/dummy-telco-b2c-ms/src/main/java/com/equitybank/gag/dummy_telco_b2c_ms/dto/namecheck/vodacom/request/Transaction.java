package com.equitybank.gag.dummy_telco_b2c_ms.dto.namecheck.vodacom.request;

import java.io.Serializable;

public class Transaction implements Serializable {
    private static final long serialVersionUID = 1L;

    private String CommandID;

    // Getters and Setters
    public String getCommandID() {
        return CommandID;
    }

    public void setCommandID(String commandID) {
        this.CommandID = commandID;
    }
}