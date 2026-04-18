
package com.equitybank.payments.imt.b2c.drcbroker.service.model.response;

import java.io.Serializable;
import javax.annotation.Generated;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@XmlRootElement(name = "response")
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "MsgId",
    "eazzycashres"
})
@XmlType(name = "BusinessServiceResponseModel", propOrder = { "msgId", "eazzycashres" })
public class BusinessServiceResponseModel implements Serializable
{

    @JsonProperty("MsgId")
    private String msgId;

    @JsonProperty("eazzycashres")
    private Eazzycashres eazzycashres;
    private final static long serialVersionUID = 3211868560318006174L;

    @XmlElement(name = "MsgId")
    @JsonProperty("MsgId")
    public String getMsgId() {
        return msgId;
    }

    @JsonProperty("MsgId")
    public void setMsgId(String msgId) {
        this.msgId = msgId;
    }

    @XmlElement(name = "eazzycashres")
    @JsonProperty("eazzycashres")
    public Eazzycashres getEazzycashres() {
        return eazzycashres;
    }

    @JsonProperty("eazzycashres")
    public void setEazzycashres(Eazzycashres eazzycashres) {
        this.eazzycashres = eazzycashres;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(BusinessServiceResponseModel.class.getName()).append('@').append(Integer.toHexString(System.identityHashCode(this))).append('[');
        sb.append("msgId");
        sb.append('=');
        sb.append(((this.msgId == null)?"<null>":this.msgId));
        sb.append(',');
        sb.append("eazzycashres");
        sb.append('=');
        sb.append(((this.eazzycashres == null)?"<null>":this.eazzycashres));
        sb.append(',');
        if (sb.charAt((sb.length()- 1)) == ',') {
            sb.setCharAt((sb.length()- 1), ']');
        } else {
            sb.append(']');
        }
        return sb.toString();
    }

}
