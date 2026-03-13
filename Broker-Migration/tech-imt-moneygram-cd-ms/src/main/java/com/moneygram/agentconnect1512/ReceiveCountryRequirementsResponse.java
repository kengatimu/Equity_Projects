
package com.moneygram.agentconnect1512;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for ReceiveCountryRequirementsResponse complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ReceiveCountryRequirementsResponse"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Response"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="version" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="receiveCountryRequirementsInfo" type="{http://www.moneygram.com/AgentConnect1512}ReceiveCountryRequirementsInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ReceiveCountryRequirementsResponse", propOrder = {
    "version",
    "receiveCountryRequirementsInfo"
})
public class ReceiveCountryRequirementsResponse
    extends Response
{

    protected String version;
    protected List<ReceiveCountryRequirementsInfo> receiveCountryRequirementsInfo;

    /**
     * Gets the value of the version property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getVersion() {
        return version;
    }

    /**
     * Sets the value of the version property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setVersion(String value) {
        this.version = value;
    }

    /**
     * Gets the value of the receiveCountryRequirementsInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the receiveCountryRequirementsInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getReceiveCountryRequirementsInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ReceiveCountryRequirementsInfo }
     * 
     * 
     */
    public List<ReceiveCountryRequirementsInfo> getReceiveCountryRequirementsInfo() {
        if (receiveCountryRequirementsInfo == null) {
            receiveCountryRequirementsInfo = new ArrayList<ReceiveCountryRequirementsInfo>();
        }
        return this.receiveCountryRequirementsInfo;
    }

}
