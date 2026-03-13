
package com.huawei.cps.cpsinterface.request;

import java.util.ArrayList;
import java.util.List;
import com.huawei.cps.cpsinterface.common.ContactRecordType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Organization的ContactDetails更新数据
 * 
 * <p>Java class for ContactDetailsUpdateDataType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ContactDetailsUpdateDataType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="AddContactRecord" type="{http://cps.huawei.com/cpsinterface/common}ContactRecordType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="ModifyContactRecord" type="{http://cps.huawei.com/cpsinterface/request}ContactRecordConditionType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="RemoveContactRecord" type="{http://cps.huawei.com/cpsinterface/common}ContactRecordType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ContactDetailsUpdateDataType", propOrder = {
    "addContactRecord",
    "modifyContactRecord",
    "removeContactRecord"
})
public class ContactDetailsUpdateDataType {

    @XmlElement(name = "AddContactRecord")
    protected List<ContactRecordType> addContactRecord;
    @XmlElement(name = "ModifyContactRecord")
    protected List<ContactRecordConditionType> modifyContactRecord;
    @XmlElement(name = "RemoveContactRecord")
    protected List<ContactRecordType> removeContactRecord;

    /**
     * Gets the value of the addContactRecord property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the addContactRecord property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getAddContactRecord().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ContactRecordType }
     * 
     * 
     */
    public List<ContactRecordType> getAddContactRecord() {
        if (addContactRecord == null) {
            addContactRecord = new ArrayList<ContactRecordType>();
        }
        return this.addContactRecord;
    }

    /**
     * Gets the value of the modifyContactRecord property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the modifyContactRecord property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getModifyContactRecord().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ContactRecordConditionType }
     * 
     * 
     */
    public List<ContactRecordConditionType> getModifyContactRecord() {
        if (modifyContactRecord == null) {
            modifyContactRecord = new ArrayList<ContactRecordConditionType>();
        }
        return this.modifyContactRecord;
    }

    /**
     * Gets the value of the removeContactRecord property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the removeContactRecord property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getRemoveContactRecord().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ContactRecordType }
     * 
     * 
     */
    public List<ContactRecordType> getRemoveContactRecord() {
        if (removeContactRecord == null) {
            removeContactRecord = new ArrayList<ContactRecordType>();
        }
        return this.removeContactRecord;
    }

}
