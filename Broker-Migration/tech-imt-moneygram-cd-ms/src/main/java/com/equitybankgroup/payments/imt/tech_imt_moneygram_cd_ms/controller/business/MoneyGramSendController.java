package com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.controller.business;

//import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.adapters.XMLGregorianCalendarConverter;
import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.exception.CustomException;
import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.business.MoneySendGramService;
import static com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.util.StringTransformer.convertToXml;
import com.equitybankgroup.payments.imt.tech_imt_moneygram_cd_ms.service.util.XmlReaderService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.moneygram.agentconnect1512.AmendTransactionRequest;
import com.moneygram.agentconnect1512.ChannelTypeEnum;
import com.moneygram.agentconnect1512.CodeTableRequest;
import com.moneygram.agentconnect1512.CommitTransactionRequest;
import com.moneygram.agentconnect1512.DetailLookupRequest;
import com.moneygram.agentconnect1512.Errors;
import com.moneygram.agentconnect1512.Errors_Exception;
import com.moneygram.agentconnect1512.FeeLookupRequest;
import com.moneygram.agentconnect1512.FeeLookupResponse;
import com.moneygram.agentconnect1512.GetFieldsForProductRequest;
import com.moneygram.agentconnect1512.MoneyGramConsumerLookupRequest;
import com.moneygram.agentconnect1512.ProductType;
import com.moneygram.agentconnect1512.SendReversalRequest;
import com.moneygram.agentconnect1512.SendValidationRequest;
import com.moneygram.agentconnect1512.TargetAudienceType;
import com.thoughtworks.xstream.XStream;
import jakarta.xml.soap.MessageFactory;
import jakarta.xml.soap.SOAPBody;
import jakarta.xml.soap.SOAPException;
import jakarta.xml.soap.SOAPMessage;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.text.ParseException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.fasterxml.jackson.dataformat.xml.XmlMapper;
import com.moneygram.agentconnect1512.AmendTransactionResponse;
import com.moneygram.agentconnect1512.CommitTransactionResponse;
import com.moneygram.agentconnect1512.DetailLookupResponse;
import com.moneygram.agentconnect1512.GetFieldsForProductResponse;
import com.moneygram.agentconnect1512.SendReversalResponse;
import com.moneygram.agentconnect1512.SendValidationResponse;
import java.util.concurrent.Executor;

@RestController
@RequestMapping("/api/v1")
@Slf4j
public class MoneyGramSendController {

    @Autowired
    MoneySendGramService moneySendGramService;

    @Autowired
    XmlReaderService xmlReaderService;

    @Autowired
    Executor executor;

    @PostMapping(path = "/feeLookup", produces = {MediaType.APPLICATION_XML_VALUE})
    ResponseEntity<?> feeLookUp(@RequestBody String soapEnv) {
        try {
            System.out.println("## IMCOMMING feeLookup REQUEST..");
            System.out.println(soapEnv);
            FeeLookupRequest feeLookupRequest = (FeeLookupRequest) xmlReaderService.parseXml(soapEnv, "moneygram-fee-lookup", ProductType.SEND);
            printMoneyGramRequest(feeLookupRequest);
            FeeLookupResponse feeLookupResponse = moneySendGramService.feeLookup(feeLookupRequest);
            String formattedResponse = XmlReaderService.wrapInSoapEnvelope(convertToXml(feeLookupResponse), "FeeLookupResponse");
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

    @PostMapping("/consumerLookup")
    ResponseEntity<?> consumerLookUp(@RequestBody MoneyGramConsumerLookupRequest moneyGramConsumerLookupRequest) {
        try {
            return ResponseEntity.ok(moneySendGramService.moneyGramConsumerLookup(moneyGramConsumerLookupRequest));
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
        }
    }

    @PostMapping("/getFieldsForProduct")
    ResponseEntity<?> getFieldsForProduct(@RequestBody String soapEnv) {
        try {
            System.out.println("## IMCOMMING getFieldsForProduct REQUEST..");
            System.out.println(soapEnv);
            GetFieldsForProductRequest getFieldsForProductRequest = (GetFieldsForProductRequest) xmlReaderService.parseXml(soapEnv, "moneygram-get-field-for-product", ProductType.SEND);
            printMoneyGramRequest(getFieldsForProductRequest);
            GetFieldsForProductResponse getFieldsForProductResponse = moneySendGramService.getFieldsForProduct(getFieldsForProductRequest);
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

    @PostMapping("/sendValidation")
    ResponseEntity<?> sendValidation(@RequestBody String soapEnv) {
        try {
            System.out.println("## IMCOMMING sendValidation REQUEST..");
            System.out.println(soapEnv);
            SendValidationRequest sendValidationRequest = (SendValidationRequest) xmlReaderService.parseXml(soapEnv, "moneygram-send-validation-request", ProductType.SEND);
            printMoneyGramRequest(sendValidationRequest);
            SendValidationResponse sendValidationResponse = moneySendGramService.sendValidation(sendValidationRequest);
            String formattedResponse = XmlReaderService.wrapInSoapEnvelope(convertToXml(sendValidationResponse), "SendValidationResponse");
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
    ResponseEntity<?> commitTransaction(@RequestBody String soapEnv) {
        try {
            System.out.println("## IMCOMMING commitTransaction REQUEST..");
            System.out.println(soapEnv);
            CommitTransactionRequest commitTransactionRequest = (CommitTransactionRequest) xmlReaderService.parseXml(soapEnv, "moneygram-commit-transaction", ProductType.SEND);
            printMoneyGramRequest(commitTransactionRequest);
            CommitTransactionResponse commitTransactionResponse = moneySendGramService.commitTransaction(commitTransactionRequest);
            String formattedResponse = XmlReaderService.wrapInSoapEnvelope(convertToXml(commitTransactionResponse), "CommitTransactionResponse");
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

    @PostMapping("/detailLookup")
    ResponseEntity<?> detailLookup(@RequestBody String soapEnv) {
        try {
            System.out.println("## IMCOMMING detailLookup REQUEST..");
            System.out.println(soapEnv);
            DetailLookupRequest detailLookupRequest = (DetailLookupRequest) xmlReaderService.parseXml(soapEnv, "moneygram-detail-lookup", ProductType.SEND);
            printMoneyGramRequest(detailLookupRequest);
            DetailLookupResponse detailLookupResponse = moneySendGramService.detailLookup(detailLookupRequest);
            String formattedResponse = XmlReaderService.wrapInSoapEnvelope(convertToXml(detailLookupResponse), "DetailLookupResponse");
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

    @PostMapping("/amendTransaction")
    ResponseEntity<?> amendTransaction(@RequestBody String soapEnv) {
        try {

            System.out.println("## IMCOMMING amendTransaction REQUEST..");
            System.out.println(soapEnv);
            AmendTransactionRequest amendTransactionRequest = (AmendTransactionRequest) xmlReaderService.parseXml(soapEnv, "moneygram-amend-transaction", ProductType.SEND);
            printMoneyGramRequest(amendTransactionRequest);
            AmendTransactionResponse amendTransactionResponse = moneySendGramService.amendTransaction(amendTransactionRequest);
            String formattedResponse = XmlReaderService.wrapInSoapEnvelope(convertToXml(amendTransactionResponse), "AmendTransactionResponse");
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

    @PostMapping("/sendReversal")
    ResponseEntity<?> sendReversal(@RequestBody String soapEnv) {
        try {

            System.out.println("## IMCOMMING sendReversal REQUEST..");
            System.out.println(soapEnv);
            SendReversalRequest sendReversalRequest = (SendReversalRequest) xmlReaderService.parseXml(soapEnv, "moneygram-send-reversal", ProductType.SEND);
            printMoneyGramRequest(sendReversalRequest);
            SendReversalResponse sendReversalResponse = moneySendGramService.sendReversal(sendReversalRequest);
            String formattedResponse = XmlReaderService.wrapInSoapEnvelope(convertToXml(sendReversalResponse), "SendReversalResponse");
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

    @PostMapping("/codeTable")
    ResponseEntity<?> codeTable(@RequestBody CodeTableRequest codeTableRequest) {
        try {
            return ResponseEntity.ok(moneySendGramService.codeTable(codeTableRequest));
        } catch (Errors_Exception ex) {
            ex.printStackTrace(System.out);
            return ResponseEntity.internalServerError().build();
        }
    }

    public void printMoneyGramRequest(Object response) {
        executor.execute(() -> {
            try {
                System.out.println("REQUEST BODY TO MONEYGRAM:");
                System.out.println(convertToXml(response));
            } catch (Exception ex) {
                Logger.getLogger(MoneyGramSendController.class.getName()).log(Level.SEVERE, null, ex);
            }
        });

    }

    public String convertToXml(Object response) throws Exception {
        XmlMapper xmlMapper = new XmlMapper();
        return xmlMapper.writeValueAsString(response);
    }

    public static void main(String[] args) throws JAXBException, ParseException, DatatypeConfigurationException {
//        testJaxB();
    }

}
