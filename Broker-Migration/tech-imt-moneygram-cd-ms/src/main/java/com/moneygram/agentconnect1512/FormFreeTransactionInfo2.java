
package com.moneygram.agentconnect1512;

import java.math.BigDecimal;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for FormFreeTransactionInfo2 complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="FormFreeTransactionInfo2"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}FormFreeTransactionInfo"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="amount" type="{http://www.moneygram.com/AgentConnect1512}decimal14"/&gt;
 *         &lt;element name="sendCurrency" type="{http://www.moneygram.com/AgentConnect1512}currencyCode"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "FormFreeTransactionInfo2", propOrder = {
    "amount",
    "sendCurrency"
})
public class FormFreeTransactionInfo2
    extends FormFreeTransactionInfo
{

    @XmlElement(required = true)
    protected BigDecimal amount;
    @XmlElement(required = true)
    protected String sendCurrency;

    /**
     * Gets the value of the amount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getAmount() {
        return amount;
    }

    /**
     * Sets the value of the amount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setAmount(BigDecimal value) {
        this.amount = value;
    }

    /**
     * Gets the value of the sendCurrency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSendCurrency() {
        return sendCurrency;
    }

    /**
     * Sets the value of the sendCurrency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSendCurrency(String value) {
        this.sendCurrency = value;
    }

}
