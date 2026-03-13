
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for sendReversalReasonCode.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>
 * &lt;simpleType name="sendReversalReasonCode"&gt;
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *     &lt;enumeration value="NO_RCV_LOC"/&gt;
 *     &lt;enumeration value="WRONG_SERVICE"/&gt;
 *     &lt;enumeration value="NO_TQ"/&gt;
 *     &lt;enumeration value="INCORRECT_AMT"/&gt;
 *     &lt;enumeration value="MS_NOT_USED"/&gt;
 *   &lt;/restriction&gt;
 * &lt;/simpleType&gt;
 * </pre>
 * 
 */
@XmlType(name = "sendReversalReasonCode")
@XmlEnum
public enum SendReversalReasonCode {

    NO_RCV_LOC,
    WRONG_SERVICE,
    NO_TQ,
    INCORRECT_AMT,
    MS_NOT_USED;

    public String value() {
        return name();
    }

    public static SendReversalReasonCode fromValue(String v) {
        return valueOf(v);
    }

}
