
package com.huawei.cps.cpsinterface.request;

import com.huawei.cps.cpsinterface.common.GroupBeneficiary;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 新增Group Beneficiary
 * 
 * <p>Java class for AddGroupBeneficiaryRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="AddGroupBeneficiaryRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="GroupBeneficiary" type="{http://cps.huawei.com/cpsinterface/common}GroupBeneficiary"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "AddGroupBeneficiaryRequest", propOrder = {
    "groupBeneficiary"
})
public class AddGroupBeneficiaryRequest {

    @XmlElement(name = "GroupBeneficiary", required = true)
    protected GroupBeneficiary groupBeneficiary;

    /**
     * Gets the value of the groupBeneficiary property.
     * 
     * @return
     *     possible object is
     *     {@link GroupBeneficiary }
     *     
     */
    public GroupBeneficiary getGroupBeneficiary() {
        return groupBeneficiary;
    }

    /**
     * Sets the value of the groupBeneficiary property.
     * 
     * @param value
     *     allowed object is
     *     {@link GroupBeneficiary }
     *     
     */
    public void setGroupBeneficiary(GroupBeneficiary value) {
        this.groupBeneficiary = value;
    }

}
