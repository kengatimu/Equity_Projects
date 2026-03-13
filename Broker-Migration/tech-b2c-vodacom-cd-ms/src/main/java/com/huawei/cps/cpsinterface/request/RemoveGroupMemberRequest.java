
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 删除GroupMember
 * 
 * <p>Java class for RemoveGroupMemberRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="RemoveGroupMemberRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="RemovedMSISDN" type="{http://cps.huawei.com/cpsinterface/common}MSISDNType"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "RemoveGroupMemberRequest", propOrder = {
    "removedMSISDN"
})
public class RemoveGroupMemberRequest {

    @XmlElement(name = "RemovedMSISDN", required = true)
    protected String removedMSISDN;

    /**
     * Gets the value of the removedMSISDN property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRemovedMSISDN() {
        return removedMSISDN;
    }

    /**
     * Sets the value of the removedMSISDN property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRemovedMSISDN(String value) {
        this.removedMSISDN = value;
    }

}
