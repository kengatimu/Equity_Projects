
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询Customer的账户余额
 * 
 * <p>Java class for QueryCustomerBalanceResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryCustomerBalanceResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="AccountBalanceData"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="AccountBalanceItem" type="{http://cps.huawei.com/cpsinterface/result}AccountBalanceType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
@XmlType(name = "QueryCustomerBalanceResult", propOrder = {
    "boCompletedTime",
    "accountBalanceData"
})
public class QueryCustomerBalanceResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "AccountBalanceData", required = true)
    protected QueryCustomerBalanceResult.AccountBalanceData accountBalanceData;

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
     * Gets the value of the accountBalanceData property.
     * 
     * @return
     *     possible object is
     *     {@link QueryCustomerBalanceResult.AccountBalanceData }
     *     
     */
    public QueryCustomerBalanceResult.AccountBalanceData getAccountBalanceData() {
        return accountBalanceData;
    }

    /**
     * Sets the value of the accountBalanceData property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryCustomerBalanceResult.AccountBalanceData }
     *     
     */
    public void setAccountBalanceData(QueryCustomerBalanceResult.AccountBalanceData value) {
        this.accountBalanceData = value;
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
     *         &lt;element name="AccountBalanceItem" type="{http://cps.huawei.com/cpsinterface/result}AccountBalanceType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "accountBalanceItem"
    })
    public static class AccountBalanceData {

        @XmlElement(name = "AccountBalanceItem")
        protected List<AccountBalanceType> accountBalanceItem;

        /**
         * Gets the value of the accountBalanceItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the accountBalanceItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getAccountBalanceItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link AccountBalanceType }
         * 
         * 
         */
        public List<AccountBalanceType> getAccountBalanceItem() {
            if (accountBalanceItem == null) {
                accountBalanceItem = new ArrayList<AccountBalanceType>();
            }
            return this.accountBalanceItem;
        }

    }

}
