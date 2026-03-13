
package com.moneygram.agentconnect1512;

import java.math.BigInteger;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlSeeAlso;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for FormFreeTranLookupRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="FormFreeTranLookupRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Request"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="freqCustCardNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="senderPhoneNumber" type="{http://www.moneygram.com/AgentConnect1512}phoneTypeShort" minOccurs="0"/&gt;
 *         &lt;element name="senderFirstName" type="{http://www.moneygram.com/AgentConnect1512}fNameType40" minOccurs="0"/&gt;
 *         &lt;element name="senderLastName" type="{http://www.moneygram.com/AgentConnect1512}lNameType40" minOccurs="0"/&gt;
 *         &lt;element name="billerAccountNumber" type="{http://www.moneygram.com/AgentConnect1512}billerAccountNumber" minOccurs="0"/&gt;
 *         &lt;element name="tranType" type="{http://www.moneygram.com/AgentConnect1512}stringMax4"/&gt;
 *         &lt;element name="thisLocationOnly" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="maxRowsToReturn" type="{http://www.moneygram.com/AgentConnect1512}int3" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "FormFreeTranLookupRequest", propOrder = {
    "freqCustCardNumber",
    "senderPhoneNumber",
    "senderFirstName",
    "senderLastName",
    "billerAccountNumber",
    "tranType",
    "thisLocationOnly",
    "maxRowsToReturn"
})
@XmlSeeAlso({
    FormFreeTranLookupWithAmountRequest.class
})
public class FormFreeTranLookupRequest
    extends Request
{

    protected String freqCustCardNumber;
    protected String senderPhoneNumber;
    protected String senderFirstName;
    protected String senderLastName;
    protected String billerAccountNumber;
    @XmlElement(required = true)
    protected String tranType;
    protected boolean thisLocationOnly;
    protected BigInteger maxRowsToReturn;

    /**
     * Gets the value of the freqCustCardNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFreqCustCardNumber() {
        return freqCustCardNumber;
    }

    /**
     * Sets the value of the freqCustCardNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFreqCustCardNumber(String value) {
        this.freqCustCardNumber = value;
    }

    /**
     * Gets the value of the senderPhoneNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderPhoneNumber() {
        return senderPhoneNumber;
    }

    /**
     * Sets the value of the senderPhoneNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderPhoneNumber(String value) {
        this.senderPhoneNumber = value;
    }

    /**
     * Gets the value of the senderFirstName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderFirstName() {
        return senderFirstName;
    }

    /**
     * Sets the value of the senderFirstName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderFirstName(String value) {
        this.senderFirstName = value;
    }

    /**
     * Gets the value of the senderLastName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSenderLastName() {
        return senderLastName;
    }

    /**
     * Sets the value of the senderLastName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSenderLastName(String value) {
        this.senderLastName = value;
    }

    /**
     * Gets the value of the billerAccountNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillerAccountNumber() {
        return billerAccountNumber;
    }

    /**
     * Sets the value of the billerAccountNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillerAccountNumber(String value) {
        this.billerAccountNumber = value;
    }

    /**
     * Gets the value of the tranType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTranType() {
        return tranType;
    }

    /**
     * Sets the value of the tranType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTranType(String value) {
        this.tranType = value;
    }

    /**
     * Gets the value of the thisLocationOnly property.
     * 
     */
    public boolean isThisLocationOnly() {
        return thisLocationOnly;
    }

    /**
     * Sets the value of the thisLocationOnly property.
     * 
     */
    public void setThisLocationOnly(boolean value) {
        this.thisLocationOnly = value;
    }

    /**
     * Gets the value of the maxRowsToReturn property.
     * 
     * @return
     *     possible object is
     *     {@link BigInteger }
     *     
     */
    public BigInteger getMaxRowsToReturn() {
        return maxRowsToReturn;
    }

    /**
     * Sets the value of the maxRowsToReturn property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigInteger }
     *     
     */
    public void setMaxRowsToReturn(BigInteger value) {
        this.maxRowsToReturn = value;
    }

}
