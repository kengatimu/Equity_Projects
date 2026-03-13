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
@JsonPropertyOrder({"_return"})
public class ResponseDto implements Serializable {
    private static final long serialVersionUID = 1L;

    @JsonProperty("return")
    @XmlElement(name = "return")
    private String _return;

    public String get_return() {
        return _return;
    }

    public void set_return(String _return) {
        this._return = _return;
    }

    @Override
    public String toString() {
        final StringBuilder sb = new StringBuilder("ResponseDto{");
        sb.append("_return='").append(_return).append('\'');
        sb.append('}');
        return sb.toString();
    }
}