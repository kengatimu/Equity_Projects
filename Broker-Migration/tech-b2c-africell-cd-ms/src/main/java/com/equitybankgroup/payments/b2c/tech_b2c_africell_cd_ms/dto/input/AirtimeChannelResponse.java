package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input;


import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.gson.annotations.Expose;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlRootElement;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.math.BigDecimal;

@Setter
@Getter
@XmlRootElement(name = "Envelope",namespace = "http://schemas.xmlsoap.org/soap/envelope/")
@XmlAccessorType(XmlAccessType.FIELD)
public class AirtimeChannelResponse {
    @Expose
    @JsonProperty("Body")
    @XmlElement(name = "Body",namespace = "http://schemas.xmlsoap.org/soap/envelope/")
    private Body body;

    @Override
    public String toString() {
        return "AirtimeChannelRequest{" +
                "body=" + body +
                '}';
    }

    @Data
    public static class Body{
        @Expose
        @XmlElement(name = "topup")
        private TopupResponse topupResponse;

        @Data
        public static class TopupResponse{
            @Expose
            @XmlElement(name = "return")
            private String returned;
        }
    }
}
