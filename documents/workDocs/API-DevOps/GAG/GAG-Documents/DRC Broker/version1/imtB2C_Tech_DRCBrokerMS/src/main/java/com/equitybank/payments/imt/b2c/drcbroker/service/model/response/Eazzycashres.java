
package com.equitybank.payments.imt.b2c.drcbroker.service.model.response;

import java.io.Serializable;
import javax.annotation.Generated;
import javax.xml.bind.annotation.*;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "status",
    "tranID"
})
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "Eazzycashres", propOrder = { "status", "tranID" })
public class Eazzycashres implements Serializable
{

    @XmlElement(name = "status", required = true)
    @JsonProperty("status")
    private String status;

    @XmlElement(name = "tranID", required = true)
    @JsonProperty("tranID")
    private String tranID;
    private final static long serialVersionUID = 4019626396046224266L;

    @JsonProperty("status")
    public String getStatus() {
        return status;
    }

    @JsonProperty("status")
    public void setStatus(String status) {
        this.status = status;
    }

    @JsonProperty("tranID")
    public String getTranID() {
        return tranID;
    }

    @JsonProperty("tranID")
    public void setTranID(String tranID) {
        this.tranID = tranID;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(Eazzycashres.class.getName()).append('@').append(Integer.toHexString(System.identityHashCode(this))).append('[');
        sb.append("status");
        sb.append('=');
        sb.append(((this.status == null)?"<null>":this.status));
        sb.append(',');
        sb.append("tranID");
        sb.append('=');
        sb.append(((this.tranID == null)?"<null>":this.tranID));
        sb.append(',');
        if (sb.charAt((sb.length()- 1)) == ',') {
            sb.setCharAt((sb.length()- 1), ']');
        } else {
            sb.append(']');
        }
        return sb.toString();
    }

}
