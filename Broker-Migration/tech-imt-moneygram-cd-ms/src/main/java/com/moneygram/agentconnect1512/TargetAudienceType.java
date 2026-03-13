
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for targetAudienceType.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>
 * &lt;simpleType name="targetAudienceType"&gt;
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *     &lt;enumeration value="AGENT_FACING"/&gt;
 *     &lt;enumeration value="CONSUMER_FACING"/&gt;
 *   &lt;/restriction&gt;
 * &lt;/simpleType&gt;
 * </pre>
 * 
 */
@XmlType(name = "targetAudienceType")
@XmlEnum
public enum TargetAudienceType {

    AGENT_FACING,
    CONSUMER_FACING;

    public String value() {
        return name();
    }

    public static TargetAudienceType fromValue(String v) {
        return valueOf(v);
    }

}
