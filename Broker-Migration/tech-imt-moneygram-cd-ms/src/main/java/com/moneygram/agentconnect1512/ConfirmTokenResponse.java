
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for ConfirmTokenResponse complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ConfirmTokenResponse"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Response"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="profileChanged" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="codeTableChanged" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ConfirmTokenResponse", propOrder = {
    "profileChanged",
    "codeTableChanged"
})
public class ConfirmTokenResponse
    extends Response
{

    protected boolean profileChanged;
    protected boolean codeTableChanged;

    /**
     * Gets the value of the profileChanged property.
     * 
     */
    public boolean isProfileChanged() {
        return profileChanged;
    }

    /**
     * Sets the value of the profileChanged property.
     * 
     */
    public void setProfileChanged(boolean value) {
        this.profileChanged = value;
    }

    /**
     * Gets the value of the codeTableChanged property.
     * 
     */
    public boolean isCodeTableChanged() {
        return codeTableChanged;
    }

    /**
     * Sets the value of the codeTableChanged property.
     * 
     */
    public void setCodeTableChanged(boolean value) {
        this.codeTableChanged = value;
    }

}
