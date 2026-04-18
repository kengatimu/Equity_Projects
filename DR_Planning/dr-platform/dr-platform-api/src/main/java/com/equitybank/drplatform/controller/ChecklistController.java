package com.equitybank.drplatform.controller;

import com.equitybank.drplatform.dto.request.RaiseBlockerRequest;
import com.equitybank.drplatform.dto.request.UpdateChecklistItemStatusRequest;
import com.equitybank.drplatform.dto.response.ApiResponse;
import com.equitybank.drplatform.dto.response.ChecklistItemDto;
import com.equitybank.drplatform.dto.response.ChecklistSummaryDto;
import com.equitybank.drplatform.service.CarryForwardService;
import com.equitybank.drplatform.service.ChecklistService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/campaign-applications/{campaignApplicationId}/checklist")
@RequiredArgsConstructor
public class ChecklistController {

    private final ChecklistService checklistService;
    private final CarryForwardService carryForwardService;

    @GetMapping
    public ResponseEntity<ApiResponse<List<ChecklistItemDto>>> getChecklist(
            @PathVariable UUID campaignApplicationId) {
        return ResponseEntity.ok(ApiResponse.success(
                checklistService.getChecklistForOwner(campaignApplicationId)));
    }

    @GetMapping("/summary")
    public ResponseEntity<ApiResponse<ChecklistSummaryDto>> getSummary(
            @PathVariable UUID campaignApplicationId) {
        return ResponseEntity.ok(ApiResponse.success(
                checklistService.getChecklistSummary(campaignApplicationId)));
    }

    @PatchMapping("/items/{itemId}/status")
    public ResponseEntity<ApiResponse<ChecklistItemDto>> updateItemStatus(
            @PathVariable UUID campaignApplicationId,
            @PathVariable UUID itemId,
            @Valid @RequestBody UpdateChecklistItemStatusRequest req) {
        return ResponseEntity.ok(ApiResponse.success(checklistService.updateItemStatus(itemId, req)));
    }

    @PostMapping("/items/{itemId}/block")
    public ResponseEntity<ApiResponse<ChecklistItemDto>> blockItem(
            @PathVariable UUID campaignApplicationId,
            @PathVariable UUID itemId,
            @Valid @RequestBody RaiseBlockerRequest req) {
        return ResponseEntity.ok(ApiResponse.success(checklistService.blockItem(itemId, req)));
    }

    @PostMapping("/blockers/{blockerId}/resolve")
    public ResponseEntity<ApiResponse<ChecklistItemDto>> resolveBlocker(
            @PathVariable UUID campaignApplicationId,
            @PathVariable UUID blockerId,
            @RequestBody Map<String, String> body) {
        return ResponseEntity.ok(ApiResponse.success(
                checklistService.resolveBlocker(blockerId, body.get("resolutionNotes"))));
    }

    @PostMapping("/sign-off")
    @PreAuthorize("hasAnyRole('APP_OWNER', 'DR_PARTICIPANT')")
    public ResponseEntity<ApiResponse<Void>> submitSignOff(
            @PathVariable UUID campaignApplicationId) {
        checklistService.submitSignOff(campaignApplicationId);
        return ResponseEntity.ok(ApiResponse.success(null, "Pre-DR sign-off submitted successfully"));
    }

    @PostMapping("/sign-off/acknowledge")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR')")
    public ResponseEntity<ApiResponse<Void>> acknowledgeSignOff(
            @PathVariable UUID campaignApplicationId) {
        checklistService.acknowledgeSignOff(campaignApplicationId);
        return ResponseEntity.ok(ApiResponse.success(null, "Sign-off acknowledged"));
    }

    @GetMapping("/carried-forward")
    public ResponseEntity<ApiResponse<List<ChecklistItemDto>>> getCarriedForwardItems(
            @PathVariable UUID campaignApplicationId) {
        return ResponseEntity.ok(ApiResponse.success(
                carryForwardService.getCarriedForwardItems(campaignApplicationId)));
    }

    @PostMapping("/items/{itemId}/acknowledge-carried")
    public ResponseEntity<ApiResponse<ChecklistItemDto>> acknowledgeCarriedItem(
            @PathVariable UUID campaignApplicationId,
            @PathVariable UUID itemId) {
        return ResponseEntity.ok(ApiResponse.success(carryForwardService.acknowledgeCarriedItem(itemId)));
    }

    @PostMapping("/carry-forward")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR')")
    public ResponseEntity<ApiResponse<List<ChecklistItemDto>>> carryForward(
            @PathVariable UUID campaignApplicationId,
            @RequestBody Map<String, UUID> body) {
        UUID targetId = body.get("targetCampaignApplicationId");
        return ResponseEntity.ok(ApiResponse.success(
                carryForwardService.carryForwardBlockers(campaignApplicationId, targetId)));
    }
}
