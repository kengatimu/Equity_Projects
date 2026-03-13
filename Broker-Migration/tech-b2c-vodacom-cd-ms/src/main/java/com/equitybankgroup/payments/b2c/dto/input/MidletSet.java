package com.equitybankgroup.payments.b2c.dto.input;

import com.google.gson.annotations.Expose;

import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;


@XmlAccessorType(XmlAccessType.FIELD)
public class MidletSet {
    @Expose
    @XmlElement(name = "String")
    private List<MidletStr> set;

    public List<MidletStr> getSet() {
        return this.set;
    }


    public void setSet(List<MidletStr> set) {
        this.set = set;
    }
}


/* Location:              C:\Users\geoffrey.kamau\Desktop\111\sub-b2c\b2c-sub-0.0.1-SNAPSHOT.jar!\com\way4\MidletSet.class
 * Java compiler version: 6 (50.0)
 * JD-Core Version:       1.1.3
 */