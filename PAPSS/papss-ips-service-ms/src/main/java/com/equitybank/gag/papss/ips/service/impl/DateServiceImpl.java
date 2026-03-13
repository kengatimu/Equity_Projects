package com.equitybank.gag.papss.ips.service.impl;

import com.equitybank.gag.papss.ips.service.DateService;
import org.springframework.stereotype.Service;

import java.time.*;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

@Service
public class DateServiceImpl implements DateService {
    @Override
    public String getCurrentIsoDateAndTime() {
        return DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss'Z'")
                .withZone(ZoneOffset.UTC)
                .format(Instant.now());
    }

    @Override
    public String getCurrentIsoDateOnly() {
        return LocalDate.now().toString(); // yyyy-MM-dd
    }

    @Override
    public OffsetDateTime getUtcNow() {
        return OffsetDateTime.now(ZoneOffset.UTC).truncatedTo(ChronoUnit.SECONDS);
    }


    @Override
    public String getEndToEndId(String rrn, String senderInstitutionId, String receiverInstitutionId) {
        // EndToEndId = senderInstCode + ReceiverInstCode + timestamp (yyyyMMddHHmmss) + rrn
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
        String timestamp = LocalDateTime.now().format(formatter);

        return senderInstitutionId + receiverInstitutionId + timestamp + rrn;
    }
}
