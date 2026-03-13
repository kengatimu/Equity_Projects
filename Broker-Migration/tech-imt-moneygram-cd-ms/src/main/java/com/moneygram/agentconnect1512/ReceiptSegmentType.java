
package com.moneygram.agentconnect1512;

import jakarta.activation.DataHandler;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlMimeType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Under typical circumstances binary receipts within
 *                            response payloads are simply returned as a single binary receipt.
 *                            The exception to this rule is in the context of PDF receipts. For
 *                            browser-based POEs, newer browsers (e.g. IE11) now do not handle PDF
 *                            receipts as they conventionally have because of security risks. As a
 *                            result POEs may specify in a request (or be configured) to convert
 *                            the generated PDF into equivalent images - one for each page in the
 *                            PDF receipt - and to return those images instead. When that is the
 *                            case images must be printed one per page. Consequently, this complex
 *                            type provides a definition for a receipt "segment" that can be used
 *                            within a response to hold either an entire PDF binary or a segment
 *                            of that PDF represented as an image. In the case of the latter the
 *                            sequence element must be specified to indicate which page of the
 *                            converted PDF receipt that the image corresponds to.
 * 
 * <p>Java class for ReceiptSegmentType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ReceiptSegmentType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="sequence" type="{http://www.w3.org/2001/XMLSchema}int" minOccurs="0"/&gt;
 *         &lt;element name="mimeData" type="{http://www.w3.org/2001/XMLSchema}base64Binary" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ReceiptSegmentType", propOrder = {
    "sequence",
    "mimeData"
})
public class ReceiptSegmentType {

    protected Integer sequence;
    @XmlMimeType("*/*")
    protected DataHandler mimeData;

    /**
     * Gets the value of the sequence property.
     * 
     * @return
     *     possible object is
     *     {@link Integer }
     *     
     */
    public Integer getSequence() {
        return sequence;
    }

    /**
     * Sets the value of the sequence property.
     * 
     * @param value
     *     allowed object is
     *     {@link Integer }
     *     
     */
    public void setSequence(Integer value) {
        this.sequence = value;
    }

    /**
     * Gets the value of the mimeData property.
     * 
     * @return
     *     possible object is
     *     {@link DataHandler }
     *     
     */
    public DataHandler getMimeData() {
        return mimeData;
    }

    /**
     * Sets the value of the mimeData property.
     * 
     * @param value
     *     allowed object is
     *     {@link DataHandler }
     *     
     */
    public void setMimeData(DataHandler value) {
        this.mimeData = value;
    }

}
