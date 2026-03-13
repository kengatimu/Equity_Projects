
package com.huawei.cps.cpsinterface.request;

import com.huawei.cps.cpsinterface.common.DirectDebitMandateInfo;
import com.huawei.cps.cpsinterface.common.IdentifierTypeValue;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Payer发起创建Direct Debit Mandate的操作
 * 
 * <p>Java class for CreateDirectDebitMandateByPayerRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CreateDirectDebitMandateByPayerRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="Payee" type="{http://cps.huawei.com/cpsinterface/common}IdentifierTypeValue"/&gt;
 *         &lt;element name="DirectDebitMandateInfo" type="{http://cps.huawei.com/cpsinterface/common}DirectDebitMandateInfo"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CreateDirectDebitMandateByPayerRequest", propOrder = {
    "payee",
    "directDebitMandateInfo"
})
public class CreateDirectDebitMandateByPayerRequest {

    @XmlElement(name = "Payee", required = true)
    protected IdentifierTypeValue payee;
    @XmlElement(name = "DirectDebitMandateInfo", required = true)
    protected DirectDebitMandateInfo directDebitMandateInfo;

    /**
     * Gets the value of the payee property.
     * 
     * @return
     *     possible object is
     *     {@link IdentifierTypeValue }
     *     
     */
    public IdentifierTypeValue getPayee() {
        return payee;
    }

    /**
     * Sets the value of the payee property.
     * 
     * @param value
     *     allowed object is
     *     {@link IdentifierTypeValue }
     *     
     */
    public void setPayee(IdentifierTypeValue value) {
        this.payee = value;
    }

    /**
     * Gets the value of the directDebitMandateInfo property.
     * 
     * @return
     *     possible object is
     *     {@link DirectDebitMandateInfo }
     *     
     */
    public DirectDebitMandateInfo getDirectDebitMandateInfo() {
        return directDebitMandateInfo;
    }

    /**
     * Sets the value of the directDebitMandateInfo property.
     * 
     * @param value
     *     allowed object is
     *     {@link DirectDebitMandateInfo }
     *     
     */
    public void setDirectDebitMandateInfo(DirectDebitMandateInfo value) {
        this.directDebitMandateInfo = value;
    }

}
