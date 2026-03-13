
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Customer查询Group的成员的结果消息
 * 
 * <p>Java class for ListGroupMembersByCustomerResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ListGroupMembersByCustomerResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="GroupMemberData"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="GroupMemberItem" type="{http://cps.huawei.com/cpsinterface/result}GroupMemberInfoType" maxOccurs="unbounded"/&gt;
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
@XmlType(name = "ListGroupMembersByCustomerResult", propOrder = {
    "boCompletedTime",
    "groupMemberData"
})
public class ListGroupMembersByCustomerResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "GroupMemberData", required = true)
    protected ListGroupMembersByCustomerResult.GroupMemberData groupMemberData;

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
     * Gets the value of the groupMemberData property.
     * 
     * @return
     *     possible object is
     *     {@link ListGroupMembersByCustomerResult.GroupMemberData }
     *     
     */
    public ListGroupMembersByCustomerResult.GroupMemberData getGroupMemberData() {
        return groupMemberData;
    }

    /**
     * Sets the value of the groupMemberData property.
     * 
     * @param value
     *     allowed object is
     *     {@link ListGroupMembersByCustomerResult.GroupMemberData }
     *     
     */
    public void setGroupMemberData(ListGroupMembersByCustomerResult.GroupMemberData value) {
        this.groupMemberData = value;
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
     *         &lt;element name="GroupMemberItem" type="{http://cps.huawei.com/cpsinterface/result}GroupMemberInfoType" maxOccurs="unbounded"/&gt;
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
        "groupMemberItem"
    })
    public static class GroupMemberData {

        @XmlElement(name = "GroupMemberItem", required = true)
        protected List<GroupMemberInfoType> groupMemberItem;

        /**
         * Gets the value of the groupMemberItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the groupMemberItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getGroupMemberItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link GroupMemberInfoType }
         * 
         * 
         */
        public List<GroupMemberInfoType> getGroupMemberItem() {
            if (groupMemberItem == null) {
                groupMemberItem = new ArrayList<GroupMemberInfoType>();
            }
            return this.groupMemberItem;
        }

    }

}
