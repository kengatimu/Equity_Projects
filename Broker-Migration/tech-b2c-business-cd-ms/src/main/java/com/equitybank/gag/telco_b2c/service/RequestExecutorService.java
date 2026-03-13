package com.equitybank.gag.telco_b2c.service;

import com.equitybank.gag.telco_b2c.dto.thunes.creditParties.creditPartyInfo.CreditPartyInformation;
import com.equitybank.gag.telco_b2c.dto.thunes.creditParties.creditPartyVerify.CreditPartyVerify;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.bic.BicLookup;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.countries.ListOfThunesCountries;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.details.PayerDetails;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.payers.ThunesPayers;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.rates.PayerRates;
import com.equitybank.gag.telco_b2c.dto.thunes.discovery.services.ListOfThunesServices;
import com.equitybank.gag.telco_b2c.dto.thunes.response.ChannelResponse;
import com.equitybank.gag.telco_b2c.dto.thunes.staticData.StaticDataRequest;
import com.equitybank.gag.telco_b2c.dto.thunes.transfer.quotation.CreateQuoteDto;
import com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction.TransactionRequestDto;
import com.equitybank.gag.telco_b2c.dto.wendi.namecheck.NamecheckRequest;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import org.springframework.validation.BindingResult;

import java.security.SignatureException;

public interface RequestExecutorService {
    ChannelResponse executeThunesListOfServices(String rrn, ListOfThunesServices req, BindingResult result, String type) throws CustomException, SignatureException;

    ChannelResponse executeThunesGetPayers(String rrn, ThunesPayers req, BindingResult result, String type) throws CustomException, SignatureException;

    ChannelResponse executeThunesPayerRates(String rrn, PayerRates req, BindingResult result, String type) throws CustomException, SignatureException;

    ChannelResponse executeThunesPayerDetails(String rrn, PayerDetails req, BindingResult result, String type) throws CustomException, SignatureException;

    ChannelResponse executeThunesListOfCountries(String rrn, ListOfThunesCountries req, BindingResult result, String type) throws CustomException, SignatureException;

    ChannelResponse executeThunesBicLookup(String rrn, BicLookup req, BindingResult result, String type) throws CustomException, SignatureException;

    ChannelResponse executeThunesCreditPartyInfo(String rrn, CreditPartyInformation req, BindingResult result, String type) throws CustomException, SignatureException;

    ChannelResponse executeThunesCreditPartyVerify(String rrn, CreditPartyVerify req, BindingResult result, String type) throws CustomException, SignatureException;

    ChannelResponse executeThunesStaticData(String rrn, StaticDataRequest req, BindingResult result, String type) throws CustomException, SignatureException;

    ChannelResponse executeThunesCreateQuotation(String rrn, CreateQuoteDto createQuoteDto, BindingResult bindingResult, String type) throws CustomException, SignatureException;

    ChannelResponse executeThunesSendTransaction(String rrn, TransactionRequestDto transactionRequestDto, BindingResult bindingResult, String type) throws CustomException, SignatureException;

    ChannelResponse executeWendiB2CNamecheck(String rrn, NamecheckRequest namecheckRequest, BindingResult bindingResult, String type) throws CustomException, SignatureException;
}
