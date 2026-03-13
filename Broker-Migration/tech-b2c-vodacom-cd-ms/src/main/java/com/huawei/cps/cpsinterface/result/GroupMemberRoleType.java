
package com.huawei.cps.cpsinterface.result;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * GroupMemberRole详细信息
 * 
 * <p>Java class for GroupMemberRoleType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="GroupMemberRoleType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="RoleID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="RoleName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="MinNumberRequired" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="MaxNumberAllowed" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="IsDefault" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "GroupMemberRoleType", propOrder = {
    "roleID",
    "roleName",
    "minNumberRequired",
    "maxNumberAllowed",
    "isDefault"
})
public class GroupMemberRoleType {

    @XmlElement(name = "RoleID", required = true)
    protected String roleID;
    @XmlElement(name = "RoleName", required = true)
    protected String roleName;
    @XmlElement(name = "MinNumberRequired", required = true)
    protected String minNumberRequired;
    @XmlElement(name = "MaxNumberAllowed", required = true)
    protected String maxNumberAllowed;
    @XmlElement(name = "IsDefault", required = true)
    protected String isDefault;

    /**
     * Gets the value of the roleID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRoleID() {
        return roleID;
    }

    /**
     * Sets the value of the roleID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRoleID(String value) {
        this.roleID = value;
    }

    /**
     * Gets the value of the roleName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRoleName() {
        return roleName;
    }

    /**
     * Sets the value of the roleName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRoleName(String value) {
        this.roleName = value;
    }

    /**
     * Gets the value of the minNumberRequired property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMinNumberRequired() {
        return minNumberRequired;
    }

    /**
     * Sets the value of the minNumberRequired property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMinNumberRequired(String value) {
        this.minNumberRequired = value;
    }

    /**
     * Gets the value of the maxNumberAllowed property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getMaxNumberAllowed() {
        return maxNumberAllowed;
    }

    /**
     * Sets the value of the maxNumberAllowed property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setMaxNumberAllowed(String value) {
        this.maxNumberAllowed = value;
    }

    /**
     * Gets the value of the isDefault property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIsDefault() {
        return isDefault;
    }

    /**
     * Sets the value of the isDefault property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIsDefault(String value) {
        this.isDefault = value;
    }

}
