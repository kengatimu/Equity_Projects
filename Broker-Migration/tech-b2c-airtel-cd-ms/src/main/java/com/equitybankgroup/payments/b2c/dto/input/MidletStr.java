package com.equitybankgroup.payments.b2c.dto.input;

import com.google.gson.annotations.Expose;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlAttribute;
import jakarta.xml.bind.annotation.XmlValue;


@XmlAccessorType(XmlAccessType.FIELD)
public class MidletStr {
    @Expose
    @XmlAttribute(name = "Name")
    private String name;
    @Expose
    @XmlValue
    private String description;

    public String getName() {
        return this.name;
    }


    public void setName(String name) {
        this.name = name;
    }


    public String getDescription() {
        return this.description;
    }


    public void setDescription(String description) {
        this.description = description;
    }
}


/* Location:              C:\Users\geoffrey.kamau\Desktop\111\sub-b2c\b2c-sub-0.0.1-SNAPSHOT.jar!\com\way4\MidletStr.class
 * Java compiler version: 6 (50.0)
 * JD-Core Version:       1.1.3
 */