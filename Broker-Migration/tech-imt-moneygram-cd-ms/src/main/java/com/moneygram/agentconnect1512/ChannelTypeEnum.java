
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlEnum;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for channelTypeEnum.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * <pre>
 * &lt;simpleType name="channelTypeEnum"&gt;
 *   &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *     &lt;enumeration value="ATM"/&gt;
 *     &lt;enumeration value="CALL_CENTER"/&gt;
 *     &lt;enumeration value="KIOSK"/&gt;
 *     &lt;enumeration value="LOCATION"/&gt;
 *     &lt;enumeration value="MOBILE"/&gt;
 *     &lt;enumeration value="SYSTEM"/&gt;
 *     &lt;enumeration value="WEB"/&gt;
 *     &lt;enumeration value="TABLET"/&gt;
 *   &lt;/restriction&gt;
 * &lt;/simpleType&gt;
 * </pre>
 * 
 */
@XmlType(name = "channelTypeEnum")
@XmlEnum
public enum ChannelTypeEnum {

    ATM,
    CALL_CENTER,
    KIOSK,
    LOCATION,
    MOBILE,
    SYSTEM,
    WEB,
    TABLET;

    public String value() {
        return name();
    }

    public static ChannelTypeEnum fromValue(String v) {
        return valueOf(v);
    }

}
