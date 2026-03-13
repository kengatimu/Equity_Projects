
package com.moneygram.agentconnect1512;

import java.math.BigInteger;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for RegistrationInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="RegistrationInfo"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="mgCustomerReceiveNumber" type="{http://www.moneygram.com/AgentConnect1512}customerReceiveNumber"/&gt;
 *         &lt;element name="mgCustomerReceiveNumberVersion" type="{http://www.moneygram.com/AgentConnect1512}int3"/&gt;
 *         &lt;element name="receiverFirstName" type="{http://www.moneygram.com/AgentConnect1512}fNameType40"/&gt;
 *         &lt;element name="receiverMiddleName" type="{http://www.moneygram.com/AgentConnect1512}mNameType40"/&gt;
 *         &lt;element name="receiverLastName" type="{http://www.moneygram.com/AgentConnect1512}lNameType40"/&gt;
 *         &lt;element name="receiverLastName2" type="{http://www.moneygram.com/AgentConnect1512}lNameType40"/&gt;
 *         &lt;element name="receiverPhoneNumber" type="{http://www.moneygram.com/AgentConnect1512}phoneTypeLong"/&gt;
 *         &lt;element name="creatorFirstName" type="{http://www.moneygram.com/AgentConnect1512}fNameType40"/&gt;
 *         &lt;element name="creatorMiddleName" type="{http://www.moneygram.com/AgentConnect1512}mNameType40"/&gt;
 *         &lt;element name="creatorLastName" type="{http://www.moneygram.com/AgentConnect1512}lNameType40"/&gt;
 *         &lt;element name="creatorLastName2" type="{http://www.moneygram.com/AgentConnect1512}lNameType40"/&gt;
 *         &lt;element name="fqdoInfo" type="{http://www.moneygram.com/AgentConnect1512}FQDOInfo"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "RegistrationInfo", propOrder = {
    "mgCustomerReceiveNumber",
    "mgCustomerReceiveNumberVersion",
    "receiverFirstName",
    "receiverMiddleName",
    "receiverLastName",
    "receiverLastName2",
    "receiverPhoneNumber",
    "creatorFirstName",
    "creatorMiddleName",
    "creatorLastName",
    "creatorLastName2",
    "fqdoInfo"
})
public class RegistrationInfo {

    @XmlElement(required = true)
    protected String mgCustomerReceiveNumber;
    @XmlElement(required = true)
    protected BigInteger mgCustomerReceiveNumberVersion;
    @XmlElement(required = true)
    protected String receiverFirstName;
    @XmlElement(required = true)
    protected String receiverMiddleName;
    @XmlElement(required = true)
    protected String receiverLastName;
    @XmlElement(required = true)
    protected String receiverLastName2;
    @XmlElement(required = true)
    protected String receiverPhoneNumber;
    @XmlElement(required = true)
    protected String creatorFirstName;
    @XmlElement(required = true)
    protected String creatorMiddleName;
    @XmlElement(required = true)
    protected String creatorLastName;
    @XmlElement(required = true)
    protected String creatorLastName2;
    @XmlElement(required = true)
    protected FQDOInfo fqdoInfo;

    /**
     * Gets the value of the mgCustomerReceiveNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMgCustomerReceiveNumber() {
        return mgCustomerReceiveNumber;
    }

    /**
     * Sets the value of the mgCustomerReceiveNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMgCustomerReceiveNumber(String value) {
        this.mgCustomerReceiveNumber = value;
    }

    /**
     * Gets the value of the mgCustomerReceiveNumberVersion property.
     * 
     * @return
     *     possible object is
     *     {@link BigInteger }
     *     
     */
    public BigInteger getMgCustomerReceiveNumberVersion() {
        return mgCustomerReceiveNumberVersion;
    }

    /**
     * Sets the value of the mgCustomerReceiveNumberVersion property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigInteger }
     *     
     */
    public void setMgCustomerReceiveNumberVersion(BigInteger value) {
        this.mgCustomerReceiveNumberVersion = value;
    }

    /**
     * Gets the value of the receiverFirstName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverFirstName() {
        return receiverFirstName;
    }

    /**
     * Sets the value of the receiverFirstName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverFirstName(String value) {
        this.receiverFirstName = value;
    }

    /**
     * Gets the value of the receiverMiddleName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverMiddleName() {
        return receiverMiddleName;
    }

    /**
     * Sets the value of the receiverMiddleName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverMiddleName(String value) {
        this.receiverMiddleName = value;
    }

    /**
     * Gets the value of the receiverLastName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverLastName() {
        return receiverLastName;
    }

    /**
     * Sets the value of the receiverLastName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverLastName(String value) {
        this.receiverLastName = value;
    }

    /**
     * Gets the value of the receiverLastName2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverLastName2() {
        return receiverLastName2;
    }

    /**
     * Sets the value of the receiverLastName2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverLastName2(String value) {
        this.receiverLastName2 = value;
    }

    /**
     * Gets the value of the receiverPhoneNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiverPhoneNumber() {
        return receiverPhoneNumber;
    }

    /**
     * Sets the value of the receiverPhoneNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiverPhoneNumber(String value) {
        this.receiverPhoneNumber = value;
    }

    /**
     * Gets the value of the creatorFirstName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCreatorFirstName() {
        return creatorFirstName;
    }

    /**
     * Sets the value of the creatorFirstName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCreatorFirstName(String value) {
        this.creatorFirstName = value;
    }

    /**
     * Gets the value of the creatorMiddleName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCreatorMiddleName() {
        return creatorMiddleName;
    }

    /**
     * Sets the value of the creatorMiddleName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCreatorMiddleName(String value) {
        this.creatorMiddleName = value;
    }

    /**
     * Gets the value of the creatorLastName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCreatorLastName() {
        return creatorLastName;
    }

    /**
     * Sets the value of the creatorLastName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCreatorLastName(String value) {
        this.creatorLastName = value;
    }

    /**
     * Gets the value of the creatorLastName2 property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCreatorLastName2() {
        return creatorLastName2;
    }

    /**
     * Sets the value of the creatorLastName2 property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCreatorLastName2(String value) {
        this.creatorLastName2 = value;
    }

    /**
     * Gets the value of the fqdoInfo property.
     * 
     * @return
     *     possible object is
     *     {@link FQDOInfo }
     *     
     */
    public FQDOInfo getFqdoInfo() {
        return fqdoInfo;
    }

    /**
     * Sets the value of the fqdoInfo property.
     * 
     * @param value
     *     allowed object is
     *     {@link FQDOInfo }
     *     
     */
    public void setFqdoInfo(FQDOInfo value) {
        this.fqdoInfo = value;
    }

}
