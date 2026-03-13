
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for RedirectInfoRedirectType.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>
 * &lt;simpleType name="RedirectInfoRedirectType"&gt;
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *     &lt;enumeration value="CURRENCY_REDIRECT"/&gt;
 *     &lt;enumeration value="COUNTRY_REDIRECT"/&gt;
 *     &lt;enumeration value="COUNTRY_CURRENCY_REDIRECT"/&gt;
 *   &lt;/restriction&gt;
 * &lt;/simpleType&gt;
 * </pre>
 * 
 */
@XmlType(name = "RedirectInfoRedirectType")
@XmlEnum
public enum RedirectInfoRedirectType {

    CURRENCY_REDIRECT,
    COUNTRY_REDIRECT,
    COUNTRY_CURRENCY_REDIRECT;

    public String value() {
        return name();
    }

    public static RedirectInfoRedirectType fromValue(String v) {
        return valueOf(v);
    }

}
