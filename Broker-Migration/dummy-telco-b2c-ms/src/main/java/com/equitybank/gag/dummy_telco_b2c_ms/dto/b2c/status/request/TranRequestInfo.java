
package com.equitybank.gag.dummy_telco_b2c_ms.dto.b2c.status.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import java.io.Serializable;

@XmlAccessorType(XmlAccessType.FIELD)
@JsonPropertyOrder({
    "mmHeaderInfo",
    "externalRefNo"
})
public class TranRequestInfo implements Serializable {
    private final static long serialVersionUID = 4492706398374765438L;

    @XmlElement(name = "mmHeaderInfo")
    @JsonProperty("mmHeaderInfo")
    private MmHeaderInfo mmHeaderInfo;

    @XmlElement(name = "externalRefNo")
    @JsonProperty("externalRefNo")
    private String externalRefNo;

    @JsonProperty("mmHeaderInfo")
    public MmHeaderInfo getMmHeaderInfo() {
        return mmHeaderInfo;
    }

    @JsonProperty("mmHeaderInfo")
    public void setMmHeaderInfo(MmHeaderInfo mmHeaderInfo) {
        this.mmHeaderInfo = mmHeaderInfo;
    }

    @JsonProperty("externalRefNo")
    public String getExternalRefNo() {
        return externalRefNo;
    }

    @JsonProperty("externalRefNo")
    public void setExternalRefNo(String externalRefNo) {
        this.externalRefNo = externalRefNo;
    }

}
