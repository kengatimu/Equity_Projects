
package com.huawei.cps.cpsinterface.request;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Linking Identities操作的请求消息
 * 
 * <p>Java class for LinkingIdentitiesRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="LinkingIdentitiesRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="Identity" maxOccurs="unbounded" minOccurs="2"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
 *                   &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
 *                   &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
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
@XmlType(name = "LinkingIdentitiesRequest", propOrder = {
    "identity"
})
public class LinkingIdentitiesRequest {

    @XmlElement(name = "Identity", required = true)
    protected List<LinkingIdentitiesRequest.Identity> identity;

    /**
     * Gets the value of the identity property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the identity property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getIdentity().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link LinkingIdentitiesRequest.Identity }
     * 
     * 
     */
    public List<LinkingIdentitiesRequest.Identity> getIdentity() {
        if (identity == null) {
            identity = new ArrayList<LinkingIdentitiesRequest.Identity>();
        }
        return this.identity;
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
     *         &lt;element name="IdentifierType" type="{http://cps.huawei.com/cpsinterface/common}IdentifierType"/&gt;
     *         &lt;element name="Identifier" type="{http://cps.huawei.com/cpsinterface/common}IdentifierValue"/&gt;
     *         &lt;element name="ShortCode" type="{http://cps.huawei.com/cpsinterface/common}ShortCodeType" minOccurs="0"/&gt;
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
        "identifierType",
        "identifier",
        "shortCode"
    })
    public static class Identity {

        @XmlElement(name = "IdentifierType", required = true)
        protected String identifierType;
        @XmlElement(name = "Identifier", required = true)
        protected String identifier;
        @XmlElement(name = "ShortCode")
        protected String shortCode;

        /**
         * Gets the value of the identifierType property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getIdentifierType() {
            return identifierType;
        }

        /**
         * Sets the value of the identifierType property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setIdentifierType(String value) {
            this.identifierType = value;
        }

        /**
         * Gets the value of the identifier property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getIdentifier() {
            return identifier;
        }

        /**
         * Sets the value of the identifier property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setIdentifier(String value) {
            this.identifier = value;
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

    }

}
