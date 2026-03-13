
package com.moneygram.agentconnect1512;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlSchemaType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for CountryInfoRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CountryInfoRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Request"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="countryFilter" type="{http://www.moneygram.com/AgentConnect1512}countryFilterType" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CountryInfoRequest", propOrder = {
    "countryFilter"
})
public class CountryInfoRequest
    extends Request
{

    @XmlSchemaType(name = "string")
    protected CountryFilterType countryFilter;

    /**
     * Gets the value of the countryFilter property.
     * 
     * @return
     *     possible object is
     *     {@link CountryFilterType }
     *     
     */
    public CountryFilterType getCountryFilter() {
        return countryFilter;
    }

    /**
     * Sets the value of the countryFilter property.
     * 
     * @param value
     *     allowed object is
     *     {@link CountryFilterType }
     *     
     */
    public void setCountryFilter(CountryFilterType value) {
        this.countryFilter = value;
    }

}
