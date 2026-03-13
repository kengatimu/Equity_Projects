
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlEnumValue;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for dataTypeCode.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>
 * &lt;simpleType name="dataTypeCode"&gt;
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *     &lt;enumeration value="boolean"/&gt;
 *     &lt;enumeration value="string"/&gt;
 *     &lt;enumeration value="int"/&gt;
 *     &lt;enumeration value="decimal"/&gt;
 *     &lt;enumeration value="date"/&gt;
 *     &lt;enumeration value="datetime"/&gt;
 *     &lt;enumeration value="time"/&gt;
 *     &lt;enumeration value="text"/&gt;
 *     &lt;enumeration value="cntrycode"/&gt;
 *     &lt;enumeration value="enum"/&gt;
 *     &lt;enumeration value="stringbool"/&gt;
 *   &lt;/restriction&gt;
 * &lt;/simpleType&gt;
 * </pre>
 * 
 */
@XmlType(name = "dataTypeCode")
@XmlEnum
public enum DataTypeCode {

    @XmlEnumValue("boolean")
    BOOLEAN("boolean"),
    @XmlEnumValue("string")
    STRING("string"),
    @XmlEnumValue("int")
    INT("int"),
    @XmlEnumValue("decimal")
    DECIMAL("decimal"),
    @XmlEnumValue("date")
    DATE("date"),
    @XmlEnumValue("datetime")
    DATETIME("datetime"),
    @XmlEnumValue("time")
    TIME("time"),
    @XmlEnumValue("text")
    TEXT("text"),
    @XmlEnumValue("cntrycode")
    CNTRYCODE("cntrycode"),
    @XmlEnumValue("enum")
    ENUM("enum"),
    @XmlEnumValue("stringbool")
    STRINGBOOL("stringbool");
    private final String value;

    DataTypeCode(String v) {
        value = v;
    }

    public String value() {
        return value;
    }

    public static DataTypeCode fromValue(String v) {
        for (DataTypeCode c: DataTypeCode.values()) {
            if (c.value.equals(v)) {
                return c;
            }
        }
        throw new IllegalArgumentException(v);
    }

}
