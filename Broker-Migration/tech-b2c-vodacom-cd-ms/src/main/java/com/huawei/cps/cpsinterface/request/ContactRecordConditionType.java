
package com.huawei.cps.cpsinterface.request;

import com.huawei.cps.cpsinterface.common.ContactRecordType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Organization的ContactRecordCondition数据
 * 
 * <p>Java class for ContactRecordConditionType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ContactRecordConditionType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="Condition" type="{http://cps.huawei.com/cpsinterface/common}ContactRecordType"/&gt;
 *         &lt;element name="Record"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;extension base="{http://cps.huawei.com/cpsinterface/common}ContactRecordType"&gt;
 *               &lt;/extension&gt;
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
@XmlType(name = "ContactRecordConditionType", propOrder = {
    "condition",
    "record"
})
public class ContactRecordConditionType {

    @XmlElement(name = "Condition", required = true)
    protected ContactRecordType condition;
    @XmlElement(name = "Record", required = true)
    protected ContactRecordConditionType.Record record;

    /**
     * Gets the value of the condition property.
     * 
     * @return
     *     possible object is
     *     {@link ContactRecordType }
     *     
     */
    public ContactRecordType getCondition() {
        return condition;
    }

    /**
     * Sets the value of the condition property.
     * 
     * @param value
     *     allowed object is
     *     {@link ContactRecordType }
     *     
     */
    public void setCondition(ContactRecordType value) {
        this.condition = value;
    }

    /**
     * Gets the value of the record property.
     * 
     * @return
     *     possible object is
     *     {@link ContactRecordConditionType.Record }
     *     
     */
    public ContactRecordConditionType.Record getRecord() {
        return record;
    }

    /**
     * Sets the value of the record property.
     * 
     * @param value
     *     allowed object is
     *     {@link ContactRecordConditionType.Record }
     *     
     */
    public void setRecord(ContactRecordConditionType.Record value) {
        this.record = value;
    }


    /**
     * <p>Java class for anonymous complex type.
     * 
     * <p>The following schema fragment specifies the expected content contained within this class.
     * 
     * <pre>
     * &lt;complexType&gt;
     *   &lt;complexContent&gt;
     *     &lt;extension base="{http://cps.huawei.com/cpsinterface/common}ContactRecordType"&gt;
     *     &lt;/extension&gt;
     *   &lt;/complexContent&gt;
     * &lt;/complexType&gt;
     * </pre>
     * 
     * 
     */
    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "")
    public static class Record
        extends ContactRecordType
    {


    }

}
