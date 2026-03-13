package com.equitybank.gag.papss.ots.jpos.jposService.impl;

import com.equitybank.gag.papss.ots.jpos.jposService.ISOUtilityService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.Date;

@Service
public class ISOUtilityServiceImpl implements ISOUtilityService {
    private static final Logger log = LoggerFactory.getLogger(ISOUtilityServiceImpl.class);

    private final SecureRandom secureRandom;

    // ISO-compliant date formats
    private static final SimpleDateFormat FIELD_7_FORMAT = new SimpleDateFormat("MMddHHmmss");
    private static final SimpleDateFormat FIELD_12_FORMAT = new SimpleDateFormat("yyMMddHHmmss");
    private static final SimpleDateFormat FIELD_17_FORMAT = new SimpleDateFormat("MMdd");

    public ISOUtilityServiceImpl(@Qualifier("secureRandom") SecureRandom secureRandom) {
        this.secureRandom = secureRandom;
    }

    @Override
    public String generateSTAN() {
        long timeSuffix = System.currentTimeMillis() % 100; // Last 2 digits of timestamp
        int randomPart = secureRandom.nextInt(10_000); // 4-digit random (0000-9999)
        return String.format("%02d%04d", timeSuffix, randomPart); // 6-digit total e.g. 937128
    }

    @Override
    public String getDateField7() {
        return FIELD_7_FORMAT.format(new Date()); // MMddHHmmss
    }

    @Override
    public String getDateField12() {
        return FIELD_12_FORMAT.format(new Date()); // yyMMddHHmmss
    }

    @Override
    public String getDateField17() {
        return FIELD_17_FORMAT.format(new Date()); // MMdd
    }
}
