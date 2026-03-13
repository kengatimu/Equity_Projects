package com.equitybank.gag.orange_money_ms.dto.channel.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.constraints.Size;
import javax.validation.Valid;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;


import java.io.Serializable;

@XmlRootElement(name = "request")
@XmlAccessorType(XmlAccessType.FIELD)
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({"eazzycash"})
public class request implements Serializable {
    private static final long serialVersionUID = -5018356144189357897L;
    
    @JsonProperty("msgId")
    @jakarta.xml.bind.annotation.XmlElement(name = "msgId")
//    @NotBlank(message = "msgId tag cannot be null")
//    @Size(min = 12, max = 12, message = "msgId must be exactly 12 characters")
    private String msgId;

    public String getMsgId() {
        return msgId;
    }

    public void setMsgId(String msgId) {
        this.msgId = msgId;
    }
    
    
    
    @Valid
    @JsonProperty("eazzycash")
    @XmlElement(name = "eazzycash")
    @NotNull(message = "Eazzycash tag cannot be null")
    private Eazzycash eazzycash;

    public Eazzycash getEazzycash() {
        return eazzycash;
    }

    public void setEazzycash(Eazzycash eazzycash) {
        this.eazzycash = eazzycash;
    }
}
