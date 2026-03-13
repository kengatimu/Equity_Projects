package com.equitybank.gag.papss.its.service.impl;

import com.equitybank.gag.papss.its.service.DateService;
import org.springframework.stereotype.Service;

import java.time.*;
import java.time.format.DateTimeFormatter;

@Service
public class DateServiceImpl implements DateService {
    @Override
    public String getCurrentIsoDateAndTime() {
//        return DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss'Z'")
        return DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                .withZone(ZoneOffset.UTC)
                .format(Instant.now());
    }

    @Override
    public String getCurrentIsoDateOnly() {
        return LocalDate.now().toString(); // yyyy-MM-dd
    }

    @Override
    public OffsetDateTime getUtcNow() {
        OffsetDateTime now = OffsetDateTime.now(ZoneOffset.UTC);
        return OffsetDateTime.of(
                now.getYear(), now.getMonthValue(), now.getDayOfMonth(),
                now.getHour(), now.getMinute(), now.getSecond(), 0, ZoneOffset.UTC
        );
    }

    @Override
    public String getEndToEndId(String rrn, String senderId) {
        // Generate PAPSS-style prefix using day + hour + minute pattern (e.g. 0240711)
        String dateSeed = LocalDateTime.now().format(DateTimeFormatter.ofPattern("ddHHmm"));

        // Construct EndToEndId as: prefix + senderId + rrn
        String endToEndId = dateSeed + senderId + rrn;

        // Ensure total length within ISO20022 Max35Text
        return endToEndId.length() > 35 ? endToEndId.substring(0, 35) : endToEndId;
    }

//    @Override
//    public String getEndToEndId(String rrn, String senderInstitutionId, String receiverInstitutionId) {
//        // EndToEndId = senderInstCode + ReceiverInstCode + timestamp (yyyyMMddHHmmss) + rrn
//        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
//        String timestamp = LocalDateTime.now().format(formatter);
//
//        return senderInstitutionId + receiverInstitutionId + timestamp + rrn;
//    }
}
