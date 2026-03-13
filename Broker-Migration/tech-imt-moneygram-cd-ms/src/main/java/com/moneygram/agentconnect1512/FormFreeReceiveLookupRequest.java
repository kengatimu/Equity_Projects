
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for FormFreeReceiveLookupRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="FormFreeReceiveLookupRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Request"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="referenceNumber" type="{http://www.moneygram.com/AgentConnect1512}referenceNumber"/&gt;
 *         &lt;element name="receiptImages" type="{http://www.moneygram.com/AgentConnect1512}ReceiptImagesContentType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "FormFreeReceiveLookupRequest", propOrder = {
    "referenceNumber",
    "receiptImages"
})
public class FormFreeReceiveLookupRequest
    extends Request
{

    @XmlElement(required = true)
    protected String referenceNumber;
    protected ReceiptImagesContentType receiptImages;

    /**
     * Gets the value of the referenceNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReferenceNumber() {
        return referenceNumber;
    }

    /**
     * Sets the value of the referenceNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReferenceNumber(String value) {
        this.referenceNumber = value;
    }

    /**
     * Gets the value of the receiptImages property.
     * 
     * @return
     *     possible object is
     *     {@link ReceiptImagesContentType }
     *     
     */
    public ReceiptImagesContentType getReceiptImages() {
        return receiptImages;
    }

    /**
     * Sets the value of the receiptImages property.
     * 
     * @param value
     *     allowed object is
     *     {@link ReceiptImagesContentType }
     *     
     */
    public void setReceiptImages(ReceiptImagesContentType value) {
        this.receiptImages = value;
    }

}
