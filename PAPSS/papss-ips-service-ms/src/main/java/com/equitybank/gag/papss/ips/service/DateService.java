package com.equitybank.gag.papss.ips.service;

import java.time.OffsetDateTime;

public interface DateService {
    String getCurrentIsoDateAndTime();

    String getCurrentIsoDateOnly();

    OffsetDateTime getUtcNow();

    String getEndToEndId (String rrn, String senderInstitutionId, String receiverInstitutionId);
}
