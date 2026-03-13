
package com.equitybank.gag.orange_money_ms.dto.b2c.status.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import javax.annotation.Generated;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import java.io.Serializable;

@XmlAccessorType(XmlAccessType.FIELD)
@JsonPropertyOrder({
    "TranRequestInfo"
})
@Generated("jsonschema2pojo")
public class TransferStatusInquiry implements Serializable {
    private final static long serialVersionUID = 1080653692356430821L;

    @XmlElement(name = "TranRequestInfo")
    @JsonProperty("TranRequestInfo")
    private TranRequestInfo tranRequestInfo;

    @JsonProperty("TranRequestInfo")
    public TranRequestInfo getTranRequestInfo() {
        return tranRequestInfo;
    }

    @JsonProperty("TranRequestInfo")
    public void setTranRequestInfo(TranRequestInfo tranRequestInfo) {
        this.tranRequestInfo = tranRequestInfo;
    }

}
