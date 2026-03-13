package com.equitybank.gag.telco_b2c.dto.airtime.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.Valid;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlRootElement;

import java.io.Serializable;

@XmlRootElement(name = "Envelope", namespace = "http://schemas.xmlsoap.org/soap/envelope/")
@XmlAccessorType(XmlAccessType.FIELD)
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({"Envelope"})
public class ResponsePojo implements Serializable {
    private static final long serialVersionUID = 1L;

    @Valid
    @JsonProperty(value = "Envelope", namespace = "http://schemas.xmlsoap.org/soap/envelope/")
    private ResponseEnvelop responseEnvelop;

    public ResponseEnvelop getEnvelope() {
        return responseEnvelop;
    }

    public void setEnvelope(ResponseEnvelop responseEnvelop) {
        this.responseEnvelop = responseEnvelop;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("ResponsePojo{");
        sb.append("envelope=").append(responseEnvelop);
        sb.append('}');
        return sb.toString();
    }
}