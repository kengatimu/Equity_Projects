
package com.huawei.cps.cpsinterface.result;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * O2C Link操作结果类型
 * 
 * <p>Java class for O2CLinkResultDataType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="O2CLinkResultDataType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="SuccessNumber" type="{http://www.w3.org/2001/XMLSchema}integer"/&gt;
 *         &lt;element name="FailureNumber" type="{http://www.w3.org/2001/XMLSchema}integer"/&gt;
 *         &lt;element name="FailedItem" maxOccurs="unbounded" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="O2CLinkNumber"&gt;
 *                     &lt;simpleType&gt;
 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                         &lt;minLength value="1"/&gt;
 *                         &lt;maxLength value="18"/&gt;
 *                       &lt;/restriction&gt;
 *                     &lt;/simpleType&gt;
 *                   &lt;/element&gt;
 *                   &lt;element name="FailureCode" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
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
@XmlType(name = "O2CLinkResultDataType", propOrder = {
    "successNumber",
    "failureNumber",
    "failedItem"
})
public class O2CLinkResultDataType {

    @XmlElement(name = "SuccessNumber", required = true)
    protected BigInteger successNumber;
    @XmlElement(name = "FailureNumber", required = true)
    protected BigInteger failureNumber;
    @XmlElement(name = "FailedItem")
    protected List<O2CLinkResultDataType.FailedItem> failedItem;

    /**
     * Gets the value of the successNumber property.
     * 
     * @return
     *     possible object is
     *     {@link BigInteger }
     *     
     */
    public BigInteger getSuccessNumber() {
        return successNumber;
    }

    /**
     * Sets the value of the successNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigInteger }
     *     
     */
    public void setSuccessNumber(BigInteger value) {
        this.successNumber = value;
    }

    /**
     * Gets the value of the failureNumber property.
     * 
     * @return
     *     possible object is
     *     {@link BigInteger }
     *     
     */
    public BigInteger getFailureNumber() {
        return failureNumber;
    }

    /**
     * Sets the value of the failureNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigInteger }
     *     
     */
    public void setFailureNumber(BigInteger value) {
        this.failureNumber = value;
    }

    /**
     * Gets the value of the failedItem property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the failedItem property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getFailedItem().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link O2CLinkResultDataType.FailedItem }
     * 
     * 
     */
    public List<O2CLinkResultDataType.FailedItem> getFailedItem() {
        if (failedItem == null) {
            failedItem = new ArrayList<O2CLinkResultDataType.FailedItem>();
        }
        return this.failedItem;
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
     *         &lt;element name="O2CLinkNumber"&gt;
     *           &lt;simpleType&gt;
     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *               &lt;minLength value="1"/&gt;
     *               &lt;maxLength value="18"/&gt;
     *             &lt;/restriction&gt;
     *           &lt;/simpleType&gt;
     *         &lt;/element&gt;
     *         &lt;element name="FailureCode" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
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
        "o2CLinkNumber",
        "failureCode"
    })
    public static class FailedItem {

        @XmlElement(name = "O2CLinkNumber", required = true)
        protected String o2CLinkNumber;
        @XmlElement(name = "FailureCode", required = true)
        protected String failureCode;

        /**
         * Gets the value of the o2CLinkNumber property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getO2CLinkNumber() {
            return o2CLinkNumber;
        }

        /**
         * Sets the value of the o2CLinkNumber property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setO2CLinkNumber(String value) {
            this.o2CLinkNumber = value;
        }

        /**
         * Gets the value of the failureCode property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getFailureCode() {
            return failureCode;
        }

        /**
         * Sets the value of the failureCode property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setFailureCode(String value) {
            this.failureCode = value;
        }

    }

}
