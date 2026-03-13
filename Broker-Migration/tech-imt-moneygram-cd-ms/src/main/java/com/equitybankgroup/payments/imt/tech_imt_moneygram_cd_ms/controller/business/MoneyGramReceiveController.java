package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.controller.business;

import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.exception.CustomException;
import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.business.MoneyGramReceiveService;
import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.business.MoneySendGramService;
import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.util.XmlReaderService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import com.moneygram.agentconnect1512.AmendTransactionRequest;
import com.moneygram.agentconnect1512.CommitTransactionRequest;
import com.moneygram.agentconnect1512.DetailLookupRequest;
import com.moneygram.agentconnect1512.Errors;
import com.moneygram.agentconnect1512.Errors_Exception;
import com.moneygram.agentconnect1512.FeeLookupRequest;
import com.moneygram.agentconnect1512.GetFieldsForProductRequest;
import com.moneygram.agentconnect1512.GetFieldsForProductResponse;
import com.moneygram.agentconnect1512.MoneyGramConsumerLookupRequest;
import com.moneygram.agentconnect1512.ProductType;
import com.moneygram.agentconnect1512.ReceiveReversalRequest;
import com.moneygram.agentconnect1512.ReceiveValidationRequest;
import com.moneygram.agentconnect1512.ReceiveValidationResponse;
import com.moneygram.agentconnect1512.ReferenceNumberRequest;
import com.moneygram.agentconnect1512.ReferenceNumberResponse;
import com.moneygram.agentconnect1512.SendReversalRequest;
import com.moneygram.agentconnect1512.SendValidationRequest;
import java.text.ParseException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.datatype.DatatypeConfigurationException;
import org.apache.cxf.common.util.SystemPropertyAction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/receive")
public class MoneyGramReceiveController {

    @Autowired
    MoneyGramReceiveService moneyGramReceiveService;
    
    @Autowired
    XmlReaderService xmlReaderService;

    @PostMapping("/getFieldsForProduct")
    ResponseEntity<?> getFieldsForProduct(@RequestBody String soapEnv) {
        try {
            System.out.println("## IMCOMMING getFieldsForProduct REQUEST..");
            System.out.println(soapEnv);
            GetFieldsForProductRequest getFieldsForProductRequest = (GetFieldsForProductRequest) xmlReaderService.parseXml(soapEnv, "moneygram-get-field-for-product", ProductType.RCV);
            System.out.println("REQUEST BODY TO MONEYGRAM:");
            System.out.println(convertToXml(getFieldsForProductRequest));
            GetFieldsForProductResponse getFieldsForProductResponse = moneyGramReceiveService.getFieldsForProduct(getFieldsForProductRequest);
            String formattedResponse = XmlReaderService.wrapInSoapEnvelope(convertToXml(getFieldsForProductResponse), "GetFieldsForProductResponse");
            System.out.println("RETURNING RESPONSE BACK TO CHANNEL...");
            System.out.println(formattedResponse);
            return ResponseEntity.ok(formattedResponse);
        } catch (Errors_Exception ex) {
            Errors errors = ex.getFaultInfo();
            List<com.moneygram.agentconnect1512.Error> errorList = errors.getError();
            ObjectMapper mapper = new ObjectMapper();
            String errorListStr = null;
            try {
                errorListStr = mapper.writeValueAsString(errorList);
            } catch (JsonProcessingException ex1) {
                ex1.printStackTrace(System.out);
            }
            System.out.println(errorListStr);
            ex.printStackTrace(System.out);
            return new ResponseEntity(errorListStr, HttpStatus.INTERNAL_SERVER_ERROR);
        } catch (CustomException | ParseException | DatatypeConfigurationException | IllegalArgumentException ex) {
            ex.printStackTrace(System.out);
        } catch (Exception ex) {
            ex.printStackTrace(System.out);
        }
        return ResponseEntity.internalServerError().build();
    }
    
    @PostMapping("/receiveValidation")
    ResponseEntity<?> receiveValidation(@RequestBody String soapEnv) {
        try {
            System.out.println("## IMCOMMING receiveValidation REQUEST..");
            System.out.println(soapEnv);
            ReceiveValidationRequest receiveValidationRequest = (ReceiveValidationRequest) xmlReaderService.parseXml(soapEnv, "moneygram-receive-validation-request", ProductType.RCV);
            System.out.println("REQUEST BODY TO MONEYGRAM:");
            System.out.println(convertToXml(receiveValidationRequest));
            ReceiveValidationResponse receiveValidationResponse = moneyGramReceiveService.receiveValidation(receiveValidationRequest);
            String formattedResponse = XmlReaderService.wrapInSoapEnvelope(convertToXml(receiveValidationResponse), "ReceiveValidationResponse");
            System.out.println("RETURNING RESPONSE BACK TO CHANNEL...");
            System.out.println(formattedResponse);
            return ResponseEntity.ok(formattedResponse);
        } catch (Errors_Exception ex) {
            Errors errors = ex.getFaultInfo();
            List<com.moneygram.agentconnect1512.Error> errorList = errors.getError();
            ObjectMapper mapper = new ObjectMapper();
            String errorListStr = null;
            try {
                errorListStr = mapper.writeValueAsString(errorList);
            } catch (JsonProcessingException ex1) {
                ex1.printStackTrace(System.out);
            }
            System.out.println(errorListStr);
            ex.printStackTrace(System.out);
            return new ResponseEntity(errorListStr, HttpStatus.INTERNAL_SERVER_ERROR);
        } catch (CustomException | ParseException | DatatypeConfigurationException | IllegalArgumentException ex) {
            ex.printStackTrace(System.out);
        } catch (Exception ex) {
            ex.printStackTrace(System.out);
        }
        return ResponseEntity.internalServerError().build();
    
    }
    
    @PostMapping("/commitTransaction")
    ResponseEntity<?> commitTransaction(@RequestBody CommitTransactionRequest commitTransactionRequest) {
        try {
            return ResponseEntity.ok(moneyGramReceiveService.commitTransaction(commitTransactionRequest));
        } catch (Errors_Exception ex) {
            ex.printStackTrace(System.out);
            return ResponseEntity.internalServerError().build();
        }
    }
    
    @PostMapping("/receiveReversal")
    ResponseEntity<?> receiveReversal(@RequestBody ReceiveReversalRequest receiveReversalRequest) {
        try {
            return ResponseEntity.ok(moneyGramReceiveService.receiveReversal(receiveReversalRequest));
        } catch (Errors_Exception ex) {
            ex.printStackTrace(System.out);
            return ResponseEntity.internalServerError().build();
        }
    }
    
    @PostMapping("/referenceNumber")
    ResponseEntity<?> receiveReversal(@RequestBody String soapEnv) { 
        try {
            System.out.println("## IMCOMMING referenceNumber REQUEST..");
            System.out.println(soapEnv);
            ReferenceNumberRequest referenceNumberRequest = (ReferenceNumberRequest) xmlReaderService.parseXml(soapEnv, "moneygram-reference-number-request", ProductType.RCV);
            System.out.println("REQUEST BODY TO MONEYGRAM:");
            System.out.println(convertToXml(referenceNumberRequest));
            ReferenceNumberResponse referenceNumberResponse = moneyGramReceiveService.referenceNumber(referenceNumberRequest);
            String formattedResponse = XmlReaderService.wrapInSoapEnvelope(convertToXml(referenceNumberResponse), "ReferenceNumberResponse");
            System.out.println("RETURNING RESPONSE BACK TO CHANNEL...");
            System.out.println(formattedResponse);
            return ResponseEntity.ok(formattedResponse);
        } catch (Errors_Exception ex) {
            Errors errors = ex.getFaultInfo();
            List<com.moneygram.agentconnect1512.Error> errorList = errors.getError();
            ObjectMapper mapper = new ObjectMapper();
            String errorListStr = null;
            try {
                errorListStr = mapper.writeValueAsString(errorList);
            } catch (JsonProcessingException ex1) {
                ex1.printStackTrace(System.out);
            }
            System.out.println(errorListStr);
            ex.printStackTrace(System.out);
            return new ResponseEntity(errorListStr, HttpStatus.INTERNAL_SERVER_ERROR);
        } catch (CustomException | ParseException | DatatypeConfigurationException | IllegalArgumentException ex) {
            ex.printStackTrace(System.out);
        } catch (Exception ex) {
            ex.printStackTrace(System.out);
        }
        return ResponseEntity.internalServerError().build();
    }
    
    public String convertToXml(Object response) throws Exception {
        XmlMapper xmlMapper = new XmlMapper();
        return xmlMapper.writeValueAsString(response);
    }
    
    public static void main(String[] args) {
        System.out.println(SystemPropertyAction.getProperty("user.home"));
    }
    
}
