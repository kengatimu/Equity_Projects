package com.equitybank.drplatform.dto.response;

import lombok.*;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChecklistSummaryDto {
    private UUID campaignApplicationId;
    private long total;
    private long done;
    private long blocked;
    private boolean signedOff;
    private boolean coordinatorAcknowledged;

    public double getReadinessPercent() {
        return total == 0 ? 0.0 : Math.round((double) done / total * 100.0);
    }

    /**
     * Build from the Object[] returned by the JPQL aggregate query.
     * Index 0 = COUNT(*), 1 = SUM(done+verified), 2 = SUM(blocked)
     */
    public static ChecklistSummaryDto fromRaw(Object[] raw) {
        if (raw == null) {
            return ChecklistSummaryDto.builder().total(0).done(0).blocked(0).build();
        }
        long total   = raw[0] != null ? ((Number) raw[0]).longValue() : 0L;
        long done    = raw[1] != null ? ((Number) raw[1]).longValue() : 0L;
        long blocked = raw[2] != null ? ((Number) raw[2]).longValue() : 0L;
        return ChecklistSummaryDto.builder()
                .total(total)
                .done(done)
                .blocked(blocked)
                .build();
    }
}
