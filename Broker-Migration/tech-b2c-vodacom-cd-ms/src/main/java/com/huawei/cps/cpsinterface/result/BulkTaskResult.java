
package com.huawei.cps.cpsinterface.result;

import java.math.BigInteger;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 批量任务的结果消息
 * 
 * <p>Java class for BulkTaskResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="BulkTaskResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="ReportFilePath" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="SuccessRecords" type="{http://www.w3.org/2001/XMLSchema}integer"/&gt;
 *         &lt;element name="InvalidRecords" type="{http://www.w3.org/2001/XMLSchema}integer"/&gt;
 *         &lt;element name="FailureRecords" type="{http://www.w3.org/2001/XMLSchema}integer"/&gt;
 *         &lt;element name="PaymentAmount" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="FeeAmount" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "BulkTaskResult", propOrder = {
    "reportFilePath",
    "successRecords",
    "invalidRecords",
    "failureRecords",
    "paymentAmount",
    "feeAmount"
})
public class BulkTaskResult {

    @XmlElement(name = "ReportFilePath", required = true)
    protected String reportFilePath;
    @XmlElement(name = "SuccessRecords", required = true)
    protected BigInteger successRecords;
    @XmlElement(name = "InvalidRecords", required = true)
    protected BigInteger invalidRecords;
    @XmlElement(name = "FailureRecords", required = true)
    protected BigInteger failureRecords;
    @XmlElement(name = "PaymentAmount", required = true)
    protected String paymentAmount;
    @XmlElement(name = "FeeAmount", required = true)
    protected String feeAmount;

    /**
     * Gets the value of the reportFilePath property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReportFilePath() {
        return reportFilePath;
    }

    /**
     * Sets the value of the reportFilePath property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReportFilePath(String value) {
        this.reportFilePath = value;
    }

    /**
     * Gets the value of the successRecords property.
     * 
     * @return
     *     possible object is
     *     {@link BigInteger }
     *     
     */
    public BigInteger getSuccessRecords() {
        return successRecords;
    }

    /**
     * Sets the value of the successRecords property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigInteger }
     *     
     */
    public void setSuccessRecords(BigInteger value) {
        this.successRecords = value;
    }

    /**
     * Gets the value of the invalidRecords property.
     * 
     * @return
     *     possible object is
     *     {@link BigInteger }
     *     
     */
    public BigInteger getInvalidRecords() {
        return invalidRecords;
    }

    /**
     * Sets the value of the invalidRecords property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigInteger }
     *     
     */
    public void setInvalidRecords(BigInteger value) {
        this.invalidRecords = value;
    }

    /**
     * Gets the value of the failureRecords property.
     * 
     * @return
     *     possible object is
     *     {@link BigInteger }
     *     
     */
    public BigInteger getFailureRecords() {
        return failureRecords;
    }

    /**
     * Sets the value of the failureRecords property.
     * 
     * @param value
     *     allowed object is
     *     {@link BigInteger }
     *     
     */
    public void setFailureRecords(BigInteger value) {
        this.failureRecords = value;
    }

    /**
     * Gets the value of the paymentAmount property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getPaymentAmount() {
        return paymentAmount;
    }

    /**
     * Sets the value of the paymentAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setPaymentAmount(String value) {
        this.paymentAmount = value;
    }

    /**
     * Gets the value of the feeAmount property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFeeAmount() {
        return feeAmount;
    }

    /**
     * Sets the value of the feeAmount property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFeeAmount(String value) {
        this.feeAmount = value;
    }

}
