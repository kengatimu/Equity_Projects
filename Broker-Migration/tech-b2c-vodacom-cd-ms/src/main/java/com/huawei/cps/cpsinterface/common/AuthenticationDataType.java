
package com.huawei.cps.cpsinterface.common;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Operator的认证信息
 * 
 * <p>Java class for AuthenticationDataType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="AuthenticationDataType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="AuthenticationItem" type="{http://cps.huawei.com/cpsinterface/common}AuthenticationType" maxOccurs="3"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "AuthenticationDataType", propOrder = {
    "authenticationItem"
})
public class AuthenticationDataType {

    @XmlElement(name = "AuthenticationItem", required = true)
    protected List<AuthenticationType> authenticationItem;

    /**
     * Gets the value of the authenticationItem property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the authenticationItem property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getAuthenticationItem().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link AuthenticationType }
     * 
     * 
     */
    public List<AuthenticationType> getAuthenticationItem() {
        if (authenticationItem == null) {
            authenticationItem = new ArrayList<AuthenticationType>();
        }
        return this.authenticationItem;
    }

}
