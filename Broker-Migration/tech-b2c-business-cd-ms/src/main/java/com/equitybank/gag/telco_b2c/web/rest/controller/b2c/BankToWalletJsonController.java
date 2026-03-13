/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.telco_b2c.web.rest.controller.b2c;

import com.equitybank.gag.telco_b2c.dto.Eazzycash;
import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.json.BankToWalletRequest;
import com.equitybank.gag.telco_b2c.dto.json.StatusRequest;
import com.equitybank.gag.telco_b2c.dto.json.StatusResponse;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.entity.StatusDetails;
import com.equitybank.gag.telco_b2c.entity.TransactionDetails;
import com.equitybank.gag.telco_b2c.enums.TransactionStatus;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.exception.GlobalExceptionHandler;
import com.equitybank.gag.telco_b2c.repository.TransactionDetailsRepository;
import com.equitybank.gag.telco_b2c.service.DtoProcessingService;
import com.equitybank.gag.telco_b2c.util.EnabledServicesChecker;
import com.equitybank.gag.telco_b2c.web.rest.controller.util.MiscUtil;
import com.equitybank.gag.telco_b2c.web.rest.controller.airtimeToupup.AirtimePurchaseController;
import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import jakarta.validation.Valid;

import java.security.SignatureException;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.context.request.WebRequest;

/**
 * @author ronaldcheruiyot
 */
@RestController
public class BankToWalletJsonController {
    private static final Logger log = LoggerFactory.getLogger(AirtimePurchaseController.class);

    private final boolean isInternal;
    private final DtoProcessingService dtoProcessingService;
    private final EnabledServicesChecker enabledServicesChecker;
    private final GlobalExceptionHandler globalExceptionHandler;
    private final TransactionDetailsRepository transactionDetailsRepository;

    @Autowired
    public BankToWalletJsonController(@Value("${signature.validation.isInternal}") boolean isInternal,
                                      DtoProcessingService dtoProcessingService,
                                      EnabledServicesChecker enabledServicesChecker,
                                      GlobalExceptionHandler globalExceptionHandler,
                                      TransactionDetailsRepository transactionDetailsRepository) {
        this.isInternal = isInternal;
        this.dtoProcessingService = dtoProcessingService;
        this.enabledServicesChecker = enabledServicesChecker;
        this.globalExceptionHandler = globalExceptionHandler;
        this.transactionDetailsRepository = transactionDetailsRepository;
    }

    @PostMapping(value = "/api/v2/banktowalletstatus", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> handleBankToWalletStatusRequest(@Valid @RequestBody String statusRequest, BindingResult result, WebRequest webRequest) {
        String rrn = "";
        String type = "transaction";
        StatusResponse response = new StatusResponse();
        try {
            // Check if service is enabled
            enabledServicesChecker.checkServiceStatus(enabledServicesChecker.isBankToWalletStatusEnabled(), "Bank To Wallet Status Check Service");

            StatusRequest request = (new Gson()).fromJson(statusRequest, StatusRequest.class);
            rrn = request.getOriginatingTransactionID();
            response.setOriginatingTransactionID(request.getOriginatingTransactionID());
            Optional<TransactionDetails> tranDetailsOpt = transactionDetailsRepository.findByRrnAndRequestType(request.getOriginatingTransactionID(), type);

            if (tranDetailsOpt.isEmpty()) {
                log.info(rrn + "|TransactionDetails is empty.");
                response.setStatus("NOT_FOUND");
                return new ResponseEntity<>(response, HttpStatus.OK);
            }
            TransactionDetails tranDetails = tranDetailsOpt.get();
            StatusDetails details = tranDetails.getStatusDetails();

            if (details == null) {
                log.info(rrn + "|TransactionDetails is empty.");
                response.setStatus("NOT_FOUND");
                return new ResponseEntity<>(response, HttpStatus.OK);
            }

            String statusCode = details.getStatus();
            response.setTransactionID(details.getTranId());

            if (statusCode.equalsIgnoreCase(TransactionStatus.OK.name())
                    || statusCode.equalsIgnoreCase(TransactionStatus.INITIALIZED.name())
                    || statusCode.equalsIgnoreCase(TransactionStatus.PENDING.name())
                    || statusCode.equalsIgnoreCase(TransactionStatus.TIMEOUT.name())) {
                log.info(rrn + "|Status OK.");
                response.setStatus("OK");

                return new ResponseEntity<>(response, HttpStatus.OK);
            }
        } catch (CustomException | JsonSyntaxException e) {
            log.error(rrn + ": Exception Occurred: " + e.getMessage());
        }
        log.info(rrn + "|Status FAILED.");
        response.setStatus("FAILED");
        return new ResponseEntity<>(response, HttpStatus.OK);
    }


    @PostMapping(value = "/api/v1/omnichannel/banktowallet", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> handleBankToWalletRequest(@Valid @RequestBody String bankToWalletRequest, BindingResult result, WebRequest webRequest) {
        String type = "transaction";
        String rrn = "";
        StatusResponse response = new StatusResponse();
        try {
            // Check if service is enabled
            enabledServicesChecker.checkServiceStatus(enabledServicesChecker.isBankToWalletEnabled(), "Bank To Wallet Service");

            // Log request on console
            log.info("Received Channel Transaction Request JSON: \n{}", bankToWalletRequest);

            BankToWalletRequest request = (new Gson()).fromJson(bankToWalletRequest, BankToWalletRequest.class);

            response.setOriginatingTransactionID(request.getTransactionID());

            rrn = request.getTransactionID();

            // Process the request
            String responseXml = dtoProcessingService.processChannelRequest(isInternal, getGenericXMLString(request), new Envelope(), result, type);

            response.setTransactionID(getTranId(responseXml));

            log.info("{}: Returned Success Response To Channel: \n{}", rrn, (new Gson()).toJson(response));
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (CustomException customException) {
            log.error(rrn + ": " + customException.getMessage());
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (SignatureException ex) {
            log.error(rrn + ": " + ex.getMessage());
            return globalExceptionHandler.handleCustomException(new CustomException("Signature validation failed!"), webRequest);
        }
    }

    private static String getTranId(String telcoResponseXML) {
        return MiscUtil.extractTagValue(telcoResponseXML, "tranID");
    }


    private request getGenericXMLString(BankToWalletRequest request) {
        request req = new request();
        Eazzycash eazyCash = new Eazzycash();
        eazyCash.setRrn(request.getTransactionID());
        eazyCash.setAmount(request.getAmount());
        eazyCash.setSender("0743000000");
        eazyCash.setName("EQUITY CHANNEL");
        eazyCash.setNumber(request.getBeneficiaryPhoneNumber());
        eazyCash.setTelco(request.getProviderName());
        eazyCash.setSignature("jZzbRrd8Ycwg8xClrOdddkZcHjXHnUtgf6FA9gMFtCMF720S8rZPiVgtc0nPBuNXa4WlYvK+elzapEDbxUvA+oiyWtPZYM+fqI/UAxMjCtJifvr8z7ztjOx0Tq7La63Yvju06g6AWjhs3LrZa8ECBqQkQNdK9DBTcBT/oSP0Nla3IHq/WREA40ttMPtgbQoCmp/ZCL7Rmw8ulm/A2VEUvM14LEfn2jMzij1DWPzidsCkA6q7CYPPHLFIBVpevEpTNp9WTm80RWYr8oZx5jT8i4FAFMnN58kXd1/QHfjgMxvfkP+T3XmFg2Kv5PdF7rOF0XvsaY9u6hfy2NbnQwaSMg==");
        eazyCash.setOptIn("0");
        req.setEazzycash(eazyCash);
        return req;
    }

    public static void main(String[] args) {
        String response = "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n" +
                "<response>\n" +
                "    <MsgId>202407376767</MsgId>\n" +
                "    <eazzycashres>\n" +
                "        <status>OK</status>\n" +
                "        <tranID>APC**4</tranID>\n" +
                "        <responseCode>00</responseCode>\n" +
                "        <responseDesc>Transaction Posted Succesful!</responseDesc>\n" +
                "    </eazzycashres>\n" +
                "</response>";
        System.out.println("TRAN ID: " + getTranId(response));

        StatusResponse resp = new StatusResponse();
        resp.setOriginatingTransactionID("123455");
        System.out.println((new Gson()).toJson(resp));

        String request = "{\n" +
                "    \"OriginatingTransactionID\": \"20240820991\"\n" +
                "}";
        StatusRequest req = (new Gson()).fromJson(request, StatusRequest.class);

        System.out.println("OriginatingTransactionID: " + req.getOriginatingTransactionID());

    }


}
