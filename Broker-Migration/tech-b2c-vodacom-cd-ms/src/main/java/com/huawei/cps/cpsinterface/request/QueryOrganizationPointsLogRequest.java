
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询组织积分变更流水的请求消息
 * 
 * <p>Java class for QueryOrganizationPointsLogRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryOrganizationPointsLogRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="PointType" minOccurs="0"&gt;
 *           &lt;simpleType&gt;
 *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *               &lt;maxLength value="128"/&gt;
 *             &lt;/restriction&gt;
 *           &lt;/simpleType&gt;
 *         &lt;/element&gt;
 *         &lt;element name="BeginDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
 *         &lt;element name="EndDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
 *         &lt;element name="ByPage"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="PageNumber" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
 *                   &lt;element name="PageSize" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
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
@XmlType(name = "QueryOrganizationPointsLogRequest", propOrder = {
    "pointType",
    "beginDate",
    "endDate",
    "byPage"
})
public class QueryOrganizationPointsLogRequest {

    @XmlElement(name = "PointType")
    protected String pointType;
    @XmlElement(name = "BeginDate", required = true)
    protected String beginDate;
    @XmlElement(name = "EndDate", required = true)
    protected String endDate;
    @XmlElement(name = "ByPage", required = true)
    protected QueryOrganizationPointsLogRequest.ByPage byPage;

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
     * Gets the value of the beginDate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBeginDate() {
        return beginDate;
    }

    /**
     * Sets the value of the beginDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBeginDate(String value) {
        this.beginDate = value;
    }

    /**
     * Gets the value of the endDate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getEndDate() {
        return endDate;
    }

    /**
     * Sets the value of the endDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setEndDate(String value) {
        this.endDate = value;
    }

    /**
     * Gets the value of the byPage property.
     * 
     * @return
     *     possible object is
     *     {@link QueryOrganizationPointsLogRequest.ByPage }
     *     
     */
    public QueryOrganizationPointsLogRequest.ByPage getByPage() {
        return byPage;
    }

    /**
     * Sets the value of the byPage property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryOrganizationPointsLogRequest.ByPage }
     *     
     */
    public void setByPage(QueryOrganizationPointsLogRequest.ByPage value) {
        this.byPage = value;
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
     *         &lt;element name="PageNumber" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
     *         &lt;element name="PageSize" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
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
        "pageNumber",
        "pageSize"
    })
    public static class ByPage {

        @XmlElement(name = "PageNumber")
        protected long pageNumber;
        @XmlElement(name = "PageSize")
        protected long pageSize;

        /**
         * Gets the value of the pageNumber property.
         * 
         */
        public long getPageNumber() {
            return pageNumber;
        }

        /**
         * Sets the value of the pageNumber property.
         * 
         */
        public void setPageNumber(long value) {
            this.pageNumber = value;
        }

        /**
         * Gets the value of the pageSize property.
         * 
         */
        public long getPageSize() {
            return pageSize;
        }

        /**
         * Sets the value of the pageSize property.
         * 
         */
        public void setPageSize(long value) {
            this.pageSize = value;
        }

    }

}
