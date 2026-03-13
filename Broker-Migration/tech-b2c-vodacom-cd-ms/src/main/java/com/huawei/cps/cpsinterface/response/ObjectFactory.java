
package com.huawei.cps.cpsinterface.response;

import jakarta.xml.bind.annotation.XmlRegistry;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.huawei.cps.cpsinterface.response package. 
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


    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.huawei.cps.cpsinterface.response
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link Response }
     * 
     */
    public Response createResponse() {
        return new Response();
    }

    /**
     * Create an instance of {@link Response.Header }
     * 
     */
    public Response.Header createResponseHeader() {
        return new Response.Header();
    }

    /**
     * Create an instance of {@link Response.Body }
     * 
     */
    public Response.Body createResponseBody() {
        return new Response.Body();
    }

    /**
     * Create an instance of {@link Response.Header.HeaderExtension }
     * 
     */
    public Response.Header.HeaderExtension createResponseHeaderHeaderExtension() {
        return new Response.Header.HeaderExtension();
    }

}
