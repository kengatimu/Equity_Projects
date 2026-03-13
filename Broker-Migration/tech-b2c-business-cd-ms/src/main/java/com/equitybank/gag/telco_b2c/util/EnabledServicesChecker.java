package com.equitybank.gag.telco_b2c.util;

import com.equitybank.gag.telco_b2c.exception.CustomException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class EnabledServicesChecker {

    private final boolean isAirtimeTopupEnabled;
    private final boolean isAirtimeStatusEnabled;
    private final boolean isFloatPurchaseEnabled;
    private final boolean isBankToWalletEnabled;
    private final boolean isBankToWalletStatusEnabled;
    private final boolean isAirtimeTopupXmlEnabled;
    private final boolean isFloatPurchaseXmlEnabled;
    private final boolean isBankToWalletXmlEnabled;
    private final boolean isMoneygramOutboundEnabled;
    private final boolean isMoneygramInboundEnabled;
    private final boolean isThunesOutboundEnabled;
    private final boolean isWendiOutboundEnabled;
    private final boolean isDatabaseOperationEnabled;
    private final boolean isNameCheckBankToWalletEnabled;
    private final boolean isNameCheckAirtimeTopupEnabled;
    private final boolean isNameCheckFloatPurchaseEnabled;

    // Constructor injection using @Value to get values from application.yaml
    @Autowired
    public EnabledServicesChecker(
            @Value("${enabled.services.telco.version1.airtime-topup-json:false}") boolean isAirtimeTopupEnabled,
            @Value("${enabled.services.telco.version1.airtime-status-json:false}") boolean isAirtimeStatusEnabled,
            @Value("${enabled.services.telco.version1.float-purchase-json:false}") boolean isFloatPurchaseEnabled,
            @Value("${enabled.services.telco.version1.bank-to-wallet-json:false}") boolean isBankToWalletEnabled,
            @Value("${enabled.services.telco.version1.bank-to-wallet-status-json:false}") boolean isBankToWalletStatusEnabled,
            @Value("${enabled.services.telco.version2.airtime-topup-xml:false}") boolean isAirtimeTopupXmlEnabled,
            @Value("${enabled.services.telco.version2.float-purchase-xml:false}") boolean isFloatPurchaseXmlEnabled,
            @Value("${enabled.services.telco.version2.bank-to-wallet-xml:false}") boolean isBankToWalletXmlEnabled,
            @Value("${enabled.services.imt.moneygram-outbound:false}") boolean isMoneygramOutboundEnabled,
            @Value("${enabled.services.imt.moneygram-inbound:false}") boolean isMoneygramInboundEnabled,
            @Value("${enabled.services.imt.thunes-outbound:false}") boolean isThunesOutboundEnabled,
            @Value("${enabled.services.imt.wendi-outbound:false}") boolean isWendiOutboundEnabled,
            @Value("${enabled.services.others.database-operation:false}") boolean isDatabaseOperationEnabled,
            @Value("${enabled.services.telco.version1.name-check-bank-to-wallet:false}") boolean isNameCheckBankToWalletEnabled,
            @Value("${enabled.services.telco.version1.name-check-airtime-topup:false}") boolean isNameCheckAirtimeTopupEnabled,
            @Value("${enabled.services.telco.version1.name-check-float-purchase:false}") boolean isNameCheckFloatPurchaseEnabled) {
        this.isAirtimeTopupEnabled = isAirtimeTopupEnabled;
        this.isAirtimeStatusEnabled = isAirtimeStatusEnabled;
        this.isFloatPurchaseEnabled = isFloatPurchaseEnabled;
        this.isBankToWalletEnabled = isBankToWalletEnabled;
        this.isAirtimeTopupXmlEnabled = isAirtimeTopupXmlEnabled;
        this.isFloatPurchaseXmlEnabled = isFloatPurchaseXmlEnabled;
        this.isBankToWalletXmlEnabled = isBankToWalletXmlEnabled;
        this.isMoneygramOutboundEnabled = isMoneygramOutboundEnabled;
        this.isMoneygramInboundEnabled = isMoneygramInboundEnabled;
        this.isThunesOutboundEnabled = isThunesOutboundEnabled;
        this.isWendiOutboundEnabled = isWendiOutboundEnabled;
        this.isDatabaseOperationEnabled = isDatabaseOperationEnabled;
        this.isBankToWalletStatusEnabled = isBankToWalletStatusEnabled;
        this.isNameCheckBankToWalletEnabled = isNameCheckBankToWalletEnabled;
        this.isNameCheckAirtimeTopupEnabled = isNameCheckAirtimeTopupEnabled;
        this.isNameCheckFloatPurchaseEnabled = isNameCheckFloatPurchaseEnabled;
    }

    // Method to check service status and throw an exception if it's disabled
    public void checkServiceStatus(boolean isEnabled, String serviceName) throws CustomException {
        if (!isEnabled) {
            throw new CustomException(serviceName + " Is Currently Unavailable.");
        }
    }

    // Getter methods for each service

    public boolean isNameCheckBankToWalletEnabled() {
        return isNameCheckBankToWalletEnabled;
    }

    public boolean isNameCheckAirtimeTopupEnabled() {
        return isNameCheckAirtimeTopupEnabled;
    }

    public boolean isNameCheckFloatPurchaseEnabled() {
        return isNameCheckFloatPurchaseEnabled;
    }

    public boolean isAirtimeTopupEnabled() {
        return isAirtimeTopupEnabled;
    }

    public boolean isAirtimeStatusEnabled() {
        return isAirtimeStatusEnabled;
    }

    public boolean isFloatPurchaseEnabled() {
        return isFloatPurchaseEnabled;
    }

    public boolean isBankToWalletEnabled() {
        return isBankToWalletEnabled;
    }

    public boolean isBankToWalletStatusEnabled() {
        return isBankToWalletStatusEnabled;
    }

    public boolean isAirtimeTopupXmlEnabled() {
        return isAirtimeTopupXmlEnabled;
    }

    public boolean isFloatPurchaseXmlEnabled() {
        return isFloatPurchaseXmlEnabled;
    }

    public boolean isBankToWalletXmlEnabled() {
        return isBankToWalletXmlEnabled;
    }

    public boolean isMoneygramOutboundEnabled() {
        return isMoneygramOutboundEnabled;
    }

    public boolean isThunesOutboundEnabled() {
        return isThunesOutboundEnabled;
    }

    public boolean isWendiOutboundEnabled() {
        return isWendiOutboundEnabled;
    }

    public boolean isMoneygramInboundEnabled() {
        return isMoneygramInboundEnabled;
    }

    public boolean isDatabaseOperationEnabled() {
        return isDatabaseOperationEnabled;
    }

}
