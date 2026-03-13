
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for productVariant.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>
 * &lt;simpleType name="productVariant"&gt;
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *     &lt;enumeration value="EP"/&gt;
 *     &lt;enumeration value="PREPAY"/&gt;
 *     &lt;enumeration value="UBP"/&gt;
 *   &lt;/restriction&gt;
 * &lt;/simpleType&gt;
 * </pre>
 * 
 */
@XmlType(name = "productVariant")
@XmlEnum
public enum ProductVariant {

    EP,
    PREPAY,
    UBP;

    public String value() {
        return name();
    }

    public static ProductVariant fromValue(String v) {
        return valueOf(v);
    }

}
