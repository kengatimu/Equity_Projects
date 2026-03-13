package com.papss.middleware.models.fxrate;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlAttribute;
import jakarta.xml.bind.annotation.XmlElement;
import lombok.Data;

@Data
@XmlAccessorType(XmlAccessType.FIELD)
public class FxResponse {
    @XmlElement(name = "Rate")
    private Rate[] rate;

    @XmlElement(name = "SenderAmount")
    private String senderAmount;

    @XmlElement(name = "ReceiverAmount")
    private String receiverAmount;

    @XmlElement(name = "NationalFeeAmount")
    private String nationalFeeAmount;

    @XmlElement(name = "ExchangeAmount")
    private String exchangeAmount;

    @XmlElement(name = "FeeAmount")
    private String feeAmount;

    @XmlAttribute(name = "time")
    private String time;
}
