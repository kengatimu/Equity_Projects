
package com.huawei.cps.cpsinterface.request;

import java.util.ArrayList;
import java.util.List;
import com.huawei.cps.cpsinterface.common.IDRecordType;
import com.huawei.cps.cpsinterface.common.KYCFieldType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Customer忘记Password请求修改
 * 
 * <p>Java class for CustomerForgetPasswordRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CustomerForgetPasswordRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="NewPassword" type="{http://cps.huawei.com/cpsinterface/common}PasswordType"/&gt;
 *         &lt;element name="VerifyKYCData" type="{http://cps.huawei.com/cpsinterface/common}KYCFieldType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="VerifyIDData" type="{http://cps.huawei.com/cpsinterface/common}IDRecordType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CustomerForgetPasswordRequest", propOrder = {
    "newPassword",
    "verifyKYCData",
    "verifyIDData"
})
public class CustomerForgetPasswordRequest {

    @XmlElement(name = "NewPassword", required = true)
    protected String newPassword;
    @XmlElement(name = "VerifyKYCData")
    protected List<KYCFieldType> verifyKYCData;
    @XmlElement(name = "VerifyIDData")
    protected List<IDRecordType> verifyIDData;

    /**
     * Gets the value of the newPassword property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNewPassword() {
        return newPassword;
    }

    /**
     * Sets the value of the newPassword property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNewPassword(String value) {
        this.newPassword = value;
    }

    /**
     * Gets the value of the verifyKYCData property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the verifyKYCData property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getVerifyKYCData().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link KYCFieldType }
     * 
     * 
     */
    public List<KYCFieldType> getVerifyKYCData() {
        if (verifyKYCData == null) {
            verifyKYCData = new ArrayList<KYCFieldType>();
        }
        return this.verifyKYCData;
    }

    /**
     * Gets the value of the verifyIDData property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the verifyIDData property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getVerifyIDData().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link IDRecordType }
     * 
     * 
     */
    public List<IDRecordType> getVerifyIDData() {
        if (verifyIDData == null) {
            verifyIDData = new ArrayList<IDRecordType>();
        }
        return this.verifyIDData;
    }

}
