package com.equitybank.payments.imt.b2c.drcbroker.service.util;


import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.response.BusinessServiceResponseModel;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;
import java.io.StringWriter;

@Service
public class JAXBMarshaller {
    private static final Logger log = LoggerFactory.getLogger(JAXBMarshaller.class);

    public String marshallXML(BusinessServiceResponseModel request, ErrorStatus errorStatus) {
        String xmlContent;
        JAXBContext jaxbContext;
        try {
            jaxbContext = JAXBContext.newInstance(BusinessServiceResponseModel.class);

            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
            jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
//            jaxbMarshaller.setProperty(Marshaller.JAXB_SCHEMA_LOCATION, "");

            StringWriter sw = new StringWriter();
            jaxbMarshaller.marshal(request, sw);

            xmlContent = sw.toString();
        } catch (Exception ex) {
            ex.printStackTrace();
            errorStatus.setStatus("Failed");
            errorStatus.setStatusCode("800");
            errorStatus.setStatusDesc(" Internal Exception Occurred On JAXBMarshaller");
            errorStatus.setStatusMessage("GAG InternalError:");
            log.error("Exception Occurred in JAXBMarshaller.JAXBMarshaller Method::: " + ex.getMessage());
            return null;
        }
        log.info("xmlResponse::: " + xmlContent);
        return xmlContent;
    }
}
