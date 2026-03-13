
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import com.huawei.cps.cpsinterface.common.ReminderScheduleInfo;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Query Reminder Schedule的查询结果
 * 
 * <p>Java class for QueryReminderScheduleResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryReminderScheduleResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="ReminderScheduleInfo" type="{http://cps.huawei.com/cpsinterface/common}ReminderScheduleInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "QueryReminderScheduleResult", propOrder = {
    "reminderScheduleInfo"
})
public class QueryReminderScheduleResult {

    @XmlElement(name = "ReminderScheduleInfo")
    protected List<ReminderScheduleInfo> reminderScheduleInfo;

    /**
     * Gets the value of the reminderScheduleInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the reminderScheduleInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getReminderScheduleInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ReminderScheduleInfo }
     * 
     * 
     */
    public List<ReminderScheduleInfo> getReminderScheduleInfo() {
        if (reminderScheduleInfo == null) {
            reminderScheduleInfo = new ArrayList<ReminderScheduleInfo>();
        }
        return this.reminderScheduleInfo;
    }

}
