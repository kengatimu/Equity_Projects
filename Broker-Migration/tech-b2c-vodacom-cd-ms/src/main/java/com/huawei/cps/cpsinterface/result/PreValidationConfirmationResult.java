
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import com.huawei.cps.cpsinterface.common.ParameterType;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for PreValidationConfirmationResult complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="PreValidationConfirmationResult"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="UMC_SessionID" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="ResultCode" type="{http://www.w3.org/2001/XMLSchema}string"/&gt;
 *         &lt;element name="ResultMsg" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/&gt;
 *         &lt;element name="ResultParameters" minOccurs="0"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="ResultParameter" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
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
@XmlType(name = "PreValidationConfirmationResult", propOrder = {
    "umcSessionID",
    "resultCode",
    "resultMsg",
    "resultParameters"
})
public class PreValidationConfirmationResult {

    @XmlElement(name = "UMC_SessionID", required = true)
    protected String umcSessionID;
    @XmlElement(name = "ResultCode", required = true)
    protected String resultCode;
    @XmlElement(name = "ResultMsg")
    protected String resultMsg;
    @XmlElement(name = "ResultParameters")
    protected PreValidationConfirmationResult.ResultParameters resultParameters;

    /**
     * Gets the value of the umcSessionID property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getUMCSessionID() {
        return umcSessionID;
    }

    /**
     * Sets the value of the umcSessionID property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setUMCSessionID(String value) {
        this.umcSessionID = value;
    }

    /**
     * Gets the value of the resultCode property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getResultCode() {
        return resultCode;
    }

    /**
     * Sets the value of the resultCode property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setResultCode(String value) {
        this.resultCode = value;
    }

    /**
     * Gets the value of the resultMsg property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getResultMsg() {
        return resultMsg;
    }

    /**
     * Sets the value of the resultMsg property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setResultMsg(String value) {
        this.resultMsg = value;
    }

    /**
     * Gets the value of the resultParameters property.
     * 
     * @return
     *     possible object is
     *     {@link PreValidationConfirmationResult.ResultParameters }
     *     
     */
    public PreValidationConfirmationResult.ResultParameters getResultParameters() {
        return resultParameters;
    }

    /**
     * Sets the value of the resultParameters property.
     * 
     * @param value
     *     allowed object is
     *     {@link PreValidationConfirmationResult.ResultParameters }
     *     
     */
    public void setResultParameters(PreValidationConfirmationResult.ResultParameters value) {
        this.resultParameters = value;
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
     *         &lt;element name="ResultParameter" type="{http://cps.huawei.com/cpsinterface/common}ParameterType" maxOccurs="unbounded"/&gt;
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
        "resultParameter"
    })
    public static class ResultParameters {

        @XmlElement(name = "ResultParameter", required = true)
        protected List<ParameterType> resultParameter;

        /**
         * Gets the value of the resultParameter property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the resultParameter property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getResultParameter().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link ParameterType }
         * 
         * 
         */
        public List<ParameterType> getResultParameter() {
            if (resultParameter == null) {
                resultParameter = new ArrayList<ParameterType>();
            }
            return this.resultParameter;
        }

    }

}
