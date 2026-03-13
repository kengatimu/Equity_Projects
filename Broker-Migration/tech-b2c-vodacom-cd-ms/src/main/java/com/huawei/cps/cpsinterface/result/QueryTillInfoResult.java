
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询Till的基本信息
 * 
 * <p>Java class for QueryTillInfoResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryTillInfoResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="OrgShortCode" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="TillNumber" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="MSISDN" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="Status" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="LanguageCode" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="CreationDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
 *         &lt;element name="SIMDeviceData"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="SIMDeviceItem" type="{http://cps.huawei.com/cpsinterface/result}SIMDeviceType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="DefaultOperatorID" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "QueryTillInfoResult", propOrder = {
    "boCompletedTime",
    "orgShortCode",
    "tillNumber",
    "msisdn",
    "status",
    "languageCode",
    "creationDate",
    "simDeviceData",
    "defaultOperatorID"
})
public class QueryTillInfoResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "OrgShortCode", required = true)
    protected String orgShortCode;
    @XmlElement(name = "TillNumber", required = true)
    protected String tillNumber;
    @XmlElement(name = "MSISDN", required = true)
    protected String msisdn;
    @XmlElement(name = "Status", required = true)
    protected String status;
    @XmlElement(name = "LanguageCode")
    protected String languageCode;
    @XmlElement(name = "CreationDate", required = true)
    protected String creationDate;
    @XmlElement(name = "SIMDeviceData", required = true)
    protected QueryTillInfoResult.SIMDeviceData simDeviceData;
    @XmlElement(name = "DefaultOperatorID")
    protected String defaultOperatorID;

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
     * Gets the value of the orgShortCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOrgShortCode() {
        return orgShortCode;
    }

    /**
     * Sets the value of the orgShortCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOrgShortCode(String value) {
        this.orgShortCode = value;
    }

    /**
     * Gets the value of the tillNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTillNumber() {
        return tillNumber;
    }

    /**
     * Sets the value of the tillNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTillNumber(String value) {
        this.tillNumber = value;
    }

    /**
     * Gets the value of the msisdn property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMSISDN() {
        return msisdn;
    }

    /**
     * Sets the value of the msisdn property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMSISDN(String value) {
        this.msisdn = value;
    }

    /**
     * Gets the value of the status property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getStatus() {
        return status;
    }

    /**
     * Sets the value of the status property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setStatus(String value) {
        this.status = value;
    }

    /**
     * Gets the value of the languageCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getLanguageCode() {
        return languageCode;
    }

    /**
     * Sets the value of the languageCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setLanguageCode(String value) {
        this.languageCode = value;
    }

    /**
     * Gets the value of the creationDate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCreationDate() {
        return creationDate;
    }

    /**
     * Sets the value of the creationDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCreationDate(String value) {
        this.creationDate = value;
    }

    /**
     * Gets the value of the simDeviceData property.
     * 
     * @return
     *     possible object is
     *     {@link QueryTillInfoResult.SIMDeviceData }
     *     
     */
    public QueryTillInfoResult.SIMDeviceData getSIMDeviceData() {
        return simDeviceData;
    }

    /**
     * Sets the value of the simDeviceData property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryTillInfoResult.SIMDeviceData }
     *     
     */
    public void setSIMDeviceData(QueryTillInfoResult.SIMDeviceData value) {
        this.simDeviceData = value;
    }

    /**
     * Gets the value of the defaultOperatorID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDefaultOperatorID() {
        return defaultOperatorID;
    }

    /**
     * Sets the value of the defaultOperatorID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDefaultOperatorID(String value) {
        this.defaultOperatorID = value;
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
     *         &lt;element name="SIMDeviceItem" type="{http://cps.huawei.com/cpsinterface/result}SIMDeviceType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "simDeviceItem"
    })
    public static class SIMDeviceData {

        @XmlElement(name = "SIMDeviceItem")
        protected List<SIMDeviceType> simDeviceItem;

        /**
         * Gets the value of the simDeviceItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the simDeviceItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getSIMDeviceItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link SIMDeviceType }
         * 
         * 
         */
        public List<SIMDeviceType> getSIMDeviceItem() {
            if (simDeviceItem == null) {
                simDeviceItem = new ArrayList<SIMDeviceType>();
            }
            return this.simDeviceItem;
        }

    }

}
