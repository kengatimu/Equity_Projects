
package com.huawei.cps.cpsinterface.result;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Customer确认加入Group的结果消息
 * 
 * <p>Java class for ConfirmGroupMembershipResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ConfirmGroupMembershipResult"&gt;
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
 *         &lt;element name="GroupRoleID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="GroupRoleName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ConfirmGroupMembershipResult", propOrder = {
    "boCompletedTime",
    "groupCode",
    "groupName",
    "groupRoleID",
    "groupRoleName"
})
public class ConfirmGroupMembershipResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "GroupCode", required = true)
    protected String groupCode;
    @XmlElement(name = "GroupName", required = true)
    protected String groupName;
    @XmlElement(name = "GroupRoleID", required = true)
    protected String groupRoleID;
    @XmlElement(name = "GroupRoleName", required = true)
    protected String groupRoleName;

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
     * Gets the value of the groupRoleID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getGroupRoleID() {
        return groupRoleID;
    }

    /**
     * Sets the value of the groupRoleID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setGroupRoleID(String value) {
        this.groupRoleID = value;
    }

    /**
     * Gets the value of the groupRoleName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getGroupRoleName() {
        return groupRoleName;
    }

    /**
     * Sets the value of the groupRoleName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setGroupRoleName(String value) {
        this.groupRoleName = value;
    }

}
