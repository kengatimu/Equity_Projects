
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for receiveReversalReasonCode.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>
 * &lt;simpleType name="receiveReversalReasonCode"&gt;
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *     &lt;enumeration value="WANTS_CASH"/&gt;
 *     &lt;enumeration value="WRONG_TX"/&gt;
 *     &lt;enumeration value="OUT_OF_CHECKS"/&gt;
 *     &lt;enumeration value="ID_PROBLEM"/&gt;
 *   &lt;/restriction&gt;
 * &lt;/simpleType&gt;
 * </pre>
 * 
 */
@XmlType(name = "receiveReversalReasonCode")
@XmlEnum
public enum ReceiveReversalReasonCode {

    WANTS_CASH,
    WRONG_TX,
    OUT_OF_CHECKS,
    ID_PROBLEM;

    public String value() {
        return name();
    }

    public static ReceiveReversalReasonCode fromValue(String v) {
        return valueOf(v);
    }

}
