
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * GroupMember信息
 * 
 * <p>Java class for GroupMemberInfoType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="GroupMemberInfoType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="MSISDN" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="GroupMemberRoleList"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="GroupMemberRole" type="{http://cps.huawei.com/cpsinterface/result}GroupMemberRoleSimpleType" maxOccurs="unbounded"/&gt;
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
@XmlType(name = "GroupMemberInfoType", propOrder = {
    "msisdn",
    "groupMemberRoleList"
})
public class GroupMemberInfoType {

    @XmlElement(name = "MSISDN", required = true)
    protected String msisdn;
    @XmlElement(name = "GroupMemberRoleList", required = true)
    protected GroupMemberInfoType.GroupMemberRoleList groupMemberRoleList;

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
     * Gets the value of the groupMemberRoleList property.
     * 
     * @return
     *     possible object is
     *     {@link GroupMemberInfoType.GroupMemberRoleList }
     *     
     */
    public GroupMemberInfoType.GroupMemberRoleList getGroupMemberRoleList() {
        return groupMemberRoleList;
    }

    /**
     * Sets the value of the groupMemberRoleList property.
     * 
     * @param value
     *     allowed object is
     *     {@link GroupMemberInfoType.GroupMemberRoleList }
     *     
     */
    public void setGroupMemberRoleList(GroupMemberInfoType.GroupMemberRoleList value) {
        this.groupMemberRoleList = value;
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
     *         &lt;element name="GroupMemberRole" type="{http://cps.huawei.com/cpsinterface/result}GroupMemberRoleSimpleType" maxOccurs="unbounded"/&gt;
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
        "groupMemberRole"
    })
    public static class GroupMemberRoleList {

        @XmlElement(name = "GroupMemberRole", required = true)
        protected List<GroupMemberRoleSimpleType> groupMemberRole;

        /**
         * Gets the value of the groupMemberRole property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the groupMemberRole property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getGroupMemberRole().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link GroupMemberRoleSimpleType }
         * 
         * 
         */
        public List<GroupMemberRoleSimpleType> getGroupMemberRole() {
            if (groupMemberRole == null) {
                groupMemberRole = new ArrayList<GroupMemberRoleSimpleType>();
            }
            return this.groupMemberRole;
        }

    }

}
