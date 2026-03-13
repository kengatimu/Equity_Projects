
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import com.huawei.cps.cpsinterface.common.ParameterType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 交易详情类型
 * 
 * <p>Java class for TransactionDetailType complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="TransactionDetailType"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="ReceiptNumber" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="TransactionStatus" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="TransactionType" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="ReasonType" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="Service" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="Channel" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="InitiatorGroupCode" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="InitiatorGroupMemberRole" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="Currency" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="Amount" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="Remark" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="FailureDescription" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="InitiatedTime" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
 *         &lt;element name="FinalizedTime" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
 *         &lt;element name="AccountStatmentList"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="AccountStatementItem" type="{http://cps.huawei.com/cpsinterface/result}AccountStatementType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="AuditEventList"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="AuditEventItem" type="{http://cps.huawei.com/cpsinterface/result}AuditEventType" maxOccurs="unbounded"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="TransactionNoteList"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="TransactionNoteItem" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded" minOccurs="0"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="LinkedTransactionList"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="TransactionItem" maxOccurs="unbounded" minOccurs="0"&gt;
 *                     &lt;complexType&gt;
 *                       &lt;complexContent&gt;
 *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                           &lt;sequence&gt;
 *                             &lt;element name="ReceiptNumber" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *                           &lt;/sequence&gt;
 *                         &lt;/restriction&gt;
 *                       &lt;/complexContent&gt;
 *                     &lt;/complexType&gt;
 *                   &lt;/element&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
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
@XmlType(name = "TransactionDetailType", propOrder = {
    "receiptNumber",
    "transactionStatus",
    "transactionType",
    "reasonType",
    "service",
    "channel",
    "initiatorGroupCode",
    "initiatorGroupMemberRole",
    "currency",
    "amount",
    "remark",
    "failureDescription",
    "initiatedTime",
    "finalizedTime",
    "accountStatmentList",
    "auditEventList",
    "transactionNoteList",
    "linkedTransactionList"
})
public class TransactionDetailType {

    @XmlElement(name = "ReceiptNumber", required = true)
    protected String receiptNumber;
    @XmlElement(name = "TransactionStatus", required = true)
    protected String transactionStatus;
    @XmlElement(name = "TransactionType", required = true)
    protected String transactionType;
    @XmlElement(name = "ReasonType", required = true)
    protected String reasonType;
    @XmlElement(name = "Service", required = true)
    protected String service;
    @XmlElement(name = "Channel", required = true)
    protected String channel;
    @XmlElement(name = "InitiatorGroupCode")
    protected String initiatorGroupCode;
    @XmlElement(name = "InitiatorGroupMemberRole")
    protected String initiatorGroupMemberRole;
    @XmlElement(name = "Currency", required = true)
    protected String currency;
    @XmlElement(name = "Amount", required = true)
    protected String amount;
    @XmlElement(name = "Remark", required = true)
    protected String remark;
    @XmlElement(name = "FailureDescription")
    protected String failureDescription;
    @XmlElement(name = "InitiatedTime", required = true)
    protected String initiatedTime;
    @XmlElement(name = "FinalizedTime", required = true)
    protected String finalizedTime;
    @XmlElement(name = "AccountStatmentList", required = true)
    protected TransactionDetailType.AccountStatmentList accountStatmentList;
    @XmlElement(name = "AuditEventList", required = true)
    protected TransactionDetailType.AuditEventList auditEventList;
    @XmlElement(name = "TransactionNoteList", required = true)
    protected TransactionDetailType.TransactionNoteList transactionNoteList;
    @XmlElement(name = "LinkedTransactionList", required = true)
    protected TransactionDetailType.LinkedTransactionList linkedTransactionList;

    /**
     * Gets the value of the receiptNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReceiptNumber() {
        return receiptNumber;
    }

    /**
     * Sets the value of the receiptNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReceiptNumber(String value) {
        this.receiptNumber = value;
    }

    /**
     * Gets the value of the transactionStatus property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTransactionStatus() {
        return transactionStatus;
    }

    /**
     * Sets the value of the transactionStatus property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTransactionStatus(String value) {
        this.transactionStatus = value;
    }

    /**
     * Gets the value of the transactionType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTransactionType() {
        return transactionType;
    }

    /**
     * Sets the value of the transactionType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTransactionType(String value) {
        this.transactionType = value;
    }

    /**
     * Gets the value of the reasonType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReasonType() {
        return reasonType;
    }

    /**
     * Sets the value of the reasonType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReasonType(String value) {
        this.reasonType = value;
    }

    /**
     * Gets the value of the service property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getService() {
        return service;
    }

    /**
     * Sets the value of the service property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setService(String value) {
        this.service = value;
    }

    /**
     * Gets the value of the channel property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getChannel() {
        return channel;
    }

    /**
     * Sets the value of the channel property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setChannel(String value) {
        this.channel = value;
    }

    /**
     * Gets the value of the initiatorGroupCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getInitiatorGroupCode() {
        return initiatorGroupCode;
    }

    /**
     * Sets the value of the initiatorGroupCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setInitiatorGroupCode(String value) {
        this.initiatorGroupCode = value;
    }

    /**
     * Gets the value of the initiatorGroupMemberRole property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getInitiatorGroupMemberRole() {
        return initiatorGroupMemberRole;
    }

    /**
     * Sets the value of the initiatorGroupMemberRole property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setInitiatorGroupMemberRole(String value) {
        this.initiatorGroupMemberRole = value;
    }

    /**
     * Gets the value of the currency property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCurrency() {
        return currency;
    }

    /**
     * Sets the value of the currency property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCurrency(String value) {
        this.currency = value;
    }

    /**
     * Gets the value of the amount property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAmount() {
        return amount;
    }

    /**
     * Sets the value of the amount property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAmount(String value) {
        this.amount = value;
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
     * Gets the value of the failureDescription property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFailureDescription() {
        return failureDescription;
    }

    /**
     * Sets the value of the failureDescription property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFailureDescription(String value) {
        this.failureDescription = value;
    }

    /**
     * Gets the value of the initiatedTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getInitiatedTime() {
        return initiatedTime;
    }

    /**
     * Sets the value of the initiatedTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setInitiatedTime(String value) {
        this.initiatedTime = value;
    }

    /**
     * Gets the value of the finalizedTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFinalizedTime() {
        return finalizedTime;
    }

    /**
     * Sets the value of the finalizedTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFinalizedTime(String value) {
        this.finalizedTime = value;
    }

    /**
     * Gets the value of the accountStatmentList property.
     * 
     * @return
     *     possible object is
     *     {@link TransactionDetailType.AccountStatmentList }
     *     
     */
    public TransactionDetailType.AccountStatmentList getAccountStatmentList() {
        return accountStatmentList;
    }

    /**
     * Sets the value of the accountStatmentList property.
     * 
     * @param value
     *     allowed object is
     *     {@link TransactionDetailType.AccountStatmentList }
     *     
     */
    public void setAccountStatmentList(TransactionDetailType.AccountStatmentList value) {
        this.accountStatmentList = value;
    }

    /**
     * Gets the value of the auditEventList property.
     * 
     * @return
     *     possible object is
     *     {@link TransactionDetailType.AuditEventList }
     *     
     */
    public TransactionDetailType.AuditEventList getAuditEventList() {
        return auditEventList;
    }

    /**
     * Sets the value of the auditEventList property.
     * 
     * @param value
     *     allowed object is
     *     {@link TransactionDetailType.AuditEventList }
     *     
     */
    public void setAuditEventList(TransactionDetailType.AuditEventList value) {
        this.auditEventList = value;
    }

    /**
     * Gets the value of the transactionNoteList property.
     * 
     * @return
     *     possible object is
     *     {@link TransactionDetailType.TransactionNoteList }
     *     
     */
    public TransactionDetailType.TransactionNoteList getTransactionNoteList() {
        return transactionNoteList;
    }

    /**
     * Sets the value of the transactionNoteList property.
     * 
     * @param value
     *     allowed object is
     *     {@link TransactionDetailType.TransactionNoteList }
     *     
     */
    public void setTransactionNoteList(TransactionDetailType.TransactionNoteList value) {
        this.transactionNoteList = value;
    }

    /**
     * Gets the value of the linkedTransactionList property.
     * 
     * @return
     *     possible object is
     *     {@link TransactionDetailType.LinkedTransactionList }
     *     
     */
    public TransactionDetailType.LinkedTransactionList getLinkedTransactionList() {
        return linkedTransactionList;
    }

    /**
     * Sets the value of the linkedTransactionList property.
     * 
     * @param value
     *     allowed object is
     *     {@link TransactionDetailType.LinkedTransactionList }
     *     
     */
    public void setLinkedTransactionList(TransactionDetailType.LinkedTransactionList value) {
        this.linkedTransactionList = value;
    }


    /**
     * <p>Java class for anonymous complex type.
     * 
     * <p>The following schema fragment specifies the expected content contained within this class.
     * 
     * <pre>
     * &lt;complexType&gt;
     *   &lt;complexContent&gt;
     *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *       &lt;sequence&gt;
     *         &lt;element name="AccountStatementItem" type="{http://cps.huawei.com/cpsinterface/result}AccountStatementType" maxOccurs="unbounded" minOccurs="0"/&gt;
     *       &lt;/sequence&gt;
     *     &lt;/restriction&gt;
     *   &lt;/complexContent&gt;
     * &lt;/complexType&gt;
     * </pre>
     * 
     * 
     */
    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "", propOrder = {
        "accountStatementItem"
    })
    public static class AccountStatmentList {

        @XmlElement(name = "AccountStatementItem")
        protected List<AccountStatementType> accountStatementItem;

        /**
         * Gets the value of the accountStatementItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the accountStatementItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getAccountStatementItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link AccountStatementType }
         * 
         * 
         */
        public List<AccountStatementType> getAccountStatementItem() {
            if (accountStatementItem == null) {
                accountStatementItem = new ArrayList<AccountStatementType>();
            }
            return this.accountStatementItem;
        }

    }


    /**
     * <p>Java class for anonymous complex type.
     * 
     * <p>The following schema fragment specifies the expected content contained within this class.
     * 
     * <pre>
     * &lt;complexType&gt;
     *   &lt;complexContent&gt;
     *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *       &lt;sequence&gt;
     *         &lt;element name="AuditEventItem" type="{http://cps.huawei.com/cpsinterface/result}AuditEventType" maxOccurs="unbounded"/&gt;
     *       &lt;/sequence&gt;
     *     &lt;/restriction&gt;
     *   &lt;/complexContent&gt;
     * &lt;/complexType&gt;
     * </pre>
     * 
     * 
     */
    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "", propOrder = {
        "auditEventItem"
    })
    public static class AuditEventList {

        @XmlElement(name = "AuditEventItem", required = true)
        protected List<AuditEventType> auditEventItem;

        /**
         * Gets the value of the auditEventItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the auditEventItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getAuditEventItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link AuditEventType }
         * 
         * 
         */
        public List<AuditEventType> getAuditEventItem() {
            if (auditEventItem == null) {
                auditEventItem = new ArrayList<AuditEventType>();
            }
            return this.auditEventItem;
        }

    }


    /**
     * <p>Java class for anonymous complex type.
     * 
     * <p>The following schema fragment specifies the expected content contained within this class.
     * 
     * <pre>
     * &lt;complexType&gt;
     *   &lt;complexContent&gt;
     *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *       &lt;sequence&gt;
     *         &lt;element name="TransactionItem" maxOccurs="unbounded" minOccurs="0"&gt;
     *           &lt;complexType&gt;
     *             &lt;complexContent&gt;
     *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                 &lt;sequence&gt;
     *                   &lt;element name="ReceiptNumber" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
     *                 &lt;/sequence&gt;
     *               &lt;/restriction&gt;
     *             &lt;/complexContent&gt;
     *           &lt;/complexType&gt;
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
    @XmlType(name = "", propOrder = {
        "transactionItem"
    })
    public static class LinkedTransactionList {

        @XmlElement(name = "TransactionItem")
        protected List<TransactionDetailType.LinkedTransactionList.TransactionItem> transactionItem;

        /**
         * Gets the value of the transactionItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the transactionItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getTransactionItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link TransactionDetailType.LinkedTransactionList.TransactionItem }
         * 
         * 
         */
        public List<TransactionDetailType.LinkedTransactionList.TransactionItem> getTransactionItem() {
            if (transactionItem == null) {
                transactionItem = new ArrayList<TransactionDetailType.LinkedTransactionList.TransactionItem>();
            }
            return this.transactionItem;
        }


        /**
         * <p>Java class for anonymous complex type.
         * 
         * <p>The following schema fragment specifies the expected content contained within this class.
         * 
         * <pre>
         * &lt;complexType&gt;
         *   &lt;complexContent&gt;
         *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
         *       &lt;sequence&gt;
         *         &lt;element name="ReceiptNumber" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
         *       &lt;/sequence&gt;
         *     &lt;/restriction&gt;
         *   &lt;/complexContent&gt;
         * &lt;/complexType&gt;
         * </pre>
         * 
         * 
         */
        @XmlAccessorType(XmlAccessType.FIELD)
        @XmlType(name = "", propOrder = {
            "receiptNumber"
        })
        public static class TransactionItem {

            @XmlElement(name = "ReceiptNumber", required = true)
            protected String receiptNumber;

            /**
             * Gets the value of the receiptNumber property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getReceiptNumber() {
                return receiptNumber;
            }

            /**
             * Sets the value of the receiptNumber property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setReceiptNumber(String value) {
                this.receiptNumber = value;
            }

        }

    }


    /**
     * <p>Java class for anonymous complex type.
     * 
     * <p>The following schema fragment specifies the expected content contained within this class.
     * 
     * <pre>
     * &lt;complexType&gt;
     *   &lt;complexContent&gt;
     *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *       &lt;sequence&gt;
     *         &lt;element name="TransactionNoteItem" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded" minOccurs="0"/&gt;
     *       &lt;/sequence&gt;
     *     &lt;/restriction&gt;
     *   &lt;/complexContent&gt;
     * &lt;/complexType&gt;
     * </pre>
     * 
     * 
     */
    @XmlAccessorType(XmlAccessType.FIELD)
    @XmlType(name = "", propOrder = {
        "transactionNoteItem"
    })
    public static class TransactionNoteList {

        @XmlElement(name = "TransactionNoteItem")
        protected List<ParameterType> transactionNoteItem;

        /**
         * Gets the value of the transactionNoteItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the transactionNoteItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getTransactionNoteItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link ParameterType }
         * 
         * 
         */
        public List<ParameterType> getTransactionNoteItem() {
            if (transactionNoteItem == null) {
                transactionNoteItem = new ArrayList<ParameterType>();
            }
            return this.transactionNoteItem;
        }

    }

}
