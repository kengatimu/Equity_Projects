
package com.huawei.cps.cpsinterface.result;

import com.huawei.cps.cpsinterface.common.GroupMemberRoleListType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * GroupLeader修改GroupMember的Role的结果消息
 * 
 * <p>Java class for ChangeGroupMemberRolesByGroupLeaderResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ChangeGroupMemberRolesByGroupLeaderResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="GroupCode" type="{http://cps.huawei.com/cpsinterface/common}GroupCodeType"/&gt;
 *         &lt;element name="GroupName"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="64"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="ChangedMSISDN" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="AddRoleList" type="{http://cps.huawei.com/cpsinterface/common}GroupMemberRoleListType" minOccurs="0"/&gt;
 *         &lt;element name="RemoveRoleList" type="{http://cps.huawei.com/cpsinterface/common}GroupMemberRoleListType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ChangeGroupMemberRolesByGroupLeaderResult", propOrder = {
    "boCompletedTime",
    "groupCode",
    "groupName",
    "changedMSISDN",
    "addRoleList",
    "removeRoleList"
})
public class ChangeGroupMemberRolesByGroupLeaderResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "GroupCode", required = true)
    protected String groupCode;
    @XmlElement(name = "GroupName", required = true)
    protected String groupName;
    @XmlElement(name = "ChangedMSISDN", required = true)
    protected String changedMSISDN;
    @XmlElement(name = "AddRoleList")
    protected GroupMemberRoleListType addRoleList;
    @XmlElement(name = "RemoveRoleList")
    protected GroupMemberRoleListType removeRoleList;

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
     * Gets the value of the changedMSISDN property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getChangedMSISDN() {
        return changedMSISDN;
    }

    /**
     * Sets the value of the changedMSISDN property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setChangedMSISDN(String value) {
        this.changedMSISDN = value;
    }

    /**
     * Gets the value of the addRoleList property.
     * 
     * @return
     *     possible object is
     *     {@link GroupMemberRoleListType }
     *     
     */
    public GroupMemberRoleListType getAddRoleList() {
        return addRoleList;
    }

    /**
     * Sets the value of the addRoleList property.
     * 
     * @param value
     *     allowed object is
     *     {@link GroupMemberRoleListType }
     *     
     */
    public void setAddRoleList(GroupMemberRoleListType value) {
        this.addRoleList = value;
    }

    /**
     * Gets the value of the removeRoleList property.
     * 
     * @return
     *     possible object is
     *     {@link GroupMemberRoleListType }
     *     
     */
    public GroupMemberRoleListType getRemoveRoleList() {
        return removeRoleList;
    }

    /**
     * Sets the value of the removeRoleList property.
     * 
     * @param value
     *     allowed object is
     *     {@link GroupMemberRoleListType }
     *     
     */
    public void setRemoveRoleList(GroupMemberRoleListType value) {
        this.removeRoleList = value;
    }

}
