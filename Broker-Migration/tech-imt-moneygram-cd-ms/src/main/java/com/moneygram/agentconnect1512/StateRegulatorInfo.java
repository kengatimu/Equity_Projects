
package com.moneygram.agentconnect1512;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for stateRegulatorInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="stateRegulatorInfo"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="dfJurisdiction" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="stateRegulatorURL" type="{http://www.moneygram.com/AgentConnect1512}stringMax2000"/&gt;
 *         &lt;element name="stateRegulatorPhone" type="{http://www.moneygram.com/AgentConnect1512}stringMax100"/&gt;
 *         &lt;element name="stateRegulatorName" type="{http://www.moneygram.com/AgentConnect1512}TextTranslation" maxOccurs="unbounded"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "stateRegulatorInfo", propOrder = {
    "dfJurisdiction",
    "stateRegulatorURL",
    "stateRegulatorPhone",
    "stateRegulatorName"
})
public class StateRegulatorInfo {

    @XmlElement(required = true)
    protected String dfJurisdiction;
    @XmlElement(required = true)
    protected String stateRegulatorURL;
    @XmlElement(required = true)
    protected String stateRegulatorPhone;
    @XmlElement(required = true)
    protected List<TextTranslation> stateRegulatorName;

    /**
     * Gets the value of the dfJurisdiction property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDfJurisdiction() {
        return dfJurisdiction;
    }

    /**
     * Sets the value of the dfJurisdiction property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDfJurisdiction(String value) {
        this.dfJurisdiction = value;
    }

    /**
     * Gets the value of the stateRegulatorURL property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getStateRegulatorURL() {
        return stateRegulatorURL;
    }

    /**
     * Sets the value of the stateRegulatorURL property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setStateRegulatorURL(String value) {
        this.stateRegulatorURL = value;
    }

    /**
     * Gets the value of the stateRegulatorPhone property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getStateRegulatorPhone() {
        return stateRegulatorPhone;
    }

    /**
     * Sets the value of the stateRegulatorPhone property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setStateRegulatorPhone(String value) {
        this.stateRegulatorPhone = value;
    }

    /**
     * Gets the value of the stateRegulatorName property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the stateRegulatorName property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getStateRegulatorName().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link TextTranslation }
     * 
     * 
     */
    public List<TextTranslation> getStateRegulatorName() {
        if (stateRegulatorName == null) {
            stateRegulatorName = new ArrayList<TextTranslation>();
        }
        return this.stateRegulatorName;
    }

}
