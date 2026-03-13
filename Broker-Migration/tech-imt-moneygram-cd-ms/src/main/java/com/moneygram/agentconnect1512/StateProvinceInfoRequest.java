
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for StateProvinceInfoRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="StateProvinceInfoRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Request"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="stateProvinceFilter" type="{http://www.moneygram.com/AgentConnect1512}stateProvinceFilterType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "StateProvinceInfoRequest", propOrder = {
    "stateProvinceFilter"
})
public class StateProvinceInfoRequest
    extends Request
{

    @XmlSchemaType(name = "string")
    protected StateProvinceFilterType stateProvinceFilter;

    /**
     * Gets the value of the stateProvinceFilter property.
     * 
     * @return
     *     possible object is
     *     {@link StateProvinceFilterType }
     *     
     */
    public StateProvinceFilterType getStateProvinceFilter() {
        return stateProvinceFilter;
    }

    /**
     * Sets the value of the stateProvinceFilter property.
     * 
     * @param value
     *     allowed object is
     *     {@link StateProvinceFilterType }
     *     
     */
    public void setStateProvinceFilter(StateProvinceFilterType value) {
        this.stateProvinceFilter = value;
    }

}
