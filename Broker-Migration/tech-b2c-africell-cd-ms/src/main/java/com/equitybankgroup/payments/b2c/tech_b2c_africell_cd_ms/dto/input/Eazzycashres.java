package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input;

import jakarta.xml.bind.annotation.XmlElement;
import lombok.Setter;
import lombok.ToString;

@Setter
@ToString
public class Eazzycashres {

    public String status;

    public String walletTranID;

    public String responseCode;
    public String responseDesc;

    @XmlElement(name = "status")
    public String getStatus() { return status;}
    @XmlElement(name = "walletTranID")
    public String getWalletTranID() { return walletTranID;}
    @XmlElement(name = "responseCode")
    public String getResponseCode() { return responseCode;}
    @XmlElement(name = "responseDesc")
    public String getResponseDesc() { return responseDesc;}
}
