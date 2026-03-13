package com.equitybankgroup.payments.b2c.dto.input;

import jakarta.xml.bind.annotation.XmlAccessType;
import jakarta.xml.bind.annotation.XmlAccessorType;
import jakarta.xml.bind.annotation.XmlElement;
import jakarta.xml.bind.annotation.XmlRootElement;

@XmlRootElement(name = "eazzycashStatusReq")
@XmlAccessorType(XmlAccessType.FIELD)
public class InquireRequest {

    
    /*
    <eazzycashStatusReq xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<eazzycash>
<rrn>2021111409190124</rrn>
<channel>OMNI</channel>
<bankId>43</bankId>
<telco>AIRTEL_MONEY</telco><signature>jZzbRrd8Ycwg8xClrOdddkZcHjXHnUtgf6FA9gMFtCMF720S8rZPiVgtc0nPBuNXa4WlYvK+elzapEDbxUvA+oiyWtPZYM+fqI/UAxMjCtJifvr8z7ztjOx0Tq7La63Yvju06g6AWjhs3LrZa8ECBqQkQNdK9DBTcBT/oSP0Nla3IHq/WREA40ttMPtgbQoCmp/ZCL7Rmw8ulm/A2VEUvM14LEfn2jMzij1DWPzidsCkA6q7CYPPHLFIBVpevEpTNp9WTm80RWYr8oZx5jT8i4FAFMnN58kXd1/QHfjgMxvfkP+T3XmFg2Kv5PdF7rOF0XvsaY9u6hfy2NbnQwaSMg==</signature>
</eazzycash>
</eazzycashStatusReq>
    */
  
   @XmlElement(name = "msgId")
   private String msgId;
   
   @XmlElement(name = "eazzycash")
   private Eazzycash eazzycash;

    public InquireRequest() {
    }

    public String getMsgId() {
        return msgId;
    }

    public void setMsgId(String msgId) {
        this.msgId = msgId;
    }

    public Eazzycash getEazzycash() {
        return eazzycash;
    }

    public void setEazzycash(Eazzycash eazzycash) {
        this.eazzycash = eazzycash;
    }
   
   
   
}
