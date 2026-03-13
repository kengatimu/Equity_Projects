
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 查询组织积分的结果消息
 * 
 * <p>Java class for QueryOrganizationPointsResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="QueryOrganizationPointsResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="PointsList" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="Point" maxOccurs="unbounded"&gt;
 *                     &lt;complexType&gt;
 *                       &lt;complexContent&gt;
 *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                           &lt;sequence&gt;
 *                             &lt;element name="IdentityID" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
 *                             &lt;element name="PointID" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
 *                             &lt;element name="PointType"&gt;
 *                               &lt;simpleType&gt;
 *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                   &lt;maxLength value="128"/&gt;
 *                                 &lt;/restriction&gt;
 *                               &lt;/simpleType&gt;
 *                             &lt;/element&gt;
 *                             &lt;element name="PointBalance" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
 *                             &lt;element name="Status"&gt;
 *                               &lt;simpleType&gt;
 *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                   &lt;minLength value="1"/&gt;
 *                                   &lt;maxLength value="1"/&gt;
 *                                 &lt;/restriction&gt;
 *                               &lt;/simpleType&gt;
 *                             &lt;/element&gt;
 *                             &lt;element name="OpenDate" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
 *                             &lt;element name="CloseDate" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
 *                             &lt;element name="LastUpdateTime" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
 *                             &lt;element name="BalanceLastTime" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
 *                             &lt;element name="StatusLastTime" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
 *                             &lt;element name="ExpiredDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
 *                           &lt;/sequence&gt;
 *                         &lt;/restriction&gt;
 *                       &lt;/complexContent&gt;
 *                     &lt;/complexType&gt;
 *                   &lt;/element&gt;
 *                   &lt;element name="PointSummary" maxOccurs="unbounded" minOccurs="0"&gt;
 *                     &lt;complexType&gt;
 *                       &lt;complexContent&gt;
 *                         &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                           &lt;sequence&gt;
 *                             &lt;element name="PointType"&gt;
 *                               &lt;simpleType&gt;
 *                                 &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
 *                                   &lt;maxLength value="128"/&gt;
 *                                 &lt;/restriction&gt;
 *                               &lt;/simpleType&gt;
 *                             &lt;/element&gt;
 *                             &lt;element name="TotalPoint" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
 *                             &lt;element name="ExpiredAmountCurrMonth" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
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
@XmlType(name = "QueryOrganizationPointsResult", propOrder = {
    "pointsList"
})
public class QueryOrganizationPointsResult {

    @XmlElement(name = "PointsList")
    protected QueryOrganizationPointsResult.PointsList pointsList;

    /**
     * Gets the value of the pointsList property.
     * 
     * @return
     *     possible object is
     *     {@link QueryOrganizationPointsResult.PointsList }
     *     
     */
    public QueryOrganizationPointsResult.PointsList getPointsList() {
        return pointsList;
    }

    /**
     * Sets the value of the pointsList property.
     * 
     * @param value
     *     allowed object is
     *     {@link QueryOrganizationPointsResult.PointsList }
     *     
     */
    public void setPointsList(QueryOrganizationPointsResult.PointsList value) {
        this.pointsList = value;
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
     *         &lt;element name="Point" maxOccurs="unbounded"&gt;
     *           &lt;complexType&gt;
     *             &lt;complexContent&gt;
     *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                 &lt;sequence&gt;
     *                   &lt;element name="IdentityID" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
     *                   &lt;element name="PointID" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
     *                   &lt;element name="PointType"&gt;
     *                     &lt;simpleType&gt;
     *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                         &lt;maxLength value="128"/&gt;
     *                       &lt;/restriction&gt;
     *                     &lt;/simpleType&gt;
     *                   &lt;/element&gt;
     *                   &lt;element name="PointBalance" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
     *                   &lt;element name="Status"&gt;
     *                     &lt;simpleType&gt;
     *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                         &lt;minLength value="1"/&gt;
     *                         &lt;maxLength value="1"/&gt;
     *                       &lt;/restriction&gt;
     *                     &lt;/simpleType&gt;
     *                   &lt;/element&gt;
     *                   &lt;element name="OpenDate" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
     *                   &lt;element name="CloseDate" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
     *                   &lt;element name="LastUpdateTime" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
     *                   &lt;element name="BalanceLastTime" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
     *                   &lt;element name="StatusLastTime" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
     *                   &lt;element name="ExpiredDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
     *                 &lt;/sequence&gt;
     *               &lt;/restriction&gt;
     *             &lt;/complexContent&gt;
     *           &lt;/complexType&gt;
     *         &lt;/element&gt;
     *         &lt;element name="PointSummary" maxOccurs="unbounded" minOccurs="0"&gt;
     *           &lt;complexType&gt;
     *             &lt;complexContent&gt;
     *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
     *                 &lt;sequence&gt;
     *                   &lt;element name="PointType"&gt;
     *                     &lt;simpleType&gt;
     *                       &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
     *                         &lt;maxLength value="128"/&gt;
     *                       &lt;/restriction&gt;
     *                     &lt;/simpleType&gt;
     *                   &lt;/element&gt;
     *                   &lt;element name="TotalPoint" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
     *                   &lt;element name="ExpiredAmountCurrMonth" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
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
        "point",
        "pointSummary"
    })
    public static class PointsList {

        @XmlElement(name = "Point", required = true)
        protected List<QueryOrganizationPointsResult.PointsList.Point> point;
        @XmlElement(name = "PointSummary")
        protected List<QueryOrganizationPointsResult.PointsList.PointSummary> pointSummary;

        /**
         * Gets the value of the point property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the point property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getPoint().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link QueryOrganizationPointsResult.PointsList.Point }
         * 
         * 
         */
        public List<QueryOrganizationPointsResult.PointsList.Point> getPoint() {
            if (point == null) {
                point = new ArrayList<QueryOrganizationPointsResult.PointsList.Point>();
            }
            return this.point;
        }

        /**
         * Gets the value of the pointSummary property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the pointSummary property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getPointSummary().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link QueryOrganizationPointsResult.PointsList.PointSummary }
         * 
         * 
         */
        public List<QueryOrganizationPointsResult.PointsList.PointSummary> getPointSummary() {
            if (pointSummary == null) {
                pointSummary = new ArrayList<QueryOrganizationPointsResult.PointsList.PointSummary>();
            }
            return this.pointSummary;
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
         *         &lt;element name="IdentityID" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
         *         &lt;element name="PointID" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
         *         &lt;element name="PointType"&gt;
         *           &lt;simpleType&gt;
         *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *               &lt;maxLength value="128"/&gt;
         *             &lt;/restriction&gt;
         *           &lt;/simpleType&gt;
         *         &lt;/element&gt;
         *         &lt;element name="PointBalance" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
         *         &lt;element name="Status"&gt;
         *           &lt;simpleType&gt;
         *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *               &lt;minLength value="1"/&gt;
         *               &lt;maxLength value="1"/&gt;
         *             &lt;/restriction&gt;
         *           &lt;/simpleType&gt;
         *         &lt;/element&gt;
         *         &lt;element name="OpenDate" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
         *         &lt;element name="CloseDate" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
         *         &lt;element name="LastUpdateTime" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
         *         &lt;element name="BalanceLastTime" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
         *         &lt;element name="StatusLastTime" type="{http://cps.huawei.com/cpsinterface/common}DateTime"/&gt;
         *         &lt;element name="ExpiredDate" type="{http://cps.huawei.com/cpsinterface/common}Date"/&gt;
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
            "identityID",
            "pointID",
            "pointType",
            "pointBalance",
            "status",
            "openDate",
            "closeDate",
            "lastUpdateTime",
            "balanceLastTime",
            "statusLastTime",
            "expiredDate"
        })
        public static class Point {

            @XmlElement(name = "IdentityID")
            protected long identityID;
            @XmlElement(name = "PointID")
            protected long pointID;
            @XmlElement(name = "PointType", required = true)
            protected String pointType;
            @XmlElement(name = "PointBalance")
            protected long pointBalance;
            @XmlElement(name = "Status", required = true)
            protected String status;
            @XmlElement(name = "OpenDate", required = true)
            protected String openDate;
            @XmlElement(name = "CloseDate", required = true)
            protected String closeDate;
            @XmlElement(name = "LastUpdateTime", required = true)
            protected String lastUpdateTime;
            @XmlElement(name = "BalanceLastTime", required = true)
            protected String balanceLastTime;
            @XmlElement(name = "StatusLastTime", required = true)
            protected String statusLastTime;
            @XmlElement(name = "ExpiredDate", required = true)
            protected String expiredDate;

            /**
             * Gets the value of the identityID property.
             * 
             */
            public long getIdentityID() {
                return identityID;
            }

            /**
             * Sets the value of the identityID property.
             * 
             */
            public void setIdentityID(long value) {
                this.identityID = value;
            }

            /**
             * Gets the value of the pointID property.
             * 
             */
            public long getPointID() {
                return pointID;
            }

            /**
             * Sets the value of the pointID property.
             * 
             */
            public void setPointID(long value) {
                this.pointID = value;
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
             * Gets the value of the pointBalance property.
             * 
             */
            public long getPointBalance() {
                return pointBalance;
            }

            /**
             * Sets the value of the pointBalance property.
             * 
             */
            public void setPointBalance(long value) {
                this.pointBalance = value;
            }

            /**
             * Gets the value of the status property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getStatus() {
                return status;
            }

            /**
             * Sets the value of the status property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setStatus(String value) {
                this.status = value;
            }

            /**
             * Gets the value of the openDate property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getOpenDate() {
                return openDate;
            }

            /**
             * Sets the value of the openDate property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setOpenDate(String value) {
                this.openDate = value;
            }

            /**
             * Gets the value of the closeDate property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getCloseDate() {
                return closeDate;
            }

            /**
             * Sets the value of the closeDate property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setCloseDate(String value) {
                this.closeDate = value;
            }

            /**
             * Gets the value of the lastUpdateTime property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getLastUpdateTime() {
                return lastUpdateTime;
            }

            /**
             * Sets the value of the lastUpdateTime property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setLastUpdateTime(String value) {
                this.lastUpdateTime = value;
            }

            /**
             * Gets the value of the balanceLastTime property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getBalanceLastTime() {
                return balanceLastTime;
            }

            /**
             * Sets the value of the balanceLastTime property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setBalanceLastTime(String value) {
                this.balanceLastTime = value;
            }

            /**
             * Gets the value of the statusLastTime property.
             * 
             * @return
             *     possible object is
             *     {@link String }
             *     
             */
            public String getStatusLastTime() {
                return statusLastTime;
            }

            /**
             * Sets the value of the statusLastTime property.
             * 
             * @param value
             *     allowed object is
             *     {@link String }
             *     
             */
            public void setStatusLastTime(String value) {
                this.statusLastTime = value;
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
         *         &lt;element name="PointType"&gt;
         *           &lt;simpleType&gt;
         *             &lt;restriction base="{http://www.w3.org/2001/XMLSchema}string"&gt;
         *               &lt;maxLength value="128"/&gt;
         *             &lt;/restriction&gt;
         *           &lt;/simpleType&gt;
         *         &lt;/element&gt;
         *         &lt;element name="TotalPoint" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
         *         &lt;element name="ExpiredAmountCurrMonth" type="{http://www.w3.org/2001/XMLSchema}long"/&gt;
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
            "pointType",
            "totalPoint",
            "expiredAmountCurrMonth"
        })
        public static class PointSummary {

            @XmlElement(name = "PointType", required = true)
            protected String pointType;
            @XmlElement(name = "TotalPoint")
            protected long totalPoint;
            @XmlElement(name = "ExpiredAmountCurrMonth")
            protected long expiredAmountCurrMonth;

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
             * Gets the value of the totalPoint property.
             * 
             */
            public long getTotalPoint() {
                return totalPoint;
            }

            /**
             * Sets the value of the totalPoint property.
             * 
             */
            public void setTotalPoint(long value) {
                this.totalPoint = value;
            }

            /**
             * Gets the value of the expiredAmountCurrMonth property.
             * 
             */
            public long getExpiredAmountCurrMonth() {
                return expiredAmountCurrMonth;
            }

            /**
             * Sets the value of the expiredAmountCurrMonth property.
             * 
             */
            public void setExpiredAmountCurrMonth(long value) {
                this.expiredAmountCurrMonth = value;
            }

        }

    }

}
