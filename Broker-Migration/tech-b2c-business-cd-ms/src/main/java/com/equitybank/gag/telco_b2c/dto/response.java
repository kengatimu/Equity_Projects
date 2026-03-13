package com.equitybank.gag.telco_b2c.dto;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

//This is a wrapper class to make sure the format of the xml is maintained

@XmlRootElement(name = "response")
public class response {

    @XmlElement(name = "MsgId")
    private String msgId;

    @XmlElement(name = "eazzycashres")
    private ChannelResponseDto eazzycashres;

    // Default Constructor
    public response() {
    }

    // Constructor with parameters
    public response(ChannelResponseDto eazzycashres) {
        this.eazzycashres = eazzycashres;
    }

//    // Constructor with parameters
//    public response(String msgId, OmniResponseDto eazzycashres) {
//        this.msgId = msgId;
//        this.eazzycashres = eazzycashres;
//    }

    // Getters and Setters
    public String getMsgId() {
        return msgId;
    }

    public void setMsgId(String msgId) {
        this.msgId = msgId;
    }

    public ChannelResponseDto getEazzycashres() {
        return eazzycashres;
    }

    public void setEazzycashres(ChannelResponseDto eazzycashres) {
        this.eazzycashres = eazzycashres;
    }
}
