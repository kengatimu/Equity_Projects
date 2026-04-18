package com.equitybank.drplatform.service;

import com.equitybank.drplatform.dto.response.DeadlineSetDto;
import org.springframework.stereotype.Service;

import java.time.DayOfWeek;
import java.time.LocalDate;

@Service
public class DeadlineCalculatorService {

    public DeadlineSetDto calculateDeadlines(LocalDate drDate) {
        return DeadlineSetDto.builder()
                .runbookDeadline(adjustForWeekend(drDate.minusDays(14)))
                .peerReviewDeadline(adjustForWeekend(drDate.minusDays(10)))
                .itscmApprovalDeadline(adjustForWeekend(drDate.minusDays(7)))
                .checklistDeadline(adjustForWeekend(drDate.minusDays(3)))
                .build();
    }

    private LocalDate adjustForWeekend(LocalDate date) {
        if (date.getDayOfWeek() == DayOfWeek.SATURDAY) return date.minusDays(1);
        if (date.getDayOfWeek() == DayOfWeek.SUNDAY)   return date.minusDays(2);
        return date;
    }
}
