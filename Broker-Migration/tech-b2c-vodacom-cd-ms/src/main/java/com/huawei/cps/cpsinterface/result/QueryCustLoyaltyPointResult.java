
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询客户的积分结果消息
 * 
 * <p>Java class for QueryCustLoyaltyPointResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryCustLoyaltyPointResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="LoyaltyPointData"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="LoyaltyPointItem" type="{http://cps.huawei.com/cpsinterface/result}PointBalanceType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
@XmlType(name = "QueryCustLoyaltyPointResult", propOrder = {
    "boCompletedTime",
    "loyaltyPointData"
})
public class QueryCustLoyaltyPointResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "LoyaltyPointData", required = true)
    protected QueryCustLoyaltyPointResult.LoyaltyPointData loyaltyPointData;

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
     * Gets the value of the loyaltyPointData property.
     * 
     * @return
     *     possible object is
     *     {@link QueryCustLoyaltyPointResult.LoyaltyPointData }
     *     
     */
    public QueryCustLoyaltyPointResult.LoyaltyPointData getLoyaltyPointData() {
        return loyaltyPointData;
    }

    /**
     * Sets the value of the loyaltyPointData property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryCustLoyaltyPointResult.LoyaltyPointData }
     *     
     */
    public void setLoyaltyPointData(QueryCustLoyaltyPointResult.LoyaltyPointData value) {
        this.loyaltyPointData = value;
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
     *         &lt;element name="LoyaltyPointItem" type="{http://cps.huawei.com/cpsinterface/result}PointBalanceType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "loyaltyPointItem"
    })
    public static class LoyaltyPointData {

        @XmlElement(name = "LoyaltyPointItem")
        protected List<PointBalanceType> loyaltyPointItem;

        /**
         * Gets the value of the loyaltyPointItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the loyaltyPointItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getLoyaltyPointItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link PointBalanceType }
         * 
         * 
         */
        public List<PointBalanceType> getLoyaltyPointItem() {
            if (loyaltyPointItem == null) {
                loyaltyPointItem = new ArrayList<PointBalanceType>();
            }
            return this.loyaltyPointItem;
        }

    }

}
