
package com.equitybank.payments.imt.b2c.drcbroker.service.dto;

import java.io.Serializable;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "eazzycash"
})
@Generated("jsonschema2pojo")
public class BrokerServiceSendToWalletDTO implements Serializable
{

    @JsonProperty("eazzycash")
    private Eazzycash eazzycash;
    private final static long serialVersionUID = -3708951593632309668L;

    @JsonProperty("eazzycash")
    public Eazzycash getEazzycash() {
        return eazzycash;
    }

    @JsonProperty("eazzycash")
    public void setEazzycash(Eazzycash eazzycash) {
        this.eazzycash = eazzycash;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(BrokerServiceSendToWalletDTO.class.getName()).append('@').append(Integer.toHexString(System.identityHashCode(this))).append('[');
        sb.append("eazzycash");
        sb.append('=');
        sb.append(((this.eazzycash == null)?"<null>":this.eazzycash));
        sb.append(',');
        if (sb.charAt((sb.length()- 1)) == ',') {
            sb.setCharAt((sb.length()- 1), ']');
        } else {
            sb.append(']');
        }
        return sb.toString();
    }

}
