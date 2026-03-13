
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for feeType.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>
 * &lt;simpleType name="feeType"&gt;
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *     &lt;enumeration value="VARIABLE"/&gt;
 *     &lt;enumeration value="EXACT"/&gt;
 *     &lt;enumeration value="MINIMUM"/&gt;
 *     &lt;enumeration value="NOT_FOUND"/&gt;
 *   &lt;/restriction&gt;
 * &lt;/simpleType&gt;
 * </pre>
 * 
 */
@XmlType(name = "feeType")
@XmlEnum
public enum FeeType {

    VARIABLE,
    EXACT,
    MINIMUM,
    NOT_FOUND;

    public String value() {
        return name();
    }

    public static FeeType fromValue(String v) {
        return valueOf(v);
    }

}
