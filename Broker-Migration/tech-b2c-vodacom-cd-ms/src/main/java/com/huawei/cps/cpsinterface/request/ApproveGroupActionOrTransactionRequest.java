
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Customer审批Group交易或BO
 * 
 * <p>Java class for ApproveGroupActionOrTransactionRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="ApproveGroupActionOrTransactionRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="ApprovalID" type="{http://cps.huawei.com/cpsinterface/common}ReceiptNumberType"/&gt;
 *         &lt;element name="GroupCode" type="{http://cps.huawei.com/cpsinterface/common}GroupCodeType"/&gt;
 *         &lt;element name="OperationType"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;length value="1"/&gt;
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
@XmlType(name = "ApproveGroupActionOrTransactionRequest", propOrder = {
    "approvalID",
    "groupCode",
    "operationType"
})
public class ApproveGroupActionOrTransactionRequest {

    @XmlElement(name = "ApprovalID", required = true)
    protected String approvalID;
    @XmlElement(name = "GroupCode", required = true)
    protected String groupCode;
    @XmlElement(name = "OperationType", required = true)
    protected String operationType;

    /**
     * Gets the value of the approvalID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getApprovalID() {
        return approvalID;
    }

    /**
     * Sets the value of the approvalID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setApprovalID(String value) {
        this.approvalID = value;
    }

    /**
     * Gets the value of the groupCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getGroupCode() {
        return groupCode;
    }

    /**
     * Sets the value of the groupCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setGroupCode(String value) {
        this.groupCode = value;
    }

    /**
     * Gets the value of the operationType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOperationType() {
        return operationType;
    }

    /**
     * Sets the value of the operationType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOperationType(String value) {
        this.operationType = value;
    }

}
