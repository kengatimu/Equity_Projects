package com.equitybank.gag.dummy_telco_b2c_ms.testing;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.StringWriter;

public class XPathExample {
    public static void main(String[] args) {
        try {
            // Original XML string
            String xml = "<soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">" +
                    "<soap:Body>" +
                    "<ns2:TransferStatusInquiry xmlns:ns2=\"http://b2w.banktowallet.com/b2w\">" +
                    "<TranRequestInfo>" +
                    "<mmHeaderInfo>" +
                    "<operatorCode></operatorCode>" +
                    "<requestId></requestId>" +
                    "<requestToken></requestToken>" +
                    "<requestType></requestType>" +
                    "<affiliateCode></affiliateCode>" +
                    "</mmHeaderInfo>" +
                    "<externalRefNo></externalRefNo>" +
                    "</TranRequestInfo>" +
                    "</ns2:TransferStatusInquiry>" +
                    "</soap:Body>" +
                    "</soap:Envelope>";

            // Parse the XML string into a Document
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new java.io.ByteArrayInputStream(xml.getBytes()));

            // Initialize XPath
            XPathFactory xpathFactory = XPathFactory.newInstance();
            XPath xpath = xpathFactory.newXPath();

            // Modify values using XPath
            setXPathValue(doc, xpath, "//mmHeaderInfo/operatorCode", "ORANGEMONEYML");
            setXPathValue(doc, xpath, "//mmHeaderInfo/requestId", "OR2403283ADW1F");
            setXPathValue(doc, xpath, "//mmHeaderInfo/requestToken", "");
            setXPathValue(doc, xpath, "//mmHeaderInfo/requestType", "TRANINQ");
            setXPathValue(doc, xpath, "//mmHeaderInfo/affiliateCode", "EML");
            setXPathValue(doc, xpath, "//TranRequestInfo/externalRefNo", "OR240328B2CY8D");

            // Convert the Document back to a string without the XML declaration
            TransformerFactory tf = TransformerFactory.newInstance();
            Transformer transformer = tf.newTransformer();
            transformer.setOutputProperty("omit-xml-declaration", "yes"); // Omit the XML declaration
            transformer.setOutputProperty("indent", "yes");
            StringWriter writer = new StringWriter();
            transformer.transform(new DOMSource(doc), new StreamResult(writer));

            String modifiedXml = writer.getBuffer().toString();
            System.out.println(modifiedXml);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void setXPathValue(Document doc, XPath xpath, String expression, String value) throws Exception {
        NodeList nodes = (NodeList) xpath.evaluate(expression, doc, XPathConstants.NODESET);
        for (int i = 0; i < nodes.getLength(); i++) {
            Node node = nodes.item(i);
            node.setTextContent(value);
        }
    }
}
