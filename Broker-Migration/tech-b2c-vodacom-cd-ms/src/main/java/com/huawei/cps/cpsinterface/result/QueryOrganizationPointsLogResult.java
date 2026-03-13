
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询组织积分变更流水的结果消息
 * 
 * <p>Java class for QueryOrganizationPointsLogResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryOrganizationPointsLogResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="PointLogList" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="PointLog" type="{http://cps.huawei.com/cpsinterface/result}PointLogType" maxOccurs="100"/&gt;
 *                 &lt;/sequence&gt;
 *               &lt;/restriction&gt;
 *             &lt;/complexContent&gt;
 *           &lt;/complexType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="TotalRecords" type="{http://www.w3.org/2001/XMLSchema}long" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "QueryOrganizationPointsLogResult", propOrder = {
    "pointLogList",
    "totalRecords"
})
public class QueryOrganizationPointsLogResult {

    @XmlElement(name = "PointLogList")
    protected QueryOrganizationPointsLogResult.PointLogList pointLogList;
    @XmlElement(name = "TotalRecords")
    protected Long totalRecords;

    /**
     * Gets the value of the pointLogList property.
     * 
     * @return
     *     possible object is
     *     {@link QueryOrganizationPointsLogResult.PointLogList }
     *     
     */
    public QueryOrganizationPointsLogResult.PointLogList getPointLogList() {
        return pointLogList;
    }

    /**
     * Sets the value of the pointLogList property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryOrganizationPointsLogResult.PointLogList }
     *     
     */
    public void setPointLogList(QueryOrganizationPointsLogResult.PointLogList value) {
        this.pointLogList = value;
    }

    /**
     * Gets the value of the totalRecords property.
     * 
     * @return
     *     possible object is
     *     {@link Long }
     *     
     */
    public Long getTotalRecords() {
        return totalRecords;
    }

    /**
     * Sets the value of the totalRecords property.
     * 
     * @param value
     *     allowed object is
     *     {@link Long }
     *     
     */
    public void setTotalRecords(Long value) {
        this.totalRecords = value;
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
     *         &lt;element name="PointLog" type="{http://cps.huawei.com/cpsinterface/result}PointLogType" maxOccurs="100"/&gt;
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
        "pointLog"
    })
    public static class PointLogList {

        @XmlElement(name = "PointLog", required = true)
        protected List<PointLogType> pointLog;

        /**
         * Gets the value of the pointLog property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the pointLog property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getPointLog().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link PointLogType }
         * 
         * 
         */
        public List<PointLogType> getPointLog() {
            if (pointLog == null) {
                pointLog = new ArrayList<PointLogType>();
            }
            return this.pointLog;
        }

    }

}
