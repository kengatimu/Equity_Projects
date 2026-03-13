
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 删除Reminder Schedule
 * 
 * <p>Java class for DeleteIndividualReminderScheduleRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="DeleteIndividualReminderScheduleRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="ReminderScheduleID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "DeleteIndividualReminderScheduleRequest", propOrder = {
    "reminderScheduleID"
})
public class DeleteIndividualReminderScheduleRequest {

    @XmlElement(name = "ReminderScheduleID", required = true)
    protected String reminderScheduleID;

    /**
     * Gets the value of the reminderScheduleID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReminderScheduleID() {
        return reminderScheduleID;
    }

    /**
     * Sets the value of the reminderScheduleID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReminderScheduleID(String value) {
        this.reminderScheduleID = value;
    }

}
