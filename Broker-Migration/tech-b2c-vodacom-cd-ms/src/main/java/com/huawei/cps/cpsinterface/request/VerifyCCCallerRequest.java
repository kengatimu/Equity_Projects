
package com.huawei.cps.cpsinterface.request;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * CustomerCare认证Caller
 * 
 * <p>Java class for VerifyCCCallerRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="VerifyCCCallerRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="SecurityQuestionAnswers"&gt;
 *           &lt;complexType&gt;
 *             &lt;complexContent&gt;
 *               &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *                 &lt;sequence&gt;
 *                   &lt;element name="QuestionAnswer" type="{http://cps.huawei.com/cpsinterface/request}QuestionAnswerType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
@XmlType(name = "VerifyCCCallerRequest", propOrder = {
    "securityQuestionAnswers"
})
public class VerifyCCCallerRequest {

    @XmlElement(name = "SecurityQuestionAnswers", required = true)
    protected VerifyCCCallerRequest.SecurityQuestionAnswers securityQuestionAnswers;

    /**
     * Gets the value of the securityQuestionAnswers property.
     * 
     * @return
     *     possible object is
     *     {@link VerifyCCCallerRequest.SecurityQuestionAnswers }
     *     
     */
    public VerifyCCCallerRequest.SecurityQuestionAnswers getSecurityQuestionAnswers() {
        return securityQuestionAnswers;
    }

    /**
     * Sets the value of the securityQuestionAnswers property.
     * 
     * @param value
     *     allowed object is
     *     {@link VerifyCCCallerRequest.SecurityQuestionAnswers }
     *     
     */
    public void setSecurityQuestionAnswers(VerifyCCCallerRequest.SecurityQuestionAnswers value) {
        this.securityQuestionAnswers = value;
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
     *         &lt;element name="QuestionAnswer" type="{http://cps.huawei.com/cpsinterface/request}QuestionAnswerType" maxOccurs="unbounded" minOccurs="0"/&gt;
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
        "questionAnswer"
    })
    public static class SecurityQuestionAnswers {

        @XmlElement(name = "QuestionAnswer")
        protected List<QuestionAnswerType> questionAnswer;

        /**
         * Gets the value of the questionAnswer property.
         * 
         * <p>
         * This accessor method returns a reference to the live list,
         * not a snapshot. Therefore any modification you make to the
         * returned list will be present inside the Jakarta XML Binding object.
         * This is why there is not a <CODE>set</CODE> method for the questionAnswer property.
         * 
         * <p>
         * For example, to add a new item, do as follows:
         * <pre>
         *    getQuestionAnswer().add(newItem);
         * </pre>
         * 
         * 
         * <p>
         * Objects of the following type(s) are allowed in the list
         * {@link QuestionAnswerType }
         * 
         * 
         */
        public List<QuestionAnswerType> getQuestionAnswer() {
            if (questionAnswer == null) {
                questionAnswer = new ArrayList<QuestionAnswerType>();
            }
            return this.questionAnswer;
        }

    }

}
