package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.config.ApplicationConstants;
import com.equitybank.gag.telco_b2c.dto.Eazzycash;
import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.airtime.request.TopUp;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.SignatureGenerationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.security.*;
import java.security.cert.CertificateException;
import java.util.Base64;
import java.util.Enumeration;

import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.SIGNATURE_GENERATION_ERROR;

@Service
public class SignatureGenerationServiceImpl implements SignatureGenerationService {
    private static final Logger log = LoggerFactory.getLogger(SignatureGenerationServiceImpl.class);

//    @Override
//    public String generateTransactionSignature(request request) throws CustomException {
//        try {
//            // Get clear text
//            String clearText = getTransactionClearText(request);
//            log.info("Generate Transaction Signature Clear Text: " + clearText);
//
//            return generateSignature(clearText);
//
//        } catch (CustomException e) {
//            throw new CustomException(e.getMessage());
//        }
//    }
//
//    @Override
//    public String generateAirtimeSignature(Envelope airtimeRequest) throws CustomException {
//        try {
//            // Get clear text
//            String clearText = getAirtimeClearText(airtimeRequest);
//            log.info("Generate Airtime Signature Clear Text: " + clearText);
//
//            return generateSignature(clearText);
//
//        } catch (CustomException e) {
//            throw new CustomException(e.getMessage());
//        }
//    }

//    private String generateSignature(String clearText) throws CustomException {
//        FileInputStream fis = null;
//        try {
//            // Load the keystore
//            KeyStore keyStore = KeyStore.getInstance("PKCS12");
//            fis = new FileInputStream(ApplicationConstants.KEYSTORE_PATH);
//            keyStore.load(fis, ApplicationConstants.KEYSTORE_PASSWORD.toCharArray());
//
//            // Retrieve all alias names in the KeyStore
//            Enumeration<String> aliases = keyStore.aliases();
//
//            // Assuming there is at least one alias, get the first alias name
//            String alias = aliases.nextElement();
//
//            // Retrieve the private key associated with the alias
//            PrivateKey privateKey = (PrivateKey) keyStore.getKey(alias, ApplicationConstants.KEYSTORE_PASSWORD.toCharArray());
//
//            // Sign the clear text
//            Signature signature = Signature.getInstance(ApplicationConstants.SIGNATURE_ALGORITHM);
//            signature.initSign(privateKey);
//            signature.update(clearText.getBytes());
//
//            byte[] signedData = signature.sign();
//            return new String(Base64.getEncoder().encode(signedData));
//        } catch (CertificateException | KeyStoreException | IOException | NoSuchAlgorithmException |
//                 UnrecoverableKeyException | InvalidKeyException | SignatureException e) {
//            throw new CustomException(SIGNATURE_GENERATION_ERROR);
//        } finally {
//            if (fis != null) {
//                try {
//                    fis.close();
//                } catch (IOException e) {
//                    log.error("On Verify Signature, Failed to close FileInputStream" + e.getMessage());
//                }
//            }
//        }
//    }

//    private String getTransactionClearText(request request) {
//        Eazzycash eazzyCash = request.getEazzycash();
//        BigDecimal amount = eazzyCash.getAmount();
//        String sender = eazzyCash.getSender();
//        String name = eazzyCash.getName();
//        String number = eazzyCash.getNumber();
//        String telco = eazzyCash.getTelco();
//        String rrn = eazzyCash.getRrn();
//
//        //concatenate the clear texts
//        return amount + sender + name + number + telco + rrn;
//    }

    private String getAirtimeClearText(Envelope airtimeRequest) {
        TopUp topUp = airtimeRequest.getBody().getTopUp();
        String phoneNumber = topUp.getMsisdnA();
        BigDecimal amount = topUp.getAmount();
        String telco = topUp.getTelcom();
        String channel = topUp.getChannel();
        String reference = topUp.getRrn();

        //concatenate the clear texts
        return phoneNumber + amount + telco + channel + reference;
    }

    @Override
    public String generateTransactionSignature(request request) throws CustomException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public String generateAirtimeSignature(Envelope airtimeRequest) throws CustomException {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
}
