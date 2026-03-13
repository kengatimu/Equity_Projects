package com.equitybank.gag.papss.ips.service.impl;

import com.equitybank.gag.papss.ips.service.GenerateXMLDigitalSignatureService;
import com.equitybank.gag.papss.ips.exception.CustomException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;

import javax.xml.crypto.dsig.*;
import javax.xml.crypto.dsig.dom.DOMSignContext;
import javax.xml.crypto.dsig.keyinfo.KeyInfo;
import javax.xml.crypto.dsig.keyinfo.KeyInfoFactory;
import javax.xml.crypto.dsig.keyinfo.X509Data;
import javax.xml.crypto.dsig.spec.C14NMethodParameterSpec;
import javax.xml.crypto.dsig.spec.TransformParameterSpec;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.*;
import java.nio.charset.StandardCharsets;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.cert.X509Certificate;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

import static com.equitybank.gag.papss.ips.config.StatusCodeMessages.DIGITAL_SIGNATURE_GENERATION_FAILURE;

@Service
public class GenerateXMLDigitalSignatureServiceImpl implements GenerateXMLDigitalSignatureService {
    private static final Logger log = LoggerFactory.getLogger(GenerateXMLDigitalSignatureServiceImpl.class);

    private static final String C14NEXC = "http://www.w3.org/TR/2001/REC-xml-c14n-20010315";
    private static final String SIGNATURE_METHOD_RSA = "http://www.w3.org/2001/04/xmldsig-more#rsa-sha256";
//    private static final String SIGNATURE_METHOD_ECDSA = "http://www.w3.org/2001/04/xmldsig-more#ecdsa-sha256";


    // Environment variables
    private final String keystoreLocation;
    private final String keystorePassword;
    private final String keystoreAlias;

    @Autowired
    public GenerateXMLDigitalSignatureServiceImpl(@Value("${server.ssl.key-store}") String keystoreLocation,
                                                  @Value("${server.ssl.key-store-password}") String keystorePassword,
                                                  @Value("${server.ssl.key-alias}") String keystoreAlias) {
        this.keystoreLocation = keystoreLocation;
        this.keystorePassword = keystorePassword;
        this.keystoreAlias = keystoreAlias;
    }

    @Override
    public String generateXMLDigitalSignature(String rrn, String isoXmlRequest, String type) throws CustomException {
        try (FileInputStream fis = new FileInputStream(keystoreLocation)) {

            // Load PKCS12 keystore containing our private key and cert
            KeyStore keyStore = KeyStore.getInstance("PKCS12");
            keyStore.load(fis, keystorePassword.toCharArray());

            // Get signing key and certificate
            PrivateKey privateKey = (PrivateKey) keyStore.getKey(keystoreAlias, keystorePassword.toCharArray());
            X509Certificate x509Certificate = (X509Certificate) keyStore.getCertificate(keystoreAlias);

            // Parse input XML string into Document
            Document doc = loadXMLDocumentFromString(isoXmlRequest);

            // Initialize the XML signature factory
            XMLSignatureFactory fac = XMLSignatureFactory.getInstance("DOM");

            // Define transforms: enveloped and canonicalization
            Transform envelopedTransform = fac.newTransform(Transform.ENVELOPED, (TransformParameterSpec) null);
            Transform c14NEXCTransform = fac.newTransform(C14NEXC, (TransformParameterSpec) null);
            List<Transform> transforms = Arrays.asList(envelopedTransform, c14NEXCTransform);

            // Reference to root element with SHA256 digest
            Reference ref = fac.newReference("", fac.newDigestMethod(DigestMethod.SHA256, null), transforms, null, null);

            // Build SignedInfo block with RSA-SHA256
            SignedInfo si = fac.newSignedInfo(
                    fac.newCanonicalizationMethod(CanonicalizationMethod.INCLUSIVE, (C14NMethodParameterSpec) null),
                    fac.newSignatureMethod(SIGNATURE_METHOD_RSA, null),
                    Collections.singletonList(ref));

            // Include signing certificate inside <KeyInfo>
            KeyInfoFactory kif = fac.getKeyInfoFactory();
            X509Data x509Data = kif.newX509Data(Collections.singletonList(x509Certificate));
            KeyInfo ki = kif.newKeyInfo(Collections.singletonList(x509Data));

            // Prepare signature object
            XMLSignature signature = fac.newXMLSignature(si, ki);

            // Add <Sgnr> wrapper under root and attach <Signature> there
            org.w3c.dom.Element sgnrElement = doc.createElement("Sgnr");
            doc.getDocumentElement().appendChild(sgnrElement);
            DOMSignContext sgnrContext = new DOMSignContext(privateKey, sgnrElement);

            // Sign the XML
            signature.sign(sgnrContext);

            // Convert signed Document to String
            ByteArrayOutputStream output = new ByteArrayOutputStream();
            TransformerFactory.newInstance().newTransformer().transform(new DOMSource(doc), new StreamResult(output));
            String rawSignedXml = output.toString(StandardCharsets.UTF_8).replaceAll("&#13;", "").replaceAll("\r", "");

            log.info("{}: Signed {} ISO20022 Message:\n{}", rrn, type, rawSignedXml);
            return rawSignedXml;

        } catch (Exception e) {
            log.error("{}: Exception Occurred During XML Signing: {}", rrn, e.getMessage());
            throw new CustomException(DIGITAL_SIGNATURE_GENERATION_FAILURE + e.getMessage());
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

