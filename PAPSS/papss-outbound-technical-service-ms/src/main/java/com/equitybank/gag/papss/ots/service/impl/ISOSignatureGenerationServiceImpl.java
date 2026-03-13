package com.equitybank.gag.papss.ots.service.impl;

import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.service.ISOSignatureGenerationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.crypto.dsig.*;
import javax.xml.crypto.dsig.dom.DOMSignContext;
import javax.xml.crypto.dsig.keyinfo.KeyInfo;
import javax.xml.crypto.dsig.keyinfo.KeyInfoFactory;
import javax.xml.crypto.dsig.keyinfo.X509Data;
import javax.xml.crypto.dsig.keyinfo.X509IssuerSerial;
import javax.xml.crypto.dsig.spec.C14NMethodParameterSpec;
import javax.xml.crypto.dsig.spec.TransformParameterSpec;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.cert.X509Certificate;
import java.util.Collections;
import java.util.List;

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.DIGITAL_SIGNATURE_GENERATION_FAILURE;

@Service
public class ISOSignatureGenerationServiceImpl implements ISOSignatureGenerationService {

    private static final Logger log = LoggerFactory.getLogger(ISOSignatureGenerationServiceImpl.class);

    private static final String C14NEXC = "http://www.w3.org/TR/2001/REC-xml-c14n-20010315";
    private static final String SIGNATURE_METHOD_RSA = "http://www.w3.org/2001/04/xmldsig-more#rsa-sha256";

    private final String keystoreLocation;
    private final String keystorePassword;
    private final String keystoreType;
    private final String keystoreAlias;

    public ISOSignatureGenerationServiceImpl(@Value("${papss.signing.key-store:}") String keystoreLocation,
                                             @Value("${papss.signing.key-store-password:}") String keystorePassword,
                                             @Value("${papss.signing.key-store-type:}") String keystoreType,
                                             @Value("${papss.signing.key-alias:}") String keystoreAlias) {

        this.keystoreLocation = keystoreLocation;
        this.keystorePassword = keystorePassword;
        this.keystoreType = keystoreType;
        this.keystoreAlias = keystoreAlias;
    }

    @Override
    public String generateXMLDigitalSignature(String rrn, String isoXmlRequest, String type) throws CustomException {
        try (FileInputStream fis = new FileInputStream(keystoreLocation)) {

            // For debug only
//            log.info("keystoreLocation: {}", keystoreLocation);
//            log.info("keystoreAlias: {}", keystoreAlias);

            // Load PKCS12 keystore containing our private key and cert
            KeyStore keyStore = KeyStore.getInstance(keystoreType);
            keyStore.load(fis, keystorePassword.toCharArray());

            // Get signing key and certificate
            PrivateKey privateKey = (PrivateKey) keyStore.getKey(keystoreAlias, keystorePassword.toCharArray());
            X509Certificate x509Certificate = (X509Certificate) keyStore.getCertificate(keystoreAlias);

            // Parse input XML string into Document
            Document doc = loadXMLDocumentFromString(isoXmlRequest);

            // Initialize the XML signature factory
            XMLSignatureFactory fac = XMLSignatureFactory.getInstance("DOM");

            // Required transforms: enveloped + inclusive canonicalization
            List<Transform> transforms = List.of(
                    fac.newTransform(Transform.ENVELOPED, (TransformParameterSpec) null),
                    fac.newCanonicalizationMethod(CanonicalizationMethod.INCLUSIVE, (C14NMethodParameterSpec) null));

            // Reference to root element with SHA256 digest
            Reference ref = fac.newReference("", fac.newDigestMethod(DigestMethod.SHA256, null), transforms, null, null);

            // Detect signing algorithm: RSA or EC
            String sigAlg = (privateKey.getAlgorithm().equalsIgnoreCase("EC"))
                    ? SignatureMethod.ECDSA_SHA256
                    : SignatureMethod.RSA_SHA256;

            // Build SignedInfo block
            SignedInfo si = fac.newSignedInfo(
                    fac.newCanonicalizationMethod(CanonicalizationMethod.INCLUSIVE, (C14NMethodParameterSpec) null),
                    fac.newSignatureMethod(sigAlg, null),
                    Collections.singletonList(ref));

            // Build KeyInfo with SubjectDN + IssuerSerial (as required by PAPSS)
            KeyInfoFactory kif = fac.getKeyInfoFactory();
            String subjectName = x509Certificate.getSubjectX500Principal().getName();
            String issuerName = x509Certificate.getIssuerX500Principal().getName();
            BigInteger serialNumber = x509Certificate.getSerialNumber();
            X509IssuerSerial issuerSerial = kif.newX509IssuerSerial(issuerName, serialNumber);
            X509Data xd = kif.newX509Data(List.of(subjectName, issuerSerial));
            KeyInfo ki = kif.newKeyInfo(Collections.singletonList(xd));

            // Find <Sgntr> node or create one under <AppHdr>
            NodeList parentList = doc.getElementsByTagNameNS("*", "Sgntr");
            Node parentNode;
            if (parentList.getLength() == 0) {
                NodeList appHdrList = doc.getElementsByTagNameNS("urn:montran:message.01", "AppHdr");
                if (appHdrList.getLength() == 0) {
                    throw new CustomException("AppHdr element not found for signing.");
                }
                parentNode = doc.createElement("Sgntr");
                appHdrList.item(0).appendChild(parentNode);
            } else {
                parentNode = parentList.item(0);
            }

            // Attach signature to <Sgntr> node
            DOMSignContext sgntrContext = new DOMSignContext(privateKey, parentNode);

            // Sign the XML
            XMLSignature signature = fac.newXMLSignature(si, ki);
            signature.sign(sgntrContext);

            // Convert signed Document to String
            ByteArrayOutputStream output = new ByteArrayOutputStream();
            TransformerFactory.newInstance().newTransformer().transform(new DOMSource(doc), new StreamResult(output));

            String rawSignedXml = output.toString(StandardCharsets.UTF_8);

//            // =================================================================
//            // TEMPORARY CHANGE FOR RAW XML OUTPUT
//            // This outputs the pure XML to the console for easy copying/testing
//            System.out.println("\n--- START RAW SIGNED XML FOR RRN: " + rrn + " ---");
//            System.out.println(rawSignedXml);
//            System.out.println("--- END RAW SIGNED XML ---");
//            // =================================================================

            // Log that the signing was successful using standard logging
            log.info("{}: Successfully signed {} ISO20022 Message.", rrn, type);

            return rawSignedXml;

        } catch (Exception e) {
            log.error("{}: Exception Occurred During XML Signing: {}", rrn, e.getMessage());
            throw new CustomException(DIGITAL_SIGNATURE_GENERATION_FAILURE + e.getMessage());
        }
    }

    // Utility: Convert XML string into namespace-aware DOM document.
    private static Document loadXMLDocumentFromString(String xmlString) throws Exception {
        DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
        dbf.setNamespaceAware(true); // Required for digital signatures
        DocumentBuilder db = dbf.newDocumentBuilder();
        InputStream is = new ByteArrayInputStream(xmlString.getBytes(StandardCharsets.UTF_8));
        Document doc = db.parse(is);
        doc.normalize();
        return doc;
    }
}