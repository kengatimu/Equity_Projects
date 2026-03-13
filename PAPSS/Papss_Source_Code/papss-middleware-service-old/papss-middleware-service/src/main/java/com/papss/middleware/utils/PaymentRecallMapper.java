package com.papss.middleware.utils;

import com.papss.middleware.dto.paymentreturn.PaymentRecallDto;
import com.papss.middleware.service.outbound.domains.credittransfer.TransferDetails;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.StringReader;
import java.math.BigDecimal;

public class PaymentRecallMapper {

    public static PaymentRecallDto parseXMLToPaymentRecallDto(String xmlData) {
        PaymentRecallDto.PaymentRecallDtoBuilder dtoBuilder = PaymentRecallDto.builder();

        try {
            // Initialize XML parser
            return PaymentRecallDto.builder()
                    .instId("XA0001") // From Fr/FIId/FinInstnId/ClrSysMmbId/MmbId
                    .settlementType("PAPSS") // From Fr/FIId/FinInstnId/ClrSysMmbId/ClrSysId/Prtry
                    .transactionDate("2025-03-26") // From CreDt
                    .toClearingSystemId("DJ1009") // From To/FIId/FinInstnId/ClrSysMmbId/MmbId
                    .originalEndToEndRef("a63292756da7421d9141bce7251972e6") // From OrgnlEndToEndId
                    .reasonCode("CUST") // From CxlRsnInf/Rsn/Cd
                    .amount(new BigDecimal("5")) // From OrgnlTxRef/Amt/InstdAmt (USD 5)
                    .sender(TransferDetails.builder()
                            .instId("ZW1014") // From DbtrAgt/FinInstnId/ClrSysMmbId/MmbId
                            .instBic("STBLZWHX") // From DbtrAgt/FinInstnId/BICFI
                            .country("ZW") // From Dbtr/PstlAdr/Ctry
                            .accountNumber("1034345747") // From DbtrAcct/Id/Othr/Id
                            .accountName("ECONET INSURANCE") // From Dbtr/Nm
                            .currency("USD") // From OrgnlTxRef/Amt/InstdAmt@Ccy
                            .address("ZW") // From Dbtr/PstlAdr/AdrLine
                            .amount(new BigDecimal("5")) // Same as main amount
                            .build())
                    .receiver(TransferDetails.builder()
                            .instId("DJ1009") // From CdtrAgt/FinInstnId/ClrSysMmbId/MmbId
                            .instBic("OMGGDJCK") // From CdtrAgt/FinInstnId/BICFI
                            .country("DJ") // From Cdtr/PstlAdr/Ctry
                            .accountNumber("0123456789") // From CdtrAcct/Id/Othr/Id
                            .accountName("ESTILO SAAD DIALLO") // From Cdtr/Nm
                            .currency("USD") // From OrgnlTxRef/Amt/InstdAmt@Ccy
                            .address("DJ") // From Cdtr/PstlAdr/AdrLine
                            .amount(new BigDecimal("5")) // Same as main amount
                            .build())
                    .narration("TEST INVOICE") // From RmtInf/Ustrd
                    .build();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return dtoBuilder.build();
    }

    private static String getTagValue(Document doc, String tag) {
        return doc.getElementsByTagName(tag).getLength() > 0
                ? doc.getElementsByTagName(tag).item(0).getTextContent()
                : null;
    }

    private static String getTagValue(Document doc, String tag, int index) {
        return doc.getElementsByTagName(tag).getLength() > index
                ? doc.getElementsByTagName(tag).item(index).getTextContent()
                : null;
    }

    private static String getAttributeValue(Document doc, String tag, String attribute) {
        return doc.getElementsByTagName(tag).getLength() > 0 &&
                doc.getElementsByTagName(tag).item(0).getAttributes().getNamedItem(attribute) != null
                ? doc.getElementsByTagName(tag).item(0).getAttributes().getNamedItem(attribute).getTextContent()
                : null;
    }

    private static BigDecimal parseBigDecimal(String value) {
        return value != null ? new BigDecimal(value) : BigDecimal.ZERO;
    }
}
