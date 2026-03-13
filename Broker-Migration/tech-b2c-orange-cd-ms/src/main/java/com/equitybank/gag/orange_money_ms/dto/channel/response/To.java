
package com.equitybank.gag.orange_money_ms.dto.channel.response;

import java.io.Serializable;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "msisdn",
    "userType"
})
public class To implements Serializable {
    private final static long serialVersionUID = -7289442582137792057L;

    @JsonProperty("msisdn")
    private String msisdn;

    @JsonProperty("userType")
    private String userType;

    public String getMsisdn() {
        return msisdn;
    }

    public void setMsisdn(String msisdn) {
        this.msisdn = msisdn;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }
}
