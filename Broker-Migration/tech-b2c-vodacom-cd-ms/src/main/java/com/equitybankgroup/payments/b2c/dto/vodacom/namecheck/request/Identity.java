package com.equitybankgroup.payments.b2c.dto.vodacom.namecheck.request;

import java.io.Serializable;

public class Identity implements Serializable {
    private static final long serialVersionUID = 1L;

    private String IdentifierRole;
    private String IdentifierType;
    private String Identifier;

    // Getters and Setters
    public String getIdentifierRole() {
        return IdentifierRole;
    }

    public void setIdentifierRole(String identifierRole) {
        this.IdentifierRole = identifierRole;
    }

    public String getIdentifierType() {
        return IdentifierType;
    }

    public void setIdentifierType(String identifierType) {
        this.IdentifierType = identifierType;
    }

    public String getIdentifier() {
        return Identifier;
    }

    public void setIdentifier(String identifier) {
        this.Identifier = identifier;
    }
}