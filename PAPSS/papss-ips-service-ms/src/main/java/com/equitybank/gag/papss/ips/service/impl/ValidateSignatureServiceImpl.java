package com.equitybank.gag.papss.ips.service.impl;

import com.equitybank.gag.papss.ips.exception.CustomException;
import com.equitybank.gag.papss.ips.service.ValidateSignatureService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;

import javax.xml.crypto.dsig.XMLSignature;
import javax.xml.crypto.dsig.XMLSignatureFactory;
import javax.xml.crypto.dsig.dom.DOMValidateContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.security.KeyStore;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;

import static com.equitybank.gag.papss.ips.config.StatusCodeMessages.SIGNATURE_VALIDATION_ERROR;

@Service
public class ValidateSignatureServiceImpl implements ValidateSignatureService {
    private static final Logger log = LoggerFactory.getLogger(ValidateSignatureServiceImpl.class);

    private final String truststorePath;
    private final String truststorePassword;
    private final String trustAlias;

    public ValidateSignatureServiceImpl(@Value("${server.ssl.trust-store:}") String truststorePath,
                                        @Value("${server.ssl.trust-store-password:}") String truststorePassword,
                                        @Value("${server.ssl.trust-aliases.papss:}") String trustAlias) {
        this.truststorePath = truststorePath;
        this.truststorePassword = truststorePassword;
        this.trustAlias = trustAlias;
    }


    @Override
    public boolean validateSignature(String signedXml) {
        try (FileInputStream trustFis = new FileInputStream(truststorePath)) {

            // Load the PKCS12 truststore that holds trusted public certificates
            KeyStore trustStore = KeyStore.getInstance("PKCS12");
            trustStore.load(trustFis, truststorePassword.toCharArray());

            // Get trusted certificate for verification
            X509Certificate trustedCert = (X509Certificate) trustStore.getCertificate(trustAlias);
            if (trustedCert == null) {
                throw new CustomException(SIGNATURE_VALIDATION_ERROR + "Trusted certificate not found for alias: " + trustAlias);
            }

            // Parse the signed XML into a Document
            Document doc = loadXMLDocumentFromString(signedXml);

            // Locate the <Signature> element
            NodeList signatureNodes = doc.getElementsByTagNameNS(XMLSignature.XMLNS, "Signature");
            if (signatureNodes.getLength() == 0) {
                throw new CustomException(SIGNATURE_VALIDATION_ERROR + "No Signature element found in the XML");
            }

            // Extract the embedded X509Certificate from <KeyInfo>
            NodeList x509List = doc.getElementsByTagNameNS("*", "X509Certificate");
            if (x509List.getLength() == 0) {
                throw new CustomException(SIGNATURE_VALIDATION_ERROR + "No embedded X509Certificate found in the XML");
            }

            // Decode and convert embedded base64 cert to X509
            String embeddedCertBase64 = x509List.item(0).getTextContent().replaceAll("\\s+", "");
            byte[] embeddedCertBytes = java.util.Base64.getDecoder().decode(embeddedCertBase64);
            CertificateFactory certFactory = CertificateFactory.getInstance("X.509");
            X509Certificate embeddedCert = (X509Certificate) certFactory.generateCertificate(new ByteArrayInputStream(embeddedCertBytes));

            // Compare public keys to ensure embedded cert is trusted
            if (!embeddedCert.getPublicKey().equals(trustedCert.getPublicKey())) {
                throw new SecurityException(SIGNATURE_VALIDATION_ERROR + "Public key mismatch between embedded and trusted certificate");
            }

            // Perform XML Signature validation using the embedded cert
            XMLSignatureFactory sigFactory = XMLSignatureFactory.getInstance("DOM");
            DOMValidateContext valContext = new DOMValidateContext(embeddedCert.getPublicKey(), signatureNodes.item(0));
            XMLSignature signature = sigFactory.unmarshalXMLSignature(valContext);
            boolean isValid = signature.validate(valContext);

            log.info("Signature validation result (papss): {}", isValid);
            return isValid;

        } catch (Exception e) {
            log.error("Exception during signature validation: {}", e.getMessage());
            return false;
        }
    }

    // Helper method to convert XML string into DOM Document
    private static Document loadXMLDocumentFromString(String xmlString) throws Exception {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        dbf.setNamespaceAware(true); // Required for DSig
        DocumentBuilder db = dbf.newDocumentBuilder();
        InputStream is = new ByteArrayInputStream(xmlString.getBytes(StandardCharsets.UTF_8));
        Document doc = db.parse(is);
        doc.normalize();
        return doc;
    }
}
