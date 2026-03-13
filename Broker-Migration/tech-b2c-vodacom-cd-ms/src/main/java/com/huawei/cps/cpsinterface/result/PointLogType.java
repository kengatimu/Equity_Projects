
package com.huawei.cps.cpsinterface.result;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 积分变更流水的数据类型定义
 * 
 * <p>Java class for PointLogType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="PointLogType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="PointLogID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="IdentityID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="PointType"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="128"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="PointID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="CreateTime" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
 *         &lt;element name="Amount" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
 *         &lt;element name="BeforeBalance" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
 *         &lt;element name="AfterBalance" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
 *         &lt;element name="ChangeType"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;minLength value="1"/&gt;
 *               &lt;maxLength value="2"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="Remark"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="1000"/&gt;
 *               &lt;minLength value="0"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="ChangeReason"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="512"/&gt;
 *               &lt;minLength value="0"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="InitiatorID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="InitiatorIdentityType"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="4"/&gt;
 *               &lt;minLength value="4"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="OrderID"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="22"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="TransactionID"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="22"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="EventType"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="64"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="ExpiredDate" type="{http://cps.huawei.com/cpsinterface/common}Date" minOccurs="0"/&gt;
 *         &lt;element name="ClientBusiNo" minOccurs="0"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="22"/&gt;
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
@XmlType(name = "PointLogType", propOrder = {
    "pointLogID",
    "identityID",
    "pointType",
    "pointID",
    "createTime",
    "amount",
    "beforeBalance",
    "afterBalance",
    "changeType",
    "remark",
    "changeReason",
    "initiatorID",
    "initiatorIdentityType",
    "orderID",
    "transactionID",
    "eventType",
    "expiredDate",
    "clientBusiNo"
})
public class PointLogType {

    @XmlElement(name = "PointLogID", required = true)
    protected String pointLogID;
    @XmlElement(name = "IdentityID", required = true)
    protected String identityID;
    @XmlElement(name = "PointType", required = true)
    protected String pointType;
    @XmlElement(name = "PointID", required = true)
    protected String pointID;
    @XmlElement(name = "CreateTime", required = true)
    protected String createTime;
    @XmlElement(name = "Amount")
    protected long amount;
    @XmlElement(name = "BeforeBalance")
    protected long beforeBalance;
    @XmlElement(name = "AfterBalance")
    protected long afterBalance;
    @XmlElement(name = "ChangeType", required = true)
    protected String changeType;
    @XmlElement(name = "Remark", required = true)
    protected String remark;
    @XmlElement(name = "ChangeReason", required = true)
    protected String changeReason;
    @XmlElement(name = "InitiatorID", required = true)
    protected String initiatorID;
    @XmlElement(name = "InitiatorIdentityType", required = true)
    protected String initiatorIdentityType;
    @XmlElement(name = "OrderID", required = true)
    protected String orderID;
    @XmlElement(name = "TransactionID", required = true)
    protected String transactionID;
    @XmlElement(name = "EventType", required = true)
    protected String eventType;
    @XmlElement(name = "ExpiredDate")
    protected String expiredDate;
    @XmlElement(name = "ClientBusiNo")
    protected String clientBusiNo;

    /**
     * Gets the value of the pointLogID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPointLogID() {
        return pointLogID;
    }

    /**
     * Sets the value of the pointLogID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPointLogID(String value) {
        this.pointLogID = value;
    }

    /**
     * Gets the value of the identityID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getIdentityID() {
        return identityID;
    }

    /**
     * Sets the value of the identityID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setIdentityID(String value) {
        this.identityID = value;
    }

    /**
     * Gets the value of the pointType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPointType() {
        return pointType;
    }

    /**
     * Sets the value of the pointType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPointType(String value) {
        this.pointType = value;
    }

    /**
     * Gets the value of the pointID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPointID() {
        return pointID;
    }

    /**
     * Sets the value of the pointID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPointID(String value) {
        this.pointID = value;
    }

    /**
     * Gets the value of the createTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCreateTime() {
        return createTime;
    }

    /**
     * Sets the value of the createTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCreateTime(String value) {
        this.createTime = value;
    }

    /**
     * Gets the value of the amount property.
     * 
     */
    public long getAmount() {
        return amount;
    }

    /**
     * Sets the value of the amount property.
     * 
     */
    public void setAmount(long value) {
        this.amount = value;
    }

    /**
     * Gets the value of the beforeBalance property.
     * 
     */
    public long getBeforeBalance() {
        return beforeBalance;
    }

    /**
     * Sets the value of the beforeBalance property.
     * 
     */
    public void setBeforeBalance(long value) {
        this.beforeBalance = value;
    }

    /**
     * Gets the value of the afterBalance property.
     * 
     */
    public long getAfterBalance() {
        return afterBalance;
    }

    /**
     * Sets the value of the afterBalance property.
     * 
     */
    public void setAfterBalance(long value) {
        this.afterBalance = value;
    }

    /**
     * Gets the value of the changeType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getChangeType() {
        return changeType;
    }

    /**
     * Sets the value of the changeType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setChangeType(String value) {
        this.changeType = value;
    }

    /**
     * Gets the value of the remark property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRemark() {
        return remark;
    }

    /**
     * Sets the value of the remark property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRemark(String value) {
        this.remark = value;
    }

    /**
     * Gets the value of the changeReason property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getChangeReason() {
        return changeReason;
    }

    /**
     * Sets the value of the changeReason property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setChangeReason(String value) {
        this.changeReason = value;
    }

    /**
     * Gets the value of the initiatorID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getInitiatorID() {
        return initiatorID;
    }

    /**
     * Sets the value of the initiatorID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setInitiatorID(String value) {
        this.initiatorID = value;
    }

    /**
     * Gets the value of the initiatorIdentityType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getInitiatorIdentityType() {
        return initiatorIdentityType;
    }

    /**
     * Sets the value of the initiatorIdentityType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setInitiatorIdentityType(String value) {
        this.initiatorIdentityType = value;
    }

    /**
     * Gets the value of the orderID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOrderID() {
        return orderID;
    }

    /**
     * Sets the value of the orderID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOrderID(String value) {
        this.orderID = value;
    }

    /**
     * Gets the value of the transactionID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTransactionID() {
        return transactionID;
    }

    /**
     * Sets the value of the transactionID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTransactionID(String value) {
        this.transactionID = value;
    }

    /**
     * Gets the value of the eventType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getEventType() {
        return eventType;
    }

    /**
     * Sets the value of the eventType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setEventType(String value) {
        this.eventType = value;
    }

    /**
     * Gets the value of the expiredDate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getExpiredDate() {
        return expiredDate;
    }

    /**
     * Sets the value of the expiredDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setExpiredDate(String value) {
        this.expiredDate = value;
    }

    /**
     * Gets the value of the clientBusiNo property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getClientBusiNo() {
        return clientBusiNo;
    }

    /**
     * Sets the value of the clientBusiNo property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setClientBusiNo(String value) {
        this.clientBusiNo = value;
    }

}
