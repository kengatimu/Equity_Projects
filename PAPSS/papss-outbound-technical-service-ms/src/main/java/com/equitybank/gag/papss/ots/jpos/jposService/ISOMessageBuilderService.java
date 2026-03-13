package com.equitybank.gag.papss.ots.jpos.jposService;

import com.equitybank.gag.papss.ots.dto.channelRequest.statusCheck.ChannelStatusCheckDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.exception.CustomException;
import org.jpos.iso.ISOMsg;

public interface ISOMessageBuilderService {
    ISOMsg buildPrincipalISOMessage(ChannelCreditTransferDetailsReq request, String messageId) throws CustomException;

    ISOMsg buildChargesISOMessage(ChannelCreditTransferDetailsReq request, String messageId) throws CustomException;

    ISOMsg buildReversalFromOriginalIso(ISOMsg originalIso, String rrn) throws CustomException;

    ISOMsg buildTransactionStatusISOMessage(ChannelStatusCheckDetailsReq request) throws CustomException;

    ISOMsg buildAccountInquiryISOMessage(String accountNumber) throws CustomException;

}
