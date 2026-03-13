package com.equitybank.gag.papss.ots.service.impl;

import com.equitybank.gag.papss.ots.dto.channelRequest.fxRate.GetFxRateReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.getParticipants.GetPapssParticipantsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.namecheck.ChannelNamecheckDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.statusCheck.ChannelStatusCheckDetailsReq;
import com.equitybank.gag.papss.ots.dto.channelRequest.transaction.ChannelCreditTransferDetailsReq;
import com.equitybank.gag.papss.ots.exception.CustomException;
import com.equitybank.gag.papss.ots.service.SignatureValidationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.FileInputStream;
import java.nio.charset.StandardCharsets;
import java.security.KeyStore;
import java.security.PublicKey;
import java.security.Signature;
import java.security.SignatureException;
import java.security.cert.Certificate;
import java.security.cert.CertificateException;
import java.util.Base64;

import static com.equitybank.gag.papss.ots.config.ApplicationConstants.SIGNATURE_VALIDATION_ERROR;
import static com.equitybank.gag.papss.ots.config.ApplicationConstants.TEST_SIGNATURE;

@Service
public class SignatureValidationServiceImpl implements SignatureValidationService {
    private static final Logger log = LoggerFactory.getLogger(SignatureValidationServiceImpl.class);

    private final String activeProfile;
    private final String trustStorePath;
    private final String trustStorePassword;
    private final String trustStoreType;
    private final String omniAlias;
    private final String remittanceAlias;

    public SignatureValidationServiceImpl(@Value("${spring.profiles.active:default}") String activeProfile,
                                          @Value("${server.ssl.trust-store}") String trustStorePath,
                                          @Value("${server.ssl.trust-store-password}") String trustStorePassword,
                                          @Value("${server.ssl.trust-store-type:PKCS12}") String trustStoreType,
                                          @Value("${server.ssl.trust-aliases.omni:omni}") String omniAlias,
                                          @Value("${server.ssl.trust-aliases.remittance:remittance}") String remittanceAlias) {
        this.activeProfile = activeProfile;
        this.trustStorePath = trustStorePath;
        this.trustStorePassword = trustStorePassword;
        this.trustStoreType = trustStoreType;
        this.omniAlias = omniAlias;
        this.remittanceAlias = remittanceAlias;
    }

    @Override
    public void validateGetParticipantsSignature(GetPapssParticipantsReq req) throws CustomException {
        // For testing purposes, by pass a predefined signature text
        String signature = req.getSignature();

        // Check if test signature is allowed. Test signature is not allowed in prod
        if (isTestSignatureAllowed(signature)) {
            return;
        }

        String rrn = req.getChannelInfo().getRrn();
        try {
            String alias = resolveAlias(req.getChannelInfo().getChannelId());
            PublicKey publicKey = loadPublicKeyFromTruststore(alias);
            String canonicalText = buildGetParticipantsCanonicalText(req);
            log.info("{}: Validating Get Participants Canonical Text: {}", rrn, canonicalText);
            verifySignature(publicKey, canonicalText, req.getSignature());
        } catch (Exception e) {
            log.error("{}: Signature validation failed: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public void validateGetFxRateSignature(GetFxRateReq req) throws CustomException {
        // For testing purposes, by pass a predefined signature text
        String signature = req.getSignature();

        // Check if test signature is allowed. Test signature is not allowed in prod
        if (isTestSignatureAllowed(signature)) {
            return;
        }

        String rrn = req.getChannelInfo().getRrn();
        try {
            String alias = resolveAlias(req.getChannelInfo().getChannelId());
            PublicKey publicKey = loadPublicKeyFromTruststore(alias);
            String canonicalText = buildGetFxRateCanonicalText(req);
            log.info("{}: Validating Get Fx Rate Canonical Text: {}", rrn, canonicalText);
            verifySignature(publicKey, canonicalText, req.getSignature());
        } catch (Exception e) {
            log.error("{}: Signature validation failed: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public void validateNamecheckSignature(ChannelNamecheckDetailsReq req) throws CustomException {
        // For testing purposes, by pass a predefined signature text
        String signature = req.getSignature();

        // Check if test signature is allowed. Test signature is not allowed in prod
        if (isTestSignatureAllowed(signature)) {
            return;
        }

        String rrn = req.getChannelInfo().getRrn();
        try {
            String alias = resolveAlias(req.getChannelInfo().getChannelId());
            PublicKey publicKey = loadPublicKeyFromTruststore(alias);
            String canonicalText = buildNamecheckCanonicalText(req);
            log.info("{}: Validating Namecheck Canonical Text: {}", rrn, canonicalText);
            verifySignature(publicKey, canonicalText, req.getSignature());
        } catch (Exception e) {
            log.error("{}: Signature validation failed: {}", rrn, e.getMessage());
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public void validateTransactionSignature(ChannelCreditTransferDetailsReq req) throws CustomException {
        // For testing purposes, by pass a predefined signature text
        String signature = req.getSignature();

        // Check if test signature is allowed. Test signature is not allowed in prod
        if (isTestSignatureAllowed(signature)) {
            return;
        }

        String rrn = req.getChannelInfo().getRrn();
        try {
            String alias = resolveAlias(req.getChannelInfo().getChannelId());
            PublicKey publicKey = loadPublicKeyFromTruststore(alias);
            String canonicalText = buildTransactionCanonicalText(req);
            log.info("{}: Validating Transaction Canonical Text: {}", rrn, canonicalText);
            verifySignature(publicKey, canonicalText, req.getSignature());
        } catch (Exception e) {
            log.error("{}: Signature validation failed: {}", rrn, e.getMessage());
            throw new CustomException(SIGNATURE_VALIDATION_ERROR + e.getMessage());
        }
    }

    @Override
    public void validateStatusCheckSignature(ChannelStatusCheckDetailsReq req) throws CustomException {
        // For testing purposes, by pass a predefined signature text
        String signature = req.getSignature();

        // Check if test signature is allowed. Test signature is not allowed in prod
        if (isTestSignatureAllowed(signature)) {
            return;
        }

        String rrn = req.getChannelInfo().getRrn();
        try {
            String alias = resolveAlias(req.getChannelInfo().getChannelId());
            PublicKey publicKey = loadPublicKeyFromTruststore(alias);
            String canonicalText = buildStatusCheckCanonicalText(req);
            log.info("{}: Validating Status Check Canonical Text: {}", rrn, canonicalText);
            verifySignature(publicKey, canonicalText, req.getSignature());
        } catch (Exception e) {
            log.error("{}: Signature validation failed: {}", rrn, e.getMessage());
            throw new CustomException(SIGNATURE_VALIDATION_ERROR + e.getMessage());
        }
    }

    // Loads public key from the trusted certificate in the truststore
    private PublicKey loadPublicKeyFromTruststore(String alias) throws Exception {
        KeyStore trustStore = KeyStore.getInstance(trustStoreType);
        trustStore.load(new FileInputStream(trustStorePath), trustStorePassword.toCharArray());
        Certificate cert = trustStore.getCertificate(alias);
        if (cert == null) {
            throw new CertificateException(SIGNATURE_VALIDATION_ERROR + "No certificate found for alias: " + alias);
        }
        return cert.getPublicKey();
    }

    // Verifies a base64-encoded signature against the text using the public key
    private void verifySignature(PublicKey publicKey, String text, String base64Signature) throws Exception {
        Signature signature = Signature.getInstance("SHA256withRSA");
        signature.initVerify(publicKey);
        signature.update(text.getBytes(StandardCharsets.UTF_8));
        byte[] signatureBytes = Base64.getDecoder().decode(base64Signature);
        if (!signature.verify(signatureBytes)) {
            throw new SignatureException(SIGNATURE_VALIDATION_ERROR + "Invalid digital signature.");
        }
        log.info("Signature Validation Successful!");
    }

    // Resolve alias based on channelId
    private String resolveAlias(String channelId) throws CustomException {
        if (channelId == null) {
            throw new CustomException(SIGNATURE_VALIDATION_ERROR + "channelId cannot be null");
        }
        return switch (channelId.trim().toUpperCase()) {
            case "OMNI" -> omniAlias;
            case "REMITTANCE" -> remittanceAlias;
            default -> throw new CustomException(SIGNATURE_VALIDATION_ERROR + "Unsupported channelId: " + channelId);
        };
    }

    // Determines whether TEST_SIGNATURE bypass is allowed based on active profile
    private boolean isTestSignatureAllowed(String signature) {

        if (signature == null) {
            log.info("Signature cannot be null");
            return false;
        }

        // Check if the active profile is prod
        boolean isProd = activeProfile != null && activeProfile.toLowerCase().contains("prod");

        // Allow test signature only outside production
        if (!isProd && TEST_SIGNATURE.equals(signature)) {
            log.info("TEST_SIGNATURE bypass applied under profile: {}", activeProfile);
            return true;
        }

        // Explicitly block test signature in production
        if (isProd && TEST_SIGNATURE.equals(signature)) {
            log.error("TEST_SIGNATURE detected in PROD profile. Rejecting request.");
            return false;
        }

        return false;
    }

    // Canonical text builder for get participants request
    private String buildGetParticipantsCanonicalText(GetPapssParticipantsReq req) {
        return req.getChannelInfo().getRrn()
                + req.getChannelInfo().getBankId()
                + req.getChannelInfo().getChannelId()
                + req.getChannelInfo().getSourceSystemId();
    }

    // Canonical text builder for get fx rate request
    private String buildGetFxRateCanonicalText(GetFxRateReq req) {
        return req.getChannelInfo().getRrn()
                + req.getChannelInfo().getBankId()
                + req.getChannelInfo().getChannelId()
                + req.getChannelInfo().getSourceSystemId();
    }

    // Canonical text builder for namecheck
    private String buildNamecheckCanonicalText(ChannelNamecheckDetailsReq req) {
        return req.getChannelInfo().getRrn()
                + req.getChannelInfo().getBankId()
                + req.getChannelInfo().getChannelId()
                + req.getChannelInfo().getSourceSystemId()
                + req.getSender().getInstitutionId()
                + req.getReceiver().getInstitutionId()
                + req.getReceiver().getAccountNumber();
    }

    // Canonical text builder for transaction
    private String buildTransactionCanonicalText(ChannelCreditTransferDetailsReq req) {
        return req.getChannelInfo().getRrn()
                + req.getChannelInfo().getBankId()
                + req.getChannelInfo().getChannelId()
                + req.getChannelInfo().getSourceSystemId()
                + req.getTransactionInfo().getSenderAmount()
                + req.getTransactionInfo().getReceiverAmount()
                + req.getTransactionInfo().getFxRate()
                + req.getTransactionInfo().getPapssFeeAmount()
                + req.getTransactionInfo().getBankFeeAmount()
                + req.getTransactionInfo().getTransactionCurrency()
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
                + req.getChannelInfo().getBankId()
                + req.getChannelInfo().getChannelId()
                + req.getChannelInfo().getSourceSystemId()
                + req.getOriginalTxnInfo().getOriginalRrn();
    }
}
