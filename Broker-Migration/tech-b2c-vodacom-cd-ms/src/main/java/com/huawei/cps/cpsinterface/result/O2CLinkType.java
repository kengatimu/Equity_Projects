
package com.huawei.cps.cpsinterface.result;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * O2C Link类型
 * 
 * <p>Java class for O2CLinkType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="O2CLinkType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="OrgShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType"/&gt;
 *         &lt;element name="O2CLinkNumber"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;minLength value="1"/&gt;
 *               &lt;maxLength value="18"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="MSISDN" type="{http://cps.huawei.com/cpsinterface/common}MSISDNType"/&gt;
 *         &lt;element name="CreationTime" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "O2CLinkType", propOrder = {
    "orgShortCode",
    "o2CLinkNumber",
    "msisdn",
    "creationTime"
})
public class O2CLinkType {

    @XmlElement(name = "OrgShortCode", required = true)
    protected String orgShortCode;
    @XmlElement(name = "O2CLinkNumber", required = true)
    protected String o2CLinkNumber;
    @XmlElement(name = "MSISDN", required = true)
    protected String msisdn;
    @XmlElement(name = "CreationTime", required = true)
    protected String creationTime;

    /**
     * Gets the value of the orgShortCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOrgShortCode() {
        return orgShortCode;
    }

    /**
     * Sets the value of the orgShortCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOrgShortCode(String value) {
        this.orgShortCode = value;
    }

    /**
     * Gets the value of the o2CLinkNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getO2CLinkNumber() {
        return o2CLinkNumber;
    }

    /**
     * Sets the value of the o2CLinkNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setO2CLinkNumber(String value) {
        this.o2CLinkNumber = value;
    }

    /**
     * Gets the value of the msisdn property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMSISDN() {
        return msisdn;
    }

    /**
     * Sets the value of the msisdn property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMSISDN(String value) {
        this.msisdn = value;
    }

    /**
     * Gets the value of the creationTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCreationTime() {
        return creationTime;
    }

    /**
     * Sets the value of the creationTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCreationTime(String value) {
        this.creationTime = value;
    }

}
