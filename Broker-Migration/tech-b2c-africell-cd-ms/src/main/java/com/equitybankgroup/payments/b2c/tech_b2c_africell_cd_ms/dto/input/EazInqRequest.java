package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input;

import com.google.gson.annotations.Expose;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlRootElement;
import lombok.Getter;
import lombok.Setter;


@Setter
@Getter
@XmlRootElement(name = "request")
@XmlAccessorType(XmlAccessType.FIELD)
public class EazInqRequest {
    @Expose
    @XmlElement(name = "msgId", required = false)
    private int msgId;
    @Expose
    @XmlElement(name = "eazzycash")
    private Eazzycash eazzycash;

    public String toString() {
        return "InqRequest{msgId=" + this.msgId + ", eazzycash=" + this.eazzycash.toString() + '}';
    }
}