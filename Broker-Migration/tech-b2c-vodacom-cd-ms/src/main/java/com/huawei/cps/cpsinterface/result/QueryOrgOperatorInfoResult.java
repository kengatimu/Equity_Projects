
package com.huawei.cps.cpsinterface.result;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询OrgOperator的基本信息
 * 
 * <p>Java class for QueryOrgOperatorInfoResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryOrgOperatorInfoResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="OrgOperatorBasicData" type="{http://cps.huawei.com/cpsinterface/result}OrgOperatorInfoType"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "QueryOrgOperatorInfoResult", propOrder = {
    "boCompletedTime",
    "orgOperatorBasicData"
})
public class QueryOrgOperatorInfoResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "OrgOperatorBasicData", required = true)
    protected OrgOperatorInfoType orgOperatorBasicData;

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
     * Gets the value of the orgOperatorBasicData property.
     * 
     * @return
     *     possible object is
     *     {@link OrgOperatorInfoType }
     *     
     */
    public OrgOperatorInfoType getOrgOperatorBasicData() {
        return orgOperatorBasicData;
    }

    /**
     * Sets the value of the orgOperatorBasicData property.
     * 
     * @param value
     *     allowed object is
     *     {@link OrgOperatorInfoType }
     *     
     */
    public void setOrgOperatorBasicData(OrgOperatorInfoType value) {
        this.orgOperatorBasicData = value;
    }

}
