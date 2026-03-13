package com.equitybank.gag.telco_b2c.service.impl;

import com.equitybank.gag.telco_b2c.dto.Eazzycash;
import com.equitybank.gag.telco_b2c.dto.request;
import com.equitybank.gag.telco_b2c.exception.CustomException;
import com.equitybank.gag.telco_b2c.service.TelcoAccountResolverService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.security.SecureRandom;
import java.util.Map;

import static com.equitybank.gag.telco_b2c.config.ApplicationConstants.DEFAULT_FIN_CHANNEL;
import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.DEFAULT_PROCESSING_FAILURE;

@Service
public class TelcoAccountResolverServiceImpl implements TelcoAccountResolverService {
    private static final Logger log = LoggerFactory.getLogger(TelcoAccountResolverServiceImpl.class);

    private final String keAirtelTrust;
    private final String keAirtelMsisdn;
    private final String rwAirtelTrust;
    private final String ugAirtelF102;
    private final String waridF123;
    private final String cdVodacomUsd;
    private final String cdVodacomCdf;
    private final String cdAirtelUsd;
    private final String cdAirtelCdf;
    private final String ssMtnSsp;

    public TelcoAccountResolverServiceImpl(@Value("${telco.accounts.kenya.airtel.trustaccount}") String keAirtelTrust,
                                           @Value("${telco.accounts.kenya.airtel.trustaccountmsisdn}") String keAirtelMsisdn,
                                           @Value("${telco.accounts.rwanda.airtel.trustaccount}") String rwAirtelTrust,
                                           @Value("${telco.accounts.ug.airtel.f102}") String ugAirtelF102,
                                           @Value("${telco.accounts.kenya.tmt.warid.fincale.f123}") String waridF123,
                                           @Value("${telco.accounts.drc.vodacom.custodyaccount.usd}") String cdVodacomUsd,
                                           @Value("${telco.accounts.drc.vodacom.custodyaccount.cdf}") String cdVodacomCdf,
                                           @Value("${telco.accounts.drc.airtel.custodyaccount.usd}") String cdAirtelUsd,
                                           @Value("${telco.accounts.drc.airtel.custodyaccount.cdf}") String cdAirtelCdf,
                                           @Value("${telco.accounts.ss.mtn.custodyaccount.ssp}") String ssMtnSsp) {
        this.keAirtelTrust = keAirtelTrust;
        this.keAirtelMsisdn = keAirtelMsisdn;
        this.rwAirtelTrust = rwAirtelTrust;
        this.ugAirtelF102 = ugAirtelF102;
        this.waridF123 = waridF123;
        this.cdVodacomUsd = cdVodacomUsd;
        this.cdVodacomCdf = cdVodacomCdf;
        this.cdAirtelUsd = cdAirtelUsd;
        this.cdAirtelCdf = cdAirtelCdf;
        this.ssMtnSsp = ssMtnSsp;
    }

    @Override
    public Map<String, String> resolveTelcoNameForFinacleFloatPurchase(Map<String, String> xmlTagsMap) throws CustomException {
        String dealerAccountNumber = xmlTagsMap.getOrDefault("dealerAccountNumber", "").trim();
        String nationalId = xmlTagsMap.getOrDefault("nationalID", "").trim();

        // MPESA KE takes priority if national ID is provided
        if (!nationalId.isEmpty()) {
            return Map.of(
                    "bankId", "54",
                    "telco", "MPESA",
                    "currency", "KES"
            );
        }

        // Kenya
        if (dealerAccountNumber.equals(keAirtelTrust) || dealerAccountNumber.equals(keAirtelMsisdn)) {
            return Map.of(
                    "bankId", "54",
                    "telco", "AIRTEL-MONEY",
                    "currency", "KES"
            );
        }

        // Warid (Kenya TMT)
        if (dealerAccountNumber.equals(waridF123)) {
            return Map.of(
                    "bankId", "54",
                    "telco", "WARID-TMT",
                    "currency", "KES"
            );
        }

        // Rwanda
        if (dealerAccountNumber.equals(rwAirtelTrust)) {
            return Map.of(
                    "bankId", "50",
                    "telco", "AIRTEL-MONEY",
                    "currency", "RWF"
            );
        }

        // Uganda
        if (dealerAccountNumber.equals(ugAirtelF102)) {
            return Map.of(
                    "bankId", "56",
                    "telco", "AIRTEL-MONEY",
                    "currency", "UGX"
            );
        }

        // South Sudan
        if (dealerAccountNumber.equals(ssMtnSsp)) {
            return Map.of(
                    "bankId", "11",
                    "telco", "MTN-MONEY",
                    "currency", "SSP"
            );
        }

        // DRC Vodacom
        if (dealerAccountNumber.equals(cdVodacomUsd)) {
            return Map.of(
                    "bankId", "43",
                    "telco", "VODACOM-MONEY",
                    "currency", "USD"
            );
        }
        if (dealerAccountNumber.equals(cdVodacomCdf)) {
            return Map.of(
                    "bankId", "43",
                    "telco", "VODACOM-MONEY",
                    "currency", "CDF"
            );
        }

        // DRC Airtel
        if (dealerAccountNumber.equals(cdAirtelUsd)) {
            return Map.of(
                    "bankId", "43",
                    "telco", "AIRTEL-MONEY",
                    "currency", "USD"
            );
        }
        if (dealerAccountNumber.equals(cdAirtelCdf)) {
            return Map.of(
                    "bankId", "43",
                    "telco", "AIRTEL-MONEY",
                    "currency", "CDF"
            );
        }

        // Unknown account
        throw new CustomException(DEFAULT_PROCESSING_FAILURE + "Unknown dealer account number: " + dealerAccountNumber);
    }
}
