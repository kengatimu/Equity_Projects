
package com.huawei.cps.cpsinterface.request;

import com.huawei.cps.cpsinterface.common.BankAccountRecordType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Organization的BankAccountRecordCondition数据
 * 
 * <p>Java class for BankAccountRecordConditionType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="BankAccountRecordConditionType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="Condition" type="{http://cps.huawei.com/cpsinterface/common}BankAccountRecordType"/&gt;
 *         &lt;element name="Record" type="{http://cps.huawei.com/cpsinterface/common}BankAccountRecordType"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "BankAccountRecordConditionType", propOrder = {
    "condition",
    "record"
})
public class BankAccountRecordConditionType {

    @XmlElement(name = "Condition", required = true)
    protected BankAccountRecordType condition;
    @XmlElement(name = "Record", required = true)
    protected BankAccountRecordType record;

    /**
     * Gets the value of the condition property.
     * 
     * @return
     *     possible object is
     *     {@link BankAccountRecordType }
     *     
     */
    public BankAccountRecordType getCondition() {
        return condition;
    }

    /**
     * Sets the value of the condition property.
     * 
     * @param value
     *     allowed object is
     *     {@link BankAccountRecordType }
     *     
     */
    public void setCondition(BankAccountRecordType value) {
        this.condition = value;
    }

    /**
     * Gets the value of the record property.
     * 
     * @return
     *     possible object is
     *     {@link BankAccountRecordType }
     *     
     */
    public BankAccountRecordType getRecord() {
        return record;
    }

    /**
     * Sets the value of the record property.
     * 
     * @param value
     *     allowed object is
     *     {@link BankAccountRecordType }
     *     
     */
    public void setRecord(BankAccountRecordType value) {
        this.record = value;
    }

}
