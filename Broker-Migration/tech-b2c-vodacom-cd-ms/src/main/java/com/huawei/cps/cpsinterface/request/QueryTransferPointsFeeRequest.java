
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询积分转帐手续费的请求消息
 * 
 * <p>Java class for QueryTransferPointsFeeRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryTransferPointsFeeRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="TransferAmount" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
 *         &lt;element name="PointTypeId" minOccurs="0"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="128"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "QueryTransferPointsFeeRequest", propOrder = {
    "transferAmount",
    "pointTypeId"
})
public class QueryTransferPointsFeeRequest {

    @XmlElement(name = "TransferAmount")
    protected long transferAmount;
    @XmlElement(name = "PointTypeId")
    protected String pointTypeId;

    /**
     * Gets the value of the transferAmount property.
     * 
     */
    public long getTransferAmount() {
        return transferAmount;
    }

    /**
     * Sets the value of the transferAmount property.
     * 
     */
    public void setTransferAmount(long value) {
        this.transferAmount = value;
    }

    /**
     * Gets the value of the pointTypeId property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPointTypeId() {
        return pointTypeId;
    }

    /**
     * Sets the value of the pointTypeId property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPointTypeId(String value) {
        this.pointTypeId = value;
    }

}
