
package com.huawei.cps.cpsinterface.request;

import java.util.ArrayList;
import java.util.List;
import com.huawei.cps.cpsinterface.common.KYCFieldType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 单值KYC更新数据
 * 
 * <p>Java class for SimpleKYCUpdateDataType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="SimpleKYCUpdateDataType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="AddField" type="{http://cps.huawei.com/cpsinterface/common}KYCFieldType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="ModifyField" type="{http://cps.huawei.com/cpsinterface/common}KYCFieldType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="RemoveField" type="{http://cps.huawei.com/cpsinterface/common}KYCFieldType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "SimpleKYCUpdateDataType", propOrder = {
    "addField",
    "modifyField",
    "removeField"
})
public class SimpleKYCUpdateDataType {

    @XmlElement(name = "AddField")
    protected List<KYCFieldType> addField;
    @XmlElement(name = "ModifyField")
    protected List<KYCFieldType> modifyField;
    @XmlElement(name = "RemoveField")
    protected List<KYCFieldType> removeField;

    /**
     * Gets the value of the addField property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the addField property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getAddField().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link KYCFieldType }
     * 
     * 
     */
    public List<KYCFieldType> getAddField() {
        if (addField == null) {
            addField = new ArrayList<KYCFieldType>();
        }
        return this.addField;
    }

    /**
     * Gets the value of the modifyField property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the modifyField property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getModifyField().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link KYCFieldType }
     * 
     * 
     */
    public List<KYCFieldType> getModifyField() {
        if (modifyField == null) {
            modifyField = new ArrayList<KYCFieldType>();
        }
        return this.modifyField;
    }

    /**
     * Gets the value of the removeField property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the removeField property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getRemoveField().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link KYCFieldType }
     * 
     * 
     */
    public List<KYCFieldType> getRemoveField() {
        if (removeField == null) {
            removeField = new ArrayList<KYCFieldType>();
        }
        return this.removeField;
    }

}
