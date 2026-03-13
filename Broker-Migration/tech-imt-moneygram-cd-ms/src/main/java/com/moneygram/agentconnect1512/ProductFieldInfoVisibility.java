
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for ProductFieldInfoVisibility.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>
 * &lt;simpleType name="ProductFieldInfoVisibility"&gt;
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *     &lt;enumeration value="REQ"/&gt;
 *     &lt;enumeration value="OPT"/&gt;
 *     &lt;enumeration value="SUP_OPT"/&gt;
 *     &lt;enumeration value="NOT_ALL"/&gt;
 *   &lt;/restriction&gt;
 * &lt;/simpleType&gt;
 * </pre>
 * 
 */
@XmlType(name = "ProductFieldInfoVisibility")
@XmlEnum
public enum ProductFieldInfoVisibility {

    REQ,
    OPT,
    SUP_OPT,
    NOT_ALL;

    public String value() {
        return name();
    }

    public static ProductFieldInfoVisibility fromValue(String v) {
        return valueOf(v);
    }

}
