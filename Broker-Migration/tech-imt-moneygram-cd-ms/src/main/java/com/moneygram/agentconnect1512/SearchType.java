
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for searchType.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>
 * &lt;simpleType name="searchType"&gt;
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *     &lt;enumeration value="IND"/&gt;
 *     &lt;enumeration value="CODE"/&gt;
 *     &lt;enumeration value="NAME"/&gt;
 *     &lt;enumeration value="ID"/&gt;
 *     &lt;enumeration value="BIN"/&gt;
 *   &lt;/restriction&gt;
 * &lt;/simpleType&gt;
 * </pre>
 * 
 */
@XmlType(name = "searchType")
@XmlEnum
public enum SearchType {

    IND,
    CODE,
    NAME,
    ID,
    BIN;

    public String value() {
        return name();
    }

    public static SearchType fromValue(String v) {
        return valueOf(v);
    }

}
