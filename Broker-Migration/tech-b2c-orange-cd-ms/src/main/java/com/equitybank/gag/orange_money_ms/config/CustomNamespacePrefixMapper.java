package com.equitybank.gag.orange_money_ms.config;

import com.sun.xml.bind.marshaller.NamespacePrefixMapper;

public class CustomNamespacePrefixMapper extends NamespacePrefixMapper {
    @Override
    public String getPreferredPrefix(String namespaceUri, String suggestion, boolean requirePrefix) {
        if ("http://schemas.xmlsoap.org/soap/envelope/".equals(namespaceUri)) {
            return "soap";
        }
        if ("http://b2w.banktowallet.com/b2w".equals(namespaceUri)) {
            return "ns2";
        }
        return suggestion;
    }
}
