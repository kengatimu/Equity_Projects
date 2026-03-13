
package com.equitybank.gag.dummy_telco_b2c_ms.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "action",
    "alias",
    "amount",
    "language",
    "to"
})
public class TelcoRequestDto implements Serializable {
    private final static long serialVersionUID = -3280986672034637565L;

    @JsonProperty("action")
    private String action;

    @JsonProperty("alias")
    private String alias;

    @JsonProperty("amount")
    private String amount;

    @JsonProperty("language")
    private String language;

    @JsonProperty("to")
    private To to;

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public To getTo() {
        return to;
    }

    public void setTo(To to) {
        this.to = to;
    }
}
