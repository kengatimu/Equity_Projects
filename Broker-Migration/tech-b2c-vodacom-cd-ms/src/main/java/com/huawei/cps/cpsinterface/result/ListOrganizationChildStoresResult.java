
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询Organization的ChildStore
 * 
 * <p>Java class for ListOrganizationChildStoresResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ListOrganizationChildStoresResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="ChildOrgListData"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="ChildOrgItem" type="{http://cps.huawei.com/cpsinterface/result}ChildOrganizationInfoType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
@XmlType(name = "ListOrganizationChildStoresResult", propOrder = {
    "boCompletedTime",
    "childOrgListData"
})
public class ListOrganizationChildStoresResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "ChildOrgListData", required = true)
    protected ListOrganizationChildStoresResult.ChildOrgListData childOrgListData;

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
     * Gets the value of the childOrgListData property.
     * 
     * @return
     *     possible object is
     *     {@link ListOrganizationChildStoresResult.ChildOrgListData }
     *     
     */
    public ListOrganizationChildStoresResult.ChildOrgListData getChildOrgListData() {
        return childOrgListData;
    }

    /**
     * Sets the value of the childOrgListData property.
     * 
     * @param value
     *     allowed object is
     *     {@link ListOrganizationChildStoresResult.ChildOrgListData }
     *     
     */
    public void setChildOrgListData(ListOrganizationChildStoresResult.ChildOrgListData value) {
        this.childOrgListData = value;
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
     *         &lt;element name="ChildOrgItem" type="{http://cps.huawei.com/cpsinterface/result}ChildOrganizationInfoType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "childOrgItem"
    })
    public static class ChildOrgListData {

        @XmlElement(name = "ChildOrgItem")
        protected List<ChildOrganizationInfoType> childOrgItem;

        /**
         * Gets the value of the childOrgItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the childOrgItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getChildOrgItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link ChildOrganizationInfoType }
         * 
         * 
         */
        public List<ChildOrganizationInfoType> getChildOrgItem() {
            if (childOrgItem == null) {
                childOrgItem = new ArrayList<ChildOrganizationInfoType>();
            }
            return this.childOrgItem;
        }

    }

}
