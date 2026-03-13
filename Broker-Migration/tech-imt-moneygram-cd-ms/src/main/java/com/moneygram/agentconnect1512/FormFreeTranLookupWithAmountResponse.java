
package com.moneygram.agentconnect1512;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for FormFreeTranLookupWithAmountResponse complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="FormFreeTranLookupWithAmountResponse"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Response"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="formFreeTransactionInfo2" type="{http://www.moneygram.com/AgentConnect1512}FormFreeTransactionInfo2" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "FormFreeTranLookupWithAmountResponse", propOrder = {
    "formFreeTransactionInfo2"
})
public class FormFreeTranLookupWithAmountResponse
    extends Response
{

    protected List<FormFreeTransactionInfo2> formFreeTransactionInfo2;

    /**
     * Gets the value of the formFreeTransactionInfo2 property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the formFreeTransactionInfo2 property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getFormFreeTransactionInfo2().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link FormFreeTransactionInfo2 }
     * 
     * 
     */
    public List<FormFreeTransactionInfo2> getFormFreeTransactionInfo2() {
        if (formFreeTransactionInfo2 == null) {
            formFreeTransactionInfo2 = new ArrayList<FormFreeTransactionInfo2>();
        }
        return this.formFreeTransactionInfo2;
    }

}
