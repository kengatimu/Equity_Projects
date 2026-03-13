
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for RewardsFieldInfoDisplay.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>
 * &lt;simpleType name="RewardsFieldInfoDisplay"&gt;
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *     &lt;enumeration value="YES"/&gt;
 *     &lt;enumeration value="NO"/&gt;
 *     &lt;enumeration value="OPT"/&gt;
 *   &lt;/restriction&gt;
 * &lt;/simpleType&gt;
 * </pre>
 * 
 */
@XmlType(name = "RewardsFieldInfoDisplay")
@XmlEnum
public enum RewardsFieldInfoDisplay {

    YES,
    NO,
    OPT;

    public String value() {
        return name();
    }

    public static RewardsFieldInfoDisplay fromValue(String v) {
        return valueOf(v);
    }

}
