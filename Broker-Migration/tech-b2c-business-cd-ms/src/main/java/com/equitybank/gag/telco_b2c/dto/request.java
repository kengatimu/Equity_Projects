package com.equitybank.gag.telco_b2c.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlRootElement;

import java.io.Serializable;

@XmlRootElement(name = "request")
@XmlAccessorType(XmlAccessType.FIELD)
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({"eazzycash"})
public class request implements Serializable {
    private static final long serialVersionUID = -5018356144189357897L;

    @JsonProperty("msgId")
    @XmlElement(name = "msgId")
//    @NotBlank(message = "msgId tag cannot be null")
//    @Size(min = 12, max = 12, message = "msgId must be exactly 12 characters")
    @Size(min = 12, message = "msgId must be atleast 12 characters")
    private String msgId;

    @Valid
    @JsonProperty("eazzycash")
    @XmlElement(name = "eazzycash")
    @NotNull(message = "Eazzycash tag cannot be null")
    private Eazzycash eazzycash;

    public String getMsgId() {
        return msgId;
    }

    public void setMsgId(String msgId) {
        this.msgId = msgId;
    }

    public Eazzycash getEazzycash() {
        return eazzycash;
    }

    public void setEazzycash(Eazzycash eazzycash) {
        this.eazzycash = eazzycash;
    }
}
