package com.papss.middleware.service;

import javax.xml.crypto.Data;
import javax.xml.crypto.OctetStreamData;
import javax.xml.crypto.dsig.*;
import javax.xml.crypto.dsig.dom.DOMSignContext;
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

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;
import java.security.*;
import java.security.cert.X509Certificate;
import java.security.interfaces.ECPrivateKey;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class XMSinger6 {
    private static final String ECDSA_SHA256 = "http://www.w3.org/2001/04/xmldsig-more#ecdsa-sha256";
    private static final String RSA_SHA256 = "http://www.w3.org/2001/04/xmldsig-more#rsa-sha256";

    public static String generateSignature(String xml, X509Certificate signingCert, PrivateKey signingKey)
            throws SignatureException {
        try {
            Data data = new OctetStreamData(new ByteArrayInputStream(xml.getBytes(StandardCharsets.UTF_8)));
            return generateSignature(data, signingCert, signingKey);
        } catch (Exception e) {
            throw new SignatureException("Failed signing xml", e);
        }
    }

    private static String generateSignature(Data data, X509Certificate signingCert, PrivateKey signingKey)
            throws SignatureException {
        XMLSignatureFactory fac = XMLSignatureFactory.getInstance("DOM");

        try {
            List<Transform> transforms = new ArrayList<Transform>();
            transforms.add(fac.newTransform(Transform.ENVELOPED, (TransformParameterSpec) null));
            transforms.add(fac.newCanonicalizationMethod(CanonicalizationMethod.INCLUSIVE,
                    (C14NMethodParameterSpec) null));

            Reference ref = fac.newReference("", fac.newDigestMethod(DigestMethod.SHA256, null),
                    transforms, null, null);
            String sigAlg = signingKey instanceof ECPrivateKey ? ECDSA_SHA256 : RSA_SHA256;

            SignedInfo si = fac.newSignedInfo(
                    fac.newCanonicalizationMethod(CanonicalizationMethod.INCLUSIVE, (C14NMethodParameterSpec) null),
                    fac.newSignatureMethod(sigAlg, null),
                    Collections.<Reference>singletonList(ref)
            );

            KeyInfoFactory kif = fac.getKeyInfoFactory();
            List<Object> x509Content = new ArrayList<Object>();
            x509Content.add(signingCert.getSubjectX500Principal().getName());
            x509Content.add(kif.newX509IssuerSerial(
                    signingCert.getIssuerX500Principal().getName(),
                    signingCert.getSerialNumber()));
            X509Data xd = kif.newX509Data(x509Content);
            KeyInfo ki = kif.newKeyInfo(Collections.singletonList(xd));

            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            dbf.setNamespaceAware(true);
            InputStream inputStream;
            if (data instanceof OctetStreamData) {
                inputStream = ((OctetStreamData) data).getOctetStream();
            } else {
                throw new SignatureException("Unsupported data type: " + data.getClass().getName());
            }

            Document doc = dbf.newDocumentBuilder().parse(inputStream);
            Node parentNode = getParentNode(doc);
           // Node parentNode = getParentNode(doc);

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

    private static Node getParentNode(Document doc) {
        NodeList parentList = doc.getElementsByTagNameNS("*", "Sgntr");

        if (parentList.getLength() == 0) {
            parentList = doc.getElementsByTagNameNS("*", "AppHdr");
            Node parentNode = doc.createElementNS(
                    parentList.item(0).getFirstChild().getNextSibling().getNamespaceURI(),
                    "Sgntr");
            return parentList.item(0).appendChild(parentNode);
        } else {
            return parentList.item(0);
        }
    }
}