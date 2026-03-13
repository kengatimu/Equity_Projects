package com.equitybankgroup.payments.b2c.dto.input;

import com.google.gson.annotations.Expose;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlRootElement;


@XmlRootElement(name = "response")
@XmlAccessorType(XmlAccessType.FIELD)
public class InqResponse {
    @Expose
    @XmlElement(name = "msgId")
    private String msgId;
    @Expose
    @XmlElement(name = "eazzycashres")
    private Eazzycashres eazzycashres;

    public String getMsgId() {
        return this.msgId;
    }


    public void setMsgId(String msgId) {
        this.msgId = msgId;
    }


    public Eazzycashres getEazzycashres() {
        return this.eazzycashres;
    }


    public void setEazzycashres(Eazzycashres eazzycashres) {
        this.eazzycashres = eazzycashres;
    }
}


/* Location:              C:\Users\geoffrey.kamau\Desktop\111\sub-b2c\b2c-sub-0.0.1-SNAPSHOT.jar!\com\way4\InqResponse.class
 * Java compiler version: 6 (50.0)
 * JD-Core Version:       1.1.3
 */