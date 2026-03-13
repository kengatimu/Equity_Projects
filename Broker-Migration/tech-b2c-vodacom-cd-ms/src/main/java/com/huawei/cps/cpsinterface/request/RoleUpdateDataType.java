
package com.huawei.cps.cpsinterface.request;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Operator的Role更新数据
 * 
 * <p>Java class for RoleUpdateDataType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="RoleUpdateDataType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="RoleItem" maxOccurs="unbounded"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="RoleID" type="{http://cps.huawei.com/cpsinterface/common}IDType"/&gt;
 *                   &lt;element name="EffectiveDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
 *                   &lt;element name="ExpiryDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
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
@XmlType(name = "RoleUpdateDataType", propOrder = {
    "roleItem"
})
public class RoleUpdateDataType {

    @XmlElement(name = "RoleItem", required = true)
    protected List<RoleUpdateDataType.RoleItem> roleItem;

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
     * {@link RoleUpdateDataType.RoleItem }
     * 
     * 
     */
    public List<RoleUpdateDataType.RoleItem> getRoleItem() {
        if (roleItem == null) {
            roleItem = new ArrayList<RoleUpdateDataType.RoleItem>();
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
     *         &lt;element name="EffectiveDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
     *         &lt;element name="ExpiryDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
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
        "roleID",
        "effectiveDate",
        "expiryDate"
    })
    public static class RoleItem {

        @XmlElement(name = "RoleID", required = true)
        protected String roleID;
        @XmlElement(name = "EffectiveDate", required = true)
        protected String effectiveDate;
        @XmlElement(name = "ExpiryDate", required = true)
        protected String expiryDate;

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
         * Gets the value of the effectiveDate property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getEffectiveDate() {
            return effectiveDate;
        }

        /**
         * Sets the value of the effectiveDate property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setEffectiveDate(String value) {
            this.effectiveDate = value;
        }

        /**
         * Gets the value of the expiryDate property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getExpiryDate() {
            return expiryDate;
        }

        /**
         * Sets the value of the expiryDate property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setExpiryDate(String value) {
            this.expiryDate = value;
        }

    }

}
