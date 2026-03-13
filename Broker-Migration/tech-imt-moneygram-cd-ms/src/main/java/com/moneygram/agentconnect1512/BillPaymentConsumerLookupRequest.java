
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for BillPaymentConsumerLookupRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="BillPaymentConsumerLookupRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Request"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="customerPhone" type="{http://www.moneygram.com/AgentConnect1512}phoneType14" minOccurs="0"/&gt;
 *         &lt;element name="freqCustCardNumber" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="billerAccountNumber" type="{http://www.moneygram.com/AgentConnect1512}billerAccountNumber" minOccurs="0"/&gt;
 *         &lt;element name="maxSendersToReturn" type="{http://www.moneygram.com/AgentConnect1512}intMaxToReturn"/&gt;
 *         &lt;element name="maxReceiversToReturn" type="{http://www.moneygram.com/AgentConnect1512}intMaxToReturn"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "BillPaymentConsumerLookupRequest", propOrder = {
    "customerPhone",
    "freqCustCardNumber",
    "billerAccountNumber",
    "maxSendersToReturn",
    "maxReceiversToReturn"
})
public class BillPaymentConsumerLookupRequest
    extends Request
{

    protected String customerPhone;
    protected String freqCustCardNumber;
    protected String billerAccountNumber;
    @XmlSchemaType(name = "integer")
    protected int maxSendersToReturn;
    @XmlSchemaType(name = "integer")
    protected int maxReceiversToReturn;

    /**
     * Gets the value of the customerPhone property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCustomerPhone() {
        return customerPhone;
    }

    /**
     * Sets the value of the customerPhone property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCustomerPhone(String value) {
        this.customerPhone = value;
    }

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
     * Gets the value of the maxSendersToReturn property.
     * 
     */
    public int getMaxSendersToReturn() {
        return maxSendersToReturn;
    }

    /**
     * Sets the value of the maxSendersToReturn property.
     * 
     */
    public void setMaxSendersToReturn(int value) {
        this.maxSendersToReturn = value;
    }

    /**
     * Gets the value of the maxReceiversToReturn property.
     * 
     */
    public int getMaxReceiversToReturn() {
        return maxReceiversToReturn;
    }

    /**
     * Sets the value of the maxReceiversToReturn property.
     * 
     */
    public void setMaxReceiversToReturn(int value) {
        this.maxReceiversToReturn = value;
    }

}
