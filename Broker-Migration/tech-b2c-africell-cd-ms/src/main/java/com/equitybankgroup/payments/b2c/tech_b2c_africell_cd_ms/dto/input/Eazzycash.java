package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input;

import com.google.gson.annotations.Expose;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import lombok.Data;

import java.math.BigDecimal;

@Data
@XmlAccessorType(XmlAccessType.FIELD)
public class Eazzycash {
    @Expose
    @XmlElement(name = "amount")
    private BigDecimal amount;
    @Expose
    @XmlElement(name = "sourceAccount")
    private String sourceAccount;
    @Expose
    @XmlElement(name = "currency")
    private String currency;
    @Expose
    @XmlElement(name = "sender")
    private String sender;
    @Expose
    @XmlElement(name = "number")
    private String number;
    @Expose
    @XmlElement(name = "senderIdNumber")
    private String senderIdNumber;
    @Expose
    @XmlElement(name = "name")
    private String name;
    @Expose
    @XmlElement(name = "telco")
    private String telco;
    @Expose
    @XmlElement(name = "rrn")
    private String rrn;
    @Expose
    @XmlElement(name = "signature")
    private String signature;
    @Expose
    @XmlElement(name = "channel")
    private String channel;
    @Expose
    @XmlElement(name = "tranID")
    private String walletTranID;

}
