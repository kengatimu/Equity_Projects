/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input;

import com.google.gson.annotations.Expose;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlRootElement;
import lombok.Getter;
import lombok.Setter;

/**
 *
 * @author ronaldcheruiyot
 */
@Setter
@Getter
@XmlRootElement(name = "channelDeregistrationReq")
@XmlAccessorType(XmlAccessType.FIELD)
public class ChannelDeregistrationReq {
    @Expose
    @XmlElement(name = "msisdn", required = true)
    private String msisdn;
    @Expose
    @XmlElement(name = "rrn", required = true)
    private String rrn;
    @Expose
    @XmlElement(name = "currency", required = true)
    private String currency;
    @Expose
    @XmlElement(name = "sourceAccountNumber", required = true)
    private String sourceAccountNumber;
    
}
