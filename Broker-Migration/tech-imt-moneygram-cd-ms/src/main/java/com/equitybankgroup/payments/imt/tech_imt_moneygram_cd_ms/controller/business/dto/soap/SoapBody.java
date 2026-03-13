/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.controller.business.dto.soap;

// Define the SoapBody class that contains FeeLookupRequest

import com.moneygram.agentconnect1512.FeeLookupRequest;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name = "Body")
public class SoapBody {

    @XmlElement(name = "feeLookupRequest", namespace = "http://www.moneygram.com/AgentConnect1512") // Replace with the actual namespace of your request
    private FeeLookupRequest feeLookupRequest;

    // Getters and setters
    public FeeLookupRequest getFeeLookupRequest() {
        return feeLookupRequest;
    }

    public void setFeeLookupRequest(FeeLookupRequest feeLookupRequest) {
        this.feeLookupRequest = feeLookupRequest;
    }
}
