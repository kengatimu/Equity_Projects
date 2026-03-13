package com.equitybankgroup.payments.b2c.fi;

import lombok.Data;
import lombok.Setter;
import lombok.ToString;

import jakarta.xml.bind.annotation.XmlElement;

@ToString
@Setter
public class Header {
    private ResponseHeader responseHeader;

    @XmlElement(name = "ResponseHeader",namespace = "http://www.finacle.com/fixml")
    public ResponseHeader getResponseHeader() {
        return responseHeader;
    }
}
