
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询Organization的基本信息
 * 
 * <p>Java class for QueryOrganizationInfoResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryOrganizationInfoResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="OrganizationBasicData" type="{http://cps.huawei.com/cpsinterface/result}OrganizationInfoType"/&gt;
 *         &lt;element name="SegmentData" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="SegmentItem" type="{http://cps.huawei.com/cpsinterface/result}SegmentType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
@XmlType(name = "QueryOrganizationInfoResult", propOrder = {
    "boCompletedTime",
    "organizationBasicData",
    "segmentData"
})
public class QueryOrganizationInfoResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "OrganizationBasicData", required = true)
    protected OrganizationInfoType organizationBasicData;
    @XmlElement(name = "SegmentData")
    protected QueryOrganizationInfoResult.SegmentData segmentData;

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
     * Gets the value of the organizationBasicData property.
     * 
     * @return
     *     possible object is
     *     {@link OrganizationInfoType }
     *     
     */
    public OrganizationInfoType getOrganizationBasicData() {
        return organizationBasicData;
    }

    /**
     * Sets the value of the organizationBasicData property.
     * 
     * @param value
     *     allowed object is
     *     {@link OrganizationInfoType }
     *     
     */
    public void setOrganizationBasicData(OrganizationInfoType value) {
        this.organizationBasicData = value;
    }

    /**
     * Gets the value of the segmentData property.
     * 
     * @return
     *     possible object is
     *     {@link QueryOrganizationInfoResult.SegmentData }
     *     
     */
    public QueryOrganizationInfoResult.SegmentData getSegmentData() {
        return segmentData;
    }

    /**
     * Sets the value of the segmentData property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryOrganizationInfoResult.SegmentData }
     *     
     */
    public void setSegmentData(QueryOrganizationInfoResult.SegmentData value) {
        this.segmentData = value;
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
     *         &lt;element name="SegmentItem" type="{http://cps.huawei.com/cpsinterface/result}SegmentType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "segmentItem"
    })
    public static class SegmentData {

        @XmlElement(name = "SegmentItem")
        protected List<SegmentType> segmentItem;

        /**
         * Gets the value of the segmentItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the segmentItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getSegmentItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link SegmentType }
         * 
         * 
         */
        public List<SegmentType> getSegmentItem() {
            if (segmentItem == null) {
                segmentItem = new ArrayList<SegmentType>();
            }
            return this.segmentItem;
        }

    }

}
