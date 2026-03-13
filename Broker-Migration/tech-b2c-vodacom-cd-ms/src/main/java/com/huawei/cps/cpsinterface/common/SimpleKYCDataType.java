
package com.huawei.cps.cpsinterface.common;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 单值KYC定义
 * 
 * <p>Java class for SimpleKYCDataType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="SimpleKYCDataType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="KYCField" type="{http://cps.huawei.com/cpsinterface/common}KYCFieldType" maxOccurs="unbounded"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "SimpleKYCDataType", propOrder = {
    "kycField"
})
public class SimpleKYCDataType {

    @XmlElement(name = "KYCField", required = true)
    protected List<KYCFieldType> kycField;

    /**
     * Gets the value of the kycField property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the kycField property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getKYCField().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link KYCFieldType }
     * 
     * 
     */
    public List<KYCFieldType> getKYCField() {
        if (kycField == null) {
            kycField = new ArrayList<KYCFieldType>();
        }
        return this.kycField;
    }

}
