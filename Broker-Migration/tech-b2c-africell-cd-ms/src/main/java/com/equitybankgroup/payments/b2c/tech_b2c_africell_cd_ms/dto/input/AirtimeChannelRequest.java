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
public class AirtimeChannelRequest {
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
        private Topup topup;

        @Data
        public static class Topup{
            @Expose
            @XmlElement(name = "msisdnA")
            private String msisdnA;
            @Expose
            @XmlElement(name = "amount")
            private BigDecimal amount;
            @Expose
            @XmlElement(name = "currency")
            private String currency;
            @Expose
            @XmlElement(name = "telcom")
            private String telcom;
            @Expose
            @XmlElement(name = "country")
            private String country;
            @Expose
            @XmlElement(name = "channel")
            private String channel;
            @Expose
            @XmlElement(name = "signature")
            private String signature;
            @Expose
            @XmlElement(name = "eazzycash")
            private String rrn;
        }
    }
}
