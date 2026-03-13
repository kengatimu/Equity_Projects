package com.equitybank.gag.dummy_telco_b2c_ms.dto.namecheck.vodacom.response;

import java.io.Serializable;

public class Audit implements Serializable {
    private static final long serialVersionUID = 1L;

    private String startTime;
    private String completedTime;
    private String originalTime;

    // Getters and Setters
    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getCompletedTime() {
        return completedTime;
    }

    public void setCompletedTime(String completedTime) {
        this.completedTime = completedTime;
    }

    public String getOriginalTime() {
        return originalTime;
    }

    public void setOriginalTime(String originalTime) {
        this.originalTime = originalTime;
    }
}