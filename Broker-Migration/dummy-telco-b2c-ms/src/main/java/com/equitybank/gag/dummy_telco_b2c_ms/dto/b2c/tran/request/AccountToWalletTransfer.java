
package com.equitybank.gag.dummy_telco_b2c_ms.dto.b2c.tran.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import java.io.Serializable;

@XmlAccessorType(XmlAccessType.FIELD)
@JsonPropertyOrder({
    "MobileTransferRequest"
})
public class AccountToWalletTransfer implements Serializable {
    private final static long serialVersionUID = 7383595411703539620L;

    @XmlElement(name = "MobileTransferRequest")
    @JsonProperty("MobileTransferRequest")
    private MobileTransferRequest mobileTransferRequest;

    @JsonProperty("MobileTransferRequest")
    public MobileTransferRequest getMobileTransferRequest() {
        return mobileTransferRequest;
    }

    @JsonProperty("MobileTransferRequest")
    public void setMobileTransferRequest(MobileTransferRequest mobileTransferRequest) {
        this.mobileTransferRequest = mobileTransferRequest;
    }

}
