package com.equitybank.gag.papss.its.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Test {
    private static final Logger log = LoggerFactory.getLogger(Test.class);

    public static void main(String[] args) {

        String endToEndId = getEndToEndId("rrn_100", "EQ1068", "GM1015");
        System.out.println(endToEndId);
    }
    public static  String getEndToEndId(String rrn, String senderInstitutionId, String receiverInstitutionId) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        String timestamp = LocalDateTime.now().format(formatter);

        return senderInstitutionId + receiverInstitutionId + timestamp + rrn;
    }
}