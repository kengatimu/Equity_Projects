
package com.huawei.cps.cpsinterface.result;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询Group积分Statement的结果消息
 * 
 * <p>Java class for QueryGroupLoyaltyPointStatementResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryGroupLoyaltyPointStatementResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="PointStatementData"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="PointStatementItem" type="{http://cps.huawei.com/cpsinterface/result}PointStatementType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
@XmlType(name = "QueryGroupLoyaltyPointStatementResult", propOrder = {
    "boCompletedTime",
    "pointStatementData"
})
public class QueryGroupLoyaltyPointStatementResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "PointStatementData", required = true)
    protected QueryGroupLoyaltyPointStatementResult.PointStatementData pointStatementData;

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
     * Gets the value of the pointStatementData property.
     * 
     * @return
     *     possible object is
     *     {@link QueryGroupLoyaltyPointStatementResult.PointStatementData }
     *     
     */
    public QueryGroupLoyaltyPointStatementResult.PointStatementData getPointStatementData() {
        return pointStatementData;
    }

    /**
     * Sets the value of the pointStatementData property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryGroupLoyaltyPointStatementResult.PointStatementData }
     *     
     */
    public void setPointStatementData(QueryGroupLoyaltyPointStatementResult.PointStatementData value) {
        this.pointStatementData = value;
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
     *         &lt;element name="PointStatementItem" type="{http://cps.huawei.com/cpsinterface/result}PointStatementType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "pointStatementItem",
        "nbrOfReturned",
        "nbrOfTotal"
    })
    public static class PointStatementData {

        @XmlElement(name = "PointStatementItem")
        protected List<PointStatementType> pointStatementItem;
        @XmlElement(name = "NbrOfReturned", required = true)
        protected BigInteger nbrOfReturned;
        @XmlElement(name = "NbrOfTotal", required = true)
        protected BigInteger nbrOfTotal;

        /**
         * Gets the value of the pointStatementItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the pointStatementItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getPointStatementItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link PointStatementType }
         * 
         * 
         */
        public List<PointStatementType> getPointStatementItem() {
            if (pointStatementItem == null) {
                pointStatementItem = new ArrayList<PointStatementType>();
            }
            return this.pointStatementItem;
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
