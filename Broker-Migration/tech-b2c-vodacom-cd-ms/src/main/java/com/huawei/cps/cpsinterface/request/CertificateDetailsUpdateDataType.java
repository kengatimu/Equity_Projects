
package com.huawei.cps.cpsinterface.request;

import java.util.ArrayList;
import java.util.List;
import com.huawei.cps.cpsinterface.common.CertificateRecordType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Operator的Certificate更新数据
 * 
 * <p>Java class for CertificateDetailsUpdateDataType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CertificateDetailsUpdateDataType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="AddCertificateRecord" type="{http://cps.huawei.com/cpsinterface/common}CertificateRecordType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="ModifyCertificateRecord" type="{http://cps.huawei.com/cpsinterface/request}CertificateRecordConditionType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="RemoveCertificateRecord" type="{http://cps.huawei.com/cpsinterface/common}CertificateRecordType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CertificateDetailsUpdateDataType", propOrder = {
    "addCertificateRecord",
    "modifyCertificateRecord",
    "removeCertificateRecord"
})
public class CertificateDetailsUpdateDataType {

    @XmlElement(name = "AddCertificateRecord")
    protected List<CertificateRecordType> addCertificateRecord;
    @XmlElement(name = "ModifyCertificateRecord")
    protected List<CertificateRecordConditionType> modifyCertificateRecord;
    @XmlElement(name = "RemoveCertificateRecord")
    protected List<CertificateRecordType> removeCertificateRecord;

    /**
     * Gets the value of the addCertificateRecord property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the addCertificateRecord property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getAddCertificateRecord().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link CertificateRecordType }
     * 
     * 
     */
    public List<CertificateRecordType> getAddCertificateRecord() {
        if (addCertificateRecord == null) {
            addCertificateRecord = new ArrayList<CertificateRecordType>();
        }
        return this.addCertificateRecord;
    }

    /**
     * Gets the value of the modifyCertificateRecord property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the modifyCertificateRecord property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getModifyCertificateRecord().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link CertificateRecordConditionType }
     * 
     * 
     */
    public List<CertificateRecordConditionType> getModifyCertificateRecord() {
        if (modifyCertificateRecord == null) {
            modifyCertificateRecord = new ArrayList<CertificateRecordConditionType>();
        }
        return this.modifyCertificateRecord;
    }

    /**
     * Gets the value of the removeCertificateRecord property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the removeCertificateRecord property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getRemoveCertificateRecord().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link CertificateRecordType }
     * 
     * 
     */
    public List<CertificateRecordType> getRemoveCertificateRecord() {
        if (removeCertificateRecord == null) {
            removeCertificateRecord = new ArrayList<CertificateRecordType>();
        }
        return this.removeCertificateRecord;
    }

}
