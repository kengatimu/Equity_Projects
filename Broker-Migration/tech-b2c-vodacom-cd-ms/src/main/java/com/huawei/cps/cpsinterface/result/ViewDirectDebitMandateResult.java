
package com.huawei.cps.cpsinterface.result;

import com.huawei.cps.cpsinterface.common.DirectDebitMandateInfo;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * View Direct Debit Mandate的查询结果
 * 
 * <p>Java class for ViewDirectDebitMandateResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ViewDirectDebitMandateResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="PayeeName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="PayerName" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
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
@XmlType(name = "ViewDirectDebitMandateResult", propOrder = {
    "payeeName",
    "payerName",
    "directDebitMandateInfo"
})
public class ViewDirectDebitMandateResult {

    @XmlElement(name = "PayeeName", required = true)
    protected String payeeName;
    @XmlElement(name = "PayerName", required = true)
    protected String payerName;
    @XmlElement(name = "DirectDebitMandateInfo", required = true)
    protected DirectDebitMandateInfo directDebitMandateInfo;

    /**
     * Gets the value of the payeeName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPayeeName() {
        return payeeName;
    }

    /**
     * Sets the value of the payeeName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPayeeName(String value) {
        this.payeeName = value;
    }

    /**
     * Gets the value of the payerName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPayerName() {
        return payerName;
    }

    /**
     * Sets the value of the payerName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPayerName(String value) {
        this.payerName = value;
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
