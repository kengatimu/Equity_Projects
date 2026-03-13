
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 增加GroupMember
 * 
 * <p>Java class for AddGroupMemberRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="AddGroupMemberRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="InvitedMSISDN" type="{http://cps.huawei.com/cpsinterface/common}MSISDNType"/&gt;
 *         &lt;element name="GroupRoleID" type="{http://cps.huawei.com/cpsinterface/common}IDType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "AddGroupMemberRequest", propOrder = {
    "invitedMSISDN",
    "groupRoleID"
})
public class AddGroupMemberRequest {

    @XmlElement(name = "InvitedMSISDN", required = true)
    protected String invitedMSISDN;
    @XmlElement(name = "GroupRoleID")
    protected String groupRoleID;

    /**
     * Gets the value of the invitedMSISDN property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getInvitedMSISDN() {
        return invitedMSISDN;
    }

    /**
     * Sets the value of the invitedMSISDN property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setInvitedMSISDN(String value) {
        this.invitedMSISDN = value;
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

}
