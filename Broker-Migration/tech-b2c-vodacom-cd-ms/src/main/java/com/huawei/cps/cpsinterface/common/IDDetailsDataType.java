
package com.huawei.cps.cpsinterface.common;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Customer的证件信息
 * 
 * <p>Java class for IDDetailsDataType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="IDDetailsDataType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="IDRecord" type="{http://cps.huawei.com/cpsinterface/common}IDRecordType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "IDDetailsDataType", propOrder = {
    "idRecord"
})
public class IDDetailsDataType {

    @XmlElement(name = "IDRecord")
    protected List<IDRecordType> idRecord;

    /**
     * Gets the value of the idRecord property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the idRecord property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getIDRecord().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link IDRecordType }
     * 
     * 
     */
    public List<IDRecordType> getIDRecord() {
        if (idRecord == null) {
            idRecord = new ArrayList<IDRecordType>();
        }
        return this.idRecord;
    }

}
