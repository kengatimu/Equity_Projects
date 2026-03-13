
package com.huawei.cps.cpsinterface.result;

import java.util.ArrayList;
import java.util.List;
import com.huawei.cps.cpsinterface.common.CustomerBeneficiary;
import com.huawei.cps.cpsinterface.common.GroupBeneficiary;
import com.huawei.cps.cpsinterface.common.OrganisationBeneficiary;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * Beneficiary列表数据
 * 
 * <p>Java class for BeneficiaryList complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="BeneficiaryList"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="CustomerBeneficiary" type="{http://cps.huawei.com/cpsinterface/common}CustomerBeneficiary" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="OrganisationBeneficiary" type="{http://cps.huawei.com/cpsinterface/common}OrganisationBeneficiary" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="GroupBeneficiary" type="{http://cps.huawei.com/cpsinterface/common}GroupBeneficiary" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "BeneficiaryList", propOrder = {
    "customerBeneficiary",
    "organisationBeneficiary",
    "groupBeneficiary"
})
public class BeneficiaryList {

    @XmlElement(name = "CustomerBeneficiary")
    protected List<CustomerBeneficiary> customerBeneficiary;
    @XmlElement(name = "OrganisationBeneficiary")
    protected List<OrganisationBeneficiary> organisationBeneficiary;
    @XmlElement(name = "GroupBeneficiary")
    protected List<GroupBeneficiary> groupBeneficiary;

    /**
     * Gets the value of the customerBeneficiary property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the customerBeneficiary property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getCustomerBeneficiary().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link CustomerBeneficiary }
     * 
     * 
     */
    public List<CustomerBeneficiary> getCustomerBeneficiary() {
        if (customerBeneficiary == null) {
            customerBeneficiary = new ArrayList<CustomerBeneficiary>();
        }
        return this.customerBeneficiary;
    }

    /**
     * Gets the value of the organisationBeneficiary property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the organisationBeneficiary property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getOrganisationBeneficiary().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link OrganisationBeneficiary }
     * 
     * 
     */
    public List<OrganisationBeneficiary> getOrganisationBeneficiary() {
        if (organisationBeneficiary == null) {
            organisationBeneficiary = new ArrayList<OrganisationBeneficiary>();
        }
        return this.organisationBeneficiary;
    }

    /**
     * Gets the value of the groupBeneficiary property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the groupBeneficiary property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getGroupBeneficiary().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link GroupBeneficiary }
     * 
     * 
     */
    public List<GroupBeneficiary> getGroupBeneficiary() {
        if (groupBeneficiary == null) {
            groupBeneficiary = new ArrayList<GroupBeneficiary>();
        }
        return this.groupBeneficiary;
    }

}
