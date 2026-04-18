package com.equitybank.drplatform.dto.response;

import lombok.*;
import java.time.LocalDate;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DeadlineSetDto {
    private LocalDate runbookDeadline;
    private LocalDate peerReviewDeadline;
    private LocalDate itscmApprovalDeadline;
    private LocalDate checklistDeadline;
}
