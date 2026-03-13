
package com.huawei.cps.cpsinterface.result;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 删除Organization的O2CLink
 * 
 * <p>Java class for DeleteO2CLinkResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="DeleteO2CLinkResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="O2CLinkResultData" type="{http://cps.huawei.com/cpsinterface/result}O2CLinkResultDataType"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "DeleteO2CLinkResult", propOrder = {
    "boCompletedTime",
    "o2CLinkResultData"
})
public class DeleteO2CLinkResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "O2CLinkResultData", required = true)
    protected O2CLinkResultDataType o2CLinkResultData;

    /**
     * Gets the value of the boCompletedTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBOCompletedTime() {
        return boCompletedTime;
    }

    /**
     * Sets the value of the boCompletedTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBOCompletedTime(String value) {
        this.boCompletedTime = value;
    }

    /**
     * Gets the value of the o2CLinkResultData property.
     * 
     * @return
     *     possible object is
     *     {@link O2CLinkResultDataType }
     *     
     */
    public O2CLinkResultDataType getO2CLinkResultData() {
        return o2CLinkResultData;
    }

    /**
     * Sets the value of the o2CLinkResultData property.
     * 
     * @param value
     *     allowed object is
     *     {@link O2CLinkResultDataType }
     *     
     */
    public void setO2CLinkResultData(O2CLinkResultDataType value) {
        this.o2CLinkResultData = value;
    }

}
