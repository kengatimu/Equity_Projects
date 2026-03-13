
package com.huawei.cps.cpsinterface.request;

import java.util.ArrayList;
import java.util.List;
import com.huawei.cps.cpsinterface.common.IDRecordType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Customer的IDDetails更新数据
 * 
 * <p>Java class for IDDetailsUpdateDataType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="IDDetailsUpdateDataType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="AddIDRecord" type="{http://cps.huawei.com/cpsinterface/common}IDRecordType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="ModifyIDRecord" type="{http://cps.huawei.com/cpsinterface/request}IDRecordConditionType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="RemoveIDRecord" type="{http://cps.huawei.com/cpsinterface/common}IDRecordType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "IDDetailsUpdateDataType", propOrder = {
    "addIDRecord",
    "modifyIDRecord",
    "removeIDRecord"
})
public class IDDetailsUpdateDataType {

    @XmlElement(name = "AddIDRecord")
    protected List<IDRecordType> addIDRecord;
    @XmlElement(name = "ModifyIDRecord")
    protected List<IDRecordConditionType> modifyIDRecord;
    @XmlElement(name = "RemoveIDRecord")
    protected List<IDRecordType> removeIDRecord;

    /**
     * Gets the value of the addIDRecord property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the addIDRecord property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getAddIDRecord().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link IDRecordType }
     * 
     * 
     */
    public List<IDRecordType> getAddIDRecord() {
        if (addIDRecord == null) {
            addIDRecord = new ArrayList<IDRecordType>();
        }
        return this.addIDRecord;
    }

    /**
     * Gets the value of the modifyIDRecord property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the modifyIDRecord property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getModifyIDRecord().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link IDRecordConditionType }
     * 
     * 
     */
    public List<IDRecordConditionType> getModifyIDRecord() {
        if (modifyIDRecord == null) {
            modifyIDRecord = new ArrayList<IDRecordConditionType>();
        }
        return this.modifyIDRecord;
    }

    /**
     * Gets the value of the removeIDRecord property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the removeIDRecord property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getRemoveIDRecord().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link IDRecordType }
     * 
     * 
     */
    public List<IDRecordType> getRemoveIDRecord() {
        if (removeIDRecord == null) {
            removeIDRecord = new ArrayList<IDRecordType>();
        }
        return this.removeIDRecord;
    }

}
