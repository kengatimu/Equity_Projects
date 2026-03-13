package com.equitybank.gag.papss.ips.service;

import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;

public interface CallbackService {
    void sendCallback(String state, String creditTransferXmlRequest) throws ParserConfigurationException, IOException, SAXException;
}
