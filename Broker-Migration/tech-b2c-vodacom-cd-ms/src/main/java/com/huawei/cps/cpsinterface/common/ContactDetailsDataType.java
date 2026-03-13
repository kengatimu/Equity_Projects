
package com.huawei.cps.cpsinterface.common;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Organization的联系信息
 * 
 * <p>Java class for ContactDetailsDataType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ContactDetailsDataType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="ContactRecord" type="{http://cps.huawei.com/cpsinterface/common}ContactRecordType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ContactDetailsDataType", propOrder = {
    "contactRecord"
})
public class ContactDetailsDataType {

    @XmlElement(name = "ContactRecord")
    protected List<ContactRecordType> contactRecord;

    /**
     * Gets the value of the contactRecord property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the contactRecord property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getContactRecord().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ContactRecordType }
     * 
     * 
     */
    public List<ContactRecordType> getContactRecord() {
        if (contactRecord == null) {
            contactRecord = new ArrayList<ContactRecordType>();
        }
        return this.contactRecord;
    }

}
