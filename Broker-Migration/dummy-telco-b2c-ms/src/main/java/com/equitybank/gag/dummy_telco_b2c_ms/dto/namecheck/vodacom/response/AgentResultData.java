package com.equitybank.gag.dummy_telco_b2c_ms.dto.namecheck.vodacom.response;

import java.io.Serializable;

public class AgentResultData implements Serializable {
    private static final long serialVersionUID = 1L;

    private String BankAccount;
    private String KindOfAgents;
    private String AgentProvince;
    private String AgentType;
    private String SettlementNumber;
    private String VatRegistered;
    private String VatNumber;
    private String VodashopName;
    private String Location;
    private String VodashopUniqueID;
    private String OrganisationCategoryCode;
    private String CompanyRegistrationNumberRCCM;
    private String CompanyName;
    private String NotificationReceivingEmail;
    private String NotificationReceivingMSISDN;
    private String PreferredNotificationChannel;
    private String HasBankAccount;

    public String getBankAccount() {
        return BankAccount;
    }

    public void setBankAccount(String bankAccount) {
        BankAccount = bankAccount;
    }

    public String getKindOfAgents() {
        return KindOfAgents;
    }

    public void setKindOfAgents(String kindOfAgents) {
        KindOfAgents = kindOfAgents;
    }

    public String getAgentProvince() {
        return AgentProvince;
    }

    public void setAgentProvince(String agentProvince) {
        AgentProvince = agentProvince;
    }

    public String getAgentType() {
        return AgentType;
    }

    public void setAgentType(String agentType) {
        AgentType = agentType;
    }

    public String getSettlementNumber() {
        return SettlementNumber;
    }

    public void setSettlementNumber(String settlementNumber) {
        SettlementNumber = settlementNumber;
    }

    public String getVatRegistered() {
        return VatRegistered;
    }

    public void setVatRegistered(String vatRegistered) {
        VatRegistered = vatRegistered;
    }

    public String getVatNumber() {
        return VatNumber;
    }

    public void setVatNumber(String vatNumber) {
        VatNumber = vatNumber;
    }

    public String getVodashopName() {
        return VodashopName;
    }

    public void setVodashopName(String vodashopName) {
        VodashopName = vodashopName;
    }

    public String getLocation() {
        return Location;
    }

    public void setLocation(String location) {
        Location = location;
    }

    public String getVodashopUniqueID() {
        return VodashopUniqueID;
    }

    public void setVodashopUniqueID(String vodashopUniqueID) {
        VodashopUniqueID = vodashopUniqueID;
    }

    public String getOrganisationCategoryCode() {
        return OrganisationCategoryCode;
    }

    public void setOrganisationCategoryCode(String organisationCategoryCode) {
        OrganisationCategoryCode = organisationCategoryCode;
    }

    public String getCompanyRegistrationNumberRCCM() {
        return CompanyRegistrationNumberRCCM;
    }

    public void setCompanyRegistrationNumberRCCM(String companyRegistrationNumberRCCM) {
        CompanyRegistrationNumberRCCM = companyRegistrationNumberRCCM;
    }

    public String getCompanyName() {
        return CompanyName;
    }

    public void setCompanyName(String companyName) {
        CompanyName = companyName;
    }

    public String getNotificationReceivingEmail() {
        return NotificationReceivingEmail;
    }

    public void setNotificationReceivingEmail(String notificationReceivingEmail) {
        NotificationReceivingEmail = notificationReceivingEmail;
    }

    public String getNotificationReceivingMSISDN() {
        return NotificationReceivingMSISDN;
    }

    public void setNotificationReceivingMSISDN(String notificationReceivingMSISDN) {
        NotificationReceivingMSISDN = notificationReceivingMSISDN;
    }

    public String getPreferredNotificationChannel() {
        return PreferredNotificationChannel;
    }

    public void setPreferredNotificationChannel(String preferredNotificationChannel) {
        PreferredNotificationChannel = preferredNotificationChannel;
    }

    public String getHasBankAccount() {
        return HasBankAccount;
    }

    public void setHasBankAccount(String hasBankAccount) {
        HasBankAccount = hasBankAccount;
    }
}