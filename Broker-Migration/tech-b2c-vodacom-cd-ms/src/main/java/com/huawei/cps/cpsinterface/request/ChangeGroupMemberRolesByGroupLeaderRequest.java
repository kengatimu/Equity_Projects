
package com.huawei.cps.cpsinterface.request;

import com.huawei.cps.cpsinterface.common.GroupMemberRoleListType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * GroupLeader修改GroupMember的Role
 * 
 * <p>Java class for ChangeGroupMemberRolesByGroupLeaderRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ChangeGroupMemberRolesByGroupLeaderRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="ChangedMSISDN" type="{http://cps.huawei.com/cpsinterface/common}MSISDNType"/&gt;
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
@XmlType(name = "ChangeGroupMemberRolesByGroupLeaderRequest", propOrder = {
    "changedMSISDN",
    "addRoleList",
    "removeRoleList"
})
public class ChangeGroupMemberRolesByGroupLeaderRequest {

    @XmlElement(name = "ChangedMSISDN", required = true)
    protected String changedMSISDN;
    @XmlElement(name = "AddRoleList")
    protected GroupMemberRoleListType addRoleList;
    @XmlElement(name = "RemoveRoleList")
    protected GroupMemberRoleListType removeRoleList;

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
