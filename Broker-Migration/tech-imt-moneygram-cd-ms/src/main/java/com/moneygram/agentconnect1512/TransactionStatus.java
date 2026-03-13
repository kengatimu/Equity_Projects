
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for transactionStatus.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>
 * &lt;simpleType name="transactionStatus"&gt;
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *     &lt;enumeration value="AVAIL"/&gt;
 *     &lt;enumeration value="CANCL"/&gt;
 *     &lt;enumeration value="RECVD"/&gt;
 *     &lt;enumeration value="REFND"/&gt;
 *     &lt;enumeration value="AFR"/&gt;
 *     &lt;enumeration value="UNCOMMITED"/&gt;
 *     &lt;enumeration value="PRCSS"/&gt;
 *   &lt;/restriction&gt;
 * &lt;/simpleType&gt;
 * </pre>
 * 
 */
@XmlType(name = "transactionStatus")
@XmlEnum
public enum TransactionStatus {

    AVAIL,
    CANCL,
    RECVD,
    REFND,
    AFR,
    UNCOMMITED,
    PRCSS;

    public String value() {
        return name();
    }

    public static TransactionStatus fromValue(String v) {
        return valueOf(v);
    }

}
