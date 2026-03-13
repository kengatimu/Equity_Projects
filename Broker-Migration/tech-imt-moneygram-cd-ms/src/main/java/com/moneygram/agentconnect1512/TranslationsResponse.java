
package com.moneygram.agentconnect1512;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for TranslationsResponse complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="TranslationsResponse"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Response"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="translationsVersion" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="countryTranslations" type="{http://www.moneygram.com/AgentConnect1512}CountryTranslation" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="deliveryOptionTranslations" type="{http://www.moneygram.com/AgentConnect1512}DeliveryOptionTranslation" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="currencyTranslations" type="{http://www.moneygram.com/AgentConnect1512}CurrencyTranslation" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="fqdoTextTranslations" type="{http://www.moneygram.com/AgentConnect1512}FQDOTextTranslation" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="industryTranslations" type="{http://www.moneygram.com/AgentConnect1512}IndustryTranslation" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "TranslationsResponse", propOrder = {
    "translationsVersion",
    "countryTranslations",
    "deliveryOptionTranslations",
    "currencyTranslations",
    "fqdoTextTranslations",
    "industryTranslations"
})
public class TranslationsResponse
    extends Response
{

    @XmlElement(required = true)
    protected String translationsVersion;
    protected List<CountryTranslation> countryTranslations;
    protected List<DeliveryOptionTranslation> deliveryOptionTranslations;
    protected List<CurrencyTranslation> currencyTranslations;
    protected List<FQDOTextTranslation> fqdoTextTranslations;
    protected List<IndustryTranslation> industryTranslations;

    /**
     * Gets the value of the translationsVersion property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTranslationsVersion() {
        return translationsVersion;
    }

    /**
     * Sets the value of the translationsVersion property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTranslationsVersion(String value) {
        this.translationsVersion = value;
    }

    /**
     * Gets the value of the countryTranslations property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the countryTranslations property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getCountryTranslations().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link CountryTranslation }
     * 
     * 
     */
    public List<CountryTranslation> getCountryTranslations() {
        if (countryTranslations == null) {
            countryTranslations = new ArrayList<CountryTranslation>();
        }
        return this.countryTranslations;
    }

    /**
     * Gets the value of the deliveryOptionTranslations property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the deliveryOptionTranslations property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getDeliveryOptionTranslations().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link DeliveryOptionTranslation }
     * 
     * 
     */
    public List<DeliveryOptionTranslation> getDeliveryOptionTranslations() {
        if (deliveryOptionTranslations == null) {
            deliveryOptionTranslations = new ArrayList<DeliveryOptionTranslation>();
        }
        return this.deliveryOptionTranslations;
    }

    /**
     * Gets the value of the currencyTranslations property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the currencyTranslations property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getCurrencyTranslations().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link CurrencyTranslation }
     * 
     * 
     */
    public List<CurrencyTranslation> getCurrencyTranslations() {
        if (currencyTranslations == null) {
            currencyTranslations = new ArrayList<CurrencyTranslation>();
        }
        return this.currencyTranslations;
    }

    /**
     * Gets the value of the fqdoTextTranslations property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the fqdoTextTranslations property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getFqdoTextTranslations().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link FQDOTextTranslation }
     * 
     * 
     */
    public List<FQDOTextTranslation> getFqdoTextTranslations() {
        if (fqdoTextTranslations == null) {
            fqdoTextTranslations = new ArrayList<FQDOTextTranslation>();
        }
        return this.fqdoTextTranslations;
    }

    /**
     * Gets the value of the industryTranslations property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the industryTranslations property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getIndustryTranslations().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link IndustryTranslation }
     * 
     * 
     */
    public List<IndustryTranslation> getIndustryTranslations() {
        if (industryTranslations == null) {
            industryTranslations = new ArrayList<IndustryTranslation>();
        }
        return this.industryTranslations;
    }

}
