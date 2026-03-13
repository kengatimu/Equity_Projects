
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Query Direct Debit Mandate的查询结果
 * 
 * <p>Java class for QueryDirectDebitMandateResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryDirectDebitMandateResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="DirectDebitMandateInfo" type="{http://cps.huawei.com/cpsinterface/result}ViewDirectDebitMandateResult" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "QueryDirectDebitMandateResult", propOrder = {
    "directDebitMandateInfo"
})
public class QueryDirectDebitMandateResult {

    @XmlElement(name = "DirectDebitMandateInfo")
    protected List<ViewDirectDebitMandateResult> directDebitMandateInfo;

    /**
     * Gets the value of the directDebitMandateInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the directDebitMandateInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getDirectDebitMandateInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ViewDirectDebitMandateResult }
     * 
     * 
     */
    public List<ViewDirectDebitMandateResult> getDirectDebitMandateInfo() {
        if (directDebitMandateInfo == null) {
            directDebitMandateInfo = new ArrayList<ViewDirectDebitMandateResult>();
        }
        return this.directDebitMandateInfo;
    }

}
