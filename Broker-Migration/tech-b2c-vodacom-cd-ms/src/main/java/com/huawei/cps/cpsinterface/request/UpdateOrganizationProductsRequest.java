
package com.huawei.cps.cpsinterface.request;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlType;


/**
 * 修改Organization的产品
 * 
 * <p>Java class for UpdateOrganizationProductsRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="UpdateOrganizationProductsRequest"&gt;
 *   &lt;complexContent&gt;
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="ProductUpdateData" type="{http://cps.huawei.com/cpsinterface/request}ProductUpdateDataType"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/restriction&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "UpdateOrganizationProductsRequest", propOrder = {
    "productUpdateData"
})
public class UpdateOrganizationProductsRequest {

    @XmlElement(name = "ProductUpdateData", required = true)
    protected ProductUpdateDataType productUpdateData;

    /**
     * Gets the value of the productUpdateData property.
     * 
     * @return
     *     possible object is
     *     {@link ProductUpdateDataType }
     *     
     */
    public ProductUpdateDataType getProductUpdateData() {
        return productUpdateData;
    }

    /**
     * Sets the value of the productUpdateData property.
     * 
     * @param value
     *     allowed object is
     *     {@link ProductUpdateDataType }
     *     
     */
    public void setProductUpdateData(ProductUpdateDataType value) {
        this.productUpdateData = value;
    }

}
