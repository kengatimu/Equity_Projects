
package com.moneygram.agentconnect1512;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for FeeInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="FeeInfo"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="validReceiveAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14"/&gt;
 *         &lt;element name="validReceiveCurrency" type="{http://www.moneygram.com/AgentConnect1512}currencyCode"/&gt;
 *         &lt;element name="validExchangeRate" type="{http://www.moneygram.com/AgentConnect1512}decimal14"/&gt;
 *         &lt;element name="estimatedReceiveAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="estimatedReceiveCurrency" type="{http://www.moneygram.com/AgentConnect1512}currencyCode" minOccurs="0"/&gt;
 *         &lt;element name="estimatedExchangeRate" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="totalAmount" type="{http://www.moneygram.com/AgentConnect1512}decimal14"/&gt;
 *         &lt;element name="receiveCountry" type="{http://www.moneygram.com/AgentConnect1512}countryType"/&gt;
 *         &lt;element name="deliveryOption" type="{http://www.moneygram.com/AgentConnect1512}deliveryOption" minOccurs="0"/&gt;
 *         &lt;element name="receiveAmountAltered" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="speedOfDeliveryText" type="{http://www.moneygram.com/AgentConnect1512}stringMax40" minOccurs="0"/&gt;
 *         &lt;element name="saLimitAvailable" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="revisedInformationalFee" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="deliveryOptId" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="deliveryOptDisplayName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="regAuthText" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="receiveAgentID" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="receiveAgentName" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="receiveAgentAbbreviation" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="mgManaged" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="disclosureText" type="{http://www.moneygram.com/AgentConnect1512}stringMax2000" minOccurs="0"/&gt;
 *         &lt;element name="mgiTransactionSessionID" type="{http://www.moneygram.com/AgentConnect1512}mgiTransactionSessionID"/&gt;
 *         &lt;element name="sendAmountAltered" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="additionalInfoText" type="{http://www.moneygram.com/AgentConnect1512}stringMax400" minOccurs="0"/&gt;
 *         &lt;element name="eddAdditionalDetails" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="eddAdditionalInfo" type="{http://www.moneygram.com/AgentConnect1512}EddAdditionalInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="promotionInfo" type="{http://www.moneygram.com/AgentConnect1512}PromotionInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="sendAmounts" type="{http://www.moneygram.com/AgentConnect1512}SendAmountInfo" minOccurs="0"/&gt;
 *         &lt;element name="receiveAmounts" type="{http://www.moneygram.com/AgentConnect1512}EstimatedReceiveAmountInfo" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "FeeInfo", propOrder = {
    "validReceiveAmount",
    "validReceiveCurrency",
    "validExchangeRate",
    "estimatedReceiveAmount",
    "estimatedReceiveCurrency",
    "estimatedExchangeRate",
    "totalAmount",
    "receiveCountry",
    "deliveryOption",
    "receiveAmountAltered",
    "speedOfDeliveryText",
    "saLimitAvailable",
    "revisedInformationalFee",
    "deliveryOptId",
    "deliveryOptDisplayName",
    "regAuthText",
    "receiveAgentID",
    "receiveAgentName",
    "receiveAgentAbbreviation",
    "mgManaged",
    "disclosureText",
    "mgiTransactionSessionID",
    "sendAmountAltered",
    "additionalInfoText",
    "eddAdditionalDetails",
    "promotionInfo",
    "sendAmounts",
    "receiveAmounts"
})
public class FeeInfo {

    @XmlElement(required = true)
    protected BigDecimal validReceiveAmount;
    @XmlElement(required = true)
    protected String validReceiveCurrency;
    @XmlElement(required = true)
    protected BigDecimal validExchangeRate;
    protected BigDecimal estimatedReceiveAmount;
    protected String estimatedReceiveCurrency;
    protected BigDecimal estimatedExchangeRate;
    @XmlElement(required = true)
    protected BigDecimal totalAmount;
    @XmlElement(required = true)
    protected String receiveCountry;
    protected String deliveryOption;
    protected Boolean receiveAmountAltered;
    protected String speedOfDeliveryText;
    protected BigDecimal saLimitAvailable;
    protected Boolean revisedInformationalFee;
    protected String deliveryOptId;
    protected String deliveryOptDisplayName;
    protected String regAuthText;
    protected String receiveAgentID;
    protected String receiveAgentName;
    protected String receiveAgentAbbreviation;
    protected String mgManaged;
    protected String disclosureText;
    @XmlElement(required = true)
    protected String mgiTransactionSessionID;
    protected boolean sendAmountAltered;
    protected String additionalInfoText;
    protected FeeInfo.EddAdditionalDetails eddAdditionalDetails;
    protected List<PromotionInfo> promotionInfo;
    protected SendAmountInfo sendAmounts;
    protected EstimatedReceiveAmountInfo receiveAmounts;

    /**
     * Gets the value of the validReceiveAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getValidReceiveAmount() {
        return validReceiveAmount;
    }

    /**
     * Sets the value of the validReceiveAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setValidReceiveAmount(BigDecimal value) {
        this.validReceiveAmount = value;
    }

    /**
     * Gets the value of the validReceiveCurrency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getValidReceiveCurrency() {
        return validReceiveCurrency;
    }

    /**
     * Sets the value of the validReceiveCurrency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setValidReceiveCurrency(String value) {
        this.validReceiveCurrency = value;
    }

    /**
     * Gets the value of the validExchangeRate property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getValidExchangeRate() {
        return validExchangeRate;
    }

    /**
     * Sets the value of the validExchangeRate property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setValidExchangeRate(BigDecimal value) {
        this.validExchangeRate = value;
    }

    /**
     * Gets the value of the estimatedReceiveAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getEstimatedReceiveAmount() {
        return estimatedReceiveAmount;
    }

    /**
     * Sets the value of the estimatedReceiveAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setEstimatedReceiveAmount(BigDecimal value) {
        this.estimatedReceiveAmount = value;
    }

    /**
     * Gets the value of the estimatedReceiveCurrency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getEstimatedReceiveCurrency() {
        return estimatedReceiveCurrency;
    }

    /**
     * Sets the value of the estimatedReceiveCurrency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setEstimatedReceiveCurrency(String value) {
        this.estimatedReceiveCurrency = value;
    }

    /**
     * Gets the value of the estimatedExchangeRate property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getEstimatedExchangeRate() {
        return estimatedExchangeRate;
    }

    /**
     * Sets the value of the estimatedExchangeRate property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setEstimatedExchangeRate(BigDecimal value) {
        this.estimatedExchangeRate = value;
    }

    /**
     * Gets the value of the totalAmount property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    /**
     * Sets the value of the totalAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setTotalAmount(BigDecimal value) {
        this.totalAmount = value;
    }

    /**
     * Gets the value of the receiveCountry property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiveCountry() {
        return receiveCountry;
    }

    /**
     * Sets the value of the receiveCountry property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiveCountry(String value) {
        this.receiveCountry = value;
    }

    /**
     * Gets the value of the deliveryOption property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDeliveryOption() {
        return deliveryOption;
    }

    /**
     * Sets the value of the deliveryOption property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDeliveryOption(String value) {
        this.deliveryOption = value;
    }

    /**
     * Gets the value of the receiveAmountAltered property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isReceiveAmountAltered() {
        return receiveAmountAltered;
    }

    /**
     * Sets the value of the receiveAmountAltered property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setReceiveAmountAltered(Boolean value) {
        this.receiveAmountAltered = value;
    }

    /**
     * Gets the value of the speedOfDeliveryText property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSpeedOfDeliveryText() {
        return speedOfDeliveryText;
    }

    /**
     * Sets the value of the speedOfDeliveryText property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSpeedOfDeliveryText(String value) {
        this.speedOfDeliveryText = value;
    }

    /**
     * Gets the value of the saLimitAvailable property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getSaLimitAvailable() {
        return saLimitAvailable;
    }

    /**
     * Sets the value of the saLimitAvailable property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setSaLimitAvailable(BigDecimal value) {
        this.saLimitAvailable = value;
    }

    /**
     * Gets the value of the revisedInformationalFee property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isRevisedInformationalFee() {
        return revisedInformationalFee;
    }

    /**
     * Sets the value of the revisedInformationalFee property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setRevisedInformationalFee(Boolean value) {
        this.revisedInformationalFee = value;
    }

    /**
     * Gets the value of the deliveryOptId property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDeliveryOptId() {
        return deliveryOptId;
    }

    /**
     * Sets the value of the deliveryOptId property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDeliveryOptId(String value) {
        this.deliveryOptId = value;
    }

    /**
     * Gets the value of the deliveryOptDisplayName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDeliveryOptDisplayName() {
        return deliveryOptDisplayName;
    }

    /**
     * Sets the value of the deliveryOptDisplayName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDeliveryOptDisplayName(String value) {
        this.deliveryOptDisplayName = value;
    }

    /**
     * Gets the value of the regAuthText property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRegAuthText() {
        return regAuthText;
    }

    /**
     * Sets the value of the regAuthText property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRegAuthText(String value) {
        this.regAuthText = value;
    }

    /**
     * Gets the value of the receiveAgentID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiveAgentID() {
        return receiveAgentID;
    }

    /**
     * Sets the value of the receiveAgentID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiveAgentID(String value) {
        this.receiveAgentID = value;
    }

    /**
     * Gets the value of the receiveAgentName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiveAgentName() {
        return receiveAgentName;
    }

    /**
     * Sets the value of the receiveAgentName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiveAgentName(String value) {
        this.receiveAgentName = value;
    }

    /**
     * Gets the value of the receiveAgentAbbreviation property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiveAgentAbbreviation() {
        return receiveAgentAbbreviation;
    }

    /**
     * Sets the value of the receiveAgentAbbreviation property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiveAgentAbbreviation(String value) {
        this.receiveAgentAbbreviation = value;
    }

    /**
     * Gets the value of the mgManaged property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMgManaged() {
        return mgManaged;
    }

    /**
     * Sets the value of the mgManaged property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMgManaged(String value) {
        this.mgManaged = value;
    }

    /**
     * Gets the value of the disclosureText property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDisclosureText() {
        return disclosureText;
    }

    /**
     * Sets the value of the disclosureText property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDisclosureText(String value) {
        this.disclosureText = value;
    }

    /**
     * Gets the value of the mgiTransactionSessionID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMgiTransactionSessionID() {
        return mgiTransactionSessionID;
    }

    /**
     * Sets the value of the mgiTransactionSessionID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMgiTransactionSessionID(String value) {
        this.mgiTransactionSessionID = value;
    }

    /**
     * Gets the value of the sendAmountAltered property.
     * 
     */
    public boolean isSendAmountAltered() {
        return sendAmountAltered;
    }

    /**
     * Sets the value of the sendAmountAltered property.
     * 
     */
    public void setSendAmountAltered(boolean value) {
        this.sendAmountAltered = value;
    }

    /**
     * Gets the value of the additionalInfoText property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAdditionalInfoText() {
        return additionalInfoText;
    }

    /**
     * Sets the value of the additionalInfoText property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAdditionalInfoText(String value) {
        this.additionalInfoText = value;
    }

    /**
     * Gets the value of the eddAdditionalDetails property.
     * 
     * @return
     *     possible object is
     *     {@link FeeInfo.EddAdditionalDetails }
     *     
     */
    public FeeInfo.EddAdditionalDetails getEddAdditionalDetails() {
        return eddAdditionalDetails;
    }

    /**
     * Sets the value of the eddAdditionalDetails property.
     * 
     * @param value
     *     allowed object is
     *     {@link FeeInfo.EddAdditionalDetails }
     *     
     */
    public void setEddAdditionalDetails(FeeInfo.EddAdditionalDetails value) {
        this.eddAdditionalDetails = value;
    }

    /**
     * Gets the value of the promotionInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the promotionInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getPromotionInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link PromotionInfo }
     * 
     * 
     */
    public List<PromotionInfo> getPromotionInfo() {
        if (promotionInfo == null) {
            promotionInfo = new ArrayList<PromotionInfo>();
        }
        return this.promotionInfo;
    }

    /**
     * Gets the value of the sendAmounts property.
     * 
     * @return
     *     possible object is
     *     {@link SendAmountInfo }
     *     
     */
    public SendAmountInfo getSendAmounts() {
        return sendAmounts;
    }

    /**
     * Sets the value of the sendAmounts property.
     * 
     * @param value
     *     allowed object is
     *     {@link SendAmountInfo }
     *     
     */
    public void setSendAmounts(SendAmountInfo value) {
        this.sendAmounts = value;
    }

    /**
     * Gets the value of the receiveAmounts property.
     * 
     * @return
     *     possible object is
     *     {@link EstimatedReceiveAmountInfo }
     *     
     */
    public EstimatedReceiveAmountInfo getReceiveAmounts() {
        return receiveAmounts;
    }

    /**
     * Sets the value of the receiveAmounts property.
     * 
     * @param value
     *     allowed object is
     *     {@link EstimatedReceiveAmountInfo }
     *     
     */
    public void setReceiveAmounts(EstimatedReceiveAmountInfo value) {
        this.receiveAmounts = value;
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
     *         &lt;element name="eddAdditionalInfo" type="{http://www.moneygram.com/AgentConnect1512}EddAdditionalInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "eddAdditionalInfo"
    })
    public static class EddAdditionalDetails {

        protected List<EddAdditionalInfo> eddAdditionalInfo;

        /**
         * Gets the value of the eddAdditionalInfo property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the eddAdditionalInfo property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getEddAdditionalInfo().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link EddAdditionalInfo }
         * 
         * 
         */
        public List<EddAdditionalInfo> getEddAdditionalInfo() {
            if (eddAdditionalInfo == null) {
                eddAdditionalInfo = new ArrayList<EddAdditionalInfo>();
            }
            return this.eddAdditionalInfo;
        }

    }

}
