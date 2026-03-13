package com.equitybankgroup.payments.b2c.dto.input;

import com.google.gson.annotations.Expose;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlRootElement;


@XmlRootElement(name = "request")
@XmlAccessorType(XmlAccessType.FIELD)
public class EazInqRequest {
    @Expose
    @XmlElement(name = "msgId", required = false)
    private int msgId;
    @Expose
    @XmlElement(name = "eazzycash")
    private Eazzycash eazzycash;

    public int getMsgId() {
        return this.msgId;
    }


    public void setMsgId(int msgId) {
        this.msgId = msgId;
    }


    public Eazzycash getEazzycash() {
        return this.eazzycash;
    }


    public void setEazzycash(Eazzycash eazzycash) {
        this.eazzycash = eazzycash;
    }


    public String toString() {
        return "InqRequest{msgId=" + this.msgId + ", eazzycash=" + this.eazzycash.toString() + '}';
    }
}


/* Location:              C:\Users\geoffrey.kamau\Desktop\111\sub-b2c\b2c-sub-0.0.1-SNAPSHOT.jar!\com\way4\EazInqRequest.class
 * Java compiler version: 6 (50.0)
 * JD-Core Version:       1.1.3
 */