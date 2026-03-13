
package com.huawei.cps.cpsinterface.result;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 根据交易ID查询Transaction
 * 
 * <p>Java class for SearchTransactionResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="SearchTransactionResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="TransactionDetailData" type="{http://cps.huawei.com/cpsinterface/result}TransactionDetailType"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "SearchTransactionResult", propOrder = {
    "boCompletedTime",
    "transactionDetailData"
})
public class SearchTransactionResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "TransactionDetailData", required = true)
    protected TransactionDetailType transactionDetailData;

    /**
     * Gets the value of the boCompletedTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBOCompletedTime() {
        return boCompletedTime;
    }

    /**
     * Sets the value of the boCompletedTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBOCompletedTime(String value) {
        this.boCompletedTime = value;
    }

    /**
     * Gets the value of the transactionDetailData property.
     * 
     * @return
     *     possible object is
     *     {@link TransactionDetailType }
     *     
     */
    public TransactionDetailType getTransactionDetailData() {
        return transactionDetailData;
    }

    /**
     * Sets the value of the transactionDetailData property.
     * 
     * @param value
     *     allowed object is
     *     {@link TransactionDetailType }
     *     
     */
    public void setTransactionDetailData(TransactionDetailType value) {
        this.transactionDetailData = value;
    }

}
