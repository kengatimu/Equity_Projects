/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.payments.imt.b2c.drcbroker.domain.enumeration;

import javax.validation.constraints.NotBlank;

public enum ResponseStatusCode {
    SUCCESS("SUCCESS"),
    FAILURE("FAILURE"),
    PERSISTED("PERSISTED"),
    ACCEPTED("ACCEPTED"),
    REJECTED("REJECTED");

    private final String value;

    private ResponseStatusCode(@NotBlank String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
