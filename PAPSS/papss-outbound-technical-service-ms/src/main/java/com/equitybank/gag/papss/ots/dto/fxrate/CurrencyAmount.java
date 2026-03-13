package com.equitybank.gag.papss.ots.dto.fxrate;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlText;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class CurrencyAmount implements Serializable {
    private final static long serialVersionUID = 1L;

    @JacksonXmlProperty(isAttribute = true)
    private String Ccy;

    @JacksonXmlText
    private String value;

    public String getCcy() {
        return Ccy;
    }

    public void setCcy(String ccy) {
        Ccy = ccy;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
