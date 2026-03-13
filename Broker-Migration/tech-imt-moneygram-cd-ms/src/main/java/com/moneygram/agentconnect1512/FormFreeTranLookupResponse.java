
package com.moneygram.agentconnect1512;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for FormFreeTranLookupResponse complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="FormFreeTranLookupResponse"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Response"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="formFreeTransactionInfo" type="{http://www.moneygram.com/AgentConnect1512}FormFreeTransactionInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "FormFreeTranLookupResponse", propOrder = {
    "formFreeTransactionInfo"
})
public class FormFreeTranLookupResponse
    extends Response
{

    protected List<FormFreeTransactionInfo> formFreeTransactionInfo;

    /**
     * Gets the value of the formFreeTransactionInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the formFreeTransactionInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getFormFreeTransactionInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link FormFreeTransactionInfo }
     * 
     * 
     */
    public List<FormFreeTransactionInfo> getFormFreeTransactionInfo() {
        if (formFreeTransactionInfo == null) {
            formFreeTransactionInfo = new ArrayList<FormFreeTransactionInfo>();
        }
        return this.formFreeTransactionInfo;
    }

}
