package com.equitybank.gag.papss.its.service;

import com.equitybank.gag.papss.its.exception.CustomException;
import com.equitybank.gag.papss.its.pojo.accountDetails.AccountDetails;

public interface FinacleAccountService {
    AccountDetails getAccountDetails(String rrn, String accountNumber) throws CustomException;
}
