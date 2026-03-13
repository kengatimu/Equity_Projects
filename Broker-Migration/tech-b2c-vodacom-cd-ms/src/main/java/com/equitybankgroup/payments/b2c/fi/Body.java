package com.equitybankgroup.payments.b2c.fi;


import lombok.Setter;
import lombok.ToString;

import javax.xml.bind.annotation.XmlElement;

@ToString
@Setter
public class Body {
    private ExecuteFinacleScriptResponse executeFinacleScriptResponse;
    @XmlElement(name = "executeFinacleScriptResponse",namespace = "http://www.finacle.com/fixml")
    public ExecuteFinacleScriptResponse getExecuteFinacleScriptResponse() {
        return executeFinacleScriptResponse;
    }
}
