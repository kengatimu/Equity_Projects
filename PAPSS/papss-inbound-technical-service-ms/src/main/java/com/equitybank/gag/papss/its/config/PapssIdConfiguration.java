//package com.equitybank.gag.papss.its.config;
//
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//
//import static com.equitybank.gag.papss.its.config.StatusCodeMessages.PAPSS_ID;
//import static com.equitybank.gag.papss.its.config.StatusCodeMessages.PAPSS_ID_PROD;
//
//@Configuration
//public class PapssIdConfiguration {
//
//    @Value("${spring.profiles.active:default}")
//    private String activeProfile;
//
//    @Bean(name = "papssId")
//    public String papssId() {
//        boolean isProd = activeProfile != null && activeProfile.toLowerCase().contains("prod");
//        return isProd ? PAPSS_ID_PROD : PAPSS_ID;
//    }
//}