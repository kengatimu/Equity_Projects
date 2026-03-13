package com.equitybank.gag.telco_b2c.dto.airtime.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;

import java.io.Serializable;

@XmlAccessorType(XmlAccessType.FIELD)
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({"topupResponse"})
public class ResponseBody implements Serializable {
    private static final long serialVersionUID = 1L;

    @JsonProperty(value = "topup", namespace = "http://business.airtime.telcos.equitybank.com/")
    @XmlElement(name = "topupResponse", namespace = "http://business.airtime.telcos.equitybank.com/")
    private ResponseDto topupResponse;

    // Getters and Setters
    public ResponseDto getTopupResponse() {
        return topupResponse;
    }

    public void setTopupResponse(ResponseDto topupResponse) {
        this.topupResponse = topupResponse;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("Body{");
        sb.append("topupResponse=").append(topupResponse);
        sb.append('}');
        return sb.toString();
    }
}
