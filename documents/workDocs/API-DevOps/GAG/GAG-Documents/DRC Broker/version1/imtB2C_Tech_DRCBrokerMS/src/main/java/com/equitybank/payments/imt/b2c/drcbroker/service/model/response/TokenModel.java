
package com.equitybank.payments.imt.b2c.drcbroker.service.model.response;

import java.io.Serializable;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import com.google.gson.annotations.Expose;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "access_token",
    "token_type",
    "expires_in"
})
@Generated("jsonschema2pojo")
public class TokenModel implements Serializable {
    private final static long serialVersionUID = -7504890628803070371L;

    @JsonProperty("access_token")
    @Expose
    private String access_token;

    @JsonProperty("token_type")
    @Expose
    private String token_type;

    @JsonProperty("expires_in")
    @Expose
    private Integer expires_in;

    public String getAccess_token() {
        return access_token;
    }

    public void setAccess_token(String access_token) {
        this.access_token = access_token;
    }

    public String getToken_type() {
        return token_type;
    }

    public void setToken_type(String token_type) {
        this.token_type = token_type;
    }

    public Integer getExpires_in() {
        return expires_in;
    }

    public void setExpires_in(Integer expires_in) {
        this.expires_in = expires_in;
    }

    @Override
    public String toString() {
        return "TokenModel{" +
                "access_token='" + access_token + '\'' +
                ", token_type='" + token_type + '\'' +
                ", expires_in=" + expires_in +
                '}';
    }
}
