
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 修改OrgOperator的SecretWord
 * 
 * <p>Java class for ChangeOrgOperatorSecretWordRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ChangeOrgOperatorSecretWordRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="NewSecretWord"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="256"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ChangeOrgOperatorSecretWordRequest", propOrder = {
    "newSecretWord"
})
public class ChangeOrgOperatorSecretWordRequest {

    @XmlElement(name = "NewSecretWord", required = true)
    protected String newSecretWord;

    /**
     * Gets the value of the newSecretWord property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getNewSecretWord() {
        return newSecretWord;
    }

    /**
     * Sets the value of the newSecretWord property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setNewSecretWord(String value) {
        this.newSecretWord = value;
    }

}
