package com.equitybank.drplatform.controller;

import com.equitybank.drplatform.dto.request.AddApplicationToCampaignRequest;
import com.equitybank.drplatform.dto.request.CreateCampaignRequest;
import com.equitybank.drplatform.dto.response.ApiResponse;
import com.equitybank.drplatform.dto.response.CampaignApplicationDto;
import com.equitybank.drplatform.dto.response.CampaignDto;
import com.equitybank.drplatform.dto.response.DashboardDto;
import com.equitybank.drplatform.dto.response.PagedResponse;
import com.equitybank.drplatform.service.CampaignService;
import com.equitybank.drplatform.service.DashboardService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/campaigns")
@RequiredArgsConstructor
public class CampaignController {

    private final CampaignService campaignService;
    private final DashboardService dashboardService;

    @PostMapping
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR')")
    public ResponseEntity<ApiResponse<CampaignDto>> createCampaign(
            @Valid @RequestBody CreateCampaignRequest req) {
        return ResponseEntity.status(201).body(ApiResponse.success(campaignService.createCampaign(req)));
    }

    @GetMapping
    public ResponseEntity<ApiResponse<PagedResponse<CampaignDto>>> listCampaigns(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String subsidiaryId) {
        return ResponseEntity.ok(ApiResponse.success(campaignService.listCampaigns(page, size, subsidiaryId)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<CampaignDto>> getCampaign(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(campaignService.getCampaignWithApplications(id)));
    }

    @PostMapping("/{id}/applications")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR')")
    public ResponseEntity<ApiResponse<CampaignApplicationDto>> addApplication(
            @PathVariable UUID id,
            @Valid @RequestBody AddApplicationToCampaignRequest req) {
        return ResponseEntity.status(201)
                .body(ApiResponse.success(campaignService.addApplication(id, req)));
    }

    @PostMapping("/{id}/open-pre-dr")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR')")
    public ResponseEntity<ApiResponse<CampaignDto>> openPreDr(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(campaignService.openPreDr(id)));
    }

    @PostMapping("/{id}/approve")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR')")
    public ResponseEntity<ApiResponse<CampaignDto>> approveCampaign(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(campaignService.approveCampaign(id)));
    }

    @GetMapping("/{id}/gate-check")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR')")
    public ResponseEntity<ApiResponse<CampaignService.GateCheckResult>> getGateCheck(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(campaignService.getApprovalGateStatus(id)));
    }

    @PostMapping("/{campaignId}/applications/{applicationId}/defer")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR')")
    public ResponseEntity<ApiResponse<CampaignApplicationDto>> deferApplication(
            @PathVariable UUID campaignId,
            @PathVariable UUID applicationId,
            @RequestBody Map<String, String> body) {
        return ResponseEntity.ok(ApiResponse.success(
                campaignService.deferApplication(campaignId, applicationId, body.get("reason"))));
    }

    @GetMapping("/{id}/timeline")
    public ResponseEntity<ApiResponse<List<DashboardDto.TimelineEventDto>>> getTimeline(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(dashboardService.getCampaignTimeline(id)));
    }
}
