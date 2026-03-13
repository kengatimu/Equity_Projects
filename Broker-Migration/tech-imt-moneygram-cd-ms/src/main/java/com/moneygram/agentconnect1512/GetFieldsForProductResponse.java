
package com.moneygram.agentconnect1512;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for GetFieldsForProductResponse complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="GetFieldsForProductResponse"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Response"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="fqdoInfo" type="{http://www.moneygram.com/AgentConnect1512}FQDOInfo"/&gt;
 *         &lt;element name="productFieldInfo" type="{http://www.moneygram.com/AgentConnect1512}ProductFieldInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *         &lt;element name="dynamicFieldInfo" type="{http://www.moneygram.com/AgentConnect1512}DynamicFieldInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "GetFieldsForProductResponse", propOrder = {
    "fqdoInfo",
    "productFieldInfo",
    "dynamicFieldInfo"
})
public class GetFieldsForProductResponse
    extends Response
{

    @XmlElement(required = true)
    protected FQDOInfo fqdoInfo;
    protected List<ProductFieldInfo> productFieldInfo;
    protected List<DynamicFieldInfo> dynamicFieldInfo;

    /**
     * Gets the value of the fqdoInfo property.
     * 
     * @return
     *     possible object is
     *     {@link FQDOInfo }
     *     
     */
    public FQDOInfo getFqdoInfo() {
        return fqdoInfo;
    }

    /**
     * Sets the value of the fqdoInfo property.
     * 
     * @param value
     *     allowed object is
     *     {@link FQDOInfo }
     *     
     */
    public void setFqdoInfo(FQDOInfo value) {
        this.fqdoInfo = value;
    }

    /**
     * Gets the value of the productFieldInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the productFieldInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getProductFieldInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link ProductFieldInfo }
     * 
     * 
     */
    public List<ProductFieldInfo> getProductFieldInfo() {
        if (productFieldInfo == null) {
            productFieldInfo = new ArrayList<ProductFieldInfo>();
        }
        return this.productFieldInfo;
    }

    /**
     * Gets the value of the dynamicFieldInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the dynamicFieldInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getDynamicFieldInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link DynamicFieldInfo }
     * 
     * 
     */
    public List<DynamicFieldInfo> getDynamicFieldInfo() {
        if (dynamicFieldInfo == null) {
            dynamicFieldInfo = new ArrayList<DynamicFieldInfo>();
        }
        return this.dynamicFieldInfo;
    }

}
