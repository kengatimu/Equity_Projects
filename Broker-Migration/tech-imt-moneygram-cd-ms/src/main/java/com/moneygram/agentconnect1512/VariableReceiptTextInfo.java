
package com.moneygram.agentconnect1512;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for VariableReceiptTextInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="VariableReceiptTextInfo"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="receiptTextType" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="textTranslation" type="{http://www.moneygram.com/AgentConnect1512}TextTranslation" maxOccurs="unbounded"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "VariableReceiptTextInfo", propOrder = {
    "receiptTextType",
    "textTranslation"
})
public class VariableReceiptTextInfo {

    @XmlElement(required = true)
    protected String receiptTextType;
    @XmlElement(required = true)
    protected List<TextTranslation> textTranslation;

    /**
     * Gets the value of the receiptTextType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiptTextType() {
        return receiptTextType;
    }

    /**
     * Sets the value of the receiptTextType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiptTextType(String value) {
        this.receiptTextType = value;
    }

    /**
     * Gets the value of the textTranslation property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the textTranslation property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getTextTranslation().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link TextTranslation }
     * 
     * 
     */
    public List<TextTranslation> getTextTranslation() {
        if (textTranslation == null) {
            textTranslation = new ArrayList<TextTranslation>();
        }
        return this.textTranslation;
    }

}
