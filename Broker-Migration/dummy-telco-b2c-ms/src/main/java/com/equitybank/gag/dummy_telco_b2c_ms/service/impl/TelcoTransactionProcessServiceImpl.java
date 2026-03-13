package com.equitybank.gag.dummy_telco_b2c_ms.service.impl;

import com.equitybank.gag.dummy_telco_b2c_ms.service.TelcoTransactionProcessService;
import org.springframework.stereotype.Service;

@Service
public class TelcoTransactionProcessServiceImpl implements TelcoTransactionProcessService {

    @Override
    public String feeLookupFailure() {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<soap:Envelope\n" +
                "    xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
                "    <soap:Body>\n" +
                "        <ns2:AccountToWalletTransferResponse\n" +
                "            xmlns:ns2=\"http://b2w.banktowallet.com/b2w\">\n" +
                "            <return>\n" +
                "                <mmHeaderInfo>\n" +
                "                    <operatorCode>ORANGEMONEYML</operatorCode>\n" +
                "                    <requestId>OR2403282DU9Q8</requestId>\n" +
                "                    <affiliateCode>EML</affiliateCode>\n" +
                "                    <responseCode>000</responseCode>\n" +
                "                    <responseMessage>Success</responseMessage>\n" +
                "                </mmHeaderInfo>\n" +
                "                <CBAReferenceNo>240328140102236</CBAReferenceNo>\n" +
                "            </return>\n" +
                "        </ns2:AccountToWalletTransferResponse>\n" +
                "    </soap:Body>\n" +
                "</soap:Envelope>";
    }

    @Override
    public String feeLookupSuccess() {
        return "<Envelope>\n" +
                "    <Body>\n" +
                "        <topupResponse>\n" +
                "            <return>OK|100100</return>\n" +
                "        </topupResponse>\n" +
                "    </Body>\n" +
                "</Envelope>";
    }
//
//    @Override
//    public String feeLookupSuccess() {
//        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
//                "<soap:Envelope\n" +
//                "    xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
//                "    <soap:Body>\n" +
//                "        <ns2:topupResponse\n" +
//                "            xmlns:ns2=\"http://business.airtime.telcos.equitybank.com/\"\n" +
//                "            xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:type=\"ns2:topupResponse\">\n" +
//                "            <return>ERROR|-3</return>\n" +
//                "        </ns2:topupResponse>\n" +
//                "    </soap:Body>\n" +
//                "</soap:Envelope>";
//    }

    @Override
    public String responseFinalStatusSuccess() {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<soap:Envelope\n" +
                "    xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
                "    <soap:Body>\n" +
                "        <ns2:AccountToWalletTransferResponse\n" +
                "            xmlns:ns2=\"http://b2w.banktowallet.com/b2w\">\n" +
                "            <return>\n" +
                "                <mmHeaderInfo>\n" +
                "                    <operatorCode>ORANGEMONEYML</operatorCode>\n" +
                "                    <requestId>OR2403282DU9Q8</requestId>\n" +
                "                    <affiliateCode>EML</affiliateCode>\n" +
                "                    <responseCode>000</responseCode>\n" +
                "                    <responseMessage>Success</responseMessage>\n" +
                "                </mmHeaderInfo>\n" +
                "                <CBAReferenceNo>12340000</CBAReferenceNo>\n" +
                "            </return>\n" +
                "        </ns2:AccountToWalletTransferResponse>\n" +
                "    </soap:Body>\n" +
                "</soap:Envelope>";
    }

    @Override
    public String responsePendingStatusSuccess() {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<soap:Envelope\n" +
                "    xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
                "    <soap:Body>\n" +
                "        <ns2:AccountToWalletTransferResponse\n" +
                "            xmlns:ns2=\"http://b2w.banktowallet.com/b2w\">\n" +
                "            <return>\n" +
                "                <mmHeaderInfo>\n" +
                "                    <operatorCode>ORANGEMONEYML</operatorCode>\n" +
                "                    <requestId>OR2403282DU9Q8</requestId>\n" +
                "                    <affiliateCode>EML</affiliateCode>\n" +
                "                    <responseCode>E11</responseCode>\n" +
                "                    <responseMessage>Operation in Timeout. Use TransferStatusInquiry to check status</responseMessage>\n" +
                "                </mmHeaderInfo>\n" +
                "                <CBAReferenceNo>240328140102236</CBAReferenceNo>\n" +
                "            </return>\n" +
                "        </ns2:AccountToWalletTransferResponse>\n" +
                "    </soap:Body>\n" +
                "</soap:Envelope>";
    }

    @Override
    public String responseFinalStatusFailure() {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" +
                "<soap:Envelope\n" +
                "    xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n" +
                "    <soap:Body>\n" +
                "        <ns2:AccountToWalletTransferResponse\n" +
                "            xmlns:ns2=\"http://b2w.banktowallet.com/b2w\">\n" +
                "            <return>\n" +
                "                <mmHeaderInfo>\n" +
                "                    <operatorCode>ORANGEMONEYML</operatorCode>\n" +
                "                    <requestId>OR2403282DU9Q8</requestId>\n" +
                "                    <affiliateCode>EML</affiliateCode>\n" +
                "                    <responseCode>E01</responseCode>\n" +
                "                    <responseMessage>Bank Technical Error</responseMessage>\n" +
                "                </mmHeaderInfo>\n" +
                "                <CBAReferenceNo>240328140102236</CBAReferenceNo>\n" +
                "            </return>\n" +
                "        </ns2:AccountToWalletTransferResponse>\n" +
                "    </soap:Body>\n" +
                "</soap:Envelope>";
    }
}
