package com.equitybank.gag.papss.ots.dto.fxrate;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.dataformat.xml.annotation.JacksonXmlProperty;

import java.io.Serializable;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class PaymentFXRate implements Serializable {
    private final static long serialVersionUID = 1L;

    @JacksonXmlProperty(localName = "Request")
    private Request request;

    @JacksonXmlProperty(localName = "Response")
    private Response response;

    public Request getRequest() {
        return request;
    }

    public void setRequest(Request request) {
        this.request = request;
    }

    public Response getResponse() {
        return response;
    }

    public void setResponse(Response response) {
        this.response = response;
    }
}
