
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 修改Group的RuleProfile
 * 
 * <p>Java class for ChangeGroupRuleProfileRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ChangeGroupRuleProfileRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="IdentityRuleProfileID" type="{http://cps.huawei.com/cpsinterface/common}IDType"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ChangeGroupRuleProfileRequest", propOrder = {
    "identityRuleProfileID"
})
public class ChangeGroupRuleProfileRequest {

    @XmlElement(name = "IdentityRuleProfileID", required = true)
    protected String identityRuleProfileID;

    /**
     * Gets the value of the identityRuleProfileID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIdentityRuleProfileID() {
        return identityRuleProfileID;
    }

    /**
     * Sets the value of the identityRuleProfileID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIdentityRuleProfileID(String value) {
        this.identityRuleProfileID = value;
    }

}
