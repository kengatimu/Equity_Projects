
package com.huawei.cps.cpsinterface.api_requestmgr;

import javax.xml.namespace.QName;
import com.huawei.cps.cpsinterface.request.Request;
import com.huawei.cps.cpsinterface.response.Response;
import jakarta.xml.bind.JAXBElement;
import jakarta.xml.bind.annotation.XmlElementDecl;
import jakarta.xml.bind.annotation.XmlRegistry;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.huawei.cps.cpsinterface.api_requestmgr package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {

    private final static QName _Request_QNAME = new QName("http://cps.huawei.com/cpsinterface/api_requestmgr", "Request");
    private final static QName _Response_QNAME = new QName("http://cps.huawei.com/cpsinterface/api_requestmgr", "Response");

    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.huawei.cps.cpsinterface.api_requestmgr
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Request }{@code >}
     * 
     * @param value
     *     Java instance representing xml element's value.
     * @return
     *     the new instance of {@link JAXBElement }{@code <}{@link Request }{@code >}
     */
    @XmlElementDecl(namespace = "http://cps.huawei.com/cpsinterface/api_requestmgr", name = "Request")
    public JAXBElement<Request> createRequest(Request value) {
        return new JAXBElement<Request>(_Request_QNAME, Request.class, null, value);
    }

    /**
     * Create an instance of {@link JAXBElement }{@code <}{@link Response }{@code >}
     * 
     * @param value
     *     Java instance representing xml element's value.
     * @return
     *     the new instance of {@link JAXBElement }{@code <}{@link Response }{@code >}
     */
    @XmlElementDecl(namespace = "http://cps.huawei.com/cpsinterface/api_requestmgr", name = "Response")
    public JAXBElement<Response> createResponse(Response value) {
        return new JAXBElement<Response>(_Response_QNAME, Response.class, null, value);
    }

}
