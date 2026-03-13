
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询Group Saving Plan
 * 
 * <p>Java class for QuerySavingPlanForGroupResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QuerySavingPlanForGroupResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="IdentitySavingPlanList"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="IdentitySavingPlan" type="{http://cps.huawei.com/cpsinterface/result}IdentitySavingPlanType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
@XmlType(name = "QuerySavingPlanForGroupResult", propOrder = {
    "boCompletedTime",
    "identitySavingPlanList"
})
public class QuerySavingPlanForGroupResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "IdentitySavingPlanList", required = true)
    protected QuerySavingPlanForGroupResult.IdentitySavingPlanList identitySavingPlanList;

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
     * Gets the value of the identitySavingPlanList property.
     * 
     * @return
     *     possible object is
     *     {@link QuerySavingPlanForGroupResult.IdentitySavingPlanList }
     *     
     */
    public QuerySavingPlanForGroupResult.IdentitySavingPlanList getIdentitySavingPlanList() {
        return identitySavingPlanList;
    }

    /**
     * Sets the value of the identitySavingPlanList property.
     * 
     * @param value
     *     allowed object is
     *     {@link QuerySavingPlanForGroupResult.IdentitySavingPlanList }
     *     
     */
    public void setIdentitySavingPlanList(QuerySavingPlanForGroupResult.IdentitySavingPlanList value) {
        this.identitySavingPlanList = value;
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
     *         &lt;element name="IdentitySavingPlan" type="{http://cps.huawei.com/cpsinterface/result}IdentitySavingPlanType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "identitySavingPlan"
    })
    public static class IdentitySavingPlanList {

        @XmlElement(name = "IdentitySavingPlan")
        protected List<IdentitySavingPlanType> identitySavingPlan;

        /**
         * Gets the value of the identitySavingPlan property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the identitySavingPlan property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getIdentitySavingPlan().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link IdentitySavingPlanType }
         * 
         * 
         */
        public List<IdentitySavingPlanType> getIdentitySavingPlan() {
            if (identitySavingPlan == null) {
                identitySavingPlan = new ArrayList<IdentitySavingPlanType>();
            }
            return this.identitySavingPlan;
        }

    }

}
