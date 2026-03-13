/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlRootElement;

import java.util.List;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name = "fieldValues")
public class FieldValues {

    // Maps to <keyValuePair> in XML
    private List<KeyValuePair> keyValuePair;

    public FieldValues() {
    }
    
    @XmlElement(name = "keyValuePair") 
    public List<KeyValuePair> getKeyValuePair() {
        return keyValuePair;
    }

    public void setKeyValuePair(List<KeyValuePair> keyValuePair) {
        this.keyValuePair = keyValuePair;
    }
}