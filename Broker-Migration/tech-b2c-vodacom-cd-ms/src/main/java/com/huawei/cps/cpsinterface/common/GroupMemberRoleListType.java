
package com.huawei.cps.cpsinterface.common;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * GroupMemberRole列表信息
 * 
 * <p>Java class for GroupMemberRoleListType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="GroupMemberRoleListType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="RoleItem" maxOccurs="unbounded" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="RoleID" type="{http://cps.huawei.com/cpsinterface/common}IDType"/&gt;
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
@XmlType(name = "GroupMemberRoleListType", propOrder = {
    "roleItem"
})
public class GroupMemberRoleListType {

    @XmlElement(name = "RoleItem")
    protected List<GroupMemberRoleListType.RoleItem> roleItem;

    /**
     * Gets the value of the roleItem property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the roleItem property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getRoleItem().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link GroupMemberRoleListType.RoleItem }
     * 
     * 
     */
    public List<GroupMemberRoleListType.RoleItem> getRoleItem() {
        if (roleItem == null) {
            roleItem = new ArrayList<GroupMemberRoleListType.RoleItem>();
        }
        return this.roleItem;
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
     *         &lt;element name="RoleID" type="{http://cps.huawei.com/cpsinterface/common}IDType"/&gt;
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
        "roleID"
    })
    public static class RoleItem {

        @XmlElement(name = "RoleID", required = true)
        protected String roleID;

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

    }

}
