
package com.moneygram.agentconnect1512;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * A complex type definition representing a single
 *                            receipt. A single receipt may be comprised of either one or
 *                            potentially more than one receipt mime data "segment" that
 *                            collectively represents the single receipt. This latter case is
 *                            applicable for PDF receipts that must be represented and returned to
 *                            the POE as multiple images - one for each page in the PDF.
 * 
 * <p>Java class for ReceiptResponseType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ReceiptResponseType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="receiptMimeDataSegment" type="{http://www.moneygram.com/AgentConnect1512}ReceiptSegmentType" maxOccurs="unbounded"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ReceiptResponseType", propOrder = {
    "receiptMimeDataSegment"
})
public class ReceiptResponseType {

    @XmlElement(required = true)
    protected List<ReceiptSegmentType> receiptMimeDataSegment;

    /**
     * Gets the value of the receiptMimeDataSegment property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the receiptMimeDataSegment property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getReceiptMimeDataSegment().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ReceiptSegmentType }
     * 
     * 
     */
    public List<ReceiptSegmentType> getReceiptMimeDataSegment() {
        if (receiptMimeDataSegment == null) {
            receiptMimeDataSegment = new ArrayList<ReceiptSegmentType>();
        }
        return this.receiptMimeDataSegment;
    }

}
