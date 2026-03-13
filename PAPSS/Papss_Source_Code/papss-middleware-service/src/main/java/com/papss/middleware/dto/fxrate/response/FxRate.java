package com.papss.middleware.dto.fxrate.response;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.xml.bind.annotation.XmlAttribute;
import jakarta.xml.bind.annotation.XmlRootElement;
import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
@JsonIgnoreProperties(ignoreUnknown = true)
public class FxRate {

    @JsonProperty(value = "localCurrency")
    private String localCurrency;
    @XmlAttribute(name = "settlementCurrency")
    private String settlementCurrency;
    @XmlAttribute(name = "buyRate")
    private String buyRate;
    @XmlAttribute(name = "sellRate")
    private String sellRate;
    @XmlAttribute(name = "lastUpdate")
    private String lastUpdate;
    @XmlAttribute(name = "accountType")
    private String accountType;
    @XmlAttribute(name = "name")
    private String name;
    @XmlAttribute(name = "countryCode")
    private String countryCode;

}
