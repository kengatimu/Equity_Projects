
package com.huawei.cps.cpsinterface.request;

import com.huawei.cps.cpsinterface.common.IDRecordType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Customer的IDRecordCondition数据
 * 
 * <p>Java class for IDRecordConditionType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="IDRecordConditionType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="Condition" type="{http://cps.huawei.com/cpsinterface/common}IDRecordType"/&gt;
 *         &lt;element name="Record" type="{http://cps.huawei.com/cpsinterface/common}IDRecordType"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "IDRecordConditionType", propOrder = {
    "condition",
    "record"
})
public class IDRecordConditionType {

    @XmlElement(name = "Condition", required = true)
    protected IDRecordType condition;
    @XmlElement(name = "Record", required = true)
    protected IDRecordType record;

    /**
     * Gets the value of the condition property.
     * 
     * @return
     *     possible object is
     *     {@link IDRecordType }
     *     
     */
    public IDRecordType getCondition() {
        return condition;
    }

    /**
     * Sets the value of the condition property.
     * 
     * @param value
     *     allowed object is
     *     {@link IDRecordType }
     *     
     */
    public void setCondition(IDRecordType value) {
        this.condition = value;
    }

    /**
     * Gets the value of the record property.
     * 
     * @return
     *     possible object is
     *     {@link IDRecordType }
     *     
     */
    public IDRecordType getRecord() {
        return record;
    }

    /**
     * Sets the value of the record property.
     * 
     * @param value
     *     allowed object is
     *     {@link IDRecordType }
     *     
     */
    public void setRecord(IDRecordType value) {
        this.record = value;
    }

}
