package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input;

import com.google.gson.annotations.Expose;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement(name = "response")
@XmlAccessorType(XmlAccessType.FIELD)
public class InquireResponse {
    @Expose
    @XmlElement(name = "msgId")
    private String msgId;
    @Expose
    @XmlElement(name = "eazzycashres")
    private Eazzycashres1 eazzycashres;

    public String getMsgId() {
        return this.msgId;
    }


    public void setMsgId(String msgId) {
        this.msgId = msgId;
    }

    public Eazzycashres1 getEazzycashres() {
        return eazzycashres;
    }

    public void setEazzycashres(Eazzycashres1 eazzycashres) {
        this.eazzycashres = eazzycashres;
    }

    
    
    
}


/* Location:              C:\Users\geoffrey.kamau\Desktop\111\sub-b2c\b2c-sub-0.0.1-SNAPSHOT.jar!\com\way4\InqResponse.class
 * Java compiler version: 6 (50.0)
 * JD-Core Version:       1.1.3
 */