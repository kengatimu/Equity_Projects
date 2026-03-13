
package com.moneygram.agentconnect1512;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for ConfirmTokenRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ConfirmTokenRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Request"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="codeTableVersion" type="{http://www.moneygram.com/AgentConnect1512}stringMax20" minOccurs="0"/&gt;
 *         &lt;element name="clientTableVersions" type="{http://www.moneygram.com/AgentConnect1512}VersionInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ConfirmTokenRequest", propOrder = {
    "codeTableVersion",
    "clientTableVersions"
})
public class ConfirmTokenRequest
    extends Request
{

    protected String codeTableVersion;
    protected List<VersionInfo> clientTableVersions;

    /**
     * Gets the value of the codeTableVersion property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCodeTableVersion() {
        return codeTableVersion;
    }

    /**
     * Sets the value of the codeTableVersion property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCodeTableVersion(String value) {
        this.codeTableVersion = value;
    }

    /**
     * Gets the value of the clientTableVersions property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the clientTableVersions property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getClientTableVersions().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link VersionInfo }
     * 
     * 
     */
    public List<VersionInfo> getClientTableVersions() {
        if (clientTableVersions == null) {
            clientTableVersions = new ArrayList<VersionInfo>();
        }
        return this.clientTableVersions;
    }

}
