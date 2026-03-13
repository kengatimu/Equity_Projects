package com.papss.middleware.models.participantinfo;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.xml.bind.annotation.*;
import lombok.Data;

@Data
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "participant", propOrder = {
        "bic",
        "name",
        "countryCode",
        "status",
        "paymentschemas",
        "currencies",
        "online"
})
public class Participant {

    @XmlElement(required = true)
    protected String bic;
    @XmlElement(required = true)
    protected String name;
    @XmlElement(required = true)
    protected String countryCode;
    @XmlElement(required = true)
    protected String status;
    @XmlElement(required = true)
    protected PaymentschemasType paymentschemas;
    @XmlElement(required = true)
    protected CurrenciesType currencies;
    @XmlElement(required = true)
    @JsonProperty("online")
    protected Boolean online;
    @XmlAttribute(name = "papssId")
    protected String instId;
}
