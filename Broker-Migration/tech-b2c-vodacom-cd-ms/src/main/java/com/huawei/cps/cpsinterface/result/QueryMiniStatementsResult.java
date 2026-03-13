
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询Customer或Organization的账户明细
 * 
 * <p>Java class for QueryMiniStatementsResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryMiniStatementsResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="BOCompletedTime" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="MiniStatementListData"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="MiniStatementItem" type="{http://cps.huawei.com/cpsinterface/result}MiniStatementType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
@XmlType(name = "QueryMiniStatementsResult", propOrder = {
    "boCompletedTime",
    "miniStatementListData"
})
public class QueryMiniStatementsResult {

    @XmlElement(name = "BOCompletedTime", required = true)
    protected String boCompletedTime;
    @XmlElement(name = "MiniStatementListData", required = true)
    protected QueryMiniStatementsResult.MiniStatementListData miniStatementListData;

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
     * Gets the value of the miniStatementListData property.
     * 
     * @return
     *     possible object is
     *     {@link QueryMiniStatementsResult.MiniStatementListData }
     *     
     */
    public QueryMiniStatementsResult.MiniStatementListData getMiniStatementListData() {
        return miniStatementListData;
    }

    /**
     * Sets the value of the miniStatementListData property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryMiniStatementsResult.MiniStatementListData }
     *     
     */
    public void setMiniStatementListData(QueryMiniStatementsResult.MiniStatementListData value) {
        this.miniStatementListData = value;
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
     *         &lt;element name="MiniStatementItem" type="{http://cps.huawei.com/cpsinterface/result}MiniStatementType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "miniStatementItem"
    })
    public static class MiniStatementListData {

        @XmlElement(name = "MiniStatementItem")
        protected List<MiniStatementType> miniStatementItem;

        /**
         * Gets the value of the miniStatementItem property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the miniStatementItem property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getMiniStatementItem().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link MiniStatementType }
         * 
         * 
         */
        public List<MiniStatementType> getMiniStatementItem() {
            if (miniStatementItem == null) {
                miniStatementItem = new ArrayList<MiniStatementType>();
            }
            return this.miniStatementItem;
        }

    }

}
