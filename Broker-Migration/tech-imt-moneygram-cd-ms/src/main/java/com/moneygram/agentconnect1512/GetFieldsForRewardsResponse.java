
package com.moneygram.agentconnect1512;

import java.util.ArrayList;
import java.util.List;
import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlType;


/**
 * <p>Java class for GetFieldsForRewardsResponse complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="GetFieldsForRewardsResponse"&gt;
 *   &lt;complexContent&gt;
 *     &lt;extension base="{http://www.moneygram.com/AgentConnect1512}Response"&gt;
 *       &lt;sequence&gt;
 *         &lt;element name="rewardsFieldInfo" type="{http://www.moneygram.com/AgentConnect1512}RewardsFieldInfo" maxOccurs="unbounded" minOccurs="0"/&gt;
 *       &lt;/sequence&gt;
 *     &lt;/extension&gt;
 *   &lt;/complexContent&gt;
 * &lt;/complexType&gt;
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "GetFieldsForRewardsResponse", propOrder = {
    "rewardsFieldInfo"
})
public class GetFieldsForRewardsResponse
    extends Response
{

    protected List<RewardsFieldInfo> rewardsFieldInfo;

    /**
     * Gets the value of the rewardsFieldInfo property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the Jakarta XML Binding object.
     * This is why there is not a <CODE>set</CODE> method for the rewardsFieldInfo property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getRewardsFieldInfo().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link RewardsFieldInfo }
     * 
     * 
     */
    public List<RewardsFieldInfo> getRewardsFieldInfo() {
        if (rewardsFieldInfo == null) {
            rewardsFieldInfo = new ArrayList<RewardsFieldInfo>();
        }
        return this.rewardsFieldInfo;
    }

}
