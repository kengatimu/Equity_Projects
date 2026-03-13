package com.papss.middleware.utils;

import com.papss.middleware.dto.PaymentReturnDto;
import com.papss.middleware.entities.Transaction;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.StringReader;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class TransactionParser {

    public static Transaction parseXMLToTransaction(String xmlData) {
        Transaction transaction = new Transaction();
        return transaction;
    }

    private static String getTagValue(Document doc, String tag) {
        if (doc.getElementsByTagName(tag).getLength() > 0) {
            return doc.getElementsByTagName(tag).item(0).getTextContent();
        }
        return null;
    }

    private static String getTagValue(Document doc, String tag, int index) {
        if (doc.getElementsByTagName(tag).getLength() > index) {
            return doc.getElementsByTagName(tag).item(index).getTextContent();
        }
        return null;
    }

    private static String getAttributeValue(Document doc, String tag, String attribute) {
        if (doc.getElementsByTagName(tag).getLength() > 0 && doc.getElementsByTagName(tag).item(0).getAttributes().getNamedItem(attribute) != null) {
            return doc.getElementsByTagName(tag).item(0).getAttributes().getNamedItem(attribute).getTextContent();
        }
        return null;
    }

    private static LocalDateTime parseDateTime(String dateStr) {
        if (dateStr != null) {
            return LocalDateTime.parse(dateStr, DateTimeFormatter.ISO_DATE_TIME);
        }
        return null;
    }
    private static String getElementText(Element parent, String tagName) {
        NodeList list = parent.getElementsByTagNameNS("*", tagName);
        return (list.getLength() > 0) ? list.item(0).getTextContent() : "";
    }

    private static String getElementText(Element parent, String... tags) {
        Element current = parent;
        for (String tag : tags) {
            NodeList list = current.getElementsByTagNameNS("*", tag);
            if (list.getLength() == 0) return "";
            current = (Element) list.item(0);
        }
        return current.getTextContent();
    }

    private static String getElementsByTagNameWithTag(Element parent, String tagName, int index) {
        NodeList list = parent.getElementsByTagNameNS("*", tagName);
        return (list.getLength() > index) ? list.item(index).getTextContent() : "";
    }

    private static String getAttribute(Element parent, String tagName, String attrName) {
        NodeList list = parent.getElementsByTagNameNS("*", tagName);
        if (list.getLength() > 0) {
            Element el = (Element) list.item(0);
            return el.getAttribute(attrName);
        }
        return "";
    }

    public static PaymentReturnDto paymentReturn(String xmlData) {
        try {
            // Parse XML string into Document
            DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
            InputSource is = new InputSource(new StringReader(xmlData));
            Document doc = builder.parse(is);
            doc.getDocumentElement().normalize();

            Element appHdr = (Element) doc.getElementsByTagNameNS("*", "AppHdr").item(0);
            Element pmtRtr = (Element) doc.getElementsByTagNameNS("*", "PmtRtr").item(0);

            PaymentReturnDto info = new PaymentReturnDto();

            // AppHdr fields
            info.setBizMsgId(getElementText(appHdr, "BizMsgIdr"));
            info.setMsgDefId(getElementText(appHdr, "MsgDefIdr"));
            info.setCreationDate(getElementText(appHdr, "CreDt"));
            info.setFromMemberId(getElementText(appHdr, "MmbId"));
            info.setToBic(getElementText(appHdr, "BICFI"));
            info.setToMemberId(getElementsByTagNameWithTag(appHdr, "MmbId", 1));

            // GrpHdr fields
            Element grpHdr = (Element) pmtRtr.getElementsByTagNameNS("*", "GrpHdr").item(0);
            info.setGroupMsgId(getElementText(grpHdr, "MsgId"));
            info.setNbOfTxs(getElementText(grpHdr, "NbOfTxs"));
            info.setTotalAmount(getElementText(grpHdr, "TtlRtrdIntrBkSttlmAmt"));
            info.setCurrency(getAttribute(grpHdr, "TtlRtrdIntrBkSttlmAmt", "Ccy"));
            info.setSettlementDate(getElementText(grpHdr, "IntrBkSttlmDt"));

            // TxInf fields
            Element txInf = (Element) pmtRtr.getElementsByTagNameNS("*", "TxInf").item(0);
            info.setReturnId(getElementText(txInf, "RtrId"));
            info.setOriginalMsgId(getElementText(txInf, "OrgnlMsgId"));
            info.setOriginalEndToEndId(getElementText(txInf, "OrgnlEndToEndId"));
            info.setOriginalTxId(getElementText(txInf, "OrgnlTxId"));
            info.setOriginalAmount(getElementText(txInf, "OrgnlIntrBkSttlmAmt"));
            info.setReturnedAmount(getElementText(txInf, "RtrdIntrBkSttlmAmt"));
            info.setReturnReason(getElementText(txInf, "Cd"));
            info.setDebtorName(getElementText(txInf, "Nm"));
            info.setDebtorAccount(getElementText(txInf, "DbtrAcct", "Id", "Othr", "Id"));
            info.setCreditorName(getElementText(txInf, "Cdtr", "Nm"));
            info.setCreditorAccount(getElementText(txInf, "CdtrAcct", "Id", "Othr", "Id"));

            return info;

        } catch (Exception e) {
            e.printStackTrace();
            return null; // or throw a custom exception
        }
    }

}
