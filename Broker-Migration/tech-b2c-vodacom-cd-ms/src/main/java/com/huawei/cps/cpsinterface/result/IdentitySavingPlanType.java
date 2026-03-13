
package com.huawei.cps.cpsinterface.result;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 实体订购Saving Plan信息
 * 
 * <p>Java class for IdentitySavingPlanType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="IdentitySavingPlanType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="AccountTypeID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="AccountNo" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="PlanCode" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
 *         &lt;element name="PlanName" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
 *         &lt;element name="SubscribeOrderID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="SubscribeTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "IdentitySavingPlanType", propOrder = {
    "accountTypeID",
    "accountNo",
    "planCode",
    "planName",
    "subscribeOrderID",
    "subscribeTime"
})
public class IdentitySavingPlanType {

    @XmlElement(name = "AccountTypeID", required = true)
    protected String accountTypeID;
    @XmlElement(name = "AccountNo", required = true)
    protected String accountNo;
    @XmlElement(name = "PlanCode", required = true)
    protected String planCode;
    @XmlElement(name = "PlanName", required = true)
    protected String planName;
    @XmlElement(name = "SubscribeOrderID", required = true)
    protected String subscribeOrderID;
    @XmlElement(name = "SubscribeTime", required = true)
    protected String subscribeTime;

    /**
     * Gets the value of the accountTypeID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAccountTypeID() {
        return accountTypeID;
    }

    /**
     * Sets the value of the accountTypeID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAccountTypeID(String value) {
        this.accountTypeID = value;
    }

    /**
     * Gets the value of the accountNo property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAccountNo() {
        return accountNo;
    }

    /**
     * Sets the value of the accountNo property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAccountNo(String value) {
        this.accountNo = value;
    }

    /**
     * Gets the value of the planCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPlanCode() {
        return planCode;
    }

    /**
     * Sets the value of the planCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPlanCode(String value) {
        this.planCode = value;
    }

    /**
     * Gets the value of the planName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPlanName() {
        return planName;
    }

    /**
     * Sets the value of the planName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPlanName(String value) {
        this.planName = value;
    }

    /**
     * Gets the value of the subscribeOrderID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSubscribeOrderID() {
        return subscribeOrderID;
    }

    /**
     * Sets the value of the subscribeOrderID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSubscribeOrderID(String value) {
        this.subscribeOrderID = value;
    }

    /**
     * Gets the value of the subscribeTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSubscribeTime() {
        return subscribeTime;
    }

    /**
     * Sets the value of the subscribeTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSubscribeTime(String value) {
        this.subscribeTime = value;
    }

}
