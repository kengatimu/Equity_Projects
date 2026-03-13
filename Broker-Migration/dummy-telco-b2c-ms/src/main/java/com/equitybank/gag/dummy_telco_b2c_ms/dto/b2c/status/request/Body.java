
package com.equitybank.gag.dummy_telco_b2c_ms.dto.b2c.status.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import java.io.Serializable;

@XmlAccessorType(XmlAccessType.FIELD)
@JsonPropertyOrder({
    "TransferStatusInquiry"
})
public class Body implements Serializable {
    private final static long serialVersionUID = 6271182443923886512L;

    @XmlElement(name = "TransferStatusInquiry", namespace = "http://b2w.banktowallet.com/b2w")
    @JsonProperty("TransferStatusInquiry")
    private TransferStatusInquiry transferStatusInquiry;

    @JsonProperty("TransferStatusInquiry")
    public TransferStatusInquiry getTransferStatusInquiry() {
        return transferStatusInquiry;
    }

    @JsonProperty("TransferStatusInquiry")
    public void setTransferStatusInquiry(TransferStatusInquiry transferStatusInquiry) {
        this.transferStatusInquiry = transferStatusInquiry;
    }

}
