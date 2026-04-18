package com.equitybank.drplatform.controller;

import com.equitybank.drplatform.dto.response.ApiResponse;
import com.equitybank.drplatform.dto.response.PagedResponse;
import com.equitybank.drplatform.entity.AuditLogEntity;
import com.equitybank.drplatform.repository.AuditLogRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/audit")
@RequiredArgsConstructor
@PreAuthorize("hasAnyRole('SUPER_ADMIN', 'AUDITOR', 'MANAGEMENT')")
public class AuditLogController {

    private final AuditLogRepository auditLogRepository;

    @GetMapping
    public ResponseEntity<ApiResponse<PagedResponse<AuditLogEntity>>> getAuditLogs(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "50") int size,
            @RequestParam(required = false) String resourceType,
            @RequestParam(required = false) UUID actorId) {

        var pageable = PageRequest.of(page, size, Sort.by("timestamp").descending());
        var result = resourceType != null
                ? auditLogRepository.findByResourceTypeOrderByTimestampDesc(resourceType, pageable)
                : actorId != null
                        ? auditLogRepository.findByActorIdOrderByTimestampDesc(actorId, pageable)
                        : auditLogRepository.findAllByOrderByTimestampDesc(pageable);

        return ResponseEntity.ok(ApiResponse.success(PagedResponse.from(result)));
    }

    @GetMapping("/campaigns/{campaignId}")
    public ResponseEntity<ApiResponse<PagedResponse<AuditLogEntity>>> getAuditLogsForCampaign(
            @PathVariable UUID campaignId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "50") int size) {

        var pageable = PageRequest.of(page, size, Sort.by("timestamp").descending());
        return ResponseEntity.ok(ApiResponse.success(
                PagedResponse.from(auditLogRepository.findByCampaignIdOrderByTimestampDesc(campaignId, pageable))));
    }
}
