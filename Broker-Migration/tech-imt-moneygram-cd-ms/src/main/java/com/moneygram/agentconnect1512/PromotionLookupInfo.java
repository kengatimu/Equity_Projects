
package com.moneygram.agentconnect1512;

import java.math.BigDecimal;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for PromotionLookupInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="PromotionLookupInfo"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="promotionDiscountName" type="{http://www.moneygram.com/AgentConnect1512}stringMax40" minOccurs="0"/&gt;
 *         &lt;element name="currencyCode" type="{http://www.moneygram.com/AgentConnect1512}currencyCode" minOccurs="0"/&gt;
 *         &lt;element name="promotionDiscount" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="promotionMaxDiscountAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="promotionCategoryName" type="{http://www.moneygram.com/AgentConnect1512}stringMax40" minOccurs="0"/&gt;
 *         &lt;element name="promotionName" type="{http://www.moneygram.com/AgentConnect1512}stringMax40" minOccurs="0"/&gt;
 *         &lt;element name="promotionId" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/&gt;
 *         &lt;element name="promotionBeginDate" type="{http://www.moneygram.com/AgentConnect1512}stringMax25" minOccurs="0"/&gt;
 *         &lt;element name="promotionEndDate" type="{http://www.moneygram.com/AgentConnect1512}stringMax25" minOccurs="0"/&gt;
 *         &lt;element name="promotionCategoryBeginDate" type="{http://www.moneygram.com/AgentConnect1512}stringMax25" minOccurs="0"/&gt;
 *         &lt;element name="promotionCategoryEndDate" type="{http://www.moneygram.com/AgentConnect1512}stringMax25" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "PromotionLookupInfo", propOrder = {
    "promotionDiscountName",
    "currencyCode",
    "promotionDiscount",
    "promotionMaxDiscountAmount",
    "promotionCategoryName",
    "promotionName",
    "promotionId",
    "promotionBeginDate",
    "promotionEndDate",
    "promotionCategoryBeginDate",
    "promotionCategoryEndDate"
})
public class PromotionLookupInfo {

    protected String promotionDiscountName;
    protected String currencyCode;
    protected BigDecimal promotionDiscount;
    protected BigDecimal promotionMaxDiscountAmount;
    protected String promotionCategoryName;
    protected String promotionName;
    protected Integer promotionId;
    protected String promotionBeginDate;
    protected String promotionEndDate;
    protected String promotionCategoryBeginDate;
    protected String promotionCategoryEndDate;

    /**
     * Gets the value of the promotionDiscountName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPromotionDiscountName() {
        return promotionDiscountName;
    }

    /**
     * Sets the value of the promotionDiscountName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPromotionDiscountName(String value) {
        this.promotionDiscountName = value;
    }

    /**
     * Gets the value of the currencyCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCurrencyCode() {
        return currencyCode;
    }

    /**
     * Sets the value of the currencyCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCurrencyCode(String value) {
        this.currencyCode = value;
    }

    /**
     * Gets the value of the promotionDiscount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getPromotionDiscount() {
        return promotionDiscount;
    }

    /**
     * Sets the value of the promotionDiscount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setPromotionDiscount(BigDecimal value) {
        this.promotionDiscount = value;
    }

    /**
     * Gets the value of the promotionMaxDiscountAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getPromotionMaxDiscountAmount() {
        return promotionMaxDiscountAmount;
    }

    /**
     * Sets the value of the promotionMaxDiscountAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setPromotionMaxDiscountAmount(BigDecimal value) {
        this.promotionMaxDiscountAmount = value;
    }

    /**
     * Gets the value of the promotionCategoryName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPromotionCategoryName() {
        return promotionCategoryName;
    }

    /**
     * Sets the value of the promotionCategoryName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPromotionCategoryName(String value) {
        this.promotionCategoryName = value;
    }

    /**
     * Gets the value of the promotionName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPromotionName() {
        return promotionName;
    }

    /**
     * Sets the value of the promotionName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPromotionName(String value) {
        this.promotionName = value;
    }

    /**
     * Gets the value of the promotionId property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getPromotionId() {
        return promotionId;
    }

    /**
     * Sets the value of the promotionId property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setPromotionId(Integer value) {
        this.promotionId = value;
    }

    /**
     * Gets the value of the promotionBeginDate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPromotionBeginDate() {
        return promotionBeginDate;
    }

    /**
     * Sets the value of the promotionBeginDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPromotionBeginDate(String value) {
        this.promotionBeginDate = value;
    }

    /**
     * Gets the value of the promotionEndDate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPromotionEndDate() {
        return promotionEndDate;
    }

    /**
     * Sets the value of the promotionEndDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPromotionEndDate(String value) {
        this.promotionEndDate = value;
    }

    /**
     * Gets the value of the promotionCategoryBeginDate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPromotionCategoryBeginDate() {
        return promotionCategoryBeginDate;
    }

    /**
     * Sets the value of the promotionCategoryBeginDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPromotionCategoryBeginDate(String value) {
        this.promotionCategoryBeginDate = value;
    }

    /**
     * Gets the value of the promotionCategoryEndDate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPromotionCategoryEndDate() {
        return promotionCategoryEndDate;
    }

    /**
     * Sets the value of the promotionCategoryEndDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPromotionCategoryEndDate(String value) {
        this.promotionCategoryEndDate = value;
    }

}
