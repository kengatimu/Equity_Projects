
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Customer加入的Group和角色信息
 * 
 * <p>Java class for GroupMemberType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="GroupMemberType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="GroupCode" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="GroupName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
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
@XmlType(name = "GroupMemberType", propOrder = {
    "groupCode",
    "groupName",
    "groupMemberRoleList"
})
public class GroupMemberType {

    @XmlElement(name = "GroupCode", required = true)
    protected String groupCode;
    @XmlElement(name = "GroupName", required = true)
    protected String groupName;
    @XmlElement(name = "GroupMemberRoleList", required = true)
    protected GroupMemberType.GroupMemberRoleList groupMemberRoleList;

    /**
     * Gets the value of the groupCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getGroupCode() {
        return groupCode;
    }

    /**
     * Sets the value of the groupCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setGroupCode(String value) {
        this.groupCode = value;
    }

    /**
     * Gets the value of the groupName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getGroupName() {
        return groupName;
    }

    /**
     * Sets the value of the groupName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setGroupName(String value) {
        this.groupName = value;
    }

    /**
     * Gets the value of the groupMemberRoleList property.
     * 
     * @return
     *     possible object is
     *     {@link GroupMemberType.GroupMemberRoleList }
     *     
     */
    public GroupMemberType.GroupMemberRoleList getGroupMemberRoleList() {
        return groupMemberRoleList;
    }

    /**
     * Sets the value of the groupMemberRoleList property.
     * 
     * @param value
     *     allowed object is
     *     {@link GroupMemberType.GroupMemberRoleList }
     *     
     */
    public void setGroupMemberRoleList(GroupMemberType.GroupMemberRoleList value) {
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
