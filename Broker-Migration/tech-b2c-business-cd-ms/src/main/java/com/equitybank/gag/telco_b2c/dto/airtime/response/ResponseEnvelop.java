package com.equitybank.gag.telco_b2c.dto.airtime.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.validation.Valid;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlRootElement;

import java.io.Serializable;

@XmlAccessorType(XmlAccessType.FIELD)
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({"Body"})
public class ResponseEnvelop implements Serializable {
    private static final long serialVersionUID = 1L;

    @Valid
    @JsonProperty(value = "Body", namespace = "http://schemas.xmlsoap.org/soap/envelope/")
//    @XmlElement(name = "Body", namespace = "http://schemas.xmlsoap.org/soap/envelope/")
    private ResponseBody responseBody;

    public ResponseBody getBody() {
        return responseBody;
    }

    public void setBody(ResponseBody responseBody) {
        this.responseBody = responseBody;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("Envelope{");
        sb.append("body=").append(responseBody);
        sb.append('}');
        return sb.toString();
    }
}