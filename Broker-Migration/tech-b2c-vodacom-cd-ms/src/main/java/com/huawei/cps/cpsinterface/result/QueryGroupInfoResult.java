
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询Group的基本信息的结果消息
 * 
 * <p>Java class for QueryGroupInfoResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryGroupInfoResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="GroupBasicData" type="{http://cps.huawei.com/cpsinterface/result}GroupInfoType"/&gt;
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
 *         &lt;element name="GroupMemberRoleData"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="GroupMemberRoleItem" type="{http://cps.huawei.com/cpsinterface/result}GroupMemberRoleType" maxOccurs="unbounded"/&gt;
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
@XmlType(name = "QueryGroupInfoResult", propOrder = {
    "boCompletedTime",
    "groupBasicData",
    "segmentData",
    "groupMemberRoleData"
})
public class QueryGroupInfoResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "GroupBasicData", required = true)
    protected GroupInfoType groupBasicData;
    @XmlElement(name = "SegmentData")
    protected QueryGroupInfoResult.SegmentData segmentData;
    @XmlElement(name = "GroupMemberRoleData", required = true)
    protected QueryGroupInfoResult.GroupMemberRoleData groupMemberRoleData;

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
     * Gets the value of the groupBasicData property.
     * 
     * @return
     *     possible object is
     *     {@link GroupInfoType }
     *     
     */
    public GroupInfoType getGroupBasicData() {
        return groupBasicData;
    }

    /**
     * Sets the value of the groupBasicData property.
     * 
     * @param value
     *     allowed object is
     *     {@link GroupInfoType }
     *     
     */
    public void setGroupBasicData(GroupInfoType value) {
        this.groupBasicData = value;
    }

    /**
     * Gets the value of the segmentData property.
     * 
     * @return
     *     possible object is
     *     {@link QueryGroupInfoResult.SegmentData }
     *     
     */
    public QueryGroupInfoResult.SegmentData getSegmentData() {
        return segmentData;
    }

    /**
     * Sets the value of the segmentData property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryGroupInfoResult.SegmentData }
     *     
     */
    public void setSegmentData(QueryGroupInfoResult.SegmentData value) {
        this.segmentData = value;
    }

    /**
     * Gets the value of the groupMemberRoleData property.
     * 
     * @return
     *     possible object is
     *     {@link QueryGroupInfoResult.GroupMemberRoleData }
     *     
     */
    public QueryGroupInfoResult.GroupMemberRoleData getGroupMemberRoleData() {
        return groupMemberRoleData;
    }

    /**
     * Sets the value of the groupMemberRoleData property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryGroupInfoResult.GroupMemberRoleData }
     *     
     */
    public void setGroupMemberRoleData(QueryGroupInfoResult.GroupMemberRoleData value) {
        this.groupMemberRoleData = value;
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
     *         &lt;element name="GroupMemberRoleItem" type="{http://cps.huawei.com/cpsinterface/result}GroupMemberRoleType" maxOccurs="unbounded"/&gt;
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
        "groupMemberRoleItem"
    })
    public static class GroupMemberRoleData {

        @XmlElement(name = "GroupMemberRoleItem", required = true)
        protected List<GroupMemberRoleType> groupMemberRoleItem;

        /**
         * Gets the value of the groupMemberRoleItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the groupMemberRoleItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getGroupMemberRoleItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link GroupMemberRoleType }
         * 
         * 
         */
        public List<GroupMemberRoleType> getGroupMemberRoleItem() {
            if (groupMemberRoleItem == null) {
                groupMemberRoleItem = new ArrayList<GroupMemberRoleType>();
            }
            return this.groupMemberRoleItem;
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

}
