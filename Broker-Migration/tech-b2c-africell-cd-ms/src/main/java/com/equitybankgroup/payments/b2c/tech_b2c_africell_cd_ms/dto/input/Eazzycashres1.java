package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input;

import com.google.gson.annotations.Expose;

import javax.xml.bind.annotation.XmlElement;

public class Eazzycashres1 {
    @Expose
    @XmlElement(name = "status")
    public String status;

    @Expose
    @XmlElement(name = "walletTranID")
    public String walletTranID;

    @Expose
    @XmlElement(name = "responseCode")
    public String responseCode;

    @Expose
    @XmlElement(name = "responseDesc")
    public String responseDesc;
}
