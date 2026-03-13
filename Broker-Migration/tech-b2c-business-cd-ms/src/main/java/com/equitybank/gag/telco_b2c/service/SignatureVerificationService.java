package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.dto.airtime.request.Envelope;
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
import com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction.TransactionRequestDto;
import com.equitybank.gag.telco_b2c.dto.wendi.namecheck.NamecheckRequest;
import com.equitybank.gag.telco_b2c.exception.CustomException;

import java.security.SignatureException;

import java.util.Map;

public interface SignatureVerificationService {
    boolean verifyTransactionRequestSignature(request request) throws CustomException, SignatureException;

    boolean verifyAirtimeRequestSignature(Envelope airtimeRequest) throws CustomException, SignatureException;

    boolean verifyMGFeeLookupRequestSignature(Map<String, String> xmlStringMap) throws CustomException, SignatureException;

    boolean verifyGetFieldForProductRequestSignature(Map<String, String> xmlStringMap) throws CustomException, SignatureException;

    boolean verifyReceiveGetFieldForProductRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException;

    boolean verifySendValidationRequestSignature(Map<String, String> xmlStringMap) throws CustomException, SignatureException;

    boolean verifyReceiveValidationRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException;

    boolean verifyCommitTransactionRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException;

    boolean verifyReceiveCommitTransactionRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException;

    boolean verifyDetailLookupRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException;

    boolean verifySendReversalRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException;

    boolean verifyAmendTransactionRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException;

    boolean verifyReferenceNumberRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException;

    boolean verifyReceiveReversalRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException;

    boolean verifyFloatPurchaseRequestSignature(request request) throws CustomException, SignatureException;

    boolean verifyCodeTableRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException;

    boolean verifyNamecheckRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException;

    boolean verifyStatusCheckRequestSignature(Map<String, String> xmlTagsMap) throws CustomException, SignatureException;

    boolean verifyThunesGetListOfServices(ListOfThunesServices listOfThunesServices, String type) throws CustomException, SignatureException;

    boolean verifyGetThunesPayers(ThunesPayers thunesPayers, String type) throws CustomException, SignatureException;

    boolean verifyThunesPayerRates(PayerRates payerRates, String type) throws CustomException, SignatureException;

    boolean verifyThunesPayerDetails(PayerDetails payerDetails, String type) throws CustomException, SignatureException;

    boolean verifyThunesListOfCountries(ListOfThunesCountries listOfThunesCountries, String type) throws CustomException, SignatureException;

    boolean verifyThunesBicLookup(BicLookup bicLookup, String type) throws CustomException, SignatureException;

    boolean verifyThunesCreditPartyInfo(CreditPartyInformation creditPartyInformation, String type) throws CustomException, SignatureException;

    boolean verifyThunesCreditPartyVerify(CreditPartyVerify creditPartyVerify, String type) throws CustomException, SignatureException;

    boolean verifyThunesStaticData(StaticDataRequest staticDataRequest, String type) throws CustomException, SignatureException;

    boolean verifyCreateQuoteRequest(CreateQuoteDto req, String type) throws CustomException, SignatureException;

    boolean verifySendTransactionRequest(TransactionRequestDto req, String type) throws CustomException, SignatureException;

    boolean verifyWendiB2CNamecheck(NamecheckRequest req, String type) throws CustomException, SignatureException;
}
