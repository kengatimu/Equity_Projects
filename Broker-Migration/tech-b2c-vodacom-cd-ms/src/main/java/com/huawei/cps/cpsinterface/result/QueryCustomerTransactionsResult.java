
package com.huawei.cps.cpsinterface.result;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询Customer的Transactions
 * 
 * <p>Java class for QueryCustomerTransactionsResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryCustomerTransactionsResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="TransactionListData"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="TransactionItem" type="{http://cps.huawei.com/cpsinterface/result}TransactionInfoType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *                   &lt;element name="NbrOfReturned" type="{http://www.w3.org/2001/XMLSchema}integer"/&gt;
 *                   &lt;element name="NbrOfTotal" type="{http://www.w3.org/2001/XMLSchema}integer"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "QueryCustomerTransactionsResult", propOrder = {
    "boCompletedTime",
    "transactionListData"
})
public class QueryCustomerTransactionsResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "TransactionListData", required = true)
    protected QueryCustomerTransactionsResult.TransactionListData transactionListData;

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
     * Gets the value of the transactionListData property.
     * 
     * @return
     *     possible object is
     *     {@link QueryCustomerTransactionsResult.TransactionListData }
     *     
     */
    public QueryCustomerTransactionsResult.TransactionListData getTransactionListData() {
        return transactionListData;
    }

    /**
     * Sets the value of the transactionListData property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryCustomerTransactionsResult.TransactionListData }
     *     
     */
    public void setTransactionListData(QueryCustomerTransactionsResult.TransactionListData value) {
        this.transactionListData = value;
    }


    /**
     * <p>Java class for anonymous complex type.
     * 
     * <p>The following schema fragment specifies the expected content contained within this class.
     * 
     * <pre>
     * &lt;complexType&gt;
     *   &lt;complexContent&gt;
     *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *       &lt;sequence&gt;
     *         &lt;element name="TransactionItem" type="{http://cps.huawei.com/cpsinterface/result}TransactionInfoType" maxOccurs="unbounded" minOccurs="0"/&gt;
     *         &lt;element name="NbrOfReturned" type="{http://www.w3.org/2001/XMLSchema}integer"/&gt;
     *         &lt;element name="NbrOfTotal" type="{http://www.w3.org/2001/XMLSchema}integer"/&gt;
     *       &lt;/sequence&gt;
     *     &lt;/restriction&gt;
     *   &lt;/complexContent&gt;
     * &lt;/complexType&gt;
     * </pre>
     * 
     * 
     */
    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "", propOrder = {
        "transactionItem",
        "nbrOfReturned",
        "nbrOfTotal"
    })
    public static class TransactionListData {

        @XmlElement(name = "TransactionItem")
        protected List<TransactionInfoType> transactionItem;
        @XmlElement(name = "NbrOfReturned", required = true)
        protected BigInteger nbrOfReturned;
        @XmlElement(name = "NbrOfTotal", required = true)
        protected BigInteger nbrOfTotal;

        /**
         * Gets the value of the transactionItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the transactionItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getTransactionItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link TransactionInfoType }
         * 
         * 
         */
        public List<TransactionInfoType> getTransactionItem() {
            if (transactionItem == null) {
                transactionItem = new ArrayList<TransactionInfoType>();
            }
            return this.transactionItem;
        }

        /**
         * Gets the value of the nbrOfReturned property.
         * 
         * @return
         *     possible object is
         *     {@link BigInteger }
         *     
         */
        public BigInteger getNbrOfReturned() {
            return nbrOfReturned;
        }

        /**
         * Sets the value of the nbrOfReturned property.
         * 
         * @param value
         *     allowed object is
         *     {@link BigInteger }
         *     
         */
        public void setNbrOfReturned(BigInteger value) {
            this.nbrOfReturned = value;
        }

        /**
         * Gets the value of the nbrOfTotal property.
         * 
         * @return
         *     possible object is
         *     {@link BigInteger }
         *     
         */
        public BigInteger getNbrOfTotal() {
            return nbrOfTotal;
        }

        /**
         * Sets the value of the nbrOfTotal property.
         * 
         * @param value
         *     allowed object is
         *     {@link BigInteger }
         *     
         */
        public void setNbrOfTotal(BigInteger value) {
            this.nbrOfTotal = value;
        }

    }

}
