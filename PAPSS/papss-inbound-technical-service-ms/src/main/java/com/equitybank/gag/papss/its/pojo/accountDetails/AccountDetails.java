package com.equitybank.gag.papss.its.pojo.accountDetails;

import com.equitybank.gag.papss.its.enums.AccountStatus;

import java.io.Serializable;

public class AccountDetails implements Serializable {
    private static final long serialVersionUID = 1L;

    private String firstName;
    private String lastName;
    private AccountStatus status;
    private String accountNumber;
    private String accountCurrency;
    private String accountSchemeCode;
    private String accountFreezeCode;
    private String finacleStatusCode;

    // No-args constructor
    public AccountDetails() {}

    // All-args constructor
    public AccountDetails(String firstName,
                          String lastName,
                          AccountStatus status,
                          String accountNumber,
                          String accountCurrency,
                          String accountSchemeCode,
                          String accountFreezeCode,
                          String finacleStatusCode) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.status = status;
        this.accountNumber = accountNumber;
        this.accountCurrency = accountCurrency;
        this.accountSchemeCode = accountSchemeCode;
        this.accountFreezeCode = accountFreezeCode;
        this.finacleStatusCode = finacleStatusCode;
    }

    public String getFirstName() {
        return firstName;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    public String getLastName() {
        return lastName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    public AccountStatus getStatus() {
        return status;
    }
    public void setStatus(AccountStatus status) {
        this.status = status;
    }
    public String getAccountNumber() {
        return accountNumber;
    }
    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }
    public String getAccountCurrency() {
        return accountCurrency;
    }
    public void setAccountCurrency(String accountCurrency) {
        this.accountCurrency = accountCurrency;
    }
    public String getAccountSchemeCode() {
        return accountSchemeCode;
    }
    public void setAccountSchemeCode(String accountSchemeCode) {
        this.accountSchemeCode = accountSchemeCode;
    }
    public String getAccountFreezeCode() {
        return accountFreezeCode;
    }
    public void setAccountFreezeCode(String accountFreezeCode) {
        this.accountFreezeCode = accountFreezeCode;
    }
    public String getFinacleStatusCode() {
        return finacleStatusCode;
    }
    public void setFinacleStatusCode(String finacleStatusCode) {
        this.finacleStatusCode = finacleStatusCode;
    }
}
