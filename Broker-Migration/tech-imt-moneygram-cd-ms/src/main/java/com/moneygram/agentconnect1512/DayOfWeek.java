
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlEnumValue;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for dayOfWeek.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>
 * &lt;simpleType name="dayOfWeek"&gt;
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *     &lt;enumeration value="MON"/&gt;
 *     &lt;enumeration value="TUE"/&gt;
 *     &lt;enumeration value="WED"/&gt;
 *     &lt;enumeration value="THU"/&gt;
 *     &lt;enumeration value="FRI"/&gt;
 *     &lt;enumeration value="M-F"/&gt;
 *     &lt;enumeration value="S-S"/&gt;
 *     &lt;enumeration value="SAT"/&gt;
 *     &lt;enumeration value="SUN"/&gt;
 *   &lt;/restriction&gt;
 * &lt;/simpleType&gt;
 * </pre>
 * 
 */
@XmlType(name = "dayOfWeek")
@XmlEnum
public enum DayOfWeek {

    MON("MON"),
    TUE("TUE"),
    WED("WED"),
    THU("THU"),
    FRI("FRI"),
    @XmlEnumValue("M-F")
    M_F("M-F"),
    @XmlEnumValue("S-S")
    S_S("S-S"),
    SAT("SAT"),
    SUN("SUN");
    private final String value;

    DayOfWeek(String v) {
        value = v;
    }

    public String value() {
        return value;
    }

    public static DayOfWeek fromValue(String v) {
        for (DayOfWeek c: DayOfWeek.values()) {
            if (c.value.equals(v)) {
                return c;
            }
        }
        throw new IllegalArgumentException(v);
    }

}
