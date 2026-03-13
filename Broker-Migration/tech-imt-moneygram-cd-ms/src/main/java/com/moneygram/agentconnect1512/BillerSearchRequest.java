
package com.moneygram.agentconnect1512;

import java.math.BigDecimal;
import java.math.BigInteger;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for BillerSearchRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="BillerSearchRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Request"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="searchType" type="{http://www.moneygram.com/AgentConnect1512}searchType"/&gt;
 *         &lt;element name="productVariant" type="{http://www.moneygram.com/AgentConnect1512}productVariant" minOccurs="0"/&gt;
 *         &lt;element name="industryID" type="{http://www.moneygram.com/AgentConnect1512}industryID" minOccurs="0"/&gt;
 *         &lt;element name="receiveCode" type="{http://www.moneygram.com/AgentConnect1512}receiveCodeType" minOccurs="0"/&gt;
 *         &lt;element name="billerName" type="{http://www.moneygram.com/AgentConnect1512}stringMax64" minOccurs="0"/&gt;
 *         &lt;element name="receiveAgentID" type="{http://www.moneygram.com/AgentConnect1512}agentID" minOccurs="0"/&gt;
 *         &lt;element name="binNumber" type="{http://www.moneygram.com/AgentConnect1512}binNumber" minOccurs="0"/&gt;
 *         &lt;element name="defaultInformationalFee" type="{http://www.moneygram.com/AgentConnect1512}decimal14" minOccurs="0"/&gt;
 *         &lt;element name="defaultMaxFee" type="{http://www.w3.org/2001/XMLSchema}boolean" minOccurs="0"/&gt;
 *         &lt;element name="maxRowsToReturn" type="{http://www.moneygram.com/AgentConnect1512}int3" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "BillerSearchRequest", propOrder = {
    "searchType",
    "productVariant",
    "industryID",
    "receiveCode",
    "billerName",
    "receiveAgentID",
    "binNumber",
    "defaultInformationalFee",
    "defaultMaxFee",
    "maxRowsToReturn"
})
public class BillerSearchRequest
    extends Request
{

    @XmlElement(required = true)
    @XmlSchemaType(name = "string")
    protected SearchType searchType;
    @XmlSchemaType(name = "string")
    protected ProductVariant productVariant;
    protected String industryID;
    protected String receiveCode;
    protected String billerName;
    protected String receiveAgentID;
    protected String binNumber;
    protected BigDecimal defaultInformationalFee;
    protected Boolean defaultMaxFee;
    protected BigInteger maxRowsToReturn;

    /**
     * Gets the value of the searchType property.
     * 
     * @return
     *     possible object is
     *     {@link SearchType }
     *     
     */
    public SearchType getSearchType() {
        return searchType;
    }

    /**
     * Sets the value of the searchType property.
     * 
     * @param value
     *     allowed object is
     *     {@link SearchType }
     *     
     */
    public void setSearchType(SearchType value) {
        this.searchType = value;
    }

    /**
     * Gets the value of the productVariant property.
     * 
     * @return
     *     possible object is
     *     {@link ProductVariant }
     *     
     */
    public ProductVariant getProductVariant() {
        return productVariant;
    }

    /**
     * Sets the value of the productVariant property.
     * 
     * @param value
     *     allowed object is
     *     {@link ProductVariant }
     *     
     */
    public void setProductVariant(ProductVariant value) {
        this.productVariant = value;
    }

    /**
     * Gets the value of the industryID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIndustryID() {
        return industryID;
    }

    /**
     * Sets the value of the industryID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIndustryID(String value) {
        this.industryID = value;
    }

    /**
     * Gets the value of the receiveCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiveCode() {
        return receiveCode;
    }

    /**
     * Sets the value of the receiveCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiveCode(String value) {
        this.receiveCode = value;
    }

    /**
     * Gets the value of the billerName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBillerName() {
        return billerName;
    }

    /**
     * Sets the value of the billerName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBillerName(String value) {
        this.billerName = value;
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
     * Gets the value of the binNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBinNumber() {
        return binNumber;
    }

    /**
     * Sets the value of the binNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBinNumber(String value) {
        this.binNumber = value;
    }

    /**
     * Gets the value of the defaultInformationalFee property.
     * 
     * @return
     *     possible object is
     *     {@link BigDecimal }
     *     
     */
    public BigDecimal getDefaultInformationalFee() {
        return defaultInformationalFee;
    }

    /**
     * Sets the value of the defaultInformationalFee property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigDecimal }
     *     
     */
    public void setDefaultInformationalFee(BigDecimal value) {
        this.defaultInformationalFee = value;
    }

    /**
     * Gets the value of the defaultMaxFee property.
     * 
     * @return
     *     possible object is
     *     {@link Boolean }
     *     
     */
    public Boolean isDefaultMaxFee() {
        return defaultMaxFee;
    }

    /**
     * Sets the value of the defaultMaxFee property.
     * 
     * @param value
     *     allowed object is
     *     {@link Boolean }
     *     
     */
    public void setDefaultMaxFee(Boolean value) {
        this.defaultMaxFee = value;
    }

    /**
     * Gets the value of the maxRowsToReturn property.
     * 
     * @return
     *     possible object is
     *     {@link BigInteger }
     *     
     */
    public BigInteger getMaxRowsToReturn() {
        return maxRowsToReturn;
    }

    /**
     * Sets the value of the maxRowsToReturn property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigInteger }
     *     
     */
    public void setMaxRowsToReturn(BigInteger value) {
        this.maxRowsToReturn = value;
    }

}
