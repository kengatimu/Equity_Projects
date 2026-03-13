package com.equitybank.gag.papss.its.service.impl;

import com.equitybank.gag.papss.its.service.PapssIdResolverService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import static com.equitybank.gag.papss.its.config.StatusCodeMessages.PAPSS_ID;
import static com.equitybank.gag.papss.its.config.StatusCodeMessages.PAPSS_ID_PROD;

@Service
public class PapssIdResolverServiceImpl implements PapssIdResolverService {
    private static final Logger log = LoggerFactory.getLogger(PapssIdResolverServiceImpl.class);

    private final String activeProfile;

    public PapssIdResolverServiceImpl(@Value("${spring.profiles.active:default}") String activeProfile) {
        this.activeProfile = activeProfile;
    }

    @Override
    public String resolvePapssId() {
        // Get the right papss id
        boolean isProd = activeProfile != null && activeProfile.toLowerCase().contains("prod");
        return isProd ? PAPSS_ID_PROD : PAPSS_ID;
    }
}
