package com.equitybank.payments.imt.b2c.drcbroker.web.rest.errors;

public class CustomException extends RuntimeException {

    /**
     * add generated serialVersionUID
     */
    private static final long serialVersionUID = -7905739677608486619L;

    public CustomException(String message) {
        super(message);
    }

}
