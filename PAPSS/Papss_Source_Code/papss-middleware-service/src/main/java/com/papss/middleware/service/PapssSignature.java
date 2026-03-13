package com.papss.middleware.service;

import com.papss.middleware.exception.SignatureValidationException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.crypto.*;
import javax.xml.crypto.dsig.*;
import javax.xml.crypto.dsig.dom.DOMSignContext;
import javax.xml.crypto.dsig.dom.DOMValidateContext;
import javax.xml.crypto.dsig.keyinfo.KeyInfo;
import javax.xml.crypto.dsig.keyinfo.KeyInfoFactory;
import javax.xml.crypto.dsig.keyinfo.X509Data;
import javax.xml.crypto.dsig.spec.C14NMethodParameterSpec;
import javax.xml.crypto.dsig.spec.TransformParameterSpec;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.ByteArrayInputStream;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.SignatureException;
import java.security.cert.X509Certificate;
import java.security.interfaces.ECPrivateKey;
import java.util.Collections;
import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class PapssSignature {
    private List<X509Certificate> trustedCerts;
    private final KeyStoreService keyStoreLoader;

    public String generateSignature(String xml, String keyAlias, String keyPass) throws SignatureException {
        try {
            KeyStore keyStore = keyStoreLoader.getKeyStore(keyAlias);
            Data data = new OctetStreamData(new ByteArrayInputStream(xml.getBytes(StandardCharsets.UTF_8)));
            return this.generateSignature(data, (X509Certificate) keyStore.getCertificate(keyAlias),
                    (PrivateKey) keyStore.getKey(keyAlias, keyPass.toCharArray()));
        } catch (Exception e) {
            throw new SignatureException("Failed signing xml", e);
        }
    }

    private String generateSignature(Data data, X509Certificate signingCert, PrivateKey signingKey)
            throws SignatureException {
        XMLSignatureFactory fac = XMLSignatureFactory.getInstance("DOM");

        try {
            List<Transform> transforms = List.of(
                    fac.newTransform(Transform.ENVELOPED, (TransformParameterSpec) null),
                    fac.newCanonicalizationMethod(CanonicalizationMethod.INCLUSIVE, (C14NMethodParameterSpec) null)
            );

            Reference ref = fac.newReference("", fac.newDigestMethod(DigestMethod.SHA256, null), transforms, null, null);
            String sigAlg = signingKey instanceof ECPrivateKey ? SignatureMethod.ECDSA_SHA256 : SignatureMethod.RSA_SHA256;

            SignedInfo si = fac.newSignedInfo(
                    fac.newCanonicalizationMethod(CanonicalizationMethod.INCLUSIVE, (C14NMethodParameterSpec) null),
                    fac.newSignatureMethod(sigAlg, null), Collections.singletonList(ref)
            );

            KeyInfoFactory kif = fac.getKeyInfoFactory();
            X509Data xd = kif.newX509Data(List.of(signingCert.getSubjectDN().getName(),
                    kif.newX509IssuerSerial(signingCert.getIssuerDN().getName(), signingCert.getSerialNumber())));
            KeyInfo ki = kif.newKeyInfo(Collections.singletonList(xd));

            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            dbf.setNamespaceAware(true);
            Document doc = dbf.newDocumentBuilder().parse(new ByteArrayInputStream(((OctetStreamData) data).getOctetStream().readAllBytes()));
            Node parentNode = getParentNode(doc);

            DOMSignContext dsc = new DOMSignContext(signingKey, parentNode);
            XMLSignature signature = fac.newXMLSignature(si, ki);
            signature.sign(dsc);

            StringWriter swr = new StringWriter();
            Transformer trans = TransformerFactory.newInstance().newTransformer();
            trans.transform(new DOMSource(doc), new StreamResult(swr));
            return swr.toString();
        } catch (Exception e) {
            throw new SignatureException("Error signing data", e);
        }
    }

    private Node getParentNode(Document doc) {
        NodeList parentList = doc.getElementsByTagNameNS("*", "Sgntr");
        if (parentList.getLength() == 0) {
            parentList = doc.getElementsByTagNameNS("*", "AppHdr");
            Node parentNode = doc.createElementNS(parentList.item(0).getFirstChild().getNextSibling().getNamespaceURI(), "Sgntr");
            return parentList.item(0).appendChild(parentNode);
        } else {
            return parentList.item(0);
        }
    }

    public void validateSignature(Document xmlContent) throws SignatureValidationException {
        NodeList nl = xmlContent.getElementsByTagNameNS(XMLSignature.XMLNS, "Signature");
        if (nl.getLength() == 0) {
            throw new SignatureValidationException("Cannot find Signature element");
        }

        XMLSignatureFactory fac = XMLSignatureFactory.getInstance("DOM");
        DOMValidateContext valContext = new DOMValidateContext(new KeyValueKeySelector(this.trustedCerts), nl.item(0));

        try {
            XMLSignature signature = fac.unmarshalXMLSignature(valContext);
            if (!signature.validate(valContext)) {
                throw new SignatureValidationException("Signature validation failed");
            }
        } catch (Exception e) {
            throw new SignatureValidationException("Failed validating XML signature", e);
        }
    }

    private static class KeyValueKeySelector extends KeySelector {
        List<X509Certificate> certs;

        public KeyValueKeySelector(List<X509Certificate> certs) {
            this.certs = certs;
        }

        public KeySelectorResult select(KeyInfo keyInfo, KeySelector.Purpose purpose, AlgorithmMethod method,
                                        XMLCryptoContext context) throws KeySelectorException {
            if (keyInfo == null) {
                throw new KeySelectorException("Null KeyInfo object!");
            }

            for (Object content : keyInfo.getContent()) {
                if (content instanceof X509Data x509Data) {
                    for (Object x509Content : x509Data.getContent()) {
                        if (x509Content instanceof X509Certificate cert) {
                            if (certs.stream().anyMatch(trustedCert -> trustedCert.equals(cert))) {
                                return new SimpleKeySelectorResult(cert);
                            }
                        }
                    }
                }
            }
            throw new KeySelectorException("No KeyValue element found!");
        }
    }

    private static class SimpleKeySelectorResult implements KeySelectorResult {
        private final X509Certificate cert;

        SimpleKeySelectorResult(X509Certificate cert) {
            this.cert = cert;
        }

        public X509Certificate getCert() {
            return this.cert;
        }

        public Key getKey() {
            return this.cert.getPublicKey();
        }
    }
}