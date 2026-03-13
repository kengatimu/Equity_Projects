package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.dto.thunes.creditParties.creditPartyInfo.CreditPartyInformation;
import com.equitybank.gag.telco_b2c.dto.thunes.creditParties.creditPartyVerify.CreditPartyVerify;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.bic.BicLookup;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.countries.ListOfThunesCountries;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.details.PayerDetails;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.payers.ThunesPayers;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.rates.PayerRates;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.services.ListOfThunesServices;
import com.equitybank.gag.telco_b2c.dto.thunes.transfer.quotation.CreateQuoteDto;
import com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction.TransactionRequestDto;
import com.equitybank.gag.telco_b2c.dto.wendi.namecheck.NamecheckRequest;
import com.equitybank.gag.telco_b2c.exception.CustomException;

public interface ImtHttpService {
    String thunesServicesHttpCall(String rrn, ListOfThunesServices listOfThunesServices, String type) throws CustomException;

    String thunesPayersHttpCall(String rrn, ThunesPayers thunesPayers, String type) throws CustomException;

    String thunesPayerRatesHttpCall(String rrn, PayerRates payerRates, String type) throws CustomException;

    String thunesPayerDetailsHttpCall(String rrn, PayerDetails payerDetails, String type) throws CustomException;

    String thunesListOfCountriesHttpCall(String rrn, ListOfThunesCountries listOfThunesCountries, String type) throws CustomException;

    String thunesBicLookupHttpCall(String rrn, BicLookup bicLookup, String type) throws CustomException;

    String thunesCreditPartyInfoHttpCall(String rrn, CreditPartyInformation creditPartyInformation, String type) throws CustomException;

    String thunesCreditPartyVerifyHttpCall(String rrn, CreditPartyVerify creditPartyVerify, String type) throws CustomException;

    String thunesCreateQuoteHttpCall(String rrn, CreateQuoteDto req, String type) throws CustomException;

    String thunesCreateQuoteHttpCall(String rrn, TransactionRequestDto transactionRequestDto, String type) throws CustomException;

    String wendiB2CNamecheckHttpCall(String rrn, NamecheckRequest req, String type) throws CustomException;
}
