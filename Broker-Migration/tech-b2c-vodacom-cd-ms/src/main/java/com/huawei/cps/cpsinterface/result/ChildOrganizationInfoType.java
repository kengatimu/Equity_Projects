
package com.huawei.cps.cpsinterface.result;

import java.math.BigInteger;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * ChildOrganization信息
 * 
 * <p>Java class for ChildOrganizationInfoType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ChildOrganizationInfoType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="OrganizationName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="ShortCode" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="IdentityStatus" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="ParentShortCode" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="HierarchyLevel" type="{http://www.w3.org/2001/XMLSchema}integer"/&gt;
 *         &lt;element name="HierarchyModel" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="CreationDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ChildOrganizationInfoType", propOrder = {
    "organizationName",
    "shortCode",
    "identityStatus",
    "parentShortCode",
    "hierarchyLevel",
    "hierarchyModel",
    "creationDate"
})
public class ChildOrganizationInfoType {

    @XmlElement(name = "OrganizationName", required = true)
    protected String organizationName;
    @XmlElement(name = "ShortCode", required = true)
    protected String shortCode;
    @XmlElement(name = "IdentityStatus", required = true)
    protected String identityStatus;
    @XmlElement(name = "ParentShortCode")
    protected String parentShortCode;
    @XmlElement(name = "HierarchyLevel", required = true)
    protected BigInteger hierarchyLevel;
    @XmlElement(name = "HierarchyModel")
    protected String hierarchyModel;
    @XmlElement(name = "CreationDate", required = true)
    protected String creationDate;

    /**
     * Gets the value of the organizationName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOrganizationName() {
        return organizationName;
    }

    /**
     * Sets the value of the organizationName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOrganizationName(String value) {
        this.organizationName = value;
    }

    /**
     * Gets the value of the shortCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getShortCode() {
        return shortCode;
    }

    /**
     * Sets the value of the shortCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setShortCode(String value) {
        this.shortCode = value;
    }

    /**
     * Gets the value of the identityStatus property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIdentityStatus() {
        return identityStatus;
    }

    /**
     * Sets the value of the identityStatus property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIdentityStatus(String value) {
        this.identityStatus = value;
    }

    /**
     * Gets the value of the parentShortCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getParentShortCode() {
        return parentShortCode;
    }

    /**
     * Sets the value of the parentShortCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setParentShortCode(String value) {
        this.parentShortCode = value;
    }

    /**
     * Gets the value of the hierarchyLevel property.
     * 
     * @return
     *     possible object is
     *     {@link BigInteger }
     *     
     */
    public BigInteger getHierarchyLevel() {
        return hierarchyLevel;
    }

    /**
     * Sets the value of the hierarchyLevel property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigInteger }
     *     
     */
    public void setHierarchyLevel(BigInteger value) {
        this.hierarchyLevel = value;
    }

    /**
     * Gets the value of the hierarchyModel property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getHierarchyModel() {
        return hierarchyModel;
    }

    /**
     * Sets the value of the hierarchyModel property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setHierarchyModel(String value) {
        this.hierarchyModel = value;
    }

    /**
     * Gets the value of the creationDate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCreationDate() {
        return creationDate;
    }

    /**
     * Sets the value of the creationDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCreationDate(String value) {
        this.creationDate = value;
    }

}
