package com.equitybankgroup.payments.b2c.dto.input;

import com.google.gson.annotations.Expose;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlAttribute;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlRootElement;


@XmlRootElement(name = "MidletRq")
@XmlAccessorType(XmlAccessType.FIELD)
public class MidletRq {
    @Expose
    @XmlAttribute(name = "Mode")
    private String mode;
    @Expose
    @XmlAttribute(name = "version")
    private String version;
    @Expose
    @XmlElement(name = "Set")
    private MidletSet MidletSet;

    public MidletSet getMidletSet() {
        return this.MidletSet;
    }


    public void setMidletSet(MidletSet midletSet) {
        this.MidletSet = midletSet;
    }


    public String getVersion() {
        return this.version;
    }


    public void setVersion(String version) {
        this.version = version;
    }


    public String getMode() {
        return this.mode;
    }


    public void setMode(String mode) {
        this.mode = mode;
    }
}


/* Location:              C:\Users\geoffrey.kamau\Desktop\111\sub-b2c\b2c-sub-0.0.1-SNAPSHOT.jar!\com\way4\MidletRq.class
 * Java compiler version: 6 (50.0)
 * JD-Core Version:       1.1.3
 */