/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.orange_money_ms.dto.airtime;

import com.equitybank.gag.orange_money_ms.service.util.MiscUtil;
import lombok.Builder;

/**
 * @author ronaldcheruiyot
 */
@Builder
public class AirtimeRequestDTO {
    private final String extNWCode;
    private final String msisdn;
    private final String pin;
    private final String loginId;
    private final String password;
    private final String extCode;
    private final String extRefNum;
    private final String msisdn2;
    private final String amount;
    private final String currency;
    private final String language1;
    private final String language2;
    private final String selector;

    public String getAirtimeXMLRequest() {
        return "<?xml version=\"1.0\"?>\n" +
                "<COMMAND>\n" +
                "<TYPE>EXRCTRFREQ</TYPE>\n" +
                "<DATE>" + MiscUtil.getCurrentTimestamp("dd/MM/yyyyHH:mm:ss") + "</DATE>\n" +
                "<EXTNWCODE>" + this.extNWCode + "</EXTNWCODE>\n" +
                "<MSISDN>" + this.msisdn + "</MSISDN>\n" +
                "<PIN>" + this.pin + "</PIN>\n" +
                "<LOGINID>" + this.loginId + "</LOGINID>\n" +
                "<PASSWORD></PASSWORD>\n" +
                "<EXTCODE></EXTCODE>\n" +
                "<EXTREFNUM>" + this.extRefNum + "</EXTREFNUM>\n" +
                "<MSISDN2>" + this.msisdn2 + "</MSISDN2>\n" +
                "<AMOUNT>" + this.amount + "</AMOUNT>\n" +
                "<CURRENCY>" + this.currency + "</CURRENCY>\n" +
                "<LANGUAGE1>" + this.language1 + "</LANGUAGE1>\n" +
                "<LANGUAGE2>" + this.language2 + "</LANGUAGE2>\n" +
                "<SELECTOR>" + this.selector + "</SELECTOR>\n" +
                "</COMMAND>";
    }
}
