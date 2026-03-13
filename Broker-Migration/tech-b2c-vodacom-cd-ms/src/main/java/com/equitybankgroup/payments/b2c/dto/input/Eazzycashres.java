package com.equitybankgroup.payments.b2c.dto.input;

import com.google.gson.annotations.Expose;

import jakarta.xml.bind.annotation.XmlElement;

public class Eazzycashres {
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
