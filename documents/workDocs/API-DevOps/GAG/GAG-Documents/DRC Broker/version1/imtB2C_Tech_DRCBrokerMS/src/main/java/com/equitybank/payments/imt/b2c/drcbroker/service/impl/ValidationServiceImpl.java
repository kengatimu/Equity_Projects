package com.equitybank.payments.imt.b2c.drcbroker.service.impl;

import com.equitybank.payments.imt.b2c.drcbroker.service.ValidationService;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.error.status.ErrorStatus;
import com.equitybank.payments.imt.b2c.drcbroker.service.model.request.BusinessServiceRequestModel;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
public class ValidationServiceImpl implements ValidationService {
    private static final Logger log = LoggerFactory.getLogger(ValidationServiceImpl.class);

    private final String REGEX_0 = "[^'&_´+`~<>/=:;!@#$%^*?]*";
    private final String REGEX_1 = "[^'&_´`~<>/=:;!@#$%^*?]*";
    private final String REGEX_2 = "['&_´+`~<>/=:;!@#$%^*-+]*";
    private final String DEFAULT_NAME = "Null";
    private Pattern pattern;
    private Matcher matcher;

    private final Gson gson;

    @Autowired
    public ValidationServiceImpl(Gson gson) {
        this.gson = gson;
    }

    @Override
    public BusinessServiceRequestModel validateInputs(BusinessServiceRequestModel requestModel, String inputType, ErrorStatus errorStatus) {
        String receiverPhone = requestModel.getEazzycash().getNumber();
        String amountStr = requestModel.getEazzycash().getAmount();
        String telco = requestModel.getEazzycash().getTelco();
        String rrn = requestModel.getEazzycash().getRrn();
        boolean isValid;
        String type;

        if (inputType.equalsIgnoreCase("AtmCode")) {
            String receiverAccount = requestModel.getEazzycash().getSender();
            String name = requestModel.getEazzycash().getName();

            //validate the amount
            String validatedAmount = validateAmount(amountStr, rrn, errorStatus);
            if (validatedAmount == null) return null;
            requestModel.getEazzycash().setAmount(validatedAmount);

            //validate receiverAccount
            type = "ReceiverAccount";
            isValid = specialCharacterCheck(receiverAccount, type, rrn, errorStatus);
            if (!isValid) return null;

            //validate receiverPhone
            String formattedMobile = formatMobile(receiverPhone, rrn, errorStatus);
            if (formattedMobile == null) return null;

            //validate rrn
            type = "rrn";
            isValid = specialCharacterCheck(rrn, type, rrn, errorStatus);
            if (!isValid) return null;

            //validate name
            type = "AtmGetCode";
            isValid = specialCharacterCheck(name, type, rrn, errorStatus);
            if (!isValid) return null;

            //validate telco
            type = "AtmGetCode";
            isValid = specialCharacterCheck(telco, type, rrn, errorStatus);
            if (!isValid) return null;

        } else {
            String senderPhone = requestModel.getEazzycash().getSender();

            //validate the amount
            String validatedAmount = validateAmount(amountStr, rrn, errorStatus);
            if (validatedAmount == null) return null;
            requestModel.getEazzycash().setAmount(validatedAmount);

            //validate senderPhone
            String formattedMobile = formatMobile(senderPhone, rrn, errorStatus);
            if (formattedMobile == null) return null;

            //validate receiverPhone
            formattedMobile = formatMobile(receiverPhone, rrn, errorStatus);
            if (formattedMobile == null) return null;

            //replace special characters from name field
            replaceSpecialCharacters(requestModel);

            //validate telco
            type = "Telco";
            isValid = specialCharacterCheck(telco, type, rrn, errorStatus);
            if (!isValid) return null;

            //validate rrn
            type = "rrn";
            isValid = specialCharacterCheck(rrn, type, rrn, errorStatus);
            if (!isValid) return null;
        }
        log.info("Validated Request::: " + gson.toJson(requestModel));
        return requestModel;
    }

    private String validateAmount(String amountStr, String rrn, ErrorStatus errorStatus) {
        BigDecimal amount;

        boolean isNull = checkForNull(amountStr, rrn, errorStatus);
        if (!isNull) return null;

        try {
            amount = new BigDecimal(amountStr);
            if (amount.compareTo(new BigDecimal("0")) > 0) {
                amount = amount.setScale(1, RoundingMode.CEILING);
                return String.valueOf(amount);
            } else {
                errorStatus.setStatus("Failed");
                errorStatus.setStatusCode("600");
                errorStatus.setStatusDesc(" Supplied Amount Is Less Than Minimum");
                errorStatus.setStatusMessage(rrn);
                log.error("Amount Validation Failed: Supplied Amount Is Less Than Minimum");
                return null;
            }
        } catch (Exception e) {
            errorStatus.setStatus("Failed");
            errorStatus.setStatusCode("600");
            errorStatus.setStatusDesc(" Supplied Amount Is Invalid");
            errorStatus.setStatusMessage(rrn);
            log.error("Amount Validation Failed: Supplied Amount Is Invalid");
            return null;
        }
    }

    private String formatMobile(String phoneNumber, String rrn, ErrorStatus errorStatus) {
        String type = "Phone";

        boolean isNull = checkForNull(phoneNumber, rrn, errorStatus);
        if (!isNull) return null;

        boolean isValid = specialCharacterCheck(phoneNumber, type, rrn, errorStatus);
        if (!isValid) return null;

        if (phoneNumber.length() != 13) {
            errorStatus.setStatus("Failed");
            errorStatus.setStatusCode("600");
            errorStatus.setStatusDesc(" Invalid Mobile Number Format For: " + phoneNumber + ". International Format Allowed: +2XXXXXX…");
            errorStatus.setStatusMessage(rrn);
            log.error("Mobile Number Validation Failed: Invalid Mobile Number Format For: " + phoneNumber + ". International Format Allowed: +2XXXXXX…");
            return null;
        }
        return phoneNumber;
    }

    private boolean specialCharacterCheck(String input, String type, String rrn, ErrorStatus errorStatus) {
        if (!type.equalsIgnoreCase("AtmGetCode")) {
            boolean isNull = checkForNull(input, rrn, errorStatus);
            if (!isNull) return false;
        } else input = DEFAULT_NAME;
        if (type.equalsIgnoreCase("Phone"))
            pattern = Pattern.compile(REGEX_1);
        else pattern = Pattern.compile(REGEX_0);

        matcher = pattern.matcher(input);
        boolean isMatched = matcher.matches();
        if (!isMatched) {
            errorStatus.setStatus("Failed");
            errorStatus.setStatusCode("600");
            errorStatus.setStatusDesc(" Special characters is not allowed in " + input + " field");
            errorStatus.setStatusMessage(rrn);
            log.error("Input Validation Failed: Special characters is not allowed in " + input + " field");
            return false;
        }
        return true;
    }

    private void replaceSpecialCharacters(BusinessServiceRequestModel requestModel) {
        String name = requestModel.getEazzycash().getName().equals("") ? DEFAULT_NAME : requestModel.getEazzycash().getName();
        requestModel.getEazzycash().setName(name.replaceAll(REGEX_2, ""));
    }

    private boolean checkForNull(String input, String rrn, ErrorStatus errorStatus) {
        if (input.isEmpty()) {
            errorStatus.setStatus("Failed");
            errorStatus.setStatusCode("600");
            errorStatus.setStatusDesc(" Input Field Cannot Be Empty");
            errorStatus.setStatusMessage(rrn);
            log.error("Input Validation Failed: Input Field Cannot Be Empty");
            return false;
        }
        return true;
    }
}
