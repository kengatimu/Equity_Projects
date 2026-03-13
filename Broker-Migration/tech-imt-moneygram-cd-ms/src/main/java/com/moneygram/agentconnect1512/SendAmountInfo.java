
package com.moneygram.agentconnect1512;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for SendAmountInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="SendAmountInfo"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="sendAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14nonZero" minOccurs="0"/&gt;
 *         &lt;element name="sendCurrency" type="{http://www.moneygram.com/AgentConnect1512}currencyCode" minOccurs="0"/&gt;
 *         &lt;element name="totalSendFees" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="totalDiscountAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="totalSendTaxes" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="totalAmountToCollect" type="{http://www.moneygram.com/AgentConnect1512}decimal14nonZero" minOccurs="0"/&gt;
 *         &lt;element name="detailSendAmounts" type="{http://www.moneygram.com/AgentConnect1512}AmountInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "SendAmountInfo", propOrder = {
    "sendAmount",
    "sendCurrency",
    "totalSendFees",
    "totalDiscountAmount",
    "totalSendTaxes",
    "totalAmountToCollect",
    "detailSendAmounts"
})
public class SendAmountInfo {

    protected BigDecimal sendAmount;
    protected String sendCurrency;
    protected BigDecimal totalSendFees;
    protected BigDecimal totalDiscountAmount;
    protected BigDecimal totalSendTaxes;
    protected BigDecimal totalAmountToCollect;
    protected List<AmountInfo> detailSendAmounts;

    /**
     * Gets the value of the sendAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getSendAmount() {
        return sendAmount;
    }

    /**
     * Sets the value of the sendAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setSendAmount(BigDecimal value) {
        this.sendAmount = value;
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

    /**
     * Gets the value of the totalSendFees property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getTotalSendFees() {
        return totalSendFees;
    }

    /**
     * Sets the value of the totalSendFees property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setTotalSendFees(BigDecimal value) {
        this.totalSendFees = value;
    }

    /**
     * Gets the value of the totalDiscountAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getTotalDiscountAmount() {
        return totalDiscountAmount;
    }

    /**
     * Sets the value of the totalDiscountAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setTotalDiscountAmount(BigDecimal value) {
        this.totalDiscountAmount = value;
    }

    /**
     * Gets the value of the totalSendTaxes property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getTotalSendTaxes() {
        return totalSendTaxes;
    }

    /**
     * Sets the value of the totalSendTaxes property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setTotalSendTaxes(BigDecimal value) {
        this.totalSendTaxes = value;
    }

    /**
     * Gets the value of the totalAmountToCollect property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getTotalAmountToCollect() {
        return totalAmountToCollect;
    }

    /**
     * Sets the value of the totalAmountToCollect property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setTotalAmountToCollect(BigDecimal value) {
        this.totalAmountToCollect = value;
    }

    /**
     * Gets the value of the detailSendAmounts property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the detailSendAmounts property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getDetailSendAmounts().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link AmountInfo }
     * 
     * 
     */
    public List<AmountInfo> getDetailSendAmounts() {
        if (detailSendAmounts == null) {
            detailSendAmounts = new ArrayList<AmountInfo>();
        }
        return this.detailSendAmounts;
    }

}
