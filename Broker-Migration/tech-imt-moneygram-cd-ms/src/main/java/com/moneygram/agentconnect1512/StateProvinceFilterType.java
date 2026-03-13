
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for stateProvinceFilterType.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>
 * &lt;simpleType name="stateProvinceFilterType"&gt;
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *     &lt;enumeration value="USA"/&gt;
 *     &lt;enumeration value="CAN"/&gt;
 *     &lt;enumeration value="MEX"/&gt;
 *   &lt;/restriction&gt;
 * &lt;/simpleType&gt;
 * </pre>
 * 
 */
@XmlType(name = "stateProvinceFilterType")
@XmlEnum
public enum StateProvinceFilterType {

    USA,
    CAN,
    MEX;

    public String value() {
        return name();
    }

    public static StateProvinceFilterType fromValue(String v) {
        return valueOf(v);
    }

}
