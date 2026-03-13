
package com.huawei.cps.cpsinterface.request;

import java.util.ArrayList;
import java.util.List;
import com.huawei.cps.cpsinterface.common.BankAccountRecordType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Organization的BankAccountDetails更新数据
 * 
 * <p>Java class for BankAccountDetailsUpdateDataType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="BankAccountDetailsUpdateDataType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="AddAccountRecord" type="{http://cps.huawei.com/cpsinterface/common}BankAccountRecordType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="ModifyAccountRecord" type="{http://cps.huawei.com/cpsinterface/request}BankAccountRecordConditionType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="RemoveAccountRecord" type="{http://cps.huawei.com/cpsinterface/common}BankAccountRecordType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "BankAccountDetailsUpdateDataType", propOrder = {
    "addAccountRecord",
    "modifyAccountRecord",
    "removeAccountRecord"
})
public class BankAccountDetailsUpdateDataType {

    @XmlElement(name = "AddAccountRecord")
    protected List<BankAccountRecordType> addAccountRecord;
    @XmlElement(name = "ModifyAccountRecord")
    protected List<BankAccountRecordConditionType> modifyAccountRecord;
    @XmlElement(name = "RemoveAccountRecord")
    protected List<BankAccountRecordType> removeAccountRecord;

    /**
     * Gets the value of the addAccountRecord property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the addAccountRecord property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getAddAccountRecord().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link BankAccountRecordType }
     * 
     * 
     */
    public List<BankAccountRecordType> getAddAccountRecord() {
        if (addAccountRecord == null) {
            addAccountRecord = new ArrayList<BankAccountRecordType>();
        }
        return this.addAccountRecord;
    }

    /**
     * Gets the value of the modifyAccountRecord property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the modifyAccountRecord property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getModifyAccountRecord().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link BankAccountRecordConditionType }
     * 
     * 
     */
    public List<BankAccountRecordConditionType> getModifyAccountRecord() {
        if (modifyAccountRecord == null) {
            modifyAccountRecord = new ArrayList<BankAccountRecordConditionType>();
        }
        return this.modifyAccountRecord;
    }

    /**
     * Gets the value of the removeAccountRecord property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the removeAccountRecord property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getRemoveAccountRecord().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link BankAccountRecordType }
     * 
     * 
     */
    public List<BankAccountRecordType> getRemoveAccountRecord() {
        if (removeAccountRecord == null) {
            removeAccountRecord = new ArrayList<BankAccountRecordType>();
        }
        return this.removeAccountRecord;
    }

}
