package com.equitybank.gag.telco_b2c.dto.airtime.request;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.Valid;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;

@XmlAccessorType(XmlAccessType.FIELD)
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({"topup"})
public class Body {

    @Valid
    @JsonProperty("topup")
    @XmlElement(name = "topup", namespace = "http://business.airtime.telcos.equitybank.com/")
    private TopUp topUp;

    public TopUp getTopUp() {
        return topUp;
    }

    public void setTopUp(TopUp topUp) {
        this.topUp = topUp;
    }
}
