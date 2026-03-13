
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for FormFreeBPLookupRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="FormFreeBPLookupRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Request"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="confirmationNumber" type="{http://www.moneygram.com/AgentConnect1512}confirmationNumber"/&gt;
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
@XmlType(name = "FormFreeBPLookupRequest", propOrder = {
    "confirmationNumber",
    "receiptImages"
})
public class FormFreeBPLookupRequest
    extends Request
{

    @XmlElement(required = true)
    protected String confirmationNumber;
    protected ReceiptImagesContentType receiptImages;

    /**
     * Gets the value of the confirmationNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getConfirmationNumber() {
        return confirmationNumber;
    }

    /**
     * Sets the value of the confirmationNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setConfirmationNumber(String value) {
        this.confirmationNumber = value;
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
