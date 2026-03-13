/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.mtn_money_ms.enums;

import org.hibernate.validator.constraints.NotBlank;

public enum TranStatus {
    PROCESSING("PROCESSING"),
    PENDING("PENDING"),
    SUCCESS("SUCCESS"),
    FAILURE("FAILURE"),
    EXPIRED("EXPIRED"),
    UNKNOWN("UNKNOWN"),
    REVERSED("REVERSED"),
    GENERATED("GENERATED"),
    ERROR("ERROR"),
    REJECTED("REJECTED"),
    TIMEOUT("TIMEOUT");

    private final String value;

    private TranStatus(@NotBlank String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
