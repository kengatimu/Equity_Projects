
package com.huawei.cps.cpsinterface.request;

import com.huawei.cps.cpsinterface.common.CertificateRecordType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Operator的CertificateRecordCondition数据
 * 
 * <p>Java class for CertificateRecordConditionType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CertificateRecordConditionType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="Condition" type="{http://cps.huawei.com/cpsinterface/common}CertificateRecordType"/&gt;
 *         &lt;element name="Record" type="{http://cps.huawei.com/cpsinterface/common}CertificateRecordType"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CertificateRecordConditionType", propOrder = {
    "condition",
    "record"
})
public class CertificateRecordConditionType {

    @XmlElement(name = "Condition", required = true)
    protected CertificateRecordType condition;
    @XmlElement(name = "Record", required = true)
    protected CertificateRecordType record;

    /**
     * Gets the value of the condition property.
     * 
     * @return
     *     possible object is
     *     {@link CertificateRecordType }
     *     
     */
    public CertificateRecordType getCondition() {
        return condition;
    }

    /**
     * Sets the value of the condition property.
     * 
     * @param value
     *     allowed object is
     *     {@link CertificateRecordType }
     *     
     */
    public void setCondition(CertificateRecordType value) {
        this.condition = value;
    }

    /**
     * Gets the value of the record property.
     * 
     * @return
     *     possible object is
     *     {@link CertificateRecordType }
     *     
     */
    public CertificateRecordType getRecord() {
        return record;
    }

    /**
     * Sets the value of the record property.
     * 
     * @param value
     *     allowed object is
     *     {@link CertificateRecordType }
     *     
     */
    public void setRecord(CertificateRecordType value) {
        this.record = value;
    }

}
