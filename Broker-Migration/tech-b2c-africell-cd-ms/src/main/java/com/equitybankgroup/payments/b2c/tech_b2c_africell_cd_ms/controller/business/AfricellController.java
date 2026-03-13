package com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.controller.business;

import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.constants.TPGConstants;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input.AirtimeChannelRequest;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input.ChannelDeregistrationReq;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input.EazInqRequest;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input.Eazzycashres;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input.InqResponse;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input.InquireResponse;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.input.WalletResponse;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.namecheck.MobileNumberInquireReq;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.dto.namecheck.MobileNumberInquireRes;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.service.business.OpenAPIAfricellBankToWalletService;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.service.business.RegistrationService;
import com.equitybankgroup.payments.b2c.tech_b2c_africell_cd_ms.service.util.MiscUtil;
import com.fasterxml.jackson.core.JsonProcessingException;
import java.util.Map;
import java.util.logging.Level;
import javax.xml.bind.JAXBException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class AfricellController {
    private final static Logger logger = LoggerFactory.getLogger(AfricellController.class);

    @Autowired
    OpenAPIAfricellBankToWalletService openAPIAfricellService;
    
    @Autowired
    RegistrationService registrationService;
    
    @PostMapping("/v1/banktowallet/namecheck")
    public ResponseEntity namecheck(@RequestBody String requestStr) throws JAXBException
    {  
        MobileNumberInquireReq request = (MobileNumberInquireReq) MiscUtil.strToObject(requestStr, MobileNumberInquireReq.class);
//        try {
//            Airtelb2cResponse response = openAPIAirtelUgBankToWalletService.nameCheck(request, "CD", "CDF");
//            if(response.getStatus() == TranStatus.SUCCESS)
//            {   
//                String rName = response.getAditionalData().get(Airtelb2cOpenApiConstants.CUSTOMER_FIRST_NAME) + " " + response.getAditionalData().get(Airtelb2cOpenApiConstants.CUSTOMER_LAST_NAME);
//                MobileNumberInquireRes mobileNumberInquireRes = new MobileNumberInquireRes(request, "00", rName);
//                return new ResponseEntity<>(mobileNumberInquireRes, getResponseHeaders(), HttpStatus.OK);
//            }
//        } catch (Exception ex) {
//            ex.printStackTrace(System.out);
//        }
        MobileNumberInquireRes mobileNumberInquireRes = new MobileNumberInquireRes(request, "00", request.getMobileNumber());
        return new ResponseEntity<>(mobileNumberInquireRes, getResponseHeaders(), HttpStatus.OK);
    }

    @PostMapping(value = "/v1/transaction", consumes = MediaType.APPLICATION_XML_VALUE, produces = MediaType.APPLICATION_XML_VALUE)
    public ResponseEntity<?> postTransaction(@RequestBody String request) throws JsonProcessingException {
        System.out.println("##### INCOMMING TRANSACTION REQUEST: " + request);
        try {
            EazInqRequest inqRequest = (EazInqRequest) MiscUtil.strToObject(request, EazInqRequest.class);
            WalletResponse rs = new WalletResponse();
            Eazzycashres eazzycashres = new Eazzycashres();
            rs.setEazzycashres(eazzycashres);
            
            String walletResponse = openAPIAfricellService.sendTransaction(inqRequest, "CD", rs);
            logger.info("Response=> {}",walletResponse);
            return ResponseEntity.ok(walletResponse);
        } catch (JAXBException ex) {
            ex.printStackTrace(System.out);
        }
        return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
    }
    
    @PostMapping(value = "/v1/deregister", consumes = MediaType.APPLICATION_XML_VALUE, produces = MediaType.APPLICATION_XML_VALUE)
    public ResponseEntity<?> deregister(@RequestBody String request) throws JsonProcessingException {
        System.out.println("##### INCOMMING DEREGISTRATION REQUEST: " + request);
        try {
            ChannelDeregistrationReq channelDeregistrationReq = (ChannelDeregistrationReq) MiscUtil.strToObject(request, ChannelDeregistrationReq.class);
            WalletResponse rs = new WalletResponse();
            Eazzycashres eazzycashres = new Eazzycashres();
            rs.setEazzycashres(eazzycashres);
            
            InquireResponse inqResponse = registrationService.deRegister(channelDeregistrationReq);
            String inqResponseStr = MiscUtil.objectToStr(inqResponse, InquireResponse.class);
            logger.info("Response=> {}",inqResponseStr);
            return ResponseEntity.ok(inqResponseStr);
        } catch (JAXBException ex) {
            ex.printStackTrace(System.out);
        }
        return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
    }
    
    @GetMapping(value = "/v1/registrations", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> registrations() throws JsonProcessingException {
        try {
            return ResponseEntity.ok(registrationService.registrationsAll());
        } catch (Exception ex) {
            ex.printStackTrace(System.out);
        }
        return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
    }
    
    @PostMapping(value = "/AirTimeTopUpWSService/AirTimeTopUp", consumes = MediaType.APPLICATION_XML_VALUE, produces = MediaType.APPLICATION_XML_VALUE)
    public ResponseEntity<?> airtimeTopUp(@RequestBody String request) {
        System.out.println("##### INCOMMING TRANSACTION REQUEST: " + request);
        try {
            Map<String, String> map = MiscUtil.extractAllTagValues(request);
            map.put(TPGConstants.AIRTIME_ORIGINAL_REQUEST, request);
            String response = openAPIAfricellService.handleTopUp(map);
            
            logger.info("Response=> {}",response);
            return ResponseEntity.ok(response);
        } catch (Exception ex) {
            ex.printStackTrace(System.out);
        }
        return new ResponseEntity(HttpStatus.INTERNAL_SERVER_ERROR);
    }
    
    private MultiValueMap<String, String> getResponseHeaders()
    {
        MultiValueMap<String, String> headers = new LinkedMultiValueMap<>();
        headers.add("Content-Type", "application/xml");
        return headers;
    }

}
