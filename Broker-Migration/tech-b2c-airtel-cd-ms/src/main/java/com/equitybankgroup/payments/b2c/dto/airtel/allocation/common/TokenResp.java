package com.equitybankgroup.payments.b2c.dto.airtel.allocation.common;

import com.google.gson.annotations.Expose;

import java.util.Date;

public class TokenResp {
    @Expose
    private String access_token;

    @Expose
    private String expires_in;

    @Expose
    private Date createdOn;

    public String getAccess_token() {
        return this.access_token;
    }

    public void setAccess_token(String access_token) {
        this.access_token = access_token;
    }

    public String getExpires_in() {
        return this.expires_in;
    }

    public void setExpires_in(String expires_in) {
        this.expires_in = expires_in;
    }

    public Date getCreatedOn() {
        return this.createdOn;
    }

    public void setCreatedOn(Date createdOn) {
        this.createdOn = createdOn;
    }
}
