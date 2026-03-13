
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 修改SPOperator的KYC
 * 
 * <p>Java class for UpdateSPOperatorKYCRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="UpdateSPOperatorKYCRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="SimpleKYCUpdateData" type="{http://cps.huawei.com/cpsinterface/request}SimpleKYCUpdateDataType" minOccurs="0"/&gt;
 *         &lt;element name="IDDetailsUpdateData" type="{http://cps.huawei.com/cpsinterface/request}IDDetailsUpdateDataType" minOccurs="0"/&gt;
 *         &lt;element name="CertificateDetailsUpdateData" type="{http://cps.huawei.com/cpsinterface/request}CertificateDetailsUpdateDataType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "UpdateSPOperatorKYCRequest", propOrder = {
    "simpleKYCUpdateData",
    "idDetailsUpdateData",
    "certificateDetailsUpdateData"
})
public class UpdateSPOperatorKYCRequest {

    @XmlElement(name = "SimpleKYCUpdateData")
    protected SimpleKYCUpdateDataType simpleKYCUpdateData;
    @XmlElement(name = "IDDetailsUpdateData")
    protected IDDetailsUpdateDataType idDetailsUpdateData;
    @XmlElement(name = "CertificateDetailsUpdateData")
    protected CertificateDetailsUpdateDataType certificateDetailsUpdateData;

    /**
     * Gets the value of the simpleKYCUpdateData property.
     * 
     * @return
     *     possible object is
     *     {@link SimpleKYCUpdateDataType }
     *     
     */
    public SimpleKYCUpdateDataType getSimpleKYCUpdateData() {
        return simpleKYCUpdateData;
    }

    /**
     * Sets the value of the simpleKYCUpdateData property.
     * 
     * @param value
     *     allowed object is
     *     {@link SimpleKYCUpdateDataType }
     *     
     */
    public void setSimpleKYCUpdateData(SimpleKYCUpdateDataType value) {
        this.simpleKYCUpdateData = value;
    }

    /**
     * Gets the value of the idDetailsUpdateData property.
     * 
     * @return
     *     possible object is
     *     {@link IDDetailsUpdateDataType }
     *     
     */
    public IDDetailsUpdateDataType getIDDetailsUpdateData() {
        return idDetailsUpdateData;
    }

    /**
     * Sets the value of the idDetailsUpdateData property.
     * 
     * @param value
     *     allowed object is
     *     {@link IDDetailsUpdateDataType }
     *     
     */
    public void setIDDetailsUpdateData(IDDetailsUpdateDataType value) {
        this.idDetailsUpdateData = value;
    }

    /**
     * Gets the value of the certificateDetailsUpdateData property.
     * 
     * @return
     *     possible object is
     *     {@link CertificateDetailsUpdateDataType }
     *     
     */
    public CertificateDetailsUpdateDataType getCertificateDetailsUpdateData() {
        return certificateDetailsUpdateData;
    }

    /**
     * Sets the value of the certificateDetailsUpdateData property.
     * 
     * @param value
     *     allowed object is
     *     {@link CertificateDetailsUpdateDataType }
     *     
     */
    public void setCertificateDetailsUpdateData(CertificateDetailsUpdateDataType value) {
        this.certificateDetailsUpdateData = value;
    }

}
