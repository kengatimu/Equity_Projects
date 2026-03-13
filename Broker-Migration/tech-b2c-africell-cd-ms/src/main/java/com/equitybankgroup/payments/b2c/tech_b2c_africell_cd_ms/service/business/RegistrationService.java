/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.service.business;

import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.constants.AfricellConstants;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input.ChannelDeregistrationReq;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input.EazInqRequest;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input.Eazzycash;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input.Eazzycashres1;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input.InquireResponse;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.model.TelcoRegistration;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.repository.TelcoRegistrationRepository;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.service.business.http.OutboundHttpAdapter;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.service.util.MiscUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;

/**
 * @author ronaldcheruiyot
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class RegistrationService {

    private final TelcoRegistrationRepository telcoRegistrationRepository;

    private final OutboundHttpAdapter httpAdapter;

    private final AfricellUtil africellUtil;

    @Value("${africell.cd.token.registrationURL}")
    private String registrationURL;

    public List<TelcoRegistration> registrationsAll() {
        return telcoRegistrationRepository.findAll();
    }

    public InquireResponse deRegister(ChannelDeregistrationReq channelDeregistrationReq) {
        String msisdn = channelDeregistrationReq.getMsisdn();
        String rrn = channelDeregistrationReq.getRrn();
        String currency = channelDeregistrationReq.getCurrency();
        if (MiscUtil.isNullOrEmpty(rrn)) {
            rrn = MiscUtil.generateRandomRRN(12);
        }
        String sourceAccount = channelDeregistrationReq.getSourceAccountNumber();
        log.info("msisdn: " + msisdn);
        log.info("sourceAccount: " + sourceAccount);
        EazInqRequest inqRequest = new EazInqRequest();
        Eazzycash eazzycash = new Eazzycash();
        eazzycash.setRrn(rrn);
        inqRequest.setMsgId(Integer.valueOf(MiscUtil.generateRandomRRN(9)));
        inqRequest.setEazzycash(eazzycash);
        if (MiscUtil.isNullOrEmpty(msisdn)) {
            return this.writeServletErrorMsg("Validation failure: msisdn cannot be null or empty", "FAILED", "400", inqRequest);

        }

        if (MiscUtil.isNullOrEmpty(sourceAccount)) {
            return this.writeServletErrorMsg("Validation failure: sourceAccount cannot be null or empty", "FAILED", "400", inqRequest);

        }

        try {
            List<TelcoRegistration> registrations = telcoRegistrationRepository.findByMsisdAndSourceAccountList(msisdn, sourceAccount, "CD", currency);
            if (!registrations.isEmpty()) {
                HttpHeaders headers = new HttpHeaders();
                headers.add("Content-Type", "application/xml");
                headers.add("Authorization", "Bearer " + africellUtil.getAfricellRegistrationToken());
                TelcoRegistration telcoRegistration = registrations.get(0);

                String deregStr = telcoRegistrationToDeRegistrationReq(telcoRegistration);
                String responseStr = httpAdapter.httpPost(registrationURL.replaceAll("BankRegX/1.0", "BankDeRegX/1.0"), headers, deregStr);

                if (MiscUtil.isNullOrEmpty(responseStr)) {
                    log.info(rrn + "|De-Registration was not successful! response is null");
                    return this.writeServletErrorMsg("Registration was not successful! response is null", "FAILED", "13", inqRequest);
                }
                Map<String, String> map = MiscUtil.extractAllTagValues(responseStr);
                String TXNSTATUS = map.get(AfricellConstants.AFRICELL_REGISTRATION_RESPONSE_TXNSTATUS);
                String TXNSTATUSEIG = map.get(AfricellConstants.AFRICELL_REGISTRATION_RESPONSE_TXNSTATUSEIG);
                String MESSAGE = map.get(AfricellConstants.AFRICELL_REGISTRATION_RESPONSE_MESSAGE);
                String TRID = map.get(AfricellConstants.AFRICELL_REGISTRATION_RESPONSE_TRID);
                String TXNID = map.get(AfricellConstants.AFRICELL_REGISTRATION_RESPONSE_TXNID);
                String message = "Registration failed!";
                String telcoStatusCode = "13";
                if (!MiscUtil.isNullOrEmpty(MESSAGE)) {
                    message = MESSAGE;
                }

                if (!MiscUtil.isNullOrEmpty(TXNSTATUSEIG)) {
                    telcoStatusCode = TXNSTATUSEIG;
                }

                if (MiscUtil.isNullOrEmpty(TXNSTATUS)) {
                    log.info(rrn + "|De-Registration was not successful! TXNSTATUS is not found");

                    return this.writeServletErrorMsg(message, "FAILED", telcoStatusCode, inqRequest);
                }

                if (TXNSTATUS.equalsIgnoreCase("200") && TXNSTATUSEIG.equalsIgnoreCase("200")) {
                    log.info(rrn + "|De-Registration successful.");
                    message = message + " TXNID: " + TXNID;
                    telcoRegistrationRepository.deleteAll(registrations);
                    return this.writeServletSuccessMsg(message, rrn, TRID, String.valueOf(inqRequest.getMsgId()));

                }
                return this.writeServletErrorMsg(message, "FAILED", telcoStatusCode, inqRequest);
            }

            return this.writeServletErrorMsg("Details not found in local database.", "FAILED", "11", inqRequest);
        } catch (Exception e) {
            e.printStackTrace(System.out);
            return this.writeServletErrorMsg("Error occurred: " + e.getMessage(), "FAILED", "500", inqRequest);
        }
    }

    public InquireResponse register(EazInqRequest inqRequest) throws Exception {

        TelcoRegistration telcoRegistration = eazInqRequestToTelcoRegistration(inqRequest);
        String rrn = inqRequest.getEazzycash().getRrn();
        String msisdn = inqRequest.getEazzycash().getNumber();
        String currency = inqRequest.getEazzycash().getCurrency();
        msisdn = MiscUtil.formatAfricellNumber(msisdn);
        telcoRegistration.setMsisdn(msisdn);
        inqRequest.getEazzycash().setNumber(msisdn);
        String sourceAccount = inqRequest.getEazzycash().getSourceAccount();
        String senderIdNumber = inqRequest.getEazzycash().getSenderIdNumber();
        List<TelcoRegistration> existingOpt = telcoRegistrationRepository.findByMsisdAndSourceAccountList(msisdn, sourceAccount, "CD", currency);
//        if (!existingOpt.isEmpty()) {
//            TelcoRegistration existing = existingOpt.get(0);
//            String status = existing.getStatus();
//            log.info(rrn + "| Registration exists, status: " + status);
//            log.info(rrn + "| Confirming with Africell...");
//            updateIdNumberIfRequired(existingOpt, senderIdNumber, currency);
//        } else {
//            updateIdNumberIfRequired(existingOpt, senderIdNumber, currency);
//            existingOpt = telcoRegistrationRepository.saveAll(existingOpt);
//            if(existingOpt.isEmpty()) throw new Exception("Could not update registration details in local db.");
//            telcoRegistration = existingOpt.get(0);
//        }

        if (existingOpt != null && !existingOpt.isEmpty()) {
            log.info("Retrieved {} records:", existingOpt.size());
            for (TelcoRegistration record : existingOpt) {
                log.info("Record Details: {}", record);
            }

            TelcoRegistration existing = existingOpt.get(0);
            String status = existing.getStatus();
            log.info(rrn + "| Registration exists, status: " + status);
            log.info(rrn + "| Confirming with Africell...");
            updateIdNumberIfRequired(existingOpt, senderIdNumber, currency);
        } else {
            log.info("List is empty. No existing registrations found.");

            existingOpt = new ArrayList<>();
            updateIdNumberIfRequired(existingOpt, senderIdNumber, currency);

            if (existingOpt.isEmpty()) {
                log.warn("No valid registrations found to update. Skipping save operation.");
            } else {
                existingOpt = telcoRegistrationRepository.saveAll(existingOpt);

                if (existingOpt.isEmpty()) {
                    throw new Exception("Could not update registration details in local DB.");
                }

                telcoRegistration = existingOpt.get(0);
            }
        }

        String registStrationReq = telcoRegistrationToRegistrationReq(telcoRegistration);
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Type", "application/xml");
        headers.add("Authorization", "Bearer " + africellUtil.getAfricellRegistrationToken());
        MiscUtil.printHeaders(headers, "transaction");
        String responseStr = httpAdapter.httpPost(registrationURL, headers, registStrationReq);
        if (MiscUtil.isNullOrEmpty(responseStr)) {
            log.info(rrn + "|Registration was not successful! response is null");
            telcoRegistration.setStatus("FAILED");
            telcoRegistrationRepository.deleteAll(existingOpt);
            return this.writeServletErrorMsg("Registration was not successful! response is null", "FAILED", "13", inqRequest);
        }
        Map<String, String> map = MiscUtil.extractAllTagValues(responseStr);
        String TXNSTATUS = map.get(AfricellConstants.AFRICELL_REGISTRATION_RESPONSE_TXNSTATUS);
        String TXNSTATUSEIG = map.get(AfricellConstants.AFRICELL_REGISTRATION_RESPONSE_TXNSTATUSEIG);
        String MESSAGE = map.get(AfricellConstants.AFRICELL_REGISTRATION_RESPONSE_MESSAGE);
        String TRID = map.get(AfricellConstants.AFRICELL_REGISTRATION_RESPONSE_TRID);
        String TXNID = map.get(AfricellConstants.AFRICELL_REGISTRATION_RESPONSE_TXNID);
        String message = "Registration failed!";
        String telcoStatusCode = "13";
        if (!MiscUtil.isNullOrEmpty(MESSAGE)) {
            message = MESSAGE;
        }

        if (!MiscUtil.isNullOrEmpty(TXNSTATUSEIG)) {
            telcoStatusCode = TXNSTATUSEIG;
        }

        if (MiscUtil.isNullOrEmpty(TXNSTATUS)) {
            log.info(rrn + "|Registration was not successful!");
            telcoRegistration.setStatus("FAILED");
            telcoRegistrationRepository.save(telcoRegistration);
            return this.writeServletErrorMsg(message, "FAILED", telcoStatusCode, inqRequest);
        }

        if (TXNSTATUS.equalsIgnoreCase("200") && TXNSTATUSEIG.equalsIgnoreCase("00")) {
            log.info(rrn + "|Registration successful.");
            telcoRegistration.setRegistrationId(TRID);
            telcoRegistration.setStatus("COMPLETED");
            telcoRegistrationRepository.save(telcoRegistration);
            return this.writeServletSuccessMsg(message, rrn, TRID, String.valueOf(inqRequest.getMsgId()));

        }

        if (TXNSTATUS.equalsIgnoreCase("5524") && TXNSTATUSEIG.equalsIgnoreCase("01")) {
            log.info(rrn + "|Registration already exists.");
            telcoRegistration.setRegistrationId(TXNID);
            telcoRegistration.setStatus("COMPLETED");
            telcoRegistrationRepository.save(telcoRegistration);
            return this.writeServletSuccessMsg(message, rrn, TXNID, String.valueOf(inqRequest.getMsgId()));

        }

        telcoRegistration.setStatus("FAILED");
        telcoRegistrationRepository.save(telcoRegistration);
        return this.writeServletErrorMsg(message, "FAILED", telcoStatusCode, inqRequest);

        /*
        <COMMAND>
 <TYPE>BANKREG</TYPE>
 <TXNSTATUS>200</TXNSTATUS>
 <TXNID>XX180628.0235.C00064</TXNID>
Mobiquity Page 9
 <TXNSTATUSEIG>00</TXNSTATUSEIG>
 <MSISDN>7701536335</MSISDN>
 <DATE>0628023516</DATE>
 <TIME>023516</TIME>
 <MESSAGE>Your Bank Account Successfully Registration and
Service charge RUB : deducted from your wallet </MESSAGE>
 <TRID>7701536335201806280235C0642</TRID>
</COMMAND>
         */
    }

//    private void updateIdNumberIfRequired(List<TelcoRegistration> telcoRegistrations, String senderIdNumber, String currency) throws Exception {
//        for(TelcoRegistration telcoRegistration : telcoRegistrations) {
//            if (MiscUtil.isNullOrEmpty(telcoRegistration.getIdNumber())) {
//                telcoRegistration.setIdNumber(senderIdNumber);
//                telcoRegistration.setCurrency(currency);
//            }
//
//            if (MiscUtil.isNullOrEmpty(telcoRegistration.getIdNumber())) {
//                throw new Exception("Sender ID number required for registration!");
//            }
//        }
//    }

    private void updateIdNumberIfRequired(List<TelcoRegistration> telcoRegistrations, String senderIdNumber, String currency) throws Exception {
        if (telcoRegistrations == null || telcoRegistrations.isEmpty()) {
            log.info("No registrations found to update.");
            return;
        }

        if (MiscUtil.isNullOrEmpty(senderIdNumber)) {
            throw new Exception("Sender ID number is required but missing!");
        }

        for (TelcoRegistration telcoRegistration : telcoRegistrations) {
            if (MiscUtil.isNullOrEmpty(telcoRegistration.getIdNumber())) {
                log.info("Updating idNumber for registration ID: {}", telcoRegistration.getId());
                telcoRegistration.setIdNumber(senderIdNumber);
                telcoRegistration.setCurrency(currency);
            }
        }
    }

    public TelcoRegistration eazInqRequestToTelcoRegistration(EazInqRequest inqRequest) {
        String[] names = MiscUtil.splitBySpace(inqRequest.getEazzycash().getName(), inqRequest.getEazzycash().getSourceAccount());
        TelcoRegistration telcoRegistration = new TelcoRegistration();
        telcoRegistration.setCountryCode("CD");
        telcoRegistration.setFirstName(names[0]);
        telcoRegistration.setLastName(names[1]);
        telcoRegistration.setGrade("P2P");
        telcoRegistration.setIsBarred(false);
        telcoRegistration.setIsPinSet(true);
        telcoRegistration.setIsActive(false);
        telcoRegistration.setMsisdn(inqRequest.getEazzycash().getNumber());
        telcoRegistration.setTelco("AFRICELL");
        telcoRegistration.setCurrency(inqRequest.getEazzycash().getCurrency());
        telcoRegistration.setSourceAccountNumber(inqRequest.getEazzycash().getSourceAccount());
        telcoRegistration.setStatus("PENDING");
        telcoRegistration.setIdNumber(inqRequest.getEazzycash().getSenderIdNumber());
        return telcoRegistration;
    }

    public String telcoRegistrationToRegistrationReq(TelcoRegistration telcoRegistration) {
        String provider = "102";
        String bankId = "BE cdf";
        String currency = telcoRegistration.getCurrency();
        if (telcoRegistration.getCurrency().equals("USD")) {
            provider = "101";
            bankId = "BE usd";
        }
        return "<COMMAND>\n"
                + "    <TYPE>BANKREG</TYPE>\n"
                + "    <LANGUAGE>1</LANGUAGE>\n"
                + "    <BANKID>" + bankId + "</BANKID>\n"
                + "    <BANKNAME>BCDC EQUITY " + currency + "</BANKNAME>\n"
                + "    <MSISDN>" + telcoRegistration.getMsisdn() + "</MSISDN>\n"
                + "    <PROVIDER>" + provider + "</PROVIDER>\n"
                + "    <PAYID>12</PAYID>\n"
                + "    <FNAME>" + telcoRegistration.getFirstName() + "</FNAME>\n"
                + "    <LNAME>" + telcoRegistration.getLastName() + "</LNAME>\n"
                + "    <USERROLE>Customer</USERROLE>\n"
                + "    <BANKACCNUMBER>" + telcoRegistration.getSourceAccountNumber() + "</BANKACCNUMBER>\n"
                + "    <CUSTOMERID>" + telcoRegistration.getIdNumber() + "</CUSTOMERID>\n"
                + "</COMMAND>";
    }

    public String telcoRegistrationToDeRegistrationReq(TelcoRegistration telcoRegistration) {
        String provider = "102";
        String bankId = "BE cdf";
        String currency = telcoRegistration.getCurrency();
        if (telcoRegistration.getCurrency().equals("USD")) {
            provider = "101";
            bankId = "BE usd";
        }
        return "<COMMAND>\n"
                + " <TYPE>BKDREG</TYPE>\n"
                + " <LANGUAGE>1</LANGUAGE>\n"
                + " <BANKID>" + bankId + "</BANKID>\n"
                + " <BANKNAME>BCDC EQUITY " + currency + "</BANKNAME>\n"
                + " <MSISDN>" + telcoRegistration.getMsisdn() + "</MSISDN>\n"
                + " <PROVIDER>" + provider + "</PROVIDER>\n"
                + " <PAYID>12</PAYID>\n"
                + " <FNAME>" + telcoRegistration.getFirstName() + "</FNAME>\n"
                + " <LNAME>" + telcoRegistration.getLastName() + "</LNAME>\n"
                + " <USERROLE>Customer</USERROLE>\n"
                + " <BRANCHCODE>BRANCH1</BRANCHCODE>\n"
                + " <IDNO>" + telcoRegistration.getIdNumber() + "</IDNO>\n"
                + " <BANKACCNUMBER>" + telcoRegistration.getSourceAccountNumber() + "</BANKACCNUMBER>\n"
                + "</COMMAND>";
    }

    private InquireResponse writeServletErrorMsg(String msg, String status, String telcoStatusCode, EazInqRequest inqRequest) {
        InquireResponse resp = new InquireResponse();
        Eazzycashres1 eazzycashres = new Eazzycashres1();
        resp.setEazzycashres(eazzycashres);
        String rrn = inqRequest.getEazzycash().getRrn();
        String msgId = String.valueOf(inqRequest.getMsgId());
        try {
            resp.setMsgId(((msgId != null) && !msgId.isEmpty()) ? msgId : rrn);
            if ((status != null) && !(status.isEmpty())) {
                (resp.getEazzycashres()).status = "ERROR|" + status;
            } else {
                (resp.getEazzycashres()).status = "ERROR";
            }

            if ((msg != null) && !(msg.isEmpty())) {
                (resp.getEazzycashres()).responseDesc = msg;
            }

            if ((telcoStatusCode != null) && !(telcoStatusCode.isEmpty())) {
                (resp.getEazzycashres()).responseCode = telcoStatusCode;
            }
            return resp;
        } catch (Exception ex) {
            ex.printStackTrace(System.out);
        }
        return null;
    }

    private InquireResponse writeServletSuccessMsg(String msg, String rrn, String tranID, String msgId) {
        try {
            InquireResponse resp = new InquireResponse();
            Eazzycashres1 eazzycashres = new Eazzycashres1();
            eazzycashres.status = "OK|" + tranID;
            eazzycashres.responseCode = "00";
            eazzycashres.walletTranID = tranID;
            if ((msg != null) && !(msg.isEmpty())) {
                eazzycashres.responseDesc = msg;
            }
            resp.setMsgId(((msgId != null) && !msgId.isEmpty()) ? msgId : rrn);
            resp.setEazzycashres(eazzycashres);

            return resp;
        } catch (Exception ex) {
            ex.printStackTrace(System.out);
        }
        return null;
    }

    public static void main(String[] args) {
        System.out.println(Integer.valueOf(MiscUtil.generateRandomRRN(9)));
    }

}
