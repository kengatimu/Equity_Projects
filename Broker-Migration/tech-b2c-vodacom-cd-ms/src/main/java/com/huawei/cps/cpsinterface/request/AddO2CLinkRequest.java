
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 增加Organization的O2CLink
 * 
 * <p>Java class for AddO2CLinkRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="AddO2CLinkRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="O2CLinkAddData"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="MSISDN" type="{http://cps.huawei.com/cpsinterface/common}MSISDNType"/&gt;
 *                   &lt;element name="O2CLinkNumber"&gt;
 *                     &lt;simpleType&gt;
 *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                         &lt;minLength value="1"/&gt;
 *                         &lt;maxLength value="18"/&gt;
 *                       &lt;/restriction&gt;
 *                     &lt;/simpleType&gt;
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
@XmlType(name = "AddO2CLinkRequest", propOrder = {
    "o2CLinkAddData"
})
public class AddO2CLinkRequest {

    @XmlElement(name = "O2CLinkAddData", required = true)
    protected AddO2CLinkRequest.O2CLinkAddData o2CLinkAddData;

    /**
     * Gets the value of the o2CLinkAddData property.
     * 
     * @return
     *     possible object is
     *     {@link AddO2CLinkRequest.O2CLinkAddData }
     *     
     */
    public AddO2CLinkRequest.O2CLinkAddData getO2CLinkAddData() {
        return o2CLinkAddData;
    }

    /**
     * Sets the value of the o2CLinkAddData property.
     * 
     * @param value
     *     allowed object is
     *     {@link AddO2CLinkRequest.O2CLinkAddData }
     *     
     */
    public void setO2CLinkAddData(AddO2CLinkRequest.O2CLinkAddData value) {
        this.o2CLinkAddData = value;
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
     *         &lt;element name="MSISDN" type="{http://cps.huawei.com/cpsinterface/common}MSISDNType"/&gt;
     *         &lt;element name="O2CLinkNumber"&gt;
     *           &lt;simpleType&gt;
     *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *               &lt;minLength value="1"/&gt;
     *               &lt;maxLength value="18"/&gt;
     *             &lt;/restriction&gt;
     *           &lt;/simpleType&gt;
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
        "msisdn",
        "o2CLinkNumber"
    })
    public static class O2CLinkAddData {

        @XmlElement(name = "MSISDN", required = true)
        protected String msisdn;
        @XmlElement(name = "O2CLinkNumber", required = true)
        protected String o2CLinkNumber;

        /**
         * Gets the value of the msisdn property.
         * 
         * @return
         *     possible object is
         *     {@link String }
         *     
         */
        public String getMSISDN() {
            return msisdn;
        }

        /**
         * Sets the value of the msisdn property.
         * 
         * @param value
         *     allowed object is
         *     {@link String }
         *     
         */
        public void setMSISDN(String value) {
            this.msisdn = value;
        }

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

    }

}
