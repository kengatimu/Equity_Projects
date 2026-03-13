
package com.moneygram.agentconnect1512;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for ReceiveAmountInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ReceiveAmountInfo"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="receiveAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="receiveCurrency" type="{http://www.moneygram.com/AgentConnect1512}currencyCode" minOccurs="0"/&gt;
 *         &lt;element name="validCurrencyIndicator" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="payoutCurrency" type="{http://www.moneygram.com/AgentConnect1512}currencyCode" minOccurs="0"/&gt;
 *         &lt;element name="totalReceiveFees" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="totalReceiveTaxes" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="totalReceiveAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="receiveFeesAreEstimated" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="receiveTaxesAreEstimated" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="detailReceiveAmounts" type="{http://www.moneygram.com/AgentConnect1512}AmountInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ReceiveAmountInfo", propOrder = {
    "receiveAmount",
    "receiveCurrency",
    "validCurrencyIndicator",
    "payoutCurrency",
    "totalReceiveFees",
    "totalReceiveTaxes",
    "totalReceiveAmount",
    "receiveFeesAreEstimated",
    "receiveTaxesAreEstimated",
    "detailReceiveAmounts"
})
public class ReceiveAmountInfo {

    protected BigDecimal receiveAmount;
    protected String receiveCurrency;
    protected Boolean validCurrencyIndicator;
    protected String payoutCurrency;
    protected BigDecimal totalReceiveFees;
    protected BigDecimal totalReceiveTaxes;
    protected BigDecimal totalReceiveAmount;
    protected boolean receiveFeesAreEstimated;
    protected boolean receiveTaxesAreEstimated;
    protected List<AmountInfo> detailReceiveAmounts;

    /**
     * Gets the value of the receiveAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getReceiveAmount() {
        return receiveAmount;
    }

    /**
     * Sets the value of the receiveAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setReceiveAmount(BigDecimal value) {
        this.receiveAmount = value;
    }

    /**
     * Gets the value of the receiveCurrency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiveCurrency() {
        return receiveCurrency;
    }

    /**
     * Sets the value of the receiveCurrency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiveCurrency(String value) {
        this.receiveCurrency = value;
    }

    /**
     * Gets the value of the validCurrencyIndicator property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isValidCurrencyIndicator() {
        return validCurrencyIndicator;
    }

    /**
     * Sets the value of the validCurrencyIndicator property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setValidCurrencyIndicator(Boolean value) {
        this.validCurrencyIndicator = value;
    }

    /**
     * Gets the value of the payoutCurrency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPayoutCurrency() {
        return payoutCurrency;
    }

    /**
     * Sets the value of the payoutCurrency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPayoutCurrency(String value) {
        this.payoutCurrency = value;
    }

    /**
     * Gets the value of the totalReceiveFees property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getTotalReceiveFees() {
        return totalReceiveFees;
    }

    /**
     * Sets the value of the totalReceiveFees property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setTotalReceiveFees(BigDecimal value) {
        this.totalReceiveFees = value;
    }

    /**
     * Gets the value of the totalReceiveTaxes property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getTotalReceiveTaxes() {
        return totalReceiveTaxes;
    }

    /**
     * Sets the value of the totalReceiveTaxes property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setTotalReceiveTaxes(BigDecimal value) {
        this.totalReceiveTaxes = value;
    }

    /**
     * Gets the value of the totalReceiveAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getTotalReceiveAmount() {
        return totalReceiveAmount;
    }

    /**
     * Sets the value of the totalReceiveAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setTotalReceiveAmount(BigDecimal value) {
        this.totalReceiveAmount = value;
    }

    /**
     * Gets the value of the receiveFeesAreEstimated property.
     * 
     */
    public boolean isReceiveFeesAreEstimated() {
        return receiveFeesAreEstimated;
    }

    /**
     * Sets the value of the receiveFeesAreEstimated property.
     * 
     */
    public void setReceiveFeesAreEstimated(boolean value) {
        this.receiveFeesAreEstimated = value;
    }

    /**
     * Gets the value of the receiveTaxesAreEstimated property.
     * 
     */
    public boolean isReceiveTaxesAreEstimated() {
        return receiveTaxesAreEstimated;
    }

    /**
     * Sets the value of the receiveTaxesAreEstimated property.
     * 
     */
    public void setReceiveTaxesAreEstimated(boolean value) {
        this.receiveTaxesAreEstimated = value;
    }

    /**
     * Gets the value of the detailReceiveAmounts property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the detailReceiveAmounts property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getDetailReceiveAmounts().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link AmountInfo }
     * 
     * 
     */
    public List<AmountInfo> getDetailReceiveAmounts() {
        if (detailReceiveAmounts == null) {
            detailReceiveAmounts = new ArrayList<AmountInfo>();
        }
        return this.detailReceiveAmounts;
    }

}
