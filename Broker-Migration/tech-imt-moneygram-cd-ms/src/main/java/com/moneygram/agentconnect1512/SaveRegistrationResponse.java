
package com.moneygram.agentconnect1512;

import java.math.BigInteger;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for SaveRegistrationResponse complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="SaveRegistrationResponse"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Response"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="mgCustomerReceiveNumber" type="{http://www.moneygram.com/AgentConnect1512}customerReceiveNumber"/&gt;
 *         &lt;element name="mgCustomerReceiveNumberVersion" type="{http://www.moneygram.com/AgentConnect1512}int3" minOccurs="0"/&gt;
 *         &lt;element name="registrationStatusCode" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="verificationRequiredForUse" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="ofacStatus" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "SaveRegistrationResponse", propOrder = {
    "mgCustomerReceiveNumber",
    "mgCustomerReceiveNumberVersion",
    "registrationStatusCode",
    "verificationRequiredForUse",
    "ofacStatus"
})
public class SaveRegistrationResponse
    extends Response
{

    @XmlElement(required = true)
    protected String mgCustomerReceiveNumber;
    protected BigInteger mgCustomerReceiveNumberVersion;
    @XmlElement(required = true)
    protected String registrationStatusCode;
    protected boolean verificationRequiredForUse;
    protected boolean ofacStatus;

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
     * Gets the value of the registrationStatusCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRegistrationStatusCode() {
        return registrationStatusCode;
    }

    /**
     * Sets the value of the registrationStatusCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRegistrationStatusCode(String value) {
        this.registrationStatusCode = value;
    }

    /**
     * Gets the value of the verificationRequiredForUse property.
     * 
     */
    public boolean isVerificationRequiredForUse() {
        return verificationRequiredForUse;
    }

    /**
     * Sets the value of the verificationRequiredForUse property.
     * 
     */
    public void setVerificationRequiredForUse(boolean value) {
        this.verificationRequiredForUse = value;
    }

    /**
     * Gets the value of the ofacStatus property.
     * 
     */
    public boolean isOfacStatus() {
        return ofacStatus;
    }

    /**
     * Sets the value of the ofacStatus property.
     * 
     */
    public void setOfacStatus(boolean value) {
        this.ofacStatus = value;
    }

}
