
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for countryFilterType.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>
 * &lt;simpleType name="countryFilterType"&gt;
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *     &lt;enumeration value="RECEIVE_ACTIVE"/&gt;
 *     &lt;enumeration value="MG_DIRECTED_SEND"/&gt;
 *   &lt;/restriction&gt;
 * &lt;/simpleType&gt;
 * </pre>
 * 
 */
@XmlType(name = "countryFilterType")
@XmlEnum
public enum CountryFilterType {

    RECEIVE_ACTIVE,
    MG_DIRECTED_SEND;

    public String value() {
        return name();
    }

    public static CountryFilterType fromValue(String v) {
        return valueOf(v);
    }

}
