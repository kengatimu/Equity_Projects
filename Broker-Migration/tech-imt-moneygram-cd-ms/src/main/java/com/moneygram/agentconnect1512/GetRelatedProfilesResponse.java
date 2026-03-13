
package com.moneygram.agentconnect1512;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for GetRelatedProfilesResponse complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="GetRelatedProfilesResponse"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Response"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="modelUnitProfileID" type="{http://www.w3.org/2001/XMLSchema}int"/&gt;
 *         &lt;element name="modelPOS" type="{http://www.w3.org/2001/XMLSchema}boolean"/&gt;
 *         &lt;element name="profileInfo" type="{http://www.moneygram.com/AgentConnect1512}ProfileInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "GetRelatedProfilesResponse", propOrder = {
    "modelUnitProfileID",
    "modelPOS",
    "profileInfo"
})
public class GetRelatedProfilesResponse
    extends Response
{

    protected int modelUnitProfileID;
    protected boolean modelPOS;
    protected List<ProfileInfo> profileInfo;

    /**
     * Gets the value of the modelUnitProfileID property.
     * 
     */
    public int getModelUnitProfileID() {
        return modelUnitProfileID;
    }

    /**
     * Sets the value of the modelUnitProfileID property.
     * 
     */
    public void setModelUnitProfileID(int value) {
        this.modelUnitProfileID = value;
    }

    /**
     * Gets the value of the modelPOS property.
     * 
     */
    public boolean isModelPOS() {
        return modelPOS;
    }

    /**
     * Sets the value of the modelPOS property.
     * 
     */
    public void setModelPOS(boolean value) {
        this.modelPOS = value;
    }

    /**
     * Gets the value of the profileInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the profileInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getProfileInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ProfileInfo }
     * 
     * 
     */
    public List<ProfileInfo> getProfileInfo() {
        if (profileInfo == null) {
            profileInfo = new ArrayList<ProfileInfo>();
        }
        return this.profileInfo;
    }

}
