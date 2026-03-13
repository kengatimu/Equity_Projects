package com.bishop.papss_channel_mock_service.service.impl;

import com.bishop.papss_channel_mock_service.dto.channelRequest.namecheck.ChannelNamecheckDetailsReq;
import com.bishop.papss_channel_mock_service.dto.channelRequest.statusCheck.ChannelStatusCheckDetailsReq;
import com.bishop.papss_channel_mock_service.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.bishop.papss_channel_mock_service.exception.CustomException;
import com.bishop.papss_channel_mock_service.service.SignatureGenerationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.FileInputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.*;
import java.security.cert.CertificateException;
import java.util.Base64;

import static com.bishop.papss_channel_mock_service.config.ApplicationConstants.SIGNATURE_GENERATION_ERROR;

@Service
public class SignatureGenerationServiceImpl implements SignatureGenerationService {

    private static final Logger log = LoggerFactory.getLogger(SignatureGenerationServiceImpl.class);

    @Value("${server.ssl.key-store}")
    private String keyStorePath;

    @Value("${server.ssl.key-store-password}")
    private String keyStorePassword;

    @Value("${server.ssl.key-store-type:PKCS12}")
    private String keyStoreType;

    @Value("${server.ssl.key-aliases.omni}")
    private String omniAlias;

    @Value("${server.ssl.key-aliases.remittance}")
    private String remittanceAlias;

    // Generates a digital signature for a namecheck request using canonical text and private key
    @Override
    public String generateNamecheckSignature(ChannelNamecheckDetailsReq request) throws CustomException {
        String rrn = request.getChannelInfo().getRrn();
        try {
            String alias = resolveAlias(request.getChannelInfo().getChannelId());
            PrivateKey privateKey = loadPrivateKeyFromKeystore(alias);
            String canonicalText = buildNamecheckCanonicalText(request);
            log.info("{}: Canonical Namecheck Text: {}", rrn, canonicalText);
            return signWithPrivateKey(privateKey, canonicalText);
        } catch (KeyStoreException
                 | UnrecoverableKeyException
                 | IOException
                 | CertificateException
                 | NoSuchAlgorithmException
                 | InvalidKeyException
                 | SignatureException e) {
            log.error("{}: Error during signature generation: {}", rrn, e.getMessage());
            throw new CustomException(SIGNATURE_GENERATION_ERROR  + e.getMessage());
        } catch (Exception e) {
            log.error("{}: Unexpected error during signature generation: {}", rrn, e.getMessage());
            throw new CustomException(SIGNATURE_GENERATION_ERROR + "Unexpected error: " + e.getMessage());
        }
    }

    // Generates a digital signature for a credit transfer request using canonical text and private key
    @Override
    public String generateTransactionSignature(ChannelCreditTransferDetailsReq request) throws CustomException {
        String rrn = request.getChannelInfo().getRrn();
        try {
            String alias = resolveAlias(request.getChannelInfo().getChannelId());
            PrivateKey privateKey = loadPrivateKeyFromKeystore(alias);
            String canonicalText = buildTransactionCanonicalText(request);
            log.info("{}: Canonical Transaction Text: {}", rrn, canonicalText);
            return signWithPrivateKey(privateKey, canonicalText);
        } catch (KeyStoreException
                 | UnrecoverableKeyException
                 | IOException
                 | CertificateException
                 | NoSuchAlgorithmException
                 | InvalidKeyException
                 | SignatureException e) {
            log.error("{}: Error during signature generation: {}", rrn, e.getMessage());
            throw new CustomException(SIGNATURE_GENERATION_ERROR + e.getMessage());
        } catch (Exception e) {
            log.error("{}: Unexpected error during signature generation: {}", rrn, e.getMessage());
            throw new CustomException(SIGNATURE_GENERATION_ERROR + "Unexpected error: " + e.getMessage());
        }
    }

    @Override
    public String generateStatusCheckSignature(ChannelStatusCheckDetailsReq request) throws CustomException {
        String rrn = request.getChannelInfo().getRrn();
        try {
            String alias = resolveAlias(request.getChannelInfo().getChannelId());
            PrivateKey privateKey = loadPrivateKeyFromKeystore(alias);
            String canonicalText = buildStatusCheckCanonicalText(request);
            log.info("{}: Canonical Transaction Text: {}", rrn, canonicalText);
            return signWithPrivateKey(privateKey, canonicalText);
        } catch (KeyStoreException
                 | UnrecoverableKeyException
                 | IOException
                 | CertificateException
                 | NoSuchAlgorithmException
                 | InvalidKeyException
                 | SignatureException e) {
            log.error("{}: Error during signature generation: {}", rrn, e.getMessage());
            throw new CustomException(SIGNATURE_GENERATION_ERROR + e.getMessage());
        } catch (Exception e) {
            log.error("{}: Unexpected error during signature generation: {}", rrn, e.getMessage());
            throw new CustomException(SIGNATURE_GENERATION_ERROR + "Unexpected error: " + e.getMessage());
        }
    }

    // Loads private key from the configured keystore using the provided alias
    private PrivateKey loadPrivateKeyFromKeystore(String alias) throws Exception {
        KeyStore keyStore = KeyStore.getInstance(keyStoreType);
        keyStore.load(new FileInputStream(keyStorePath), keyStorePassword.toCharArray());
        return (PrivateKey) keyStore.getKey(alias, keyStorePassword.toCharArray());
    }

    // Sign the given text using the private key and return a Base64-encoded signature
    private String signWithPrivateKey(PrivateKey privateKey, String textToSign) throws Exception {
        Signature signature = Signature.getInstance("SHA256withRSA");
        signature.initSign(privateKey);
        signature.update(textToSign.getBytes(StandardCharsets.UTF_8));
        byte[] digitalSignature = signature.sign();
        return Base64.getEncoder().encodeToString(digitalSignature);
    }

    // Determine alias based on the channelId
    private String resolveAlias(String channelId) throws CustomException {
        if (channelId == null) {
            throw new CustomException(SIGNATURE_GENERATION_ERROR + "channelId cannot be null");
        }
        return switch (channelId.trim().toUpperCase()) {
            case "OMNI" -> omniAlias;
            case "REMITTANCE" -> remittanceAlias;
            default -> throw new CustomException(SIGNATURE_GENERATION_ERROR + "Unsupported channelId: " + channelId);
        };
    }

    // Build canonical string for namecheck
    private String buildNamecheckCanonicalText(ChannelNamecheckDetailsReq req) {
        return req.getChannelInfo().getRrn()
                + req.getChannelInfo().getChannelId()
                + req.getChannelInfo().getSourceSystemId()
                + req.getSender().getInstitutionId()
                + req.getReceiver().getInstitutionId()
                + req.getReceiver().getAccountNumber();
    }

    // Build canonical string for credit transfer
    private String buildTransactionCanonicalText(ChannelCreditTransferDetailsReq req) {
        return req.getChannelInfo().getRrn()
                + req.getChannelInfo().getChannelId()
                + req.getChannelInfo().getSourceSystemId()
                + req.getTransactionInfo().getAmount()
                + req.getTransactionInfo().getFeeAmount()
                + req.getSender().getCurrency()
                + req.getSender().getInstitutionId()
                + req.getSender().getAccountNumber()
                + req.getSender().getAccountName()
                + req.getReceiver().getInstitutionId()
                + req.getReceiver().getCurrency()
                + req.getReceiver().getAccountName();
    }

    // Canonical text builder for status check
    private String buildStatusCheckCanonicalText(ChannelStatusCheckDetailsReq req) {
        return req.getChannelInfo().getRrn()
                + req.getChannelInfo().getChannelId()
                + req.getChannelInfo().getSourceSystemId()
                + req.getOriginalTxnInfo().getOriginalRrn();
    }
}
