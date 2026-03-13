package com.papss.middleware.utils;

import com.papss.middleware.service.outbound.domains.creditreturn.CreditReturnRequest;
import com.papss.middleware.service.outbound.domains.creditreturn.OriginalTran;
import com.papss.middleware.service.outbound.domains.creditreturn.SupplementaryDataDto;
import com.papss.middleware.service.outbound.domains.credittransfer.TransferDetails;
import montran.message.Message;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.XMLConstants;
import javax.xml.namespace.NamespaceContext;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;
import java.io.ByteArrayInputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;
import java.util.*;

public class CreditReturnMapper {

    public static CreditReturnRequest mapXmlToCreditReturnRequest(Message message) throws Exception {

        CreditReturnRequest request = new CreditReturnRequest();
        request.setEndToEndRef(message.getPmtRtr().getTxInves().get(0).getOrgnlEndToEndId());
        request.setReturnReasonCode(message.getPmtRtr().getTxInves().get(0).getRtrRsnInves().get(0).getRsn().getCd());
        request.setInstBic(message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getDbtrAgt().getFinInstnId().getBICFI());
        request.setInstId(message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getDbtrAgt().getFinInstnId().getClrSysMmbId().getMmbId());
        request.setTranDateTime(getDate(message.getPmtRtr().getGrpHdr().getCreDtTm()));

        OriginalTran tran = new OriginalTran();
        tran.setTransRef(message.getPmtRtr().getTxInves().get(0).getRtrId());
        tran.setTranDateTime(request.getTranDateTime());
       // tran.setCategoryPurpose();
        tran.setNarration(message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getRmtInf().getUstrds().get(0));
        tran.setEndToEndRef(request.getEndToEndRef());
        tran.setLocalInstrumentType(message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getPmtTpInf().getLclInstrm().getCd());
        tran.setInstId(request.getInstId());
        tran.setIsInvoice(false); // Default value

        TransferDetails receiver = TransferDetails.builder()//receiver
                .instId(message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getDbtrAgt().getFinInstnId().getClrSysMmbId().getMmbId())
                .instBic(message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getDbtrAgt().getFinInstnId().getBICFI())
                .country(message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getDbtr().getPstlAdr().getCtry())
                .accountNumber(message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getDbtrAcct().getId().getOthr().getId())
                .accountName(message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getDbtr().getNm())
                .currency(message.getPmtRtr().getTxInves().get(0).getRtrdIntrBkSttlmAmt().getCcy())
                .address(message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getDbtr().getPstlAdr().getAdrLines().get(0))
                .amount(message.getPmtRtr().getTxInves().get(0).getRtrdIntrBkSttlmAmt().getValue())
                .build();


        TransferDetails sender = TransferDetails.builder()///

                .instId(message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getCdtrAgt().getFinInstnId().getClrSysMmbId().getMmbId())
                .instBic(message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getCdtrAgt().getFinInstnId().getBICFI())
                .country(message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getCdtr().getPstlAdr().getCtry())
                .accountNumber(message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getDbtrAcct().getId().getOthr().getId())
                .accountName(message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getCdtr().getNm())
                .currency(message.getPmtRtr().getTxInves().get(0).getOrgnlIntrBkSttlmAmt().getCcy())
                .amount(message.getPmtRtr().getTxInves().get(0).getOrgnlIntrBkSttlmAmt().getValue())
                .address(message.getPmtRtr().getTxInves().get(0).getOrgnlTxRef().getCdtr().getPstlAdr().getAdrLines().get(0))
                .build();

        tran.setSender(sender);
        tran.setReceiver(receiver);

        request.setOriginalTran(tran);

        // Extract supplementary data
        //SupplementaryDataDto supplementaryData = extractSupplementaryData(message.getPmtRtr().getSplmtryDatas().get(0).getEnvlp().getAny());
        //request.setSupplementaryData(supplementaryData);

        return request;
    }

    private static SupplementaryDataDto extractSupplementaryData(Element element) {
        return null;
    }

    private static String getDate(Calendar calendar){
        SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd'T'HH:mm:ss'Z'");
        sdf.setTimeZone(TimeZone.getTimeZone("UTC")); // Optional: for UTC output
        return sdf.format(calendar.getTime());
    }
}
