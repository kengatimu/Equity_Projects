
package com.huawei.cps.cpsinterface.result;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询Customer的AccountStatements
 * 
 * <p>Java class for QueryCustomerAccountStatementsResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryCustomerAccountStatementsResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="AccountStatementListData"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="AccountStatementItem" type="{http://cps.huawei.com/cpsinterface/result}AccountStatementType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
@XmlType(name = "QueryCustomerAccountStatementsResult", propOrder = {
    "boCompletedTime",
    "accountStatementListData"
})
public class QueryCustomerAccountStatementsResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "AccountStatementListData", required = true)
    protected QueryCustomerAccountStatementsResult.AccountStatementListData accountStatementListData;

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
     * Gets the value of the accountStatementListData property.
     * 
     * @return
     *     possible object is
     *     {@link QueryCustomerAccountStatementsResult.AccountStatementListData }
     *     
     */
    public QueryCustomerAccountStatementsResult.AccountStatementListData getAccountStatementListData() {
        return accountStatementListData;
    }

    /**
     * Sets the value of the accountStatementListData property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryCustomerAccountStatementsResult.AccountStatementListData }
     *     
     */
    public void setAccountStatementListData(QueryCustomerAccountStatementsResult.AccountStatementListData value) {
        this.accountStatementListData = value;
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
     *         &lt;element name="AccountStatementItem" type="{http://cps.huawei.com/cpsinterface/result}AccountStatementType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "accountStatementItem",
        "nbrOfReturned",
        "nbrOfTotal"
    })
    public static class AccountStatementListData {

        @XmlElement(name = "AccountStatementItem")
        protected List<AccountStatementType> accountStatementItem;
        @XmlElement(name = "NbrOfReturned", required = true)
        protected BigInteger nbrOfReturned;
        @XmlElement(name = "NbrOfTotal", required = true)
        protected BigInteger nbrOfTotal;

        /**
         * Gets the value of the accountStatementItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the accountStatementItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getAccountStatementItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link AccountStatementType }
         * 
         * 
         */
        public List<AccountStatementType> getAccountStatementItem() {
            if (accountStatementItem == null) {
                accountStatementItem = new ArrayList<AccountStatementType>();
            }
            return this.accountStatementItem;
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
