
package com.huawei.cps.cpsinterface.request;

import com.huawei.cps.cpsinterface.common.BankAccountDetailsDataType;
import com.huawei.cps.cpsinterface.common.CertificateDetailsDataType;
import com.huawei.cps.cpsinterface.common.ContactDetailsDataType;
import com.huawei.cps.cpsinterface.common.IDDetailsDataType;
import com.huawei.cps.cpsinterface.common.SimpleKYCDataType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Customer Get Start PIN请求消息
 * 
 * <p>Java class for CustomerGetStartPINRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CustomerGetStartPINRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="KYCDataVerification"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="SimpleKYCData" type="{http://cps.huawei.com/cpsinterface/common}SimpleKYCDataType" minOccurs="0"/&gt;
 *                   &lt;element name="IDDetailsData" type="{http://cps.huawei.com/cpsinterface/common}IDDetailsDataType" minOccurs="0"/&gt;
 *                   &lt;element name="ContactDetailsData" type="{http://cps.huawei.com/cpsinterface/common}ContactDetailsDataType" minOccurs="0"/&gt;
 *                   &lt;element name="CertificateDetailsData" type="{http://cps.huawei.com/cpsinterface/common}CertificateDetailsDataType" minOccurs="0"/&gt;
 *                   &lt;element name="BankAccountDetailsData" type="{http://cps.huawei.com/cpsinterface/common}BankAccountDetailsDataType" minOccurs="0"/&gt;
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
@XmlType(name = "CustomerGetStartPINRequest", propOrder = {
    "kycDataVerification"
})
public class CustomerGetStartPINRequest {

    @XmlElement(name = "KYCDataVerification", required = true)
    protected CustomerGetStartPINRequest.KYCDataVerification kycDataVerification;

    /**
     * Gets the value of the kycDataVerification property.
     * 
     * @return
     *     possible object is
     *     {@link CustomerGetStartPINRequest.KYCDataVerification }
     *     
     */
    public CustomerGetStartPINRequest.KYCDataVerification getKYCDataVerification() {
        return kycDataVerification;
    }

    /**
     * Sets the value of the kycDataVerification property.
     * 
     * @param value
     *     allowed object is
     *     {@link CustomerGetStartPINRequest.KYCDataVerification }
     *     
     */
    public void setKYCDataVerification(CustomerGetStartPINRequest.KYCDataVerification value) {
        this.kycDataVerification = value;
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
     *         &lt;element name="SimpleKYCData" type="{http://cps.huawei.com/cpsinterface/common}SimpleKYCDataType" minOccurs="0"/&gt;
     *         &lt;element name="IDDetailsData" type="{http://cps.huawei.com/cpsinterface/common}IDDetailsDataType" minOccurs="0"/&gt;
     *         &lt;element name="ContactDetailsData" type="{http://cps.huawei.com/cpsinterface/common}ContactDetailsDataType" minOccurs="0"/&gt;
     *         &lt;element name="CertificateDetailsData" type="{http://cps.huawei.com/cpsinterface/common}CertificateDetailsDataType" minOccurs="0"/&gt;
     *         &lt;element name="BankAccountDetailsData" type="{http://cps.huawei.com/cpsinterface/common}BankAccountDetailsDataType" minOccurs="0"/&gt;
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
        "simpleKYCData",
        "idDetailsData",
        "contactDetailsData",
        "certificateDetailsData",
        "bankAccountDetailsData"
    })
    public static class KYCDataVerification {

        @XmlElement(name = "SimpleKYCData")
        protected SimpleKYCDataType simpleKYCData;
        @XmlElement(name = "IDDetailsData")
        protected IDDetailsDataType idDetailsData;
        @XmlElement(name = "ContactDetailsData")
        protected ContactDetailsDataType contactDetailsData;
        @XmlElement(name = "CertificateDetailsData")
        protected CertificateDetailsDataType certificateDetailsData;
        @XmlElement(name = "BankAccountDetailsData")
        protected BankAccountDetailsDataType bankAccountDetailsData;

        /**
         * Gets the value of the simpleKYCData property.
         * 
         * @return
         *     possible object is
         *     {@link SimpleKYCDataType }
         *     
         */
        public SimpleKYCDataType getSimpleKYCData() {
            return simpleKYCData;
        }

        /**
         * Sets the value of the simpleKYCData property.
         * 
         * @param value
         *     allowed object is
         *     {@link SimpleKYCDataType }
         *     
         */
        public void setSimpleKYCData(SimpleKYCDataType value) {
            this.simpleKYCData = value;
        }

        /**
         * Gets the value of the idDetailsData property.
         * 
         * @return
         *     possible object is
         *     {@link IDDetailsDataType }
         *     
         */
        public IDDetailsDataType getIDDetailsData() {
            return idDetailsData;
        }

        /**
         * Sets the value of the idDetailsData property.
         * 
         * @param value
         *     allowed object is
         *     {@link IDDetailsDataType }
         *     
         */
        public void setIDDetailsData(IDDetailsDataType value) {
            this.idDetailsData = value;
        }

        /**
         * Gets the value of the contactDetailsData property.
         * 
         * @return
         *     possible object is
         *     {@link ContactDetailsDataType }
         *     
         */
        public ContactDetailsDataType getContactDetailsData() {
            return contactDetailsData;
        }

        /**
         * Sets the value of the contactDetailsData property.
         * 
         * @param value
         *     allowed object is
         *     {@link ContactDetailsDataType }
         *     
         */
        public void setContactDetailsData(ContactDetailsDataType value) {
            this.contactDetailsData = value;
        }

        /**
         * Gets the value of the certificateDetailsData property.
         * 
         * @return
         *     possible object is
         *     {@link CertificateDetailsDataType }
         *     
         */
        public CertificateDetailsDataType getCertificateDetailsData() {
            return certificateDetailsData;
        }

        /**
         * Sets the value of the certificateDetailsData property.
         * 
         * @param value
         *     allowed object is
         *     {@link CertificateDetailsDataType }
         *     
         */
        public void setCertificateDetailsData(CertificateDetailsDataType value) {
            this.certificateDetailsData = value;
        }

        /**
         * Gets the value of the bankAccountDetailsData property.
         * 
         * @return
         *     possible object is
         *     {@link BankAccountDetailsDataType }
         *     
         */
        public BankAccountDetailsDataType getBankAccountDetailsData() {
            return bankAccountDetailsData;
        }

        /**
         * Sets the value of the bankAccountDetailsData property.
         * 
         * @param value
         *     allowed object is
         *     {@link BankAccountDetailsDataType }
         *     
         */
        public void setBankAccountDetailsData(BankAccountDetailsDataType value) {
            this.bankAccountDetailsData = value;
        }

    }

}
