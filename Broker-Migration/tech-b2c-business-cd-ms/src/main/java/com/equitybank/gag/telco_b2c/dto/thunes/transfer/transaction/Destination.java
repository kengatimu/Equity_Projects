package com.equitybank.gag.telco_b2c.dto.thunes.transfer.transaction;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({
        "msisdn",
        "swiftBicCode",
        "bankAccountNumber",
        "iban",
        "clabe",
        "ifsCode",
        "sortCode",
        "branchNumber",
        "routingCode",
        "accountType"
})
public class Destination implements Serializable {

    private static final long serialVersionUID = -3654403108291954245L;

    @Pattern(regexp = "\\+?[1-9]\\d{7,14}", message = "destination.msisdn must be in international format, e.g. +254712345678")
    @JsonProperty("msisdn")
    private String msisdn;

    @Size(min = 8, max = 11, message = "destination.swiftBicCode must be 8 or 11 characters")
    @Pattern(regexp = "[A-Z0-9]{8}|[A-Z0-9]{11}", message = "destination.swiftBicCode must be a valid SWIFT BIC")
    @JsonProperty("swiftBicCode")
    private String swiftBicCode;

    @Size(max = 34, message = "destination.bankAccountNumber must not exceed 34 characters")
    @JsonProperty("bankAccountNumber")
    private String bankAccountNumber;

    @Pattern(regexp = "^[A-Z]{2}\\d{2}[A-Z0-9]{11,30}$", message = "destination.iban must be a valid IBAN format, e.g. FR1420041010050500013M02606")
    @JsonProperty("iban")
    private String iban;


    @Pattern(regexp = "\\d{18}", message = "destination.clabe must be exactly 18 digits")
    @JsonProperty("clabe")
    private String clabe;

    @Pattern(regexp = "[A-Z]{4}0[A-Z0-9]{6}", message = "destination.ifsCode must be a valid IFSC code")
    @JsonProperty("ifsCode")
    private String ifsCode;

    @Pattern(regexp = "\\d{6}", message = "destination.sortCode must be 6 digits")
    @JsonProperty("sortCode")
    private String sortCode;

    @Size(max = 10, message = "destination.branchNumber must not exceed 10 characters")
    @JsonProperty("branchNumber")
    private String branchNumber;

    @Size(max = 20, message = "destination.routingCode must not exceed 20 characters")
    @JsonProperty("routingCode")
    private String routingCode;

    @Size(max = 20, message = "destination.accountType must not exceed 20 characters")
    @JsonProperty("accountType")
    private String accountType;


    public String getMsisdn() {
        return msisdn;
    }

    public void setMsisdn(String msisdn) {
        this.msisdn = msisdn;
    }

    public String getSwiftBicCode() {
        return swiftBicCode;
    }

    public void setSwiftBicCode(String swiftBicCode) {
        this.swiftBicCode = swiftBicCode;
    }

    public String getBankAccountNumber() {
        return bankAccountNumber;
    }

    public void setBankAccountNumber(String bankAccountNumber) {
        this.bankAccountNumber = bankAccountNumber;
    }

    public String getIban() {
        return iban;
    }

    public void setIban(String iban) {
        this.iban = iban;
    }

    public String getClabe() {
        return clabe;
    }

    public void setClabe(String clabe) {
        this.clabe = clabe;
    }

    public String getIfsCode() {
        return ifsCode;
    }

    public void setIfsCode(String ifsCode) {
        this.ifsCode = ifsCode;
    }

    public String getSortCode() {
        return sortCode;
    }

    public void setSortCode(String sortCode) {
        this.sortCode = sortCode;
    }

    public String getBranchNumber() {
        return branchNumber;
    }

    public void setBranchNumber(String branchNumber) {
        this.branchNumber = branchNumber;
    }

    public String getRoutingCode() {
        return routingCode;
    }

    public void setRoutingCode(String routingCode) {
        this.routingCode = routingCode;
    }

    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }
}
