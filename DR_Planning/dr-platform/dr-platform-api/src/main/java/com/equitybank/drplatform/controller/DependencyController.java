package com.equitybank.drplatform.controller;

import com.equitybank.drplatform.dto.request.CreateDependencyRequest;
import com.equitybank.drplatform.dto.request.CreateSharedResourceRequest;
import com.equitybank.drplatform.dto.request.ResolveConflictRequest;
import com.equitybank.drplatform.dto.response.ApiResponse;
import com.equitybank.drplatform.dto.response.ConflictDto;
import com.equitybank.drplatform.dto.response.DependencyDto;
import com.equitybank.drplatform.dto.response.DependencyHistoryDto;
import com.equitybank.drplatform.dto.response.SharedResourceDto;
import com.equitybank.drplatform.dto.response.SharedResourceHistoryDto;
import com.equitybank.drplatform.dto.response.SharedResourceSummaryDto;
import com.equitybank.drplatform.security.DrPlatformUserDetails;
import com.equitybank.drplatform.service.ConflictResolutionService;
import com.equitybank.drplatform.service.DependencyEngineService;
import com.equitybank.drplatform.service.SharedResourceService;
import com.equitybank.drplatform.service.SharedResourceService.ArchiveSharedResourceResult;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class DependencyController {

    private final DependencyEngineService dependencyEngineService;
    private final ConflictResolutionService conflictResolutionService;
    private final SharedResourceService sharedResourceService;

    @PostMapping("/applications/{applicationId}/dependencies")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR', 'APP_OWNER')")
    public ResponseEntity<ApiResponse<DependencyDto>> addDependency(
            @PathVariable UUID applicationId,
            @Valid @RequestBody CreateDependencyRequest req) {
        return ResponseEntity.status(201)
                .body(ApiResponse.success(dependencyEngineService.registerDependency(applicationId, req)));
    }

    @GetMapping("/applications/{applicationId}/dependencies")
    public ResponseEntity<ApiResponse<List<DependencyDto>>> getDependencies(
            @PathVariable UUID applicationId) {
        return ResponseEntity.ok(ApiResponse.success(dependencyEngineService.getApplicationDependencies(applicationId)));
    }

    /**
     * Global shared-resource view — all infrastructure resources that are
     * shared by 2+ applications, sorted by application count descending.
     * Drives the Dependency Engine page's "Shared Resources" tab.
     */
    @GetMapping("/dependencies/shared")
    public ResponseEntity<ApiResponse<List<SharedResourceSummaryDto>>> getSharedResources() {
        return ResponseEntity.ok(ApiResponse.success(dependencyEngineService.getSharedResourcesSummary()));
    }

    @PatchMapping("/dependencies/{dependencyId}/deactivate")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR', 'APP_OWNER')")
    public ResponseEntity<ApiResponse<DependencyEngineService.DeactivateDependencyResult>> deactivateDependency(
            @PathVariable UUID dependencyId) {
        DependencyEngineService.DeactivateDependencyResult result =
                dependencyEngineService.deactivateDependency(dependencyId);
        String msg = result.isHasWarnings()
                ? "Dependency deactivated. WARNING: " + result.getWarningApps().size() + " other app(s) depend on this resource."
                : "Dependency deactivated";
        return ResponseEntity.ok(ApiResponse.success(result, msg));
    }

    /**
     * Archives an application dependency link by copying it to application_dependency_history
     * then hard-deleting it from application_dependencies. Returns warnings if other apps
     * shared the same resource. App Owners can archive dependencies from their own applications.
     */
    @DeleteMapping("/dependencies/{dependencyId}")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR', 'APP_OWNER')")
    public ResponseEntity<ApiResponse<DependencyEngineService.ArchiveDependencyResult>> archiveDependency(
            @PathVariable UUID dependencyId,
            @AuthenticationPrincipal DrPlatformUserDetails principal) {
        DependencyEngineService.ArchiveDependencyResult result =
                dependencyEngineService.archiveDependency(dependencyId, principal.getUser().getId(), principal.getUser().getEmail());
        String msg = result.isHasWarnings()
                ? "Dependency archived. Note: " + result.getWarningApps().size() + " other app(s) also used this resource."
                : "Dependency archived";
        return ResponseEntity.ok(ApiResponse.success(result, msg));
    }

    @GetMapping("/applications/{applicationId}/dependencies/history")
    public ResponseEntity<ApiResponse<List<DependencyHistoryDto>>> getDependencyHistory(
            @PathVariable UUID applicationId) {
        return ResponseEntity.ok(ApiResponse.success(dependencyEngineService.getDependencyHistory(applicationId)));
    }

    @GetMapping("/campaigns/{campaignId}/conflicts")
    public ResponseEntity<ApiResponse<List<ConflictDto>>> getCampaignConflicts(
            @PathVariable UUID campaignId,
            @RequestParam(defaultValue = "false") boolean unresolvedOnly) {
        List<ConflictDto> conflicts = unresolvedOnly
                ? conflictResolutionService.getUnresolvedConflicts(campaignId)
                : conflictResolutionService.getAllConflicts(campaignId);
        return ResponseEntity.ok(ApiResponse.success(conflicts));
    }

    @PostMapping("/conflicts/{conflictId}/resolve")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR')")
    public ResponseEntity<ApiResponse<ConflictDto>> resolveConflict(
            @PathVariable UUID conflictId,
            @Valid @RequestBody ResolveConflictRequest req,
            @AuthenticationPrincipal DrPlatformUserDetails principal) {
        return ResponseEntity.ok(ApiResponse.success(
                conflictResolutionService.resolveConflict(conflictId, req, principal.getUser().getId())));
    }

    // ── Shared Resource Registry ──────────────────────────────────────────────

    /**
     * List all active shared resources (optionally filtered by type or search query).
     * Used by the Dependency Engine typeahead and the dependency form modal.
     */
    @GetMapping("/shared-resources")
    public ResponseEntity<ApiResponse<List<SharedResourceDto>>> listSharedResources(
            @RequestParam(required = false) String q,
            @RequestParam(required = false) String type) {
        List<SharedResourceDto> result = (q != null && !q.isBlank())
                ? sharedResourceService.search(q)
                : (type != null ? sharedResourceService.listByType(type) : sharedResourceService.listAll());
        return ResponseEntity.ok(ApiResponse.success(result));
    }

    /**
     * App Owners know their systems best — they are the right people to register
     * the shared resources their applications depend on. Coordinators should
     * coordinate campaigns, not do data entry.
     *
     * Guardrails that prevent naming drift (instead of permission gates):
     *   1. The form forces search-first; "Create New" only appears when nothing matches.
     *   2. Code must be UPPERCASE_SNAKE (validated here and in the DB index).
     *   3. DB unique index on UPPER(code) physically prevents duplicates.
     *   4. SUPER_ADMIN / COORDINATOR can deactivate wrong entries after the fact.
     */
    /** List shared resource archive history — resources that were hard-deleted via archive. */
    @GetMapping("/shared-resources/history")
    public ResponseEntity<ApiResponse<List<SharedResourceHistoryDto>>> listSharedResourceHistory() {
        return ResponseEntity.ok(ApiResponse.success(sharedResourceService.listHistory()));
    }

    @PostMapping("/shared-resources")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR', 'APP_OWNER')")
    public ResponseEntity<ApiResponse<SharedResourceDto>> createSharedResource(
            @Valid @RequestBody CreateSharedResourceRequest req) {
        return ResponseEntity.status(201)
                .body(ApiResponse.success(sharedResourceService.create(req)));
    }

    /**
     * Deactivates a shared resource (soft-delete: sets isActive = false).
     * Only coordinators and above can deactivate — prevents App Owners from hiding shared entries.
     */
    @PatchMapping("/shared-resources/{id}/deactivate")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR')")
    public ResponseEntity<ApiResponse<SharedResourceDto>> deactivateSharedResource(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(
                sharedResourceService.deactivateSharedResource(id),
                "Shared resource deactivated"));
    }

    /**
     * Archives (hard-deletes) a shared resource from the registry.
     *
     * When {@code force=false} (default) and active dependencies reference this resource,
     * the response carries {@code hasWarnings=true} and {@code warningApps} listing the
     * affected applications — no deletion occurs. Re-submit with {@code force=true} to
     * confirm the destructive operation after the user acknowledges the warning.
     */
    @DeleteMapping("/shared-resources/{id}")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR')")
    public ResponseEntity<ApiResponse<ArchiveSharedResourceResult>> archiveSharedResource(
            @PathVariable UUID id,
            @RequestParam(defaultValue = "false") boolean force,
            @AuthenticationPrincipal DrPlatformUserDetails principal) {
        ArchiveSharedResourceResult result = sharedResourceService.archiveSharedResource(
                id, force, principal.getUser().getId(), principal.getUser().getEmail());
        String msg = result.isArchived()
                ? (result.isHasWarnings()
                        ? "Shared resource archived. Note: " + result.getWarningApps().size() + " app(s) referenced this resource."
                        : "Shared resource archived")
                : "Shared resource has " + result.getWarningApps().size() + " dependent app(s). Re-submit with force=true to confirm deletion.";
        return ResponseEntity.ok(ApiResponse.success(result, msg));
    }

    @PostMapping("/campaigns/{campaignId}/conflicts/scan")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR')")
    public ResponseEntity<ApiResponse<Void>> triggerConflictScan(@PathVariable UUID campaignId) {
        dependencyEngineService.scanCampaignConflictsAsync(campaignId);
        return ResponseEntity.ok(ApiResponse.success(null, "Conflict scan triggered asynchronously"));
    }
}
