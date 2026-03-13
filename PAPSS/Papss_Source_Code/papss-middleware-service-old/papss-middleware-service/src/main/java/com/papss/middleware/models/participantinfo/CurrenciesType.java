package com.papss.middleware.models.participantinfo;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;
import lombok.Data;

import java.util.List;

@Data
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "currenciesType", propOrder = {
        "currencies"
})
public class CurrenciesType {

    @XmlElement(name = "currency")
    protected List<String> currencies;
}
