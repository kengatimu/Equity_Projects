package com.equitybank.drplatform.controller;

import com.equitybank.drplatform.dto.request.CreateApplicationRequest;
import com.equitybank.drplatform.dto.response.ApiResponse;
import com.equitybank.drplatform.dto.response.ApplicationDto;
import com.equitybank.drplatform.dto.response.ApplicationHistoryDto;
import com.equitybank.drplatform.dto.response.PagedResponse;
import com.equitybank.drplatform.security.DrPlatformUserDetails;
import com.equitybank.drplatform.service.ApplicationExportService;
import com.equitybank.drplatform.service.ApplicationImportService;
import com.equitybank.drplatform.service.ApplicationService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/applications")
@RequiredArgsConstructor
public class ApplicationController {

    private final ApplicationService applicationService;
    private final ApplicationImportService applicationImportService;
    private final ApplicationExportService applicationExportService;

    @PostMapping
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR', 'APP_OWNER')")
    public ResponseEntity<ApiResponse<ApplicationDto>> createApplication(
            @Valid @RequestBody CreateApplicationRequest req) {
        return ResponseEntity.status(201)
                .body(ApiResponse.success(applicationService.createApplication(req)));
    }

    @GetMapping
    public ResponseEntity<ApiResponse<PagedResponse<ApplicationDto>>> listApplications(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String tier,
            @RequestParam(required = false) String subsidiaryId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        var pageable = PageRequest.of(page, size, Sort.by("name").ascending());
        return ResponseEntity.ok(ApiResponse.success(
                applicationService.search(name, tier, subsidiaryId, pageable)));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<ApplicationDto>> getApplication(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(applicationService.getById(id)));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR', 'APP_OWNER')")
    public ResponseEntity<ApiResponse<ApplicationDto>> updateApplication(
            @PathVariable UUID id,
            @Valid @RequestBody CreateApplicationRequest req) {
        return ResponseEntity.ok(ApiResponse.success(applicationService.updateApplication(id, req)));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<ApiResponse<Void>> archiveApplication(
            @PathVariable UUID id,
            @AuthenticationPrincipal DrPlatformUserDetails actor) {
        applicationService.archiveApplication(id, actor.getUser().getId(), actor.getUser().getEmail());
        return ResponseEntity.ok(ApiResponse.success(null, "Application archived"));
    }

    @PatchMapping("/{id}/deactivate")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR', 'APP_OWNER')")
    public ResponseEntity<ApiResponse<ApplicationDto>> deactivateApplication(
            @PathVariable UUID id) {
        applicationService.deactivateApplication(id);
        return ResponseEntity.ok(ApiResponse.success(null, "Application deactivated"));
    }

    @GetMapping("/history")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR')")
    public ResponseEntity<ApiResponse<List<ApplicationHistoryDto>>> getHistory() {
        return ResponseEntity.ok(ApiResponse.success(applicationService.getArchiveHistory()));
    }

    @PostMapping("/history/{id}/restore")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR')")
    public ResponseEntity<ApiResponse<ApplicationDto>> restoreApplication(@PathVariable UUID id) {
        return ResponseEntity.ok(ApiResponse.success(applicationService.restoreApplication(id)));
    }

    @PostMapping(value = "/import", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR')")
    public ResponseEntity<ApiResponse<ApplicationImportService.ImportResult>> importApplications(
            @RequestParam("file") MultipartFile file) throws IOException {
        ApplicationImportService.ImportResult result =
                applicationImportService.parseAndImport(file);
        return ResponseEntity.ok(ApiResponse.success(result,
                "Import completed: " + result.getImported() + " imported, "
                        + result.getUpdated() + " updated, "
                        + result.getSkipped() + " skipped, "
                        + result.getErrors().size() + " errors"));
    }

    @GetMapping("/export")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'COORDINATOR', 'GROUP_COORDINATOR')")
    public ResponseEntity<byte[]> exportApplications() throws IOException {
        byte[] bytes = applicationExportService.exportAll();
        String filename = "applications_" + LocalDate.now() + ".xlsx";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"));
        headers.setContentDisposition(ContentDisposition.attachment().filename(filename).build());
        headers.setContentLength(bytes.length);
        return ResponseEntity.ok().headers(headers).body(bytes);
    }

    /** Applications owned by the currently authenticated user (APP_OWNER self-service view). */
    @GetMapping("/my")
    @PreAuthorize("hasAnyRole('APP_OWNER', 'DR_PARTICIPANT', 'COORDINATOR', 'GROUP_COORDINATOR', 'SUPER_ADMIN')")
    public ResponseEntity<ApiResponse<List<ApplicationDto>>> getMyApplications(
            @AuthenticationPrincipal DrPlatformUserDetails userDetails) {
        return ResponseEntity.ok(ApiResponse.success(
                applicationService.listByOwner(userDetails.getUser().getId())));
    }

    @GetMapping("/by-campaign/{campaignId}")
    public ResponseEntity<ApiResponse<List<ApplicationDto>>> getApplicationsForCampaign(
            @PathVariable UUID campaignId) {
        return ResponseEntity.ok(ApiResponse.success(
                applicationService.getApplicationsForCampaign(campaignId)));
    }
}
