/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.equitybank.gag.telco_b2c.web.rest.controller.util;

import java.util.HashMap;
import java.util.Map;

import com.equitybank.gag.telco_b2c.exception.CustomException;
import org.springframework.stereotype.Component;

import static com.equitybank.gag.telco_b2c.config.StatusCodeMessages.INVALID_NUMBER_ERROR;

/**
 *
 * @author ronaldcheruiyot
 */
@Component
public class TelcoResolver {

    public static final String MTN = "MTN";
    public static final String AIRTEL = "AIRTEL";
    public static final String ORANGE = "ORANGE";
    public static final String VODACOM = "VODACOM";
    public static final String AFRICELL = "AFRICELL";

    private static final Map<String, String> TELCO_MAP = new HashMap<>();
    
    public TelcoResolver()
    {
        TelcoResolver.TELCO_MAP.put("080", ORANGE);
        TelcoResolver.TELCO_MAP.put("084", ORANGE);
        TelcoResolver.TELCO_MAP.put("085", ORANGE);
        TelcoResolver.TELCO_MAP.put("089", ORANGE);
        TelcoResolver.TELCO_MAP.put("077", ORANGE);
        TelcoResolver.TELCO_MAP.put("070", ORANGE);

        TelcoResolver.TELCO_MAP.put("081", VODACOM);
        TelcoResolver.TELCO_MAP.put("082", VODACOM);
        TelcoResolver.TELCO_MAP.put("083", VODACOM);
        TelcoResolver.TELCO_MAP.put("086", VODACOM);

        TelcoResolver.TELCO_MAP.put("099", AIRTEL);
        TelcoResolver.TELCO_MAP.put("098", AIRTEL);
        TelcoResolver.TELCO_MAP.put("097", AIRTEL);
        TelcoResolver.TELCO_MAP.put("096", AIRTEL);

        TelcoResolver.TELCO_MAP.put("090", AFRICELL);
        TelcoResolver.TELCO_MAP.put("091", AFRICELL);

        TelcoResolver.TELCO_MAP.put("092", MTN);
    }
    
    public String getTelcoFromPrefix(String prefix)
    {
        return TelcoResolver.TELCO_MAP.get(prefix);
    }
    
    public String resolveTelco(String input) throws CustomException
    {
        System.out.println("MSISDN: " + input);
        String msisdnA = input.substring(Math.max(0, input.length() - 9)); 
        msisdnA = "0" + msisdnA;
        String prefix = msisdnA.substring(0, 3);
        System.out.println(msisdnA + "|PREFIX: " + prefix);
        String telco = getTelcoFromPrefix(prefix);
        if(MiscUtil.isNullOrEmpty(telco)) throw new CustomException(INVALID_NUMBER_ERROR);
        System.out.println(msisdnA + "|RESOLVED TELCO: " + telco);
        return telco;
    }
    
    public static void main(String[] args) throws CustomException {
        TelcoResolver telcoResolver = new TelcoResolver();
        String misisdn1 = "243808765489";
        String misisdn2 = "243848765489";
        String misisdn3 = "243858765489";
        String misisdn4 = "243898765489";
        String misisdn5 = "243818765489";
        String misisdn6 = "243828765489";
        String misisdn7 = "243838765489";
        String misisdn8 = "243998765489";
        String misisdn9 = "243988765489";
        String misisdn10 = "243978765489";
        String misisdn11 = "243908765489";
        String misisdn12 = "243918765489";
        telcoResolver.resolveTelco(misisdn1);
        telcoResolver.resolveTelco(misisdn2);
        telcoResolver.resolveTelco(misisdn3);
        telcoResolver.resolveTelco(misisdn4);
        telcoResolver.resolveTelco(misisdn5);
        telcoResolver.resolveTelco(misisdn6);
        telcoResolver.resolveTelco(misisdn7);
        telcoResolver.resolveTelco(misisdn8);
        telcoResolver.resolveTelco(misisdn9);
        telcoResolver.resolveTelco(misisdn10);
        telcoResolver.resolveTelco(misisdn11);
        telcoResolver.resolveTelco(misisdn12);
        
        String misisdn13 = "808765489";
        String misisdn14 = "848765489";
        String misisdn15 = "858765489";
        String misisdn16 = "898765489";
        String misisdn17 = "818765489";
        String misisdn18 = "828765489";
        String misisdn19 = "838765489";
        String misisdn20 = "998765489";
        String misisdn21 = "988765489";
        String misisdn22 = "978765489";
        String misisdn23 = "908765489";
        String misisdn24 = "918765489";
        telcoResolver.resolveTelco(misisdn13);
        telcoResolver.resolveTelco(misisdn14);
        telcoResolver.resolveTelco(misisdn15);
        telcoResolver.resolveTelco(misisdn16);
        telcoResolver.resolveTelco(misisdn17);
        telcoResolver.resolveTelco(misisdn18);
        telcoResolver.resolveTelco(misisdn19);
        telcoResolver.resolveTelco(misisdn20);
        telcoResolver.resolveTelco(misisdn21);
        telcoResolver.resolveTelco(misisdn22);
        telcoResolver.resolveTelco(misisdn23);
        telcoResolver.resolveTelco(misisdn24);
        
        telcoResolver.resolveTelco("243918765489");
        
        telcoResolver.resolveTelco("7704100015");
    }
    
}
/*
Orange : 080, 084, 085 & 089
Vodacom : 081, 082 & 083
Airtel : 099, 098 & 097
Africell : 090 & 091
*/