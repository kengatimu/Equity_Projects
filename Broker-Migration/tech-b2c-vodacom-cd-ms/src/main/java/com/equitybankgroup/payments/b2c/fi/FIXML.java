package com.equitybankgroup.payments.b2c.fi;


import lombok.Data;

import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;


@Data
@XmlRootElement(name = "FIXML",namespace = "http://www.finacle.com/fixml")
public class FIXML {
    private Header header;
    private Body body;

    @XmlElement(name = "Header",namespace = "http://www.finacle.com/fixml")
    public Header getHeader() {
        return header;
    }
    @XmlElement(name = "Body",namespace = "http://www.finacle.com/fixml")
    public Body getBody() {
        return body;
    }
}
