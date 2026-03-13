
package com.moneygram.agentconnect1512;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for BillerSearchResponse complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="BillerSearchResponse"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Response"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="billerInfo" type="{http://www.moneygram.com/AgentConnect1512}BillerInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "BillerSearchResponse", propOrder = {
    "billerInfo"
})
public class BillerSearchResponse
    extends Response
{

    protected List<BillerInfo> billerInfo;

    /**
     * Gets the value of the billerInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the billerInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getBillerInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link BillerInfo }
     * 
     * 
     */
    public List<BillerInfo> getBillerInfo() {
        if (billerInfo == null) {
            billerInfo = new ArrayList<BillerInfo>();
        }
        return this.billerInfo;
    }

}
