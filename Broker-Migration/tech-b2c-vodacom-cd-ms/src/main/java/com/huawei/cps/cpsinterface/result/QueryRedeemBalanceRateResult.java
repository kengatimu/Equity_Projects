
package com.huawei.cps.cpsinterface.result;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询积分兑换余额的比率
 * 
 * <p>Java class for QueryRedeemBalanceRateResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryRedeemBalanceRateResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;choice&gt;
 *         &lt;element name="RedeemRate" type="{http://www.w3.org/2001/XMLSchema}short"/&gt;
 *         &lt;sequence&gt;
 *           &lt;element name="PerPointAmount" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
 *           &lt;element name="FundsAmount" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;/sequence&gt;
 *       &lt;/choice&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "QueryRedeemBalanceRateResult", propOrder = {
    "redeemRate",
    "perPointAmount",
    "fundsAmount"
})
public class QueryRedeemBalanceRateResult {

    @XmlElement(name = "RedeemRate")
    protected Short redeemRate;
    @XmlElement(name = "PerPointAmount")
    protected Long perPointAmount;
    @XmlElement(name = "FundsAmount")
    protected String fundsAmount;

    /**
     * Gets the value of the redeemRate property.
     * 
     * @return
     *     possible object is
     *     {@link Short }
     *     
     */
    public Short getRedeemRate() {
        return redeemRate;
    }

    /**
     * Sets the value of the redeemRate property.
     * 
     * @param value
     *     allowed object is
     *     {@link Short }
     *     
     */
    public void setRedeemRate(Short value) {
        this.redeemRate = value;
    }

    /**
     * Gets the value of the perPointAmount property.
     * 
     * @return
     *     possible object is
     *     {@link Long }
     *     
     */
    public Long getPerPointAmount() {
        return perPointAmount;
    }

    /**
     * Sets the value of the perPointAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link Long }
     *     
     */
    public void setPerPointAmount(Long value) {
        this.perPointAmount = value;
    }

    /**
     * Gets the value of the fundsAmount property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFundsAmount() {
        return fundsAmount;
    }

    /**
     * Sets the value of the fundsAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFundsAmount(String value) {
        this.fundsAmount = value;
    }

}
