package com.equitybank.gag.telco_b2c.dto.thunes.response;

import java.io.Serializable;

public class ChannelStatusInfo implements Serializable {
    private final static long serialVersionUID = 1L;

    private String status;
    private String code;
    private String description;

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}

