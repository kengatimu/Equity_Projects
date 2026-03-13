
package com.huawei.cps.cpsinterface.result;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询Group Beneficiary的结果消息
 * 
 * <p>Java class for LookupGroupBeneficiaryResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="LookupGroupBeneficiaryResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="BeneficiaryList" type="{http://cps.huawei.com/cpsinterface/result}BeneficiaryList"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "LookupGroupBeneficiaryResult", propOrder = {
    "boCompletedTime",
    "beneficiaryList"
})
public class LookupGroupBeneficiaryResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "BeneficiaryList", required = true)
    protected BeneficiaryList beneficiaryList;

    /**
     * Gets the value of the boCompletedTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBOCompletedTime() {
        return boCompletedTime;
    }

    /**
     * Sets the value of the boCompletedTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBOCompletedTime(String value) {
        this.boCompletedTime = value;
    }

    /**
     * Gets the value of the beneficiaryList property.
     * 
     * @return
     *     possible object is
     *     {@link BeneficiaryList }
     *     
     */
    public BeneficiaryList getBeneficiaryList() {
        return beneficiaryList;
    }

    /**
     * Sets the value of the beneficiaryList property.
     * 
     * @param value
     *     allowed object is
     *     {@link BeneficiaryList }
     *     
     */
    public void setBeneficiaryList(BeneficiaryList value) {
        this.beneficiaryList = value;
    }

}
