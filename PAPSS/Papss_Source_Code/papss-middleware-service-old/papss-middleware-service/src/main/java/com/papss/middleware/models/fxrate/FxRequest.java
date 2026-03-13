package com.papss.middleware.models.fxrate;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlAttribute;
import lombok.Data;

@Data
@XmlAccessorType(XmlAccessType.FIELD)
public class FxRequest {
    @XmlAttribute(name = "LclInstrm")
    private String lclInstrm;
    @XmlAttribute(name = "ReceiverBank")
    private String receiverBank;
    @XmlAttribute(name = "ReceiverCountry")
    private String receiverCountry;
    @XmlAttribute(name = "ReceiverCurrency")
    private String receiverCurrency;
    @XmlAttribute(name = "SenderCountry")
    private String senderCountry;
    @XmlAttribute(name = "SenderCurrency")
    private String senderCurrency;
    @XmlAttribute(name = "amount")
    private String amount;
    @XmlAttribute(name = "isInvoice")
    private String isInvoice;
    @XmlAttribute(name = "time")
    private String time;
}
