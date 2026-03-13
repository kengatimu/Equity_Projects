
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 返回结果：查询已订购的Bundle详情，供API查询使用
 * 
 * <p>Java class for QueryIdentityBundleResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryIdentityBundleResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BundleList" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="Bundle" maxOccurs="unbounded"&gt;
 *                     &lt;complexType&gt;
 *                       &lt;complexContent&gt;
 *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                           &lt;sequence&gt;
 *                             &lt;element name="IdentityBundleId" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
 *                             &lt;element name="BundleName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *                             &lt;element name="BundleType" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *                             &lt;element name="BundleProvider" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *                             &lt;element name="EffectiveDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
 *                             &lt;element name="ExpirationDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
 *                           &lt;/sequence&gt;
 *                         &lt;/restriction&gt;
 *                       &lt;/complexContent&gt;
 *                     &lt;/complexType&gt;
 *                   &lt;/element&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="BundleElementList" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="BundleElement" maxOccurs="unbounded"&gt;
 *                     &lt;complexType&gt;
 *                       &lt;complexContent&gt;
 *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                           &lt;sequence&gt;
 *                             &lt;element name="IdentityBundleId" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
 *                             &lt;element name="ElementType" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *                             &lt;element name="ElementIdentifier" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *                             &lt;element name="UNIT" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *                             &lt;element name="Volume" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *                             &lt;element name="Value" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *                             &lt;element name="MaxValue" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *                           &lt;/sequence&gt;
 *                         &lt;/restriction&gt;
 *                       &lt;/complexContent&gt;
 *                     &lt;/complexType&gt;
 *                   &lt;/element&gt;
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
@XmlType(name = "QueryIdentityBundleResult", propOrder = {
    "bundleList",
    "bundleElementList"
})
public class QueryIdentityBundleResult {

    @XmlElement(name = "BundleList")
    protected QueryIdentityBundleResult.BundleList bundleList;
    @XmlElement(name = "BundleElementList")
    protected QueryIdentityBundleResult.BundleElementList bundleElementList;

    /**
     * Gets the value of the bundleList property.
     * 
     * @return
     *     possible object is
     *     {@link QueryIdentityBundleResult.BundleList }
     *     
     */
    public QueryIdentityBundleResult.BundleList getBundleList() {
        return bundleList;
    }

    /**
     * Sets the value of the bundleList property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryIdentityBundleResult.BundleList }
     *     
     */
    public void setBundleList(QueryIdentityBundleResult.BundleList value) {
        this.bundleList = value;
    }

    /**
     * Gets the value of the bundleElementList property.
     * 
     * @return
     *     possible object is
     *     {@link QueryIdentityBundleResult.BundleElementList }
     *     
     */
    public QueryIdentityBundleResult.BundleElementList getBundleElementList() {
        return bundleElementList;
    }

    /**
     * Sets the value of the bundleElementList property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryIdentityBundleResult.BundleElementList }
     *     
     */
    public void setBundleElementList(QueryIdentityBundleResult.BundleElementList value) {
        this.bundleElementList = value;
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
     *         &lt;element name="BundleElement" maxOccurs="unbounded"&gt;
     *           &lt;complexType&gt;
     *             &lt;complexContent&gt;
     *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                 &lt;sequence&gt;
     *                   &lt;element name="IdentityBundleId" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
     *                   &lt;element name="ElementType" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
     *                   &lt;element name="ElementIdentifier" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
     *                   &lt;element name="UNIT" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
     *                   &lt;element name="Volume" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
     *                   &lt;element name="Value" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
     *                   &lt;element name="MaxValue" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
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
    @XmlType(name = "", propOrder = {
        "bundleElement"
    })
    public static class BundleElementList {

        @XmlElement(name = "BundleElement", required = true)
        protected List<QueryIdentityBundleResult.BundleElementList.BundleElement> bundleElement;

        /**
         * Gets the value of the bundleElement property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the bundleElement property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getBundleElement().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link QueryIdentityBundleResult.BundleElementList.BundleElement }
         * 
         * 
         */
        public List<QueryIdentityBundleResult.BundleElementList.BundleElement> getBundleElement() {
            if (bundleElement == null) {
                bundleElement = new ArrayList<QueryIdentityBundleResult.BundleElementList.BundleElement>();
            }
            return this.bundleElement;
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
         *         &lt;element name="IdentityBundleId" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
         *         &lt;element name="ElementType" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
         *         &lt;element name="ElementIdentifier" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
         *         &lt;element name="UNIT" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
         *         &lt;element name="Volume" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
         *         &lt;element name="Value" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
         *         &lt;element name="MaxValue" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
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
            "identityBundleId",
            "elementType",
            "elementIdentifier",
            "unit",
            "volume",
            "value",
            "maxValue"
        })
        public static class BundleElement {

            @XmlElement(name = "IdentityBundleId")
            protected long identityBundleId;
            @XmlElement(name = "ElementType", required = true)
            protected String elementType;
            @XmlElement(name = "ElementIdentifier", required = true)
            protected String elementIdentifier;
            @XmlElement(name = "UNIT", required = true)
            protected String unit;
            @XmlElement(name = "Volume", required = true)
            protected String volume;
            @XmlElement(name = "Value", required = true)
            protected String value;
            @XmlElement(name = "MaxValue")
            protected String maxValue;

            /**
             * Gets the value of the identityBundleId property.
             * 
             */
            public long getIdentityBundleId() {
                return identityBundleId;
            }

            /**
             * Sets the value of the identityBundleId property.
             * 
             */
            public void setIdentityBundleId(long value) {
                this.identityBundleId = value;
            }

            /**
             * Gets the value of the elementType property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getElementType() {
                return elementType;
            }

            /**
             * Sets the value of the elementType property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setElementType(String value) {
                this.elementType = value;
            }

            /**
             * Gets the value of the elementIdentifier property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getElementIdentifier() {
                return elementIdentifier;
            }

            /**
             * Sets the value of the elementIdentifier property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setElementIdentifier(String value) {
                this.elementIdentifier = value;
            }

            /**
             * Gets the value of the unit property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getUNIT() {
                return unit;
            }

            /**
             * Sets the value of the unit property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setUNIT(String value) {
                this.unit = value;
            }

            /**
             * Gets the value of the volume property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getVolume() {
                return volume;
            }

            /**
             * Sets the value of the volume property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setVolume(String value) {
                this.volume = value;
            }

            /**
             * Gets the value of the value property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getValue() {
                return value;
            }

            /**
             * Sets the value of the value property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setValue(String value) {
                this.value = value;
            }

            /**
             * Gets the value of the maxValue property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getMaxValue() {
                return maxValue;
            }

            /**
             * Sets the value of the maxValue property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setMaxValue(String value) {
                this.maxValue = value;
            }

        }

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
     *         &lt;element name="Bundle" maxOccurs="unbounded"&gt;
     *           &lt;complexType&gt;
     *             &lt;complexContent&gt;
     *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                 &lt;sequence&gt;
     *                   &lt;element name="IdentityBundleId" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
     *                   &lt;element name="BundleName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
     *                   &lt;element name="BundleType" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
     *                   &lt;element name="BundleProvider" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
     *                   &lt;element name="EffectiveDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
     *                   &lt;element name="ExpirationDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
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
    @XmlType(name = "", propOrder = {
        "bundle"
    })
    public static class BundleList {

        @XmlElement(name = "Bundle", required = true)
        protected List<QueryIdentityBundleResult.BundleList.Bundle> bundle;

        /**
         * Gets the value of the bundle property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the bundle property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getBundle().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link QueryIdentityBundleResult.BundleList.Bundle }
         * 
         * 
         */
        public List<QueryIdentityBundleResult.BundleList.Bundle> getBundle() {
            if (bundle == null) {
                bundle = new ArrayList<QueryIdentityBundleResult.BundleList.Bundle>();
            }
            return this.bundle;
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
         *         &lt;element name="IdentityBundleId" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
         *         &lt;element name="BundleName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
         *         &lt;element name="BundleType" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
         *         &lt;element name="BundleProvider" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
         *         &lt;element name="EffectiveDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
         *         &lt;element name="ExpirationDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
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
            "identityBundleId",
            "bundleName",
            "bundleType",
            "bundleProvider",
            "effectiveDate",
            "expirationDate"
        })
        public static class Bundle {

            @XmlElement(name = "IdentityBundleId")
            protected long identityBundleId;
            @XmlElement(name = "BundleName", required = true)
            protected String bundleName;
            @XmlElement(name = "BundleType", required = true)
            protected String bundleType;
            @XmlElement(name = "BundleProvider", required = true)
            protected String bundleProvider;
            @XmlElement(name = "EffectiveDate", required = true)
            protected String effectiveDate;
            @XmlElement(name = "ExpirationDate", required = true)
            protected String expirationDate;

            /**
             * Gets the value of the identityBundleId property.
             * 
             */
            public long getIdentityBundleId() {
                return identityBundleId;
            }

            /**
             * Sets the value of the identityBundleId property.
             * 
             */
            public void setIdentityBundleId(long value) {
                this.identityBundleId = value;
            }

            /**
             * Gets the value of the bundleName property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getBundleName() {
                return bundleName;
            }

            /**
             * Sets the value of the bundleName property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setBundleName(String value) {
                this.bundleName = value;
            }

            /**
             * Gets the value of the bundleType property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getBundleType() {
                return bundleType;
            }

            /**
             * Sets the value of the bundleType property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setBundleType(String value) {
                this.bundleType = value;
            }

            /**
             * Gets the value of the bundleProvider property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getBundleProvider() {
                return bundleProvider;
            }

            /**
             * Sets the value of the bundleProvider property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setBundleProvider(String value) {
                this.bundleProvider = value;
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
             * Gets the value of the expirationDate property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getExpirationDate() {
                return expirationDate;
            }

            /**
             * Sets the value of the expirationDate property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setExpirationDate(String value) {
                this.expirationDate = value;
            }

        }

    }

}
