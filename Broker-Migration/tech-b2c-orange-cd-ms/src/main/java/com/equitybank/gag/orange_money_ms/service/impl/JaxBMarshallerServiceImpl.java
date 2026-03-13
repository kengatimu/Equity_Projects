package com.equitybank.gag.orange_money_ms.service.impl;

import com.equitybank.gag.orange_money_ms.config.CustomNamespacePrefixMapper;
import com.equitybank.gag.orange_money_ms.dto.b2c.status.request.StatusEnvelope;
import com.equitybank.gag.orange_money_ms.dto.b2c.tran.request.*;
import com.equitybank.gag.orange_money_ms.exception.CustomException;
import com.equitybank.gag.orange_money_ms.service.JaxBMarshallerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import java.io.StringWriter;

import static com.equitybank.gag.orange_money_ms.config.ApplicationConstants.JAXB_NAMESPACE_PREFIX_MAPPER;
import static com.equitybank.gag.orange_money_ms.config.StatusCodeMessages.DEFAULT_PROCESSING_FAILURE;

@Service
public class JaxBMarshallerServiceImpl implements JaxBMarshallerService {
    private static final Logger log = LoggerFactory.getLogger(JaxBMarshallerServiceImpl.class);

    @Override
    public String marshallTransactionRequestToXml(Envelope request, String rrn) throws CustomException {
        try {
            // Initialize JAXB context and marshaller
            JAXBContext jaxbContext = JAXBContext.newInstance(Envelope.class,
                    Body.class,
                    AccountToWalletTransfer.class,
                    MobileTransferRequest.class,
                    MmHeaderInfo.class);
            Marshaller marshaller = jaxbContext.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            marshaller.setProperty(Marshaller.JAXB_FRAGMENT, Boolean.TRUE); // Remove the XML declaration

            // Appending the namespace prefixes
            marshaller.setProperty(JAXB_NAMESPACE_PREFIX_MAPPER, new CustomNamespacePrefixMapper());

            // Marshal the request
            StringWriter sw = new StringWriter();
            marshaller.marshal(request, sw);
            String xmlOutput = sw.toString();

            // Modify the XML string to adjust namespaces
            String telcoXmlRequest = xmlOutput
                    .replace(" xmlns:ns2=\"http://b2w.banktowallet.com/b2w\"", "") // Remove ns2 from Envelope
                    .replaceFirst("<ns2:AccountToWalletTransfer>", "<ns2:AccountToWalletTransfer xmlns:ns2=\"http://b2w.banktowallet.com/b2w\">"); // Add ns2 to AccountToWalletTransfer

            // Output the modified XML
            log.info("{}: Composed Orange Money Xml Request: \n{}", rrn, telcoXmlRequest);
            return telcoXmlRequest;
        } catch (JAXBException e) {
            throw new CustomException(String.format("%s %s%s", rrn, DEFAULT_PROCESSING_FAILURE, e.getMessage()));
        }
    }

    @Override
    public String marshallStatusCheckRequestToXml(StatusEnvelope request, String rrn) throws CustomException {
        try {
            // Initialize JAXB context and marshaller
            JAXBContext jaxbContext = JAXBContext.newInstance(StatusEnvelope.class,
                    com.equitybank.gag.orange_money_ms.dto.b2c.status.request.Body.class,
                    com.equitybank.gag.orange_money_ms.dto.b2c.status.request.TransferStatusInquiry.class,
                    com.equitybank.gag.orange_money_ms.dto.b2c.status.request.TranRequestInfo.class,
                    com.equitybank.gag.orange_money_ms.dto.b2c.status.request.MmHeaderInfo.class);
            Marshaller marshaller = jaxbContext.createMarshaller();
            marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
            marshaller.setProperty(Marshaller.JAXB_FRAGMENT, Boolean.TRUE); // Remove the XML declaration

            // Appending the namespace prefixes
            marshaller.setProperty(JAXB_NAMESPACE_PREFIX_MAPPER, new CustomNamespacePrefixMapper());

            // Marshal the request
            StringWriter sw = new StringWriter();
            marshaller.marshal(request, sw);
            String xmlOutput = sw.toString();

            // Modify the XML string to adjust namespaces
            String telcoXmlRequest = xmlOutput
                    .replace(" xmlns:ns2=\"http://b2w.banktowallet.com/b2w\"", "") // Remove ns2 from Envelope
                    .replaceFirst("<ns2:TransferStatusInquiry>", "<ns2:TransferStatusInquiry xmlns:ns2=\"http://b2w.banktowallet.com/b2w\">"); // Add ns2 to AccountToWalletTransfer

            // Output the modified XML
            log.info("{}: Composed Orange Money Xml Request: \n{}", rrn, telcoXmlRequest);
            return telcoXmlRequest;
        } catch (JAXBException e) {
            throw new CustomException(String.format("%s %s%s", rrn, DEFAULT_PROCESSING_FAILURE, e.getMessage()));
        }
    }
}
