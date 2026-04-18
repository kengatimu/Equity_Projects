
package com.equitybank.payments.imt.b2c.drcbroker.service.model.response;

import java.io.Serializable;
import javax.annotation.Generated;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
    "Code",
    "Message",
    "Description"
})
@Generated("jsonschema2pojo")
public class ErrorModel implements Serializable
{

    @JsonProperty("Code")
    private Integer Code;
    @JsonProperty("Message")
    private String Message;
    @JsonProperty("Description")
    private String Description;
    private final static long serialVersionUID = -2300146751150096272L;

    public Integer getCode() {
        return Code;
    }

    public void setCode(Integer code) {
        Code = code;
    }

    public String getMessage() {
        return Message;
    }

    public void setMessage(String message) {
        Message = message;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        Description = description;
    }

    @Override
    public String toString() {
        return "BrokerErrorModel{" +
                "Code=" + Code +
                ", Message='" + Message + '\'' +
                ", Description='" + Description + '\'' +
                '}';
    }
}
