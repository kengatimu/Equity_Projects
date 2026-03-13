package com.equitybank.gag.dummy_telco_b2c_ms.dto.b2c.tran.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import java.io.Serializable;

@XmlAccessorType(XmlAccessType.FIELD)
@JsonPropertyOrder({
        "AccountToWalletTransfer"
})
public class Body implements Serializable {
    private static final long serialVersionUID = -3216418243679386514L;

    @XmlElement(name = "AccountToWalletTransfer", namespace = "http://b2w.banktowallet.com/b2w")
    @JsonProperty("AccountToWalletTransfer")
    private AccountToWalletTransfer accountToWalletTransfer;

    @JsonProperty("AccountToWalletTransfer")
    public AccountToWalletTransfer getAccountToWalletTransfer() {
        return accountToWalletTransfer;
    }

    @JsonProperty("AccountToWalletTransfer")
    public void setAccountToWalletTransfer(AccountToWalletTransfer accountToWalletTransfer) {
        this.accountToWalletTransfer = accountToWalletTransfer;
    }
}
