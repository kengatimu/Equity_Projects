package com.equitybank.gag.papss.its.service.impl;

import com.equitybank.gag.papss.its.exception.CustomException;
import com.equitybank.gag.papss.its.service.ISO20022ValidateSignatureService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.w3c.dom.*;

import javax.xml.crypto.dsig.*;
import javax.xml.crypto.dsig.dom.DOMValidateContext;
import javax.xml.crypto.dsig.keyinfo.X509Data;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.security.KeyStore;
import java.security.cert.X509Certificate;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.SIGNATURE_VALIDATION_ERROR;

@Service
public class ISO20022ValidateSignatureServiceImpl implements ISO20022ValidateSignatureService {

    private static final Logger log = LoggerFactory.getLogger(ISO20022ValidateSignatureServiceImpl.class);

    private final String keyStorePath;
    private final String keyStorePassword;
    private final String alias;

    public ISO20022ValidateSignatureServiceImpl(@Value("${papss.signing.key-store:}") String keyStorePath,
                                                @Value("${papss.signing.key-store-password:}") String keyStorePassword,
                                                @Value("${papss.signing.key-alias:}") String alias) {

        this.keyStorePath = keyStorePath;
        this.keyStorePassword = keyStorePassword;
        this.alias = alias;
    }

    @Override
    public void validateSignature(String rrn, String xmlInput) throws CustomException {
        log.info("{}: ===== Starting ISO20022 XML Signature Validation =====", rrn);

        try (FileInputStream trustFis = new FileInputStream(keyStorePath)) {

            // -------------------------------------------------------------
            // 1. Load Truststore
            // -------------------------------------------------------------
            log.info("{}: Loading truststore: {}", rrn, keyStorePath);

            KeyStore trustStore = KeyStore.getInstance("PKCS12");
            trustStore.load(trustFis, keyStorePassword.toCharArray());

            X509Certificate trustedCert = (X509Certificate) trustStore.getCertificate(alias);
            if (trustedCert == null) {
                log.error("{}: Certificate not found for alias '{}'", rrn, alias);
                throw new CustomException(SIGNATURE_VALIDATION_ERROR + "Trusted certificate not found for alias: " + alias);
            }

            log.info("{}: Loaded PAPSS trusted certificate. Certificate details:  \nIssuer={}, \nSerial={}", rrn, trustedCert.getIssuerX500Principal(), trustedCert.getSerialNumber());

            // -------------------------------------------------------------
            // 2. Parse XML
            // -------------------------------------------------------------
            log.info("{}: Parsing inbound XML...", rrn);
            Document doc = loadXMLDocumentFromString(xmlInput);
            log.info("{}: XML parsed successfully", rrn);

            // -------------------------------------------------------------
            // 3. Locate Signature Node
            // -------------------------------------------------------------
            NodeList signatureNodes = doc.getElementsByTagNameNS(XMLSignature.XMLNS, "Signature");

            if (signatureNodes.getLength() == 0) {
                log.error("{}: No <Signature> element found", rrn);
                throw new CustomException(SIGNATURE_VALIDATION_ERROR + " No Signature element found in XML.");
            }

            Node signatureNode = signatureNodes.item(0);
            log.info("{}: Found <Signature> node", rrn);

            // -------------------------------------------------------------
            // 4. Unmarshal Signature
            // -------------------------------------------------------------
            XMLSignatureFactory sigFactory = XMLSignatureFactory.getInstance("DOM");
            DOMValidateContext valContext = new DOMValidateContext(trustedCert.getPublicKey(), signatureNode);

            XMLSignature signature = sigFactory.unmarshalXMLSignature(valContext);
            log.info("{}: XMLSignature unmarshalled successfully", rrn);

            // -------------------------------------------------------------
            // 4A. Extract X509IssuerName and X509SerialNumber from KeyInfo (PAPSS sends only metadata)
            // -------------------------------------------------------------
            if (signature.getKeyInfo() != null) {
                String x509IssuerName = null;
                String x509SerialNumber = null;

                for (Object kiObj : signature.getKeyInfo().getContent()) {
                    if (kiObj instanceof X509Data) {
                        X509Data x509Data = (X509Data) kiObj;

                        for (Object data : x509Data.getContent()) {
                            if (data instanceof String) {
                                // <X509SubjectName> ignored — not useful for PAPSS validation
                            }
                            if (data instanceof javax.xml.crypto.dsig.keyinfo.X509IssuerSerial) {
                                javax.xml.crypto.dsig.keyinfo.X509IssuerSerial is = (javax.xml.crypto.dsig.keyinfo.X509IssuerSerial) data;
                                x509IssuerName = is.getIssuerName();
                                x509SerialNumber = is.getSerialNumber().toString();
                                log.info("{}: Received certificate details:  \nIssuer={}, \nSerial={}", rrn, x509IssuerName, x509SerialNumber);
                            }
                        }
                    }
                }

                // ---------------------------------------------------------
                // 4B. Compare X509IssuerName and X509SerialNumber (only meaningful PAPSS check)
                // ---------------------------------------------------------
                if (x509IssuerName != null && x509SerialNumber != null) {

                    boolean issuerMatch = trustedCert.getIssuerX500Principal().getName().equals(x509IssuerName);
                    boolean serialMatch = trustedCert.getSerialNumber().toString().equals(x509SerialNumber);
                    boolean certIdentityMatch = (issuerMatch && serialMatch);

                    log.info("{}: X509IssuerName and X509SerialNumber match = {}", rrn, certIdentityMatch);

                    if (!certIdentityMatch) {
                        log.error("{}: X509IssuerName or X509SerialNumber differ from trusted PAPSS certificate. Signature cannot be trusted.", rrn);
                        log.info("{}: ===== XML Signature INVALID =====", rrn);
                        throw new CustomException(SIGNATURE_VALIDATION_ERROR + " X509IssuerName or X509SerialNumber differ from trusted PAPSS certificate. Signature cannot be trusted.");
                    }

                } else {
                    log.warn("{}: No X509IssuerName or X509SerialNumber inside <KeyInfo>. PAPSS may omit metadata.", rrn);
                }
            }
            // -------------------------------------------------------------
            // 5. Validate Full Signature
            // -------------------------------------------------------------
            log.info("{}: Validating signature...", rrn);

            boolean isValid = signature.validate(valContext);
            log.info("{}: Final Signature Validation Result = {}", rrn, isValid);

            if (!isValid) {
                boolean sigValueValid = signature.getSignatureValue().validate(valContext);
                log.error("{}: SignatureValue validation = {}", rrn, sigValueValid);

                for (Object refObj : signature.getSignedInfo().getReferences()) {
                    Reference ref = (Reference) refObj;
                    boolean refValid = ref.validate(valContext);
                    log.error("{}: Reference URI='{}' digest validation = {}", rrn, ref.getURI(), refValid);
                }

                log.info("{}: ===== XML Signature INVALID =====", rrn);
                throw new CustomException(SIGNATURE_VALIDATION_ERROR + " XML Signature validation failed.");
            }

            log.info("{}: ===== XML Signature VALID =====", rrn);

        } catch (Exception e) {
            log.error("{}: EXCEPTION during signature validation: {}", rrn, e.getMessage());
            throw new CustomException("Exception during signature validation: " + e.getMessage());
        }
    }

    private static Document loadXMLDocumentFromString(String xmlString) throws Exception {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        dbf.setNamespaceAware(true);

        DocumentBuilder db = dbf.newDocumentBuilder();
        InputStream is = new ByteArrayInputStream(xmlString.getBytes(StandardCharsets.UTF_8));

        Document doc = db.parse(is);
        doc.normalize();

        return doc;
    }
}

