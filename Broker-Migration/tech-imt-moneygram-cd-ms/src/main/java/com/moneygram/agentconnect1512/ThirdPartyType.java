
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for thirdPartyType.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>
 * &lt;simpleType name="thirdPartyType"&gt;
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *     &lt;enumeration value="ORG"/&gt;
 *     &lt;enumeration value="NONE"/&gt;
 *     &lt;enumeration value="PERSON"/&gt;
 *   &lt;/restriction&gt;
 * &lt;/simpleType&gt;
 * </pre>
 * 
 */
@XmlType(name = "thirdPartyType")
@XmlEnum
public enum ThirdPartyType {

    ORG,
    NONE,
    PERSON;

    public String value() {
        return name();
    }

    public static ThirdPartyType fromValue(String v) {
        return valueOf(v);
    }

}
