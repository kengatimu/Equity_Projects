package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.config.ApplicationConstants;
import com.equitybank.gag.telco_b2c.dto.Eazzycash;
import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
import com.equitybank.gag.telco_b2c.dto.airtime.request.TopUp;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.dto.thunes.creditParties.creditPartyInfo.CreditPartyInformation;
import com.equitybank.gag.telco_b2c.dto.thunes.creditParties.creditPartyVerify.CreditPartyVerify;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.bic.BicLookup;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.countries.ListOfThunesCountries;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.details.PayerDetails;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.payers.ThunesPayers;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.rates.PayerRates;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.services.ListOfThunesServices;
import com.equitybank.gag.telco_b2c.dto.thunes.staticData.StaticDataRequest;
import com.equitybank.gag.telco_b2c.dto.thunes.transfer.quotation.CreateQuoteDto;
import com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction.Destination;
import com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction.TransactionRequestDto;
import com.equitybank.gag.telco_b2c.dto.wendi.namecheck.NamecheckRequest;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.SignatureVerificationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Paths;
import java.security.*;
import java.security.cert.CertificateFactory;
import java.security.cert.X509Certificate;
import java.util.Base64;
import java.util.Map;

import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.DEFAULT_FIN_CHANNEL;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.SIGNATURE_VALIDATION_ERROR;

@Service
public class SignatureVerificationServiceImpl implements SignatureVerificationService {
    private static final Logger log = LoggerFactory.getLogger(SignatureVerificationServiceImpl.class);

    private final String activeProfile;
    private final String certificatePath;

    @Autowired
    public SignatureVerificationServiceImpl(@Value("${spring.profiles.active:default}") String activeProfile,
                                            @Value("${signature.validation.certificate.path}") String certificatePath) {
        this.activeProfile = activeProfile;
        this.certificatePath = certificatePath;
    }

    @Override
    public boolean verifyTransactionRequestSignature(request request) throws CustomException, SignatureException {
        try {
            String rrn = request.getEazzycash().getRrn();
            String channel = request.getEazzycash().getChannel();

            // Get clear text
            String clearText = getTransactionClearText(request);
            log.info("Verify Transaction Signature Clear Text: {}", clearText);

            // Get the source signature
            String sourceSignature = request.getEazzycash().getSignature();

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyFloatPurchaseRequestSignature(request request) throws CustomException, SignatureException {
        try {
            String rrn = request.getEazzycash().getRrn();
            String channel = request.getEazzycash().getChannel();

            // Finacle over the counter do send signatures, return true
            if (channel.equalsIgnoreCase(DEFAULT_FIN_CHANNEL)) {
                log.info("Finacle Over The Counter Float Purchase Signature Verification By-Passed!! returning OK.");
                return true;
            }

            // Get clear text
            String clearText = getFloatPurchaseClearText(request);
            log.info("Verify Float Purchase Signature Clear Text: {}", clearText);

            // Get the source signature
            String sourceSignature = request.getEazzycash().getSignature();

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyAirtimeRequestSignature(Envelope airtimeRequest) throws CustomException, SignatureException {
        // Airtime uses Bearer Token
        return true;

//        try {
//            String rrn = airtimeRequest.getBody().getTopUp().getRrn();
//            String channel = airtimeRequest.getBody().getTopUp().getChannel();
//
//            // Get clear text
//            String clearText = getAirtimeRequestClearText(airtimeRequest);
//            log.info("Airtime TopUp Verify Signature Clear Text: {}", clearText);
//
//            // Get the source signature
//            String sourceSignature = airtimeRequest.getBody().getTopUp().getSignature();
//
//            return verifySignature(clearText, sourceSignature, channel, rrn);
//        } catch (CustomException e) {
//            e.printStackTrace();
//            throw new CustomException(e.getMessage());
//        }
    }

    @Override
    public boolean verifyMGFeeLookupRequestSignature(Map<String, String> xmlStringMap) throws CustomException, SignatureException {
        try {
            // Get map values
            String rrn = xmlStringMap.get("rrn");
            String channel = xmlStringMap.get("channelId");
            String sourceSignature = xmlStringMap.get("signature");

            // Get clear text
            String clearText = getMGFeeLookupClearText(xmlStringMap);
            log.info("MG Fee Lookup Signature Clear Text: {}", clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyGetFieldForProductRequestSignature(Map<String, String> xmlStringMap) throws CustomException, SignatureException {
        try {
            // Get map values
            String rrn = xmlStringMap.get("rrn");
            String channel = xmlStringMap.get("channelId");
            String sourceSignature = xmlStringMap.get("signature");

            // Get clear text
            String clearText = getFieldForProductClearText(xmlStringMap);
            log.info("Get Field For Product Signature Clear Text: {}", clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyReceiveGetFieldForProductRequestSignature(Map<String, String> xmlStringMap) throws CustomException, SignatureException {
        try {
            // Get map values
            String rrn = xmlStringMap.get("rrn");
            String channel = xmlStringMap.get("channelId");
            String sourceSignature = xmlStringMap.get("signature");

            // Get clear text
            String clearText = getReceiveFieldForProductClearText(xmlStringMap);
            log.info("Get Receive Field For Product Signature Clear Text: {}", clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifySendValidationRequestSignature(Map<String, String> xmlStringMap) throws CustomException, SignatureException {
        try {
            // Get map values
            String rrn = xmlStringMap.get("rrn");
            String channel = xmlStringMap.get("channelId");
            String sourceSignature = xmlStringMap.get("signature");

            // Get clear text
            String clearText = sendValidationRequestClearText(xmlStringMap);
            log.info("Get Send Validation Request Signature Clear Text: {}", clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyReceiveValidationRequestSignature(Map<String, String> xmlStringMap) throws CustomException, SignatureException {
        try {
            // Get map values
            String rrn = xmlStringMap.get("rrn");
            String channel = xmlStringMap.get("channelId");
            String sourceSignature = xmlStringMap.get("signature");

            // Get clear text
            String clearText = receiveValidationRequestClearText(xmlStringMap);
            log.info("Get Receive Validation Request Signature Clear Text: {}", clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyCommitTransactionRequestSignature(Map<String, String> xmlStringMap) throws CustomException, SignatureException {
        try {
            // Get map values
            String rrn = xmlStringMap.get("rrn");
            String channel = xmlStringMap.get("channelId");
            String sourceSignature = xmlStringMap.get("signature");

            // Get clear text
            String clearText = commitTransactionRequestClearText(xmlStringMap);
            log.info("Get Commit Transaction Request Signature Clear Text: {}", clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyReceiveCommitTransactionRequestSignature(Map<String, String> xmlStringMap) throws CustomException, SignatureException {
        try {
            // Get map values
            String rrn = xmlStringMap.get("rrn");
            String channel = xmlStringMap.get("channelId");
            String sourceSignature = xmlStringMap.get("signature");

            // Get clear text
            String clearText = receiveCommitTransactionRequestClearText(xmlStringMap);
            log.info("Get Receive Commit Transaction Request Signature Clear Text: {}", clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyDetailLookupRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException {
        try {
            // Get map values
            String rrn = xmlTagsMap.get("referenceNumber");
            String channel = xmlTagsMap.get("channelId");
            String sourceSignature = xmlTagsMap.get("signature");

            // Get clear text
            String clearText = detailLookupRequestClearText(xmlTagsMap);
            log.info("Get Detail Lookup Request Signature Clear Text: {}", clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifySendReversalRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException {
        try {
            // Get map values
            String rrn = xmlTagsMap.get("rrn");
            String channel = xmlTagsMap.get("channelId");
            String sourceSignature = xmlTagsMap.get("signature");

            // Get clear text
            String clearText = sendReversalRequestClearText(xmlTagsMap);
            log.info("Get Send Reversal Request Signature Clear Text: {}", clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyAmendTransactionRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException {
        try {
            // Get map values
            String rrn = xmlTagsMap.get("rrn");
            String channel = xmlTagsMap.get("channelId");
            String sourceSignature = xmlTagsMap.get("signature");

            // Get clear text
            String clearText = amendTransactionRequestClearText(xmlTagsMap);
            log.info("Get Amend Transaction Request Signature Clear Text: {}", clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyReferenceNumberRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException {
        try {
            // Get map values
            String rrn = xmlTagsMap.get("rrn");
            String channel = xmlTagsMap.get("channelId");
            String sourceSignature = xmlTagsMap.get("signature");

            // Get clear text
            String clearText = referenceNumberRequestClearText(xmlTagsMap);
            log.info("Get Reference Number Request Signature Clear Text: {}", clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyReceiveReversalRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException {
        try {
            // Get map values
            String rrn = xmlTagsMap.get("rrn");
            String channel = xmlTagsMap.get("channelId");
            String sourceSignature = xmlTagsMap.get("signature");

            // Get clear text
            String clearText = receiveReversalRequestClearText(xmlTagsMap);
            log.info("Receive Reversal Request Signature Clear Text: {}", clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyCodeTableRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException {
        try {
            // Get map values
            String rrn = xmlTagsMap.get("rrn");
            String channel = xmlTagsMap.get("channelId");
            String sourceSignature = xmlTagsMap.get("signature");

            // Get clear text
            String clearText = codeTableRequestClearText(xmlTagsMap);
            log.info("Code Table Request Signature Clear Text: {}", clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyNamecheckRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException {
        try {
            // Get map values
            String rrn = xmlTagsMap.get("msgId");
            String channel = xmlTagsMap.get("channel");
            String sourceSignature = xmlTagsMap.get("signature");

            // Finacle over the counter do send signatures, return true
            if (channel.equalsIgnoreCase(DEFAULT_FIN_CHANNEL)) {
                log.info("Finacle Over The Counter Float Purchase Signature Verification By-Passed!! returning OK.");
                return true;
            }

            // Get clear text
            String clearText = nameCheckRequestClearText(xmlTagsMap);
            log.info("Name Check Request Signature Clear Text: {}", clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyStatusCheckRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException {
        try {
            // Get map values
            String rrn = xmlTagsMap.get("rrn");
            String channel = xmlTagsMap.get("channel");
            String sourceSignature = xmlTagsMap.get("signature");

            // Get clear text
            String clearText = statusCheckRequestClearText(xmlTagsMap);
            log.info("Status Check Request Signature Clear Text: {}", clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyThunesGetListOfServices(ListOfThunesServices listOfThunesServices, String type) throws CustomException, SignatureException {
        try {
            String rrn = listOfThunesServices.getChannelInfo().getRrn();
            String channel = listOfThunesServices.getChannelInfo().getChannelId();
            String sourceSignature = listOfThunesServices.getSignature();

            // Get clear text
            String clearText = listOfThunesServicesRequestClearText(listOfThunesServices);
            log.info("{}: {} List of Services Request Signature Clear Text: {}", rrn, type, clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyGetThunesPayers(ThunesPayers thunesPayers, String type) throws CustomException, SignatureException {
        try {
            String rrn = thunesPayers.getChannelInfo().getRrn();
            String channel = thunesPayers.getChannelInfo().getChannelId();
            String sourceSignature = thunesPayers.getSignature();

            // Get clear text
            String clearText = listOfGetThunesPayersRequestClearText(thunesPayers);
            log.info("{}: {} Thunes Payers Request Signature Clear Text: {}", rrn, type, clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyThunesPayerRates(PayerRates payerRates, String type) throws CustomException, SignatureException {
        try {
            String rrn = payerRates.getChannelInfo().getRrn();
            String channel = payerRates.getChannelInfo().getChannelId();
            String sourceSignature = payerRates.getSignature();

            // Get clear text
            String clearText = getThunesPayersRatesClearText(payerRates);
            log.info("{}: {} Thunes Payer Rates Request Signature Clear Text: {}", rrn, type, clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyThunesPayerDetails(PayerDetails payerDetails, String type) throws CustomException, SignatureException {
        try {
            String rrn = payerDetails.getChannelInfo().getRrn();
            String channel = payerDetails.getChannelInfo().getChannelId();
            String sourceSignature = payerDetails.getSignature();

            // Get clear text
            String clearText = getThunesPayersDetailsClearText(payerDetails);
            log.info("{}: {} Thunes Payer Details Request Signature Clear Text: {}", rrn, type, clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyThunesListOfCountries(ListOfThunesCountries listOfThunesCountries, String type) throws CustomException, SignatureException {
        try {
            String rrn = listOfThunesCountries.getChannelInfo().getRrn();
            String channel = listOfThunesCountries.getChannelInfo().getChannelId();
            String sourceSignature = listOfThunesCountries.getSignature();

            // Get clear text
            String clearText = getThunesListOfCountriesClearText(listOfThunesCountries);
            log.info("{}: {} Thunes List of Countries Request Signature Clear Text: {}", rrn, type, clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyThunesBicLookup(BicLookup bicLookup, String type) throws CustomException, SignatureException {
        try {
            String rrn = bicLookup.getChannelInfo().getRrn();
            String channel = bicLookup.getChannelInfo().getChannelId();
            String sourceSignature = bicLookup.getSignature();

            // Get clear text
            String clearText = getThunesBicLookupClearText(bicLookup);
            log.info("{}: {} Thunes Bic Lookup Request Signature Clear Text: {}", rrn, type, clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyThunesCreditPartyInfo(CreditPartyInformation creditPartyInformation, String type) throws CustomException, SignatureException {
        try {
            String rrn = creditPartyInformation.getChannelInfo().getRrn();
            String channel = creditPartyInformation.getChannelInfo().getChannelId();
            String sourceSignature = creditPartyInformation.getSignature();

            // Get clear text
            String clearText = getThunesCreditPartyInfoClearText(creditPartyInformation);
            log.info("{}: {} Thunes Credit Party Info Request Signature Clear Text: {}", rrn, type, clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyThunesCreditPartyVerify(CreditPartyVerify creditPartyVerify, String type) throws CustomException, SignatureException {
        try {
            String rrn = creditPartyVerify.getChannelInfo().getRrn();
            String channel = creditPartyVerify.getChannelInfo().getChannelId();
            String sourceSignature = creditPartyVerify.getSignature();

            // Get clear text
            String clearText = getThunesCreditPartyVerifyClearText(creditPartyVerify);
            log.info("{}: {} Thunes Credit Party Verify Request Signature Clear Text: {}", rrn, type, clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyThunesStaticData(StaticDataRequest staticDataRequest, String type) throws CustomException, SignatureException {
        try {
            String rrn = staticDataRequest.getChannelInfo().getRrn();
            String channel = staticDataRequest.getChannelInfo().getChannelId();
            String sourceSignature = staticDataRequest.getSignature();

            // Get clear text
            String clearText = getThunesStaticDataClearText(staticDataRequest);
            log.info("{}: {} Thunes Static Data Request Signature Clear Text: {}", rrn, type, clearText);

            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyCreateQuoteRequest(CreateQuoteDto createQuoteDto, String type) throws CustomException, SignatureException {
        try {
            String rrn = createQuoteDto.getChannelInfo().getRrn();
            String channel = createQuoteDto.getChannelInfo().getChannelId();
            String sourceSignature = createQuoteDto.getSignature();

            // Get clear text
            String clearText = getThunesCrateQuoteClearText(createQuoteDto);
            log.info("{}: {} Thunes Create Quote Request Signature Clear Text: {}", rrn, type, clearText);
            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifySendTransactionRequest(TransactionRequestDto transactionRequestDto, String type) throws CustomException, SignatureException {
        try {
            String rrn = transactionRequestDto.getChannelInfo().getRrn();
            String channel = transactionRequestDto.getChannelInfo().getChannelId();
            String sourceSignature = transactionRequestDto.getSignature();

            // Get clear text
            String clearText = getThunesSendTransactionClearText(transactionRequestDto);
            log.info("{}: {} Thunes Send Transaction Request Signature Clear Text: {}", rrn, type, clearText);
            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    @Override
    public boolean verifyWendiB2CNamecheck(NamecheckRequest req, String type) throws CustomException, SignatureException {
        try {
            String rrn = req.getChannelInfo().getRrn();
            String channel = req.getChannelInfo().getChannelId();
            String sourceSignature = req.getSignature();

            // Get clear text
            String clearText = getWendiB2CNamecheckClearText(req);
            log.info("{}: {} Wendi B2C Namecheck Request Signature Clear Text: {}", rrn, type, clearText);
            return verifySignature(clearText, sourceSignature, channel, rrn);
        } catch (CustomException e) {
            e.printStackTrace();
            throw new CustomException(e.getMessage());
        }
    }

    private boolean verifySignature(String clearText, String sourceSignature, String channel, String rrn) throws CustomException, SignatureException {
        FileInputStream fis = null;

        // Mock signature value (only valid outside prod)
        String mockSig = "elzapEDbxUvA+oiyWtPZYM+fqI/MOCK/UAxMjCtJifvr8z7ztjOx0Tq7La63Yvju06g6AWjhs3LrZa8ECBqQkQNdK9DBTcBT/oSP0Nla3IHq/WREA40ttMPtgbQoCmp/ZCL7Rmw8ulm/A2VEUvM14LEfn2jMzij1DWPzidsCkA6q7CYPPHLFIBVpevEpTNp9WTm80RWYr8oZx5jT8i4FAFMnN58kXd1==";

        // Only allow mock signature in non-prod environments
        if (!"prod".equalsIgnoreCase(activeProfile)
                && sourceSignature != null
                && sourceSignature.equalsIgnoreCase(mockSig)) {
            log.info("{}: Mocked signature accepted in [{}] profile", rrn, activeProfile);
            return true;
        }

        log.info("SIGNATURE CLEAR TEXT: " + clearText);

        // Determine the certificate path based on the channel
        String certificatePath = determineCertificatePath(channel, rrn);
        log.info("{}: CertificatePath: {}", rrn, certificatePath);

        try {
            // Read the certificate
            fis = new FileInputStream(certificatePath);
            CertificateFactory cf = CertificateFactory.getInstance("X.509");

            X509Certificate certificate = (X509Certificate) cf.generateCertificate(fis);
            log.info("X509Certificate: ".toUpperCase() + certificate.getSubjectX500Principal().getName() + "  READ SUCCESSFULLY!!");

            // Get the public key from the cert file
            PublicKey publicKey = certificate.getPublicKey();

            // Verify the signature
            Signature signature = Signature.getInstance(ApplicationConstants.SIGNATURE_ALGORITHM);
            signature.initVerify(publicKey);
            signature.update(clearText.getBytes());

            byte[] decodedSignature = Base64.getDecoder().decode(sourceSignature);
            return signature.verify(decodedSignature);

        } catch (Exception e) {
            e.printStackTrace();
            throw new SignatureException(SIGNATURE_VALIDATION_ERROR);
        } finally {
            if (fis != null) {
                try {
                    fis.close();
                } catch (IOException e) {
                    log.error("On Verify Signature, Failed to close FileInputStream" + e.getMessage());
                }
            }
        }
    }

    private String determineCertificatePath(String channelId, String rrn) throws CustomException {
        // Check if the certificate exists
        boolean isCertificateValid = validateCertificateExists(channelId);

        if (isCertificateValid) {
            log.info("{}: {} Certificate Found!", rrn, channelId.toUpperCase());
            return certificatePath + channelId.toUpperCase() + ".cer";
        } else {
            log.error("{}: Certificate Not Found. Invalid ChannelId", rrn);
            throw new CustomException(SIGNATURE_VALIDATION_ERROR);
        }
    }

    private boolean validateCertificateExists(String channelId) {
        // Ensure the channelId is uppercase and concatenate with .cer
        String certificateFileName = channelId.toUpperCase() + ".cer";

        // Create the full path to the certificate file
        File certificateFile = Paths.get(certificatePath, certificateFileName).toFile();

        // Check if the file exists
        return certificateFile.exists();
    }

    private String getTransactionClearText(request request) {
        Eazzycash eazzyCash = request.getEazzycash();
//        BigDecimal amount = eazzyCash.getAmount().setScale(2, RoundingMode.CEILING);
        BigDecimal amount = eazzyCash.getAmount();
        String sender = eazzyCash.getSender();
        String name = eazzyCash.getName();
        String number = eazzyCash.getNumber();
        String telco = eazzyCash.getTelco();
        String rrn = eazzyCash.getRrn();

        //concatenate the clear texts
        return amount + sender + name + number + telco + rrn;
    }

    private String getFloatPurchaseClearText(request request) {
        Eazzycash eazzyCash = request.getEazzycash();
        String rrn = eazzyCash.getRrn();
//        BigDecimal amount = eazzyCash.getAmount().setScale(2, RoundingMode.CEILING);
        BigDecimal amount = eazzyCash.getAmount();
        String sourceAccount = eazzyCash.getSourceAccount();
        String currency = eazzyCash.getCurrency();
        String name = eazzyCash.getName();
        String number = eazzyCash.getNumber();
        String telco = eazzyCash.getTelco();

        //concatenate the clear texts
        return rrn + amount + sourceAccount + currency + name + number + telco;
    }

    private String getAirtimeRequestClearText(Envelope airtimeRequest) {
        TopUp topUp = airtimeRequest.getBody().getTopUp();
        String phoneNumber = topUp.getMsisdnA();
//        BigDecimal amount = topUp.getAmount().setScale(2, RoundingMode.CEILING);
        BigDecimal amount = topUp.getAmount();
        String telco = topUp.getTelcom();
        String channel = topUp.getChannel();
        String reference = topUp.getRrn();

        //concatenate the clear texts
        return phoneNumber + amount + telco + channel + reference;
    }

    private String getMGFeeLookupClearText(Map<String, String> xmlStringMap) {
        String amount;
        // Retrieve the amount values from the map, defaulting to null if they are absent
        String amountExcludingFee = xmlStringMap.get("amountExcludingFee");
        String amountIncludingFee = xmlStringMap.get("amountIncludingFee");
        String receiveAmount = xmlStringMap.get("receiveAmount");

        // Determine the amount to save based on the first non-null value
        if (amountExcludingFee != null) {
            amount = amountExcludingFee;
        } else if (amountIncludingFee != null) {
            amount = amountIncludingFee;
        } else {
            amount = receiveAmount;
        }

        String rrn = xmlStringMap.get("rrn");
        String channel = xmlStringMap.get("channelId");
        String sourceSystemId = xmlStringMap.get("sourceSystemId");
        String receiveCountry = xmlStringMap.get("receiveCountry");

        //concatenate the clear texts
        return rrn + channel + sourceSystemId + amount + receiveCountry;
    }

    private String getFieldForProductClearText(Map<String, String> xmlStringMap) {
        String rrn = xmlStringMap.get("rrn");
        String channel = xmlStringMap.get("channelId");
        String sourceSystemId = xmlStringMap.get("sourceSystemId");
        String receiveCountry = xmlStringMap.get("receiveCountry");
        String receiveCurrency = xmlStringMap.get("receiveCurrency");
        String amount = xmlStringMap.get("amount");

        //concatenate the clear texts
        return rrn + channel + sourceSystemId + receiveCountry + receiveCurrency + amount;
    }

    private String getReceiveFieldForProductClearText(Map<String, String> xmlStringMap) {
        String rrn = xmlStringMap.get("rrn");
        String channel = xmlStringMap.get("channelId");
        String sourceSystemId = xmlStringMap.get("sourceSystemId");
        String receiveCountry = xmlStringMap.get("receiveCountry");
        String receiveCurrency = xmlStringMap.get("receiveCurrency");
        String amount = xmlStringMap.get("amount");

        //concatenate the clear texts
        return rrn + channel + sourceSystemId + receiveCountry + receiveCurrency + amount;
    }

    private String sendValidationRequestClearText(Map<String, String> xmlStringMap) {
        String rrn = xmlStringMap.get("rrn");
        String channel = xmlStringMap.get("channelId");
        String sourceSystemId = xmlStringMap.get("sourceSystemId");
        String destinationAccount = xmlStringMap.get("accountNumber");
        String amount = xmlStringMap.get("amount");
        String receiverFirstName = xmlStringMap.get("receiverFirstName");

        //concatenate the clear texts
        return rrn + channel + sourceSystemId + destinationAccount + amount + receiverFirstName;
    }

    private String receiveValidationRequestClearText(Map<String, String> xmlStringMap) {
        String rrn = xmlStringMap.get("rrn");
        String channel = xmlStringMap.get("channelId");
        String sourceSystemId = xmlStringMap.get("sourceSystemId");
        String referenceNumber = xmlStringMap.get("referenceNumber");
        String agentCheckAmount = xmlStringMap.get("agentCheckAmount");
        String receiveCurrency = xmlStringMap.get("receiveCurrency");
        String mgiTransactionSessionID = xmlStringMap.get("mgiTransactionSessionID");

        //concatenate the clear texts
        return rrn + channel + sourceSystemId + referenceNumber + agentCheckAmount + receiveCurrency + mgiTransactionSessionID;
    }

    private String commitTransactionRequestClearText(Map<String, String> xmlStringMap) {
        String rrn = xmlStringMap.get("rrn");
        String channel = xmlStringMap.get("channelId");
        String sourceSystemId = xmlStringMap.get("sourceSystemId");
        String sourceAccount = xmlStringMap.get("senderAccountNumber");
        String currency = xmlStringMap.get("transactionCurrency");
        String mgiTransactionSessionID = xmlStringMap.get("mgiTransactionSessionID");

        //concatenate the clear texts
        return rrn + channel + sourceSystemId + sourceAccount + currency + mgiTransactionSessionID;
    }

    private String receiveCommitTransactionRequestClearText(Map<String, String> xmlStringMap) {
        String rrn = xmlStringMap.get("rrn");
        String channel = xmlStringMap.get("channelId");
        String sourceSystemId = xmlStringMap.get("sourceSystemId");
        String receiverAccountNumber = xmlStringMap.get("receiverAccountNumber");
        String currency = xmlStringMap.get("transactionCurrency");
        String mgiTransactionSessionID = xmlStringMap.get("mgiTransactionSessionID");

        //concatenate the clear texts
        return rrn + channel + sourceSystemId + receiverAccountNumber + currency + mgiTransactionSessionID;
    }

    private String detailLookupRequestClearText(Map<String, String> xmlTagsMap) {
        String referenceNumber = xmlTagsMap.get("referenceNumber");
        String channel = xmlTagsMap.get("channelId");
        String sourceSystemId = xmlTagsMap.get("sourceSystemId");
        String bankId = xmlTagsMap.get("bankId");

        //concatenate the clear texts
        return referenceNumber + channel + sourceSystemId + bankId;
    }

    private String sendReversalRequestClearText(Map<String, String> xmlTagsMap) {
        String rrn = xmlTagsMap.get("rrn");
        String channel = xmlTagsMap.get("channelId");
        String sourceSystemId = xmlTagsMap.get("sourceSystemId");
        String amount = xmlTagsMap.get("sendAmount");
        String fee = xmlTagsMap.get("feeAmount");
        String currency = xmlTagsMap.get("sendCurrency");
        String referenceNumber = xmlTagsMap.get("referenceNumber");

        //concatenate the clear texts
        return rrn + channel + sourceSystemId + amount + fee + currency + referenceNumber;
    }

    private String amendTransactionRequestClearText(Map<String, String> xmlTagsMap) {
        String rrn = xmlTagsMap.get("rrn");
        String channel = xmlTagsMap.get("channelId");
        String sourceSystemId = xmlTagsMap.get("sourceSystemId");
        String referenceNumber = xmlTagsMap.get("referenceNumber");
        String receiverFirstName = xmlTagsMap.get("receiverFirstName");
        String receiverLastName = xmlTagsMap.get("receiverLastName");

        //concatenate the clear texts
        return rrn + channel + sourceSystemId + referenceNumber + receiverFirstName + receiverLastName;
    }

    private String referenceNumberRequestClearText(Map<String, String> xmlTagsMap) {
        String rrn = xmlTagsMap.get("rrn");
        String channel = xmlTagsMap.get("channelId");
        String sourceSystemId = xmlTagsMap.get("sourceSystemId");
        String referenceNumber = xmlTagsMap.get("referenceNumber");

        //concatenate the clear texts
        return rrn + channel + sourceSystemId + referenceNumber;
    }

    private String receiveReversalRequestClearText(Map<String, String> xmlTagsMap) {
        String rrn = xmlTagsMap.get("rrn");
        String channel = xmlTagsMap.get("channelId");
        String sourceSystemId = xmlTagsMap.get("sourceSystemId");
        String sendAmount = xmlTagsMap.get("sendAmount");
        String feeAmount = xmlTagsMap.get("feeAmount");
        String sendCurrency = xmlTagsMap.get("sendCurrency");
        String referenceNumber = xmlTagsMap.get("referenceNumber");
        String reversalType = xmlTagsMap.get("reversalType");

        //concatenate the clear texts
        return rrn + channel + sourceSystemId + sendAmount + feeAmount + sendCurrency + referenceNumber + reversalType;
    }

    private String codeTableRequestClearText(Map<String, String> xmlTagsMap) {
        String rrn = xmlTagsMap.get("rrn");
        String channel = xmlTagsMap.get("channelId");
        String sourceSystemId = xmlTagsMap.get("sourceSystemId");
        String agentAllowedOnly = xmlTagsMap.get("agentAllowedOnly");

        //concatenate the clear texts
        return rrn + channel + sourceSystemId + agentAllowedOnly;
    }

    private String nameCheckRequestClearText(Map<String, String> xmlTagsMap) {
        String msgId = xmlTagsMap.get("msgId");
        String timestamp = xmlTagsMap.get("timestamp");
        String mobileNumber = xmlTagsMap.get("mobileNumber");

        //concatenate the clear texts
        return mobileNumber + timestamp + msgId;
    }

    private String statusCheckRequestClearText(Map<String, String> xmlTagsMap) {
        String rrn = xmlTagsMap.get("rrn");
        String channel = xmlTagsMap.get("channel");
        String bankId = xmlTagsMap.get("bankId");
        String telco = xmlTagsMap.get("telco");

        //concatenate the clear texts
        return rrn + channel + bankId + telco;
    }

    private String listOfThunesServicesRequestClearText(ListOfThunesServices listOfThunesServices) {
        String rrn = listOfThunesServices.getChannelInfo().getRrn();
        String bankId = listOfThunesServices.getChannelInfo().getBankId();
        String channel = listOfThunesServices.getChannelInfo().getChannelId();
        String countryCode = listOfThunesServices.getReceiver().getCountryCode();

        //concatenate the clear texts
        return rrn + bankId + channel + countryCode;
    }

    private String listOfGetThunesPayersRequestClearText(ThunesPayers thunesPayers) {
        String rrn = thunesPayers.getChannelInfo().getRrn();
        String bankId = thunesPayers.getChannelInfo().getBankId();
        String channel = thunesPayers.getChannelInfo().getChannelId();

        //concatenate the clear texts
        return rrn + bankId + channel;
    }

    private String getThunesPayersRatesClearText(PayerRates payerRates) {
        String rrn = payerRates.getChannelInfo().getRrn();
        String bankId = payerRates.getChannelInfo().getBankId();
        String channel = payerRates.getChannelInfo().getChannelId();
        String payerId = payerRates.getReceiver().getPayerId();

        //concatenate the clear texts
        return rrn + bankId + channel + payerId;
    }

    private String getThunesPayersDetailsClearText(PayerDetails payerDetails) {
        String rrn = payerDetails.getChannelInfo().getRrn();
        String bankId = payerDetails.getChannelInfo().getBankId();
        String channel = payerDetails.getChannelInfo().getChannelId();
        String payerId = payerDetails.getReceiver().getPayerId();

        //concatenate the clear texts
        return rrn + bankId + channel + payerId;
    }

    private String getThunesListOfCountriesClearText(ListOfThunesCountries listOfThunesCountries) {
        String rrn = listOfThunesCountries.getChannelInfo().getRrn();
        String bankId = listOfThunesCountries.getChannelInfo().getBankId();
        String channel = listOfThunesCountries.getChannelInfo().getChannelId();

        //concatenate the clear texts
        return rrn + bankId + channel;
    }

    private String getThunesBicLookupClearText(BicLookup bicLookup) {
        String rrn = bicLookup.getChannelInfo().getRrn();
        String bankId = bicLookup.getChannelInfo().getBankId();
        String channel = bicLookup.getChannelInfo().getChannelId();
        String bic = bicLookup.getReceiver().getBic();

        //concatenate the clear texts
        return rrn + bankId + channel + bic;

    }

    private String getThunesCreditPartyInfoClearText(CreditPartyInformation creditPartyInformation) {
        String rrn = creditPartyInformation.getChannelInfo().getRrn();
        String bankId = creditPartyInformation.getChannelInfo().getBankId();
        String channel = creditPartyInformation.getChannelInfo().getChannelId();
        String payerId = creditPartyInformation.getReceiver().getPayerId();
        String transactionType = creditPartyInformation.getReceiver().getTransactionType();

        //concatenate the clear texts
        return rrn + bankId + channel + payerId + transactionType;
    }

    private String getThunesCreditPartyVerifyClearText(CreditPartyVerify creditPartyVerify) {
        String rrn = creditPartyVerify.getChannelInfo().getRrn();
        String bankId = creditPartyVerify.getChannelInfo().getBankId();
        String channel = creditPartyVerify.getChannelInfo().getChannelId();
        String payerId = creditPartyVerify.getReceiver().getPayerId();
        String transactionType = creditPartyVerify.getReceiver().getTransactionType();

        //concatenate the clear texts
        return rrn + bankId + channel + payerId + transactionType;
    }

    private String getThunesStaticDataClearText(StaticDataRequest staticDataRequest) {
        String rrn = staticDataRequest.getChannelInfo().getRrn();
        String bankId = staticDataRequest.getChannelInfo().getBankId();
        String channel = staticDataRequest.getChannelInfo().getChannelId();
        String countryCode = staticDataRequest.getReceiver().getCountryCode();

        //concatenate the clear texts
        return rrn + bankId + channel + countryCode;
    }

    private String getThunesCrateQuoteClearText(CreateQuoteDto createQuoteDto) {
        String rrn = createQuoteDto.getChannelInfo().getRrn();
        String bankId = createQuoteDto.getChannelInfo().getBankId();
        String channel = createQuoteDto.getChannelInfo().getChannelId();
        String senderAmount = createQuoteDto.getSender().getAmount();
        String senderCurrency = createQuoteDto.getSender().getCurrency();
        String senderCountryCode = createQuoteDto.getSender().getCountryCode();
        String receiverCurrency = createQuoteDto.getReceiver().getCurrency();

        //concatenate the clear texts
        return rrn + bankId + channel + senderAmount + senderCurrency + senderCountryCode + receiverCurrency;
    }

    private String getWendiB2CNamecheckClearText(NamecheckRequest namecheckRequest) {
        String rrn = namecheckRequest.getChannelInfo().getRrn();
        String bankId = namecheckRequest.getChannelInfo().getBankId();
        String channel = namecheckRequest.getChannelInfo().getChannelId();
        String msisdn = namecheckRequest.getReceiver().getMsisdn();

        //concatenate the clear texts
        return rrn + bankId + channel + msisdn;
    }

    private String getThunesSendTransactionClearText(TransactionRequestDto dto) {

        String rrn = dto.getChannelInfo().getRrn();
        String bankId = dto.getChannelInfo().getBankId();
        String channelId = dto.getChannelInfo().getChannelId();

        String imtProvider = dto.getImtProvider();
        String transactionType = dto.getTransactionType();

        String destinationIdentifier = resolveDestinationIdentifier(dto.getDestination());

        String senderAmount = dto.getAmount().getSenderAmount();
        String senderCurrency = dto.getAmount().getSenderCurrency();
        String receiverAmount = dto.getAmount().getReceiverAmount();
        String receiverCurrency = dto.getAmount().getReceiverCurrency();

        String purpose = dto.getRemittance().getPurpose();

        //concatenate the clear texts
        return rrn + bankId + channelId + imtProvider + transactionType + destinationIdentifier + senderAmount + senderCurrency + receiverAmount + receiverCurrency + purpose;
    }

    private String resolveDestinationIdentifier(Destination destination) {

        if (hasText(destination.getMsisdn())) {
            return destination.getMsisdn();
        }
        if (hasText(destination.getIban())) {
            return destination.getIban();
        }
        if (hasText(destination.getBankAccountNumber())) {
            return destination.getBankAccountNumber();
        }
        if (hasText(destination.getClabe())) {
            return destination.getClabe();
        }
        if (hasText(destination.getRoutingCode())) {
            return destination.getRoutingCode();
        }

        return "";
    }

    private boolean hasText(String value) {
        return value != null && !value.trim().isEmpty();
    }

}
