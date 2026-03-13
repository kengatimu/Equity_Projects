
package com.huawei.cps.cpsinterface.request;

import com.huawei.cps.cpsinterface.common.ReminderScheduleInfo;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 创建Reminder Schedule的请求
 * 
 * <p>Java class for CreateReminderScheduleRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CreateReminderScheduleRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="ReminderScheduleInfo" type="{http://cps.huawei.com/cpsinterface/common}ReminderScheduleInfo"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CreateReminderScheduleRequest", propOrder = {
    "reminderScheduleInfo"
})
public class CreateReminderScheduleRequest {

    @XmlElement(name = "ReminderScheduleInfo", required = true)
    protected ReminderScheduleInfo reminderScheduleInfo;

    /**
     * Gets the value of the reminderScheduleInfo property.
     * 
     * @return
     *     possible object is
     *     {@link ReminderScheduleInfo }
     *     
     */
    public ReminderScheduleInfo getReminderScheduleInfo() {
        return reminderScheduleInfo;
    }

    /**
     * Sets the value of the reminderScheduleInfo property.
     * 
     * @param value
     *     allowed object is
     *     {@link ReminderScheduleInfo }
     *     
     */
    public void setReminderScheduleInfo(ReminderScheduleInfo value) {
        this.reminderScheduleInfo = value;
    }

}
