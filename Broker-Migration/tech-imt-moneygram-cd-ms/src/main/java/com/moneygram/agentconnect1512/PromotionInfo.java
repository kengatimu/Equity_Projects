
package com.moneygram.agentconnect1512;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for PromotionInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="PromotionInfo"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="promotionCode" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="promotionDiscountId" type="{http://www.moneygram.com/AgentConnect1512}stringMax2" minOccurs="0"/&gt;
 *         &lt;element name="promotionCategoryId" type="{http://www.moneygram.com/AgentConnect1512}stringMax2" minOccurs="0"/&gt;
 *         &lt;element name="promotionDiscount" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="promotionDiscountAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="promotionErrorCode" type="{http://www.moneygram.com/AgentConnect1512}stringMax4" minOccurs="0"/&gt;
 *         &lt;element name="promotionErrorMessage" type="{http://www.moneygram.com/AgentConnect1512}TextTranslation" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "PromotionInfo", propOrder = {
    "promotionCode",
    "promotionDiscountId",
    "promotionCategoryId",
    "promotionDiscount",
    "promotionDiscountAmount",
    "promotionErrorCode",
    "promotionErrorMessage"
})
public class PromotionInfo {

    protected String promotionCode;
    protected String promotionDiscountId;
    protected String promotionCategoryId;
    protected BigDecimal promotionDiscount;
    protected BigDecimal promotionDiscountAmount;
    protected String promotionErrorCode;
    protected List<TextTranslation> promotionErrorMessage;

    /**
     * Gets the value of the promotionCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPromotionCode() {
        return promotionCode;
    }

    /**
     * Sets the value of the promotionCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPromotionCode(String value) {
        this.promotionCode = value;
    }

    /**
     * Gets the value of the promotionDiscountId property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPromotionDiscountId() {
        return promotionDiscountId;
    }

    /**
     * Sets the value of the promotionDiscountId property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPromotionDiscountId(String value) {
        this.promotionDiscountId = value;
    }

    /**
     * Gets the value of the promotionCategoryId property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPromotionCategoryId() {
        return promotionCategoryId;
    }

    /**
     * Sets the value of the promotionCategoryId property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPromotionCategoryId(String value) {
        this.promotionCategoryId = value;
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
     * Gets the value of the promotionDiscountAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getPromotionDiscountAmount() {
        return promotionDiscountAmount;
    }

    /**
     * Sets the value of the promotionDiscountAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setPromotionDiscountAmount(BigDecimal value) {
        this.promotionDiscountAmount = value;
    }

    /**
     * Gets the value of the promotionErrorCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPromotionErrorCode() {
        return promotionErrorCode;
    }

    /**
     * Sets the value of the promotionErrorCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPromotionErrorCode(String value) {
        this.promotionErrorCode = value;
    }

    /**
     * Gets the value of the promotionErrorMessage property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the promotionErrorMessage property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getPromotionErrorMessage().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link TextTranslation }
     * 
     * 
     */
    public List<TextTranslation> getPromotionErrorMessage() {
        if (promotionErrorMessage == null) {
            promotionErrorMessage = new ArrayList<TextTranslation>();
        }
        return this.promotionErrorMessage;
    }

}
