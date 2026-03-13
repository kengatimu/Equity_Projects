/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybankgroup.payments.b2c.controller.business;

import com.equitybankgroup.payments.b2c.dto.airtel.AirtelDTO;
import com.equitybankgroup.payments.b2c.dto.airtel.Airtelb2cOpenApiConstants;
import com.equitybankgroup.payments.b2c.dto.airtel.Airtelb2cResponse;
import com.equitybankgroup.payments.b2c.dto.airtel.StatusCodes;
import com.equitybankgroup.payments.b2c.dto.airtel.contants.TPGConstants;
import com.equitybankgroup.payments.b2c.dto.input.EazInqRequest;
import com.equitybankgroup.payments.b2c.dto.input.Eazzycashres;
import com.equitybankgroup.payments.b2c.dto.input.InqResponse;
import com.equitybankgroup.payments.b2c.dto.input.InquireRequest;
import com.equitybankgroup.payments.b2c.dto.namecheck.MobileNumberInquireReq;
import com.equitybankgroup.payments.b2c.dto.namecheck.MobileNumberInquireRes;
import com.equitybankgroup.payments.b2c.enums.RequestTypes;
import com.equitybankgroup.payments.b2c.enums.TranStatus;
import com.equitybankgroup.payments.b2c.enums.TransactionStatus;
import com.equitybankgroup.payments.b2c.model.StatusDetails;
import com.equitybankgroup.payments.b2c.model.TransactionDetails;
import com.equitybankgroup.payments.b2c.repository.StatusDetailsRepository;
import com.equitybankgroup.payments.b2c.repository.TransactionDetailsRepository;
import com.equitybankgroup.payments.b2c.service.business.OpenAPIAirtelBankToWalletService;
import com.equitybankgroup.payments.b2c.service.business.allocation.OpenAPIAirtelAllocationService;
import com.equitybankgroup.payments.b2c.service.util.MiscUtil;

import java.io.StringWriter;
import java.util.Optional;

import jakarta.xml.bind.JAXBContext;
import jakarta.xml.bind.JAXBException;
import jakarta.xml.bind.Marshaller;

import javax.xml.parsers.ParserConfigurationException;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.xml.sax.SAXException;

/**
 * @author ronaldcheruiyot
 */
@RestController
@RequestMapping("/api/v1")
@Slf4j
public class AirtelController {

    @Autowired
    OpenAPIAirtelBankToWalletService openAPIAirtelUgBankToWalletService;

    @Autowired
    StatusDetailsRepository statusDetailsRepository;

    @Autowired
    OpenAPIAirtelAllocationService buyFloatService;

    @Autowired
    TransactionDetailsRepository transactionDetailsRepository;

    @PostMapping("/banktowallet/status")
    public ResponseEntity<?> statusCheck(@RequestBody String requestStr) {
        String rrn = null;
        String msgId = null;
        try {
            System.out.println("INCOMING STATUS CHECK REQUEST####\n" + requestStr);
            InquireRequest inqRequest = (InquireRequest) MiscUtil.strToObject(requestStr, InquireRequest.class);
            rrn = inqRequest.getEazzycash().getRrn();
            msgId = !MiscUtil.isNullOrEmpty(inqRequest.getMsgId()) ? inqRequest.getMsgId() : rrn;
            Optional<StatusDetails> tranOpt = statusDetailsRepository.findByRrn(rrn);


            if (tranOpt.isPresent()) {
                StatusDetails transaction = tranOpt.get();
                String status = transaction.getStatus();
                if (status.equalsIgnoreCase(TransactionStatus.OK.name())) {
                    String responseStr = this.getStatusCheckSuccessResponse(msgId, rrn, StatusCodes.SUCCESS, transaction.getStatusMessage(), transaction.getTranId());
                    return new ResponseEntity(responseStr, HttpStatus.OK);
                }

            } else {
                System.out.println("Transaction not does not exist!!");
                String responseStr = this.getStatusCheckErrorResponse(msgId, rrn, "404", "Transaction not does not exist");
                return new ResponseEntity(responseStr, HttpStatus.OK);
            }

            AirtelDTO airtDto = openAPIAirtelUgBankToWalletService.checkTransactionStatus(inqRequest, "CD");
            int x = airtDto.getStatusCode();
            String telcoStatusCode = airtDto.getTelcoStatusCode();
            String statusMessage = airtDto.getTelcoStatusMessage();
            String tranId = airtDto.getTranId();
            if (x == -3) {
                //(String msgId, String rrn, String responseCode, String responseDesc)
                String response = this.getStatusCheckErrorResponse(msgId, rrn, "-3", (MiscUtil.isNotNullAndNotEmpty(statusMessage)) ? statusMessage : "Transaction failed!! Timeout");
                log.info("********* Response back to source: ");
                log.info(response);
                return new ResponseEntity(response, HttpStatus.OK);
            }
            if (x == -1) {
                String response = this.getStatusCheckErrorResponse(msgId, rrn, telcoStatusCode, (MiscUtil.isNotNullAndNotEmpty(statusMessage)) ? statusMessage : "Transaction failed");
                log.info("********* Response back to source: ");
                log.info(response);
                return new ResponseEntity(response, HttpStatus.OK);
            }
            if (x == 1) {
                String response = this.getStatusCheckErrorResponse(msgId, rrn, telcoStatusCode, (MiscUtil.isNotNullAndNotEmpty(statusMessage)) ? statusMessage : "Transaction failed!");
                log.info("********* Response back to source: ");
                log.info(response);
                return new ResponseEntity(response, HttpStatus.OK);
            }
            if (x == 0) {
                //String msgId, String rrn, String responseCode, String responseDesc, String tranId)
                String response = getStatusCheckSuccessResponse(msgId, rrn, telcoStatusCode, statusMessage, tranId);
                log.info("********* Response back to source: ");
                log.info(response);
                return new ResponseEntity(response, HttpStatus.OK);
            }

            String response = this.getStatusCheckErrorResponse(msgId, rrn, telcoStatusCode, (MiscUtil.isNotNullAndNotEmpty(statusMessage)) ? statusMessage : "Transaction failed!");
            log.info("********* Response back to source: ");
            log.info(response);
            return new ResponseEntity(response, HttpStatus.OK);

        } catch (JAXBException | ParserConfigurationException | SAXException e) {
            e.printStackTrace(System.out);
        }
        String responseStr = this.getStatusCheckErrorResponse(msgId, rrn, "500", "Error occurred");
        return new ResponseEntity(responseStr, HttpStatus.OK);

    }

    @GetMapping("/status")
    public ResponseEntity<?> getStats(@RequestParam String rrn) {
        log.info("Get stats request, rrn: " + rrn);
        try {
            Optional<StatusDetails> status = statusDetailsRepository.findByRrn(rrn);
            if (status.isEmpty()) {
                return new ResponseEntity<>(HttpStatus.NOT_FOUND);
            }
            return new ResponseEntity<>(status.get(), HttpStatus.OK);

        } catch (Exception ex) {
            ex.printStackTrace(System.out);
        }
        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping("/banktowallet/namecheck")
    public ResponseEntity namecheck(@RequestBody String requestStr) throws JAXBException {
        MobileNumberInquireReq request = null;
        try {
            request = (MobileNumberInquireReq) MiscUtil.strToObject(requestStr, MobileNumberInquireReq.class);
            Airtelb2cResponse response = openAPIAirtelUgBankToWalletService.nameCheck(request, "CD", "CDF");
            if (response.getStatus() == TranStatus.SUCCESS) {
                String rName = response.getAditionalData().get(Airtelb2cOpenApiConstants.CUSTOMER_FIRST_NAME) + " " + response.getAditionalData().get(Airtelb2cOpenApiConstants.CUSTOMER_LAST_NAME);
                String grade = (String) response.getAditionalData().get(Airtelb2cOpenApiConstants.AIRTEL_MONEY_GRADE);

                // If grade is TEMP, the customer has a partial kyc and is not allowed to do b2c. Return code 99 to omni
                MobileNumberInquireRes mobileNumberInquireRes = grade.toUpperCase().contains("TEMP")
                        ? new MobileNumberInquireRes(request, "99", rName)
                        : new MobileNumberInquireRes(request, "00", rName);

                return new ResponseEntity<>(mobileNumberInquireRes, getResponseHeaders(), HttpStatus.OK);
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.out);
            String resp = this.getErrorResponse((request != null ? request.getMsgId() : "0000000"), "400", ex.getLocalizedMessage() != null ? ex.getLocalizedMessage() : TPGConstants.INVALID_XML_INPUT);
            return new ResponseEntity<>(resp, getResponseHeaders(), HttpStatus.BAD_REQUEST);
        }
        MobileNumberInquireRes mobileNumberInquireRes = new MobileNumberInquireRes(request, "00", request.getMobileNumber());
        return new ResponseEntity<>(mobileNumberInquireRes, getResponseHeaders(), HttpStatus.OK);
    }

    @PostMapping("/airtimetopup/namecheck")
    public ResponseEntity namecheckAirtime(@RequestBody String requestStr) throws JAXBException {
        MobileNumberInquireReq request = null;
        try {
            request = (MobileNumberInquireReq) MiscUtil.strToObject(requestStr, MobileNumberInquireReq.class);
            MobileNumberInquireRes mobileNumberInquireRes = new MobileNumberInquireRes(request, "00", request.getMobileNumber());
            return new ResponseEntity<>(mobileNumberInquireRes, getResponseHeaders(), HttpStatus.OK);
        } catch (ParserConfigurationException | SAXException ex) {
            ex.printStackTrace(System.out);
            String resp = this.getErrorResponse((request != null ? request.getMsgId() : "0000000"), "400", ex.getLocalizedMessage() != null ? ex.getLocalizedMessage() : TPGConstants.INVALID_XML_INPUT);
            return new ResponseEntity<>(resp, getResponseHeaders(), HttpStatus.BAD_REQUEST);
        }
    }

    @PostMapping("/floatpurchase/namecheck")
    public ResponseEntity namecheckBuyFloat(@RequestBody String requestStr) throws JAXBException {
        MobileNumberInquireReq request = null;
        try {
            request = (MobileNumberInquireReq) MiscUtil.strToObject(requestStr, MobileNumberInquireReq.class);
            Airtelb2cResponse response = null;
            if (!MiscUtil.isNullOrEmpty(request.getBankId()) && request.getBankId().equalsIgnoreCase("43")) {
                response = buyFloatService.nameCheck(request, "CD", "CDF");
            } else if (!MiscUtil.isNullOrEmpty(request.getBankId()) && request.getBankId().equalsIgnoreCase("54")) {
                response = buyFloatService.nameCheck(request, "KE", "KES");
            } else {
                String resp = this.getErrorResponse(request.getMsgId(), "400", "Unknown institution code!!");
                return new ResponseEntity<>(resp, getResponseHeaders(), HttpStatus.BAD_REQUEST);
            }
            if (response == null) {
                String resp = this.getErrorResponse(request.getMsgId(), "500", "Could not get response!");
                return new ResponseEntity<>(resp, getResponseHeaders(), HttpStatus.INTERNAL_SERVER_ERROR);
            }

            // Added this to handle failure response
            if ((response.getStatus() == TranStatus.FAILURE)) {
                MobileNumberInquireRes mobileNumberInquireRes = new MobileNumberInquireRes(request, "01", request.getMobileNumber());
                return new ResponseEntity<>(mobileNumberInquireRes, getResponseHeaders(), HttpStatus.BAD_REQUEST);
            }

            if (response.getStatus() == TranStatus.SUCCESS) {
                String rName = response.getAditionalData().get(Airtelb2cOpenApiConstants.CUSTOMER_FIRST_NAME) + " " + response.getAditionalData().get(Airtelb2cOpenApiConstants.CUSTOMER_LAST_NAME);

                String grade = (String) response.getAditionalData().get(Airtelb2cOpenApiConstants.AIRTEL_MONEY_GRADE);

                // If grade is TEMP, the customer has a partial kyc and is not allowed to do b2c. Return code 99 to omni
                MobileNumberInquireRes mobileNumberInquireRes = grade.toUpperCase().contains("TEMP")
                        ? new MobileNumberInquireRes(request, "99", rName)
                        : new MobileNumberInquireRes(request, "00", rName);

                return new ResponseEntity<>(mobileNumberInquireRes, getResponseHeaders(), HttpStatus.OK);
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.out);
            String resp = this.getErrorResponse((request != null ? request.getMsgId() : "0000000"), "400", ex.getLocalizedMessage() != null ? ex.getLocalizedMessage() : TPGConstants.INVALID_XML_INPUT);
            return new ResponseEntity<>(resp, getResponseHeaders(), HttpStatus.BAD_REQUEST);
        }
        MobileNumberInquireRes mobileNumberInquireRes = new MobileNumberInquireRes(request, "00", request.getMobileNumber());
        return new ResponseEntity<>(mobileNumberInquireRes, getResponseHeaders(), HttpStatus.OK);
    }

    @PostMapping("/transaction")
    public ResponseEntity postTransaction(@RequestBody String request) {
        System.out.println("##### INCOMMING TRANSACTION REQUEST: " + request);
        EazInqRequest inqRequest = null;
        try {
            inqRequest = (EazInqRequest) MiscUtil.strToObject(request, EazInqRequest.class);
            InqResponse rs = new InqResponse();
            Eazzycashres eazzycashres = new Eazzycashres();
            rs.setEazzycashres(eazzycashres);
            String rrn = !MiscUtil.isNullOrEmpty(inqRequest.getEazzycash().getWalletTranID())
                    ? inqRequest.getEazzycash().getWalletTranID() : inqRequest.getEazzycash().getRrn();
            String msgId = (inqRequest.getMsgId() > 0) ? String.valueOf(inqRequest.getMsgId()) : null;
            if (openAPIAirtelUgBankToWalletService.isLocal) {
                Optional<TransactionDetails> details = transactionDetailsRepository.findByRrnAndOperationType(inqRequest.getEazzycash().getRrn(), RequestTypes.B2C);
                if (details.isPresent()) {
                    String response = writeServletErrorMsg("Duplicate transaction", rs, "-7", null, rrn, String.valueOf(inqRequest.getMsgId()));
                    log.info("********* Response back to source: ");
                    log.info(response);
                    return new ResponseEntity(response, HttpStatus.OK);
                }
            }

            AirtelDTO airtDto = openAPIAirtelUgBankToWalletService.sendTransaction(inqRequest, "CD", rs);
            int x = airtDto.getStatusCode();
            String telcoStatusCode = airtDto.getTelcoStatusCode();
            String statusMessage = airtDto.getTelcoStatusMessage();
            String tranId = airtDto.getTranId();
            if (x == -3) {
                String response = this.writeServletErrorMsg((MiscUtil.isNotNullAndNotEmpty(statusMessage)) ? statusMessage : "Transaction failed!! Timeout", rs, "-3", telcoStatusCode, rrn, msgId);
                log.info("********* Response back to source: ");
                log.info(response);
                return new ResponseEntity(response, HttpStatus.OK);
            }
            if (x == -1) {
                String response = this.writeServletErrorMsg((MiscUtil.isNotNullAndNotEmpty(statusMessage)) ? statusMessage : "Transaction failed", rs, "-1", telcoStatusCode, rrn, msgId);
                log.info("********* Response back to source: ");
                log.info(response);
                return new ResponseEntity(response, HttpStatus.OK);
            }
            if (x == 1) {
                String response = this.writeServletErrorMsg((MiscUtil.isNotNullAndNotEmpty(statusMessage)) ? statusMessage : "Transaction failed!", rs, "1", telcoStatusCode, rrn, msgId);
                log.info("********* Response back to source: ");
                log.info(response);
                return new ResponseEntity(response, HttpStatus.OK);
            }
            if (x == 0) {
                String response = writeServletSuccessMsg("Transaction Posted Succesful!", inqRequest.getEazzycash().getRrn(), tranId, msgId);
                log.info("********* Response back to source: ");
                log.info(response);
                return new ResponseEntity(response, HttpStatus.OK);
            }

            String response = AirtelController.writeServletErrorMsg((MiscUtil.isNotNullAndNotEmpty(statusMessage)) ? statusMessage : "Transaction failed!", rs, String.valueOf(x), telcoStatusCode, rrn, msgId);
            log.info("********* Response back to source: ");
            log.info(response);
            return new ResponseEntity(response, HttpStatus.OK);
        } catch (JAXBException | ParserConfigurationException | SAXException ex) {
            ex.printStackTrace(System.out);
            String resp = this.getErrorResponse((inqRequest != null ? String.valueOf(inqRequest.getMsgId()) : "0000000"), "400", ex.getLocalizedMessage() != null ? ex.getLocalizedMessage() : TPGConstants.INVALID_XML_INPUT);
            return new ResponseEntity<>(resp, getResponseHeaders(), HttpStatus.BAD_REQUEST);
        }
//        return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    private String writeServletSuccessMsg(String msg, String rrn, String tranID, String msgId) {
        try {
            InqResponse rs = new InqResponse();
            Eazzycashres eazzycashres = new Eazzycashres();
            eazzycashres.status = "OK|" + tranID;
            eazzycashres.responseCode = "00";
            eazzycashres.walletTranID = tranID;
            if ((msg != null) && !(msg.isEmpty())) {
                eazzycashres.responseDesc = msg;
            }
            rs.setMsgId(rrn);
            rs.setEazzycashres(eazzycashres);
            JAXBContext jaxbContext = JAXBContext.newInstance(InqResponse.class);
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
            jaxbMarshaller.setProperty("jaxb.formatted.output", Boolean.valueOf(true));
            StringWriter jaxwriter = new StringWriter();
            jaxbMarshaller.marshal(rs, jaxwriter);
            StringBuffer jaxrespBfr = jaxwriter.getBuffer();
            String response = jaxrespBfr.toString();
            System.out.println(msg + response);
            System.out.println(msg);
            System.out.println(msg + jaxrespBfr.toString());
            return response;
        } catch (JAXBException ex) {
            ex.printStackTrace(System.out);
        }
        return null;
    }

    private static String writeServletErrorMsg(String msg, InqResponse rs, String status, String telcoStatusCode, String rrn, String msgId) {
        try {
            rs.setMsgId(rrn);

            if ((status != null) && !(status.isEmpty())) {
                (rs.getEazzycashres()).status = "ERROR|" + status;
            } else {
                (rs.getEazzycashres()).status = "ERROR";
            }

            if ((msg != null) && !(msg.isEmpty())) {
                (rs.getEazzycashres()).responseDesc = msg;
            }

            if ((telcoStatusCode != null) && !(telcoStatusCode.isEmpty())) {
                (rs.getEazzycashres()).responseCode = telcoStatusCode;
            }

            JAXBContext jaxbContext = JAXBContext.newInstance(InqResponse.class);
            Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
            jaxbMarshaller.setProperty("jaxb.formatted.output", Boolean.valueOf(true));
            StringWriter jaxwriter = new StringWriter();
            jaxbMarshaller.marshal(rs, jaxwriter);
            StringBuffer jaxrespBfr = jaxwriter.getBuffer();
            String response = jaxrespBfr.toString();
            System.out.println(msg + response);
            System.out.println(msg);
            System.out.println(msg + jaxrespBfr.toString());
            return response;
        } catch (JAXBException ex) {
            ex.printStackTrace(System.out);
        }
        return null;
    }

    private MultiValueMap<String, String> getResponseHeaders() {
        MultiValueMap<String, String> headers = new LinkedMultiValueMap<>();
        headers.add("Content-Type", "application/xml");
        return headers;
    }

    private String getErrorResponse(String msgId, String responseCode, String responseDesc) {
        return "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n"
                + "<response>\n"
                + "    <msgId>" + msgId + "</msgId>\n"
                + "    <eazzycashres>\n"
                + "        <status>ERROR|" + responseCode + "</status>\n"
                + "        <responseCode>" + responseCode + "</responseCode>\n"
                + "        <responseDesc>" + responseDesc + "</responseDesc>\n"
                + "    </eazzycashres>\n"
                + "</response>";
    }

    private String getStatusCheckErrorResponse(String msgId, String rrn, String responseCode, String responseDesc) {
        return "<eazzycashStatusRes>\n"
                + "    <msgId>" + msgId + "</msgId>\n"
                + "    <eazzycashres>\n"
                + "        <rrn>" + rrn + "</rrn>\n"
                + "        <status>ERROR|" + responseCode + "</status>\n"
                + "        <responseCode>" + responseCode + "</responseCode>\n"
                + "        <responseDesc>" + responseDesc + "</responseDesc>\n"
                + "    </eazzycashres>\n"
                + "</eazzycashStatusRes>";
    }

    private String getStatusCheckSuccessResponse(String msgId, String rrn, String responseCode, String responseDesc, String tranId) {
        return "<eazzycashStatusRes>\n"
                + "    <msgId>" + msgId + "</msgId>\n"
                + "    <eazzycashres>\n"
                + "        <rrn>" + rrn + "</rrn>\n"
                + "        <status>OK|" + tranId + "</status>\n"
                + "        <responseCode>" + responseCode + "</responseCode>\n"
                + "        <responseDesc>" + responseDesc + "</responseDesc>\n"
                + "    </eazzycashres>\n"
                + "</eazzycashStatusRes>";
    }

    public static void main(String[] args) {
        InqResponse inq = new InqResponse();
        Eazzycashres eres = new Eazzycashres();
        inq.setEazzycashres(eres);
        System.out.println(writeServletErrorMsg("123456", inq, "ERROR", "-6", "65675668", "67867998"));
    }

}
