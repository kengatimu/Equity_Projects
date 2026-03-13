
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for billPayCancelReasonType.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>
 * &lt;simpleType name="billPayCancelReasonType"&gt;
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *     &lt;enumeration value="ENTERED_WRONG_ACCOUNT"/&gt;
 *     &lt;enumeration value="SENT_TO_WRONG_ACCOUNT"/&gt;
 *     &lt;enumeration value="SENT_TO_WRONG_BILLER"/&gt;
 *     &lt;enumeration value="SENT_DUPLICATE_PAYMENT"/&gt;
 *     &lt;enumeration value="CUSTOMER_CHANGED_MIND"/&gt;
 *     &lt;enumeration value="CUSTOMER_LEFT_WITHOUT_PAYING"/&gt;
 *     &lt;enumeration value="SHOULD_BE_EXPRESSPAYMENT"/&gt;
 *     &lt;enumeration value="SYSTEM_ERROR"/&gt;
 *     &lt;enumeration value="OTHER"/&gt;
 *   &lt;/restriction&gt;
 * &lt;/simpleType&gt;
 * </pre>
 * 
 */
@XmlType(name = "billPayCancelReasonType")
@XmlEnum
public enum BillPayCancelReasonType {

    ENTERED_WRONG_ACCOUNT,
    SENT_TO_WRONG_ACCOUNT,
    SENT_TO_WRONG_BILLER,
    SENT_DUPLICATE_PAYMENT,
    CUSTOMER_CHANGED_MIND,
    CUSTOMER_LEFT_WITHOUT_PAYING,
    SHOULD_BE_EXPRESSPAYMENT,
    SYSTEM_ERROR,
    OTHER;

    public String value() {
        return name();
    }

    public static BillPayCancelReasonType fromValue(String v) {
        return valueOf(v);
    }

}
