
package com.moneygram.agentconnect1512;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for CodeTableResponse complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="CodeTableResponse"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Response"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="version" type="{http://www.moneygram.com/AgentConnect1512}stringMax20"/&gt;
 *         &lt;element name="stateProvinceInfo" type="{http://www.moneygram.com/AgentConnect1512}StateProvinceInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="countryInfo" type="{http://www.moneygram.com/AgentConnect1512}CountryInfo" maxOccurs="unbounded"/&gt;
 *         &lt;element name="currencyInfo" type="{http://www.moneygram.com/AgentConnect1512}CurrencyInfo" maxOccurs="unbounded"/&gt;
 *         &lt;element name="countryCurrencyInfo" type="{http://www.moneygram.com/AgentConnect1512}CountryCurrencyInfo" maxOccurs="unbounded"/&gt;
 *         &lt;element name="deliveryOptionInfo" type="{http://www.moneygram.com/AgentConnect1512}DeliveryOptionInfo" maxOccurs="unbounded"/&gt;
 *         &lt;element name="rewardsInfo" type="{http://www.moneygram.com/AgentConnect1512}RewardsInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="rewardsCardTypeInfo" type="{http://www.moneygram.com/AgentConnect1512}RewardsCardTypeInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="rewardsRegistrationInfo" type="{http://www.moneygram.com/AgentConnect1512}RewardsRegistrationInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "CodeTableResponse", propOrder = {
    "version",
    "stateProvinceInfo",
    "countryInfo",
    "currencyInfo",
    "countryCurrencyInfo",
    "deliveryOptionInfo",
    "rewardsInfo",
    "rewardsCardTypeInfo",
    "rewardsRegistrationInfo"
})
public class CodeTableResponse
    extends Response
{

    @XmlElement(required = true)
    protected String version;
    protected List<StateProvinceInfo> stateProvinceInfo;
    @XmlElement(required = true)
    protected List<CountryInfo> countryInfo;
    @XmlElement(required = true)
    protected List<CurrencyInfo> currencyInfo;
    @XmlElement(required = true)
    protected List<CountryCurrencyInfo> countryCurrencyInfo;
    @XmlElement(required = true)
    protected List<DeliveryOptionInfo> deliveryOptionInfo;
    protected List<RewardsInfo> rewardsInfo;
    protected List<RewardsCardTypeInfo> rewardsCardTypeInfo;
    protected List<RewardsRegistrationInfo> rewardsRegistrationInfo;

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
     * Gets the value of the stateProvinceInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the stateProvinceInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getStateProvinceInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link StateProvinceInfo }
     * 
     * 
     */
    public List<StateProvinceInfo> getStateProvinceInfo() {
        if (stateProvinceInfo == null) {
            stateProvinceInfo = new ArrayList<StateProvinceInfo>();
        }
        return this.stateProvinceInfo;
    }

    /**
     * Gets the value of the countryInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the countryInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getCountryInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link CountryInfo }
     * 
     * 
     */
    public List<CountryInfo> getCountryInfo() {
        if (countryInfo == null) {
            countryInfo = new ArrayList<CountryInfo>();
        }
        return this.countryInfo;
    }

    /**
     * Gets the value of the currencyInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the currencyInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getCurrencyInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link CurrencyInfo }
     * 
     * 
     */
    public List<CurrencyInfo> getCurrencyInfo() {
        if (currencyInfo == null) {
            currencyInfo = new ArrayList<CurrencyInfo>();
        }
        return this.currencyInfo;
    }

    /**
     * Gets the value of the countryCurrencyInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the countryCurrencyInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getCountryCurrencyInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link CountryCurrencyInfo }
     * 
     * 
     */
    public List<CountryCurrencyInfo> getCountryCurrencyInfo() {
        if (countryCurrencyInfo == null) {
            countryCurrencyInfo = new ArrayList<CountryCurrencyInfo>();
        }
        return this.countryCurrencyInfo;
    }

    /**
     * Gets the value of the deliveryOptionInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the deliveryOptionInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getDeliveryOptionInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link DeliveryOptionInfo }
     * 
     * 
     */
    public List<DeliveryOptionInfo> getDeliveryOptionInfo() {
        if (deliveryOptionInfo == null) {
            deliveryOptionInfo = new ArrayList<DeliveryOptionInfo>();
        }
        return this.deliveryOptionInfo;
    }

    /**
     * Gets the value of the rewardsInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the rewardsInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getRewardsInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link RewardsInfo }
     * 
     * 
     */
    public List<RewardsInfo> getRewardsInfo() {
        if (rewardsInfo == null) {
            rewardsInfo = new ArrayList<RewardsInfo>();
        }
        return this.rewardsInfo;
    }

    /**
     * Gets the value of the rewardsCardTypeInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the rewardsCardTypeInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getRewardsCardTypeInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link RewardsCardTypeInfo }
     * 
     * 
     */
    public List<RewardsCardTypeInfo> getRewardsCardTypeInfo() {
        if (rewardsCardTypeInfo == null) {
            rewardsCardTypeInfo = new ArrayList<RewardsCardTypeInfo>();
        }
        return this.rewardsCardTypeInfo;
    }

    /**
     * Gets the value of the rewardsRegistrationInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the rewardsRegistrationInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getRewardsRegistrationInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link RewardsRegistrationInfo }
     * 
     * 
     */
    public List<RewardsRegistrationInfo> getRewardsRegistrationInfo() {
        if (rewardsRegistrationInfo == null) {
            rewardsRegistrationInfo = new ArrayList<RewardsRegistrationInfo>();
        }
        return this.rewardsRegistrationInfo;
    }

}
