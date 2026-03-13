
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询Customer的基本信息
 * 
 * <p>Java class for QueryCustomerInfoResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryCustomerInfoResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="CustomerBasicData" type="{http://cps.huawei.com/cpsinterface/result}CustomerInfoType"/&gt;
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
 *         &lt;element name="CredentialData" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="CredentialItem" type="{http://cps.huawei.com/cpsinterface/result}CredentialType" maxOccurs="3"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
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
 *         &lt;element name="C2OLinkData" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="C2OLinkItem" type="{http://cps.huawei.com/cpsinterface/result}C2OLinkType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="GroupListData" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="GroupItem" type="{http://cps.huawei.com/cpsinterface/result}GroupMemberType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
@XmlType(name = "QueryCustomerInfoResult", propOrder = {
    "boCompletedTime",
    "customerBasicData",
    "segmentData",
    "credentialData",
    "simDeviceData",
    "c2OLinkData",
    "groupListData"
})
public class QueryCustomerInfoResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "CustomerBasicData", required = true)
    protected CustomerInfoType customerBasicData;
    @XmlElement(name = "SegmentData")
    protected QueryCustomerInfoResult.SegmentData segmentData;
    @XmlElement(name = "CredentialData")
    protected QueryCustomerInfoResult.CredentialData credentialData;
    @XmlElement(name = "SIMDeviceData", required = true)
    protected QueryCustomerInfoResult.SIMDeviceData simDeviceData;
    @XmlElement(name = "C2OLinkData")
    protected QueryCustomerInfoResult.C2OLinkData c2OLinkData;
    @XmlElement(name = "GroupListData")
    protected QueryCustomerInfoResult.GroupListData groupListData;

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
     * Gets the value of the customerBasicData property.
     * 
     * @return
     *     possible object is
     *     {@link CustomerInfoType }
     *     
     */
    public CustomerInfoType getCustomerBasicData() {
        return customerBasicData;
    }

    /**
     * Sets the value of the customerBasicData property.
     * 
     * @param value
     *     allowed object is
     *     {@link CustomerInfoType }
     *     
     */
    public void setCustomerBasicData(CustomerInfoType value) {
        this.customerBasicData = value;
    }

    /**
     * Gets the value of the segmentData property.
     * 
     * @return
     *     possible object is
     *     {@link QueryCustomerInfoResult.SegmentData }
     *     
     */
    public QueryCustomerInfoResult.SegmentData getSegmentData() {
        return segmentData;
    }

    /**
     * Sets the value of the segmentData property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryCustomerInfoResult.SegmentData }
     *     
     */
    public void setSegmentData(QueryCustomerInfoResult.SegmentData value) {
        this.segmentData = value;
    }

    /**
     * Gets the value of the credentialData property.
     * 
     * @return
     *     possible object is
     *     {@link QueryCustomerInfoResult.CredentialData }
     *     
     */
    public QueryCustomerInfoResult.CredentialData getCredentialData() {
        return credentialData;
    }

    /**
     * Sets the value of the credentialData property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryCustomerInfoResult.CredentialData }
     *     
     */
    public void setCredentialData(QueryCustomerInfoResult.CredentialData value) {
        this.credentialData = value;
    }

    /**
     * Gets the value of the simDeviceData property.
     * 
     * @return
     *     possible object is
     *     {@link QueryCustomerInfoResult.SIMDeviceData }
     *     
     */
    public QueryCustomerInfoResult.SIMDeviceData getSIMDeviceData() {
        return simDeviceData;
    }

    /**
     * Sets the value of the simDeviceData property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryCustomerInfoResult.SIMDeviceData }
     *     
     */
    public void setSIMDeviceData(QueryCustomerInfoResult.SIMDeviceData value) {
        this.simDeviceData = value;
    }

    /**
     * Gets the value of the c2OLinkData property.
     * 
     * @return
     *     possible object is
     *     {@link QueryCustomerInfoResult.C2OLinkData }
     *     
     */
    public QueryCustomerInfoResult.C2OLinkData getC2OLinkData() {
        return c2OLinkData;
    }

    /**
     * Sets the value of the c2OLinkData property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryCustomerInfoResult.C2OLinkData }
     *     
     */
    public void setC2OLinkData(QueryCustomerInfoResult.C2OLinkData value) {
        this.c2OLinkData = value;
    }

    /**
     * Gets the value of the groupListData property.
     * 
     * @return
     *     possible object is
     *     {@link QueryCustomerInfoResult.GroupListData }
     *     
     */
    public QueryCustomerInfoResult.GroupListData getGroupListData() {
        return groupListData;
    }

    /**
     * Sets the value of the groupListData property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryCustomerInfoResult.GroupListData }
     *     
     */
    public void setGroupListData(QueryCustomerInfoResult.GroupListData value) {
        this.groupListData = value;
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
     *         &lt;element name="C2OLinkItem" type="{http://cps.huawei.com/cpsinterface/result}C2OLinkType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "c2OLinkItem"
    })
    public static class C2OLinkData {

        @XmlElement(name = "C2OLinkItem")
        protected List<C2OLinkType> c2OLinkItem;

        /**
         * Gets the value of the c2OLinkItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the c2OLinkItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getC2OLinkItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link C2OLinkType }
         * 
         * 
         */
        public List<C2OLinkType> getC2OLinkItem() {
            if (c2OLinkItem == null) {
                c2OLinkItem = new ArrayList<C2OLinkType>();
            }
            return this.c2OLinkItem;
        }

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
     *         &lt;element name="CredentialItem" type="{http://cps.huawei.com/cpsinterface/result}CredentialType" maxOccurs="3"/&gt;
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
        "credentialItem"
    })
    public static class CredentialData {

        @XmlElement(name = "CredentialItem", required = true)
        protected List<CredentialType> credentialItem;

        /**
         * Gets the value of the credentialItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the credentialItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getCredentialItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link CredentialType }
         * 
         * 
         */
        public List<CredentialType> getCredentialItem() {
            if (credentialItem == null) {
                credentialItem = new ArrayList<CredentialType>();
            }
            return this.credentialItem;
        }

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
     *         &lt;element name="GroupItem" type="{http://cps.huawei.com/cpsinterface/result}GroupMemberType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "groupItem"
    })
    public static class GroupListData {

        @XmlElement(name = "GroupItem")
        protected List<GroupMemberType> groupItem;

        /**
         * Gets the value of the groupItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the groupItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getGroupItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link GroupMemberType }
         * 
         * 
         */
        public List<GroupMemberType> getGroupItem() {
            if (groupItem == null) {
                groupItem = new ArrayList<GroupMemberType>();
            }
            return this.groupItem;
        }

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
