
package com.equitybank.payments.imt.b2c.drcbroker.service.model.request;

import java.io.Serializable;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "amount",
    "sender",
    "name",
    "number",
    "telco",
    "rrn",
    "signature"
})
@Generated("jsonschema2pojo")
public class Eazzycash implements Serializable {

    @JsonProperty("amount")
    private String amount = "";
    @JsonProperty("sender")
    private String sender = "";
    @JsonProperty("name")
    private String name = "";
    @JsonProperty("number")
    private String number = "";
    @JsonProperty("telco")
    private String telco = "";
    @JsonProperty("rrn")
    private String rrn = "";
    @JsonProperty("signature")
    private String signature = "";
    private final static long serialVersionUID = -296906014110181744L;

    @JsonProperty("amount")
    public String getAmount() {
        return amount;
    }

    @JsonProperty("amount")
    public void setAmount(String amount) {
        this.amount = amount;
    }

    @JsonProperty("sender")
    public String getSender() {
        return sender;
    }

    @JsonProperty("sender")
    public void setSender(String sender) {
        this.sender = sender;
    }

    @JsonProperty("name")
    public String getName() {
        return name;
    }

    @JsonProperty("name")
    public void setName(String name) {
        this.name = name;
    }

    @JsonProperty("number")
    public String getNumber() {
        return number;
    }

    @JsonProperty("number")
    public void setNumber(String number) {
        this.number = number;
    }

    @JsonProperty("telco")
    public String getTelco() {
        return telco;
    }

    @JsonProperty("telco")
    public void setTelco(String telco) {
        this.telco = telco;
    }

    @JsonProperty("rrn")
    public String getRrn() {
        return rrn;
    }

    @JsonProperty("rrn")
    public void setRrn(String rrn) {
        this.rrn = rrn;
    }

    @JsonProperty("signature")
    public String getSignature() {
        return signature;
    }

    @JsonProperty("signature")
    public void setSignature(String signature) {
        this.signature = signature;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(Eazzycash.class.getName()).append('@').append(Integer.toHexString(System.identityHashCode(this))).append('[');
        sb.append("amount");
        sb.append('=');
        sb.append(((this.amount == null)?"<null>":this.amount));
        sb.append(',');
        sb.append("sender");
        sb.append('=');
        sb.append(((this.sender == null)?"<null>":this.sender));
        sb.append(',');
        sb.append("name");
        sb.append('=');
        sb.append(((this.name == null)?"<null>":this.name));
        sb.append(',');
        sb.append("number");
        sb.append('=');
        sb.append(((this.number == null)?"<null>":this.number));
        sb.append(',');
        sb.append("telco");
        sb.append('=');
        sb.append(((this.telco == null)?"<null>":this.telco));
        sb.append(',');
        sb.append("rrn");
        sb.append('=');
        sb.append(((this.rrn == null)?"<null>":this.rrn));
        sb.append(',');
        sb.append("signature");
        sb.append('=');
        sb.append(((this.signature == null)?"<null>":this.signature));
        sb.append(',');
        if (sb.charAt((sb.length()- 1)) == ',') {
            sb.setCharAt((sb.length()- 1), ']');
        } else {
            sb.append(']');
        }
        return sb.toString();
    }

}
